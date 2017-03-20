package nju.adrien.service.impl;

import nju.adrien.model.*;
import nju.adrien.repository.*;
import nju.adrien.service.FianceService;
import nju.adrien.service.HotelService;
import nju.adrien.service.ManagerService;
import nju.adrien.util.NumberFormater;
import nju.adrien.util.Utils;
import nju.adrien.vo.FinanceVO;
import nju.adrien.vo.SettlementVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ManagerServiceImpl implements ManagerService {

    private static final String admin = "admin";

    @Autowired
    private VipInfoRepository vipInfoRepository;
    @Autowired
    private AdminRepository adminRepository;
    @Autowired
    private CashRepository cashRepository;
    @Autowired
    private ApplyRepository applyRepository;
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private BankRepository bankRepository;
    @Autowired
    private HotelInfoRepository hotelInfoRepository;
    @Autowired
    private HotelPlanRepository hotelPlanRepository;
    @Autowired
    private SettleRepository settleRepository;
    @Autowired
    private FianceService fianceService;
    @Autowired
    private HotelService hotelService;

    @Override
    public Map<String, Object> login(String username, String password) {
        Map<String, Object> map = new HashMap<>();
        username = username.trim();
        password = password.trim();

        if (username.length() == 0 || password.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
        } else {
            Admin info = adminRepository.findOne(username);
            if (info == null) {
                map.put("success", false);
                map.put("error", "用户名错误！");
            } else {
                if (!Utils.md5(password).equals(info.getPassword())) {
                    map.put("success", false);
                    map.put("error", "密码错误！");
                } else {
                    map.put("success", true);
                }
            }
        }
        return map;
    }

    @Override
    public List<VipInfo> getAllVip() {
        return vipInfoRepository.findAll();
    }

    @Override
    public List<VipInfo> getVip(String phone) {
        return vipInfoRepository.findByKey("%" + phone + "%");
    }

    @Override
    public List<Apply> getAllNewApply() {
        return applyRepository.getAllNewAplply();
    }

    @Override
    public List<Apply> getAllModifyApply() {
        return applyRepository.getAllModifyAplply();
    }

    @Override
    public Map<String, Object> newHotel(String applyid) {
        Map<String, Object> map = new HashMap<>();

        Apply apply = applyRepository.findOne(applyid);

        HotelInfo info = new HotelInfo();
        info.setHid(NumberFormater.formatId(NumberFormater.string2Integer(hotelInfoRepository.getMaxHid()) + 1));
        info.setName(apply.getName());
        info.setLocation(apply.getLocation());
        info.setPhone(apply.getPhone());
        info.setPassword(Utils.md5("123456"));
        info.setBankid(apply.getBankid());

        hotelInfoRepository.saveAndFlush(info);
        applyRepository.delete(apply);
        map.put("success", true);
        return map;
    }

    @Override
    public Map<String, Object> rejectApply(String applyid) {
        Map<String, Object> map = new HashMap<>();

        Apply apply = applyRepository.findOne(applyid);
        applyRepository.delete(apply);
        map.put("success", true);
        return map;
    }

    @Override
    public Map<String, Object> modifyInfo(String applyid) {
        Map<String, Object> map = new HashMap<>();

        Apply apply = applyRepository.findOne(applyid);

        HotelInfo info = hotelInfoRepository.findOne(apply.getHid());
        info.setName(apply.getName());
        info.setLocation(apply.getLocation());
        info.setPhone(apply.getPhone());

        hotelInfoRepository.saveAndFlush(info);
        applyRepository.delete(apply);
        map.put("success", true);
        return map;
    }

    @Override
    public List<SettlementVO> getSettlement(int year, int month) {
        List<SettlementVO> result = new ArrayList<>();
        List<HotelInfo> hotels = hotelInfoRepository.findAll();
        for (HotelInfo hotel : hotels) {
            result.add(this.getSingleSettlement(hotel.getHid(), hotel.getName(), year, month));
        }
        return result;
    }

    @Override
    public Map<String, Object> makeSettlement(int year, int month) {
        Map<String, Object> map = new HashMap<>();
        List<SettlementVO> list = this.getSettlement(year, month);
        double total = 0.0;
        for (SettlementVO vo : list) {
            total += vo.getAmount();
        }

        Bank bank = bankRepository.findOne(admin);
        //余额不足
        if (bank.getBalance() < total) {
            map.put("success", false);
            map.put("error", "账户余额不足！");
            return map;
        }

        //转账
        for (SettlementVO vo : list) {
            HotelInfo info = hotelInfoRepository.findOne(vo.getHid());
            fianceService.transMoney(admin, info.getBankid(), vo.getAmount());
        }

        //结算记录
        Settle settle = new Settle();
        settle.setHasSettled(1);
        settle.setMonth(year + "-" + month);
        settleRepository.saveAndFlush(settle);

        map.put("success", true);
        return map;
    }

    @Override
    public boolean hasSettled(int year, int month) {
        if (settleRepository.findOne(year + "-" + month) == null)
            return false;
        else
            return true;
    }

    private SettlementVO getSingleSettlement(String hid, String hname, int year, int month) {
        SettlementVO settlement = new SettlementVO();
        settlement.setHid(hid);
        settlement.setHname(hname);
        settlement.setMonth(year + "-" + month);
        int number = 0;
        double amount = 0.0;
        //要求范围内的房源号码
        List<String> planids = hotelPlanRepository.getIdsByMonth(hid, year, month);
        for (String planid : planids) {
            List<Book> books = bookRepository.findByPlanid(planid);
            for (Book book : books) {
                //pay>0,并且没有cash记录
                if (book.getPay() > 0 && cashRepository.findByBookid(book.getBookid()) == null) {
                    ++number;
                    amount += book.getPay();
                }
            }
        }
        settlement.setNumber(number);
        settlement.setAmount(amount);
        return settlement;
    }

    @Override
    public FinanceVO makeFinanceAnalyse(int year, int month) {
        FinanceVO financeVO = new FinanceVO();
        double vipAccount = 0.0;
        double vipCash = 0.0;
        double nonVipCash = 0.0;

        List<String> hids = hotelInfoRepository.getAllHid();
        for (String hid : hids) {
            FinanceVO tmp = hotelService.makeFinanceAnalyse(hid, year, month);
            vipAccount += tmp.getVipAccount();
            vipCash += tmp.getVipCash();
            nonVipCash += tmp.getNonVipCash();
        }

        financeVO.setVipAccount(NumberFormater.doubleStander(vipAccount));
        financeVO.setVipCash(NumberFormater.doubleStander(vipCash));
        financeVO.setNonVipCash(NumberFormater.doubleStander(nonVipCash));
        return financeVO;
    }

}
