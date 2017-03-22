package nju.adrien.service.impl;

import nju.adrien.model.*;
import nju.adrien.repository.*;
import nju.adrien.service.BookService;
import nju.adrien.service.FianceService;
import nju.adrien.service.HotelService;
import nju.adrien.util.NumberFormater;
import nju.adrien.util.Utils;
import nju.adrien.vo.BillVO;
import nju.adrien.vo.FinanceVO;
import nju.adrien.vo.StatisticVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HotelServiceImpl implements HotelService {

    @Autowired
    private HotelInfoRepository hotelInfoRepository;
    @Autowired
    private HotelPlanRepository hotelPlanRepository;
    @Autowired
    private ApplyRepository applyRepository;
    @Autowired
    private BankRepository bankRepository;
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private CashRepository cashRepository;
    @Autowired
    private FianceService fianceService;
    @Autowired
    private BookService bookService;

    @Override
    public Map<String, Object> login(String hid, String password) {
        Map<String, Object> map = new HashMap<>();
        hid = hid.trim();
        password = password.trim();

        if (hid.length() == 0 || password.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
        } else {
            HotelInfo info = hotelInfoRepository.findOne(hid);
            if (info == null) {
                map.put("success", false);
                map.put("error", "用户名错误！");
            } else {
                if (!Utils.md5(password).equals(info.getPassword())) {
                    map.put("success", false);
                    map.put("error", "密码错误！");
                } else {
                    map.put("success", true);
                    map.put("hid", hid);
                    map.put("hname", info.getName());
                }
            }
        }
        return map;
    }

    @Override
    public Map<String, Object> password(String hid, String old, String password, String passwordAgain) {
        Map<String, Object> map = new HashMap<>();

        old = old.trim();
        password = password.trim();
        passwordAgain = passwordAgain.trim();


        if (hid == null || "".equalsIgnoreCase(hid)) {
            map.put("success", false);
            map.put("error", "尚未登陆！");
        } else if (old.length() == 0 || password.length() == 0 || passwordAgain.length() == 0) {
            map.put("success", false);
            map.put("error", "请把密码填写完整！");
        } else if (!password.equals(passwordAgain)) {
            map.put("success", false);
            map.put("error", "输入的新密码不匹配！");
        } else {
            HotelInfo info = hotelInfoRepository.findOne(hid);
            old = Utils.md5(old);
            if (!info.getPassword().equals(old)) {
                map.put("success", false);
                map.put("error", "旧密码不正确！");
            } else {
                info.setPassword(Utils.md5(password));
                hotelInfoRepository.saveAndFlush(info);
                map.put("success", true);
            }
        }
        return map;
    }

    @Override
    public Map<String, Object> editInfo(String hid, String name, String location, String phone) {
        Map<String, Object> map = new HashMap<>();
        hid = hid.trim();
        name = name.trim();
        location = location.trim();
        phone = phone.trim();

        if (name.length() == 0 || location.length() == 0 || phone.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
            return map;
        }

        Apply apply = new Apply();
        apply.setApplyid(NumberFormater.formatId(NumberFormater.string2Integer(applyRepository.getMaxApplyid()) + 1));
        apply.setName(name);
        apply.setLocation(location);
        apply.setPhone(phone);
        apply.setBankid("-1");
        apply.setHid(hid);
        applyRepository.saveAndFlush(apply);

        map.put("success", true);
        return map;
    }

    @Override
    public Map<String, Object> applyHotel(String name, String location, String phone, String bankid, String bankpsd) {
        Map<String, Object> map = new HashMap<>();
        name = name.trim();
        location = location.trim();
        phone = phone.trim();
        bankid = bankid.trim();
        bankpsd = bankpsd.trim();

        Bank bank = bankRepository.findOne(bankid);

        if (name.length() == 0 || location.length() == 0 || phone.length() == 0 || bankid.length() == 0 || bankpsd.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
            return map;
        } else if (bank == null) {
            map.put("success", false);
            map.put("error", "银行账户不存在！");
            return map;
        } else if (fianceService.bankOccupy(bankid)) {
            map.put("success", false);
            map.put("error", "银行账户已被占用！");
            return map;
        } else if (!Utils.md5(bankpsd).equalsIgnoreCase(bank.getPassword())) {
            map.put("success", false);
            map.put("error", "银行账户密码不匹配！");
            return map;
        }

        Apply apply = new Apply();
        apply.setApplyid(NumberFormater.formatId(NumberFormater.string2Integer(applyRepository.getMaxApplyid()) + 1));
        apply.setName(name);
        apply.setLocation(location);
        apply.setPhone(phone);
        apply.setBankid(bankid);
        apply.setHid("-1");
        applyRepository.saveAndFlush(apply);

        map.put("success", true);
        return map;
    }

    @Override
    public HotelPlan getPlan(String planid) {
        return hotelPlanRepository.findOne(planid);
    }

    @Override
    public Map<String, Object> editPlan(String planid, String hid, Date date, String type, double price, int available) {
        Map<String, Object> map = new HashMap<>();

        if (type.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
        } else if (price < 0) {
            map.put("success", false);
            map.put("error", "价格错误！");
        } else if (available < 0) {
            map.put("success", false);
            map.put("error", "数量错误！");
        } else {
            HotelPlan plan = new HotelPlan();
            plan.setPlanid(planid);
            plan.setHid(hid);
            plan.setDate(date);
            plan.setType(type);
            plan.setPrice(price);
            plan.setAvailable(available);

            hotelPlanRepository.saveAndFlush(plan);
            map.put("success", true);
        }

        return map;
    }

    @Override
    public Map<String, Object> addPlan(String hid, Date date, String type, double price, int available) {
        Map<String, Object> map = new HashMap<>();

        if (type.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
        } else if (price < 0) {
            map.put("success", false);
            map.put("error", "价格错误！");
        } else if (available < 0) {
            map.put("success", false);
            map.put("error", "数量错误！");
        } else if (hotelPlanRepository.findRepeat(hid, date, type) != null) {
            map.put("success", false);
            map.put("error", "计划重复！");
        } else {
            HotelPlan plan = new HotelPlan();
            plan.setPlanid(NumberFormater.formatLongId(NumberFormater.string2Integer(hotelPlanRepository.getMaxPlanid()) + 1));
            plan.setHid(hid);
            plan.setDate(date);
            plan.setType(type);
            plan.setPrice(price);
            plan.setAvailable(available);

            hotelPlanRepository.saveAndFlush(plan);
            map.put("success", true);
        }

        return map;
    }

    @Override
    public List<HotelPlan> getAvail(String hid, Date date) {
        return hotelPlanRepository.findByHidDate(hid, date);
    }

    @Override
    public List<StatisticVO> getRoomStatistic(String hid, Date date) {
        List<HotelPlan> plans = this.getAvail(hid, date);
        List<StatisticVO> list = new ArrayList<>();
        for (HotelPlan plan : plans) {
            StatisticVO vo = new StatisticVO(plan);

            List<Book> books = bookService.getBooksByPlanid(vo.getPlanid());

            //预定人数
            vo.setBookTotal(books.size());
            //预定并入住人数
            int bookCheckin = 0;
            for (Book book : books) {
                if (book.getCheckin() != 0)
                    ++bookCheckin;
            }
            vo.setBookCheckin(bookCheckin);
            //非会员现金入住客户
            List<Cash> cashInfos = cashRepository.nonVip(vo.getPlanid());
            vo.setNonBookCheckin(cashInfos.size());

            list.add(vo);
        }
        return list;
    }

    @Override
    public HotelInfo getHotelInfo(String hid) {
        return hotelInfoRepository.findOne(hid);
    }

    @Override
    public FinanceVO makeFinanceAnalyse(String hid, int year, int month) {
        FinanceVO financeVO = new FinanceVO();
        double vipAccount = 0.0;
        double vipCash = 0.0;
        double nonVipCash = 0.0;

        List<String> planids = hotelPlanRepository.getIdsByMonth(hid, year, month);
        for (String planid : planids) {
            //会员部分
            List<Book> books = bookRepository.findByPlanid(planid);
            for (Book book : books) {
                //pay>0,并且没有cash记录
                if (book.getPay() > 0 && cashRepository.findByBookid(book.getBookid()) == null) {
                    vipAccount += book.getPay();
                    //pay>0,并且有cash记录
                } else if (book.getPay() > 0 && cashRepository.findByBookid(book.getBookid()) != null) {
                    vipCash += book.getPay();
                }
            }
            //非会员部分
            List<Cash> cashes = cashRepository.nonVip(planid);
            for (Cash cash : cashes) {
                nonVipCash += cash.getAmount();
            }
        }

        financeVO.setVipAccount(NumberFormater.doubleStander(vipAccount));
        financeVO.setVipCash(NumberFormater.doubleStander(vipCash));
        financeVO.setNonVipCash(NumberFormater.doubleStander(nonVipCash));
        return financeVO;
    }

    @Override
    public List<BillVO> makeFinanceList(String hid, int year, int month) {
        List<BillVO> list = new ArrayList<>();

        List<String> planids = hotelPlanRepository.getIdsByMonth(hid, year, month);
        for (String planid : planids) {
            HotelPlan plan = this.getPlan(planid);
            //会员部分
            List<Book> books = bookRepository.findByPlanid(planid);
            for (Book book : books) {
                //pay>0,并且没有cash记录
                if (book.getPay() > 0 && cashRepository.findByBookid(book.getBookid()) == null) {
                    list.add(new BillVO(plan.getDate(), "线上", book.getBookid(), "-", book.getNames(), book.getPay()));
                    //pay>0,并且有cash记录
                } else if (book.getPay() > 0 && cashRepository.findByBookid(book.getBookid()) != null) {
                    list.add(new BillVO(plan.getDate(),"现金", book.getBookid(), cashRepository.findByBookid(book.getBookid()).getCashid(), book.getNames(), book.getPay()));
                }
            }
            //非会员部分
            List<Cash> cashes = cashRepository.nonVip(planid);
            for (Cash cash : cashes) {
                list.add(new BillVO(plan.getDate(),"现金", "-", cash.getCashid(), cash.getNames(), cash.getAmount()));
            }
        }

        return list;
    }

}
