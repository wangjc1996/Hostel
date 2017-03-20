package nju.adrien.service.impl;

import nju.adrien.model.Bank;
import nju.adrien.model.HotelInfo;
import nju.adrien.model.VipInfo;
import nju.adrien.model.VipLevel;
import nju.adrien.repository.BankRepository;
import nju.adrien.repository.HotelInfoRepository;
import nju.adrien.repository.VipInfoRepository;
import nju.adrien.repository.VipLevelRepository;
import nju.adrien.service.FianceService;
import nju.adrien.util.NumberFormater;
import nju.adrien.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class FianceServiceImpl implements FianceService {

    @Autowired
    private VipInfoRepository vipInfoRepository;
    @Autowired
    private VipLevelRepository vipLevelRepository;
    @Autowired
    private BankRepository bankRepository;
    @Autowired
    private HotelInfoRepository hotelInfoRepository;

    @Override
    public Bank getBank(String vid) {
        VipInfo vipInfo = vipInfoRepository.findOne(vid);
        return bankRepository.findOne(vipInfo.getBankid());
    }

    @Override
    public boolean bankOccupy(String bankid) {
        VipInfo vipInfo = vipInfoRepository.findByBankid(bankid);
        HotelInfo hotel = hotelInfoRepository.findByBankid(bankid);
        if (vipInfo == null && hotel == null)
            return false;
        return true;
    }

    @Override
    public synchronized Map<String, Object> validate(String vid, String money, String password) {
        Map<String, Object> map = new HashMap<>();
        VipInfo info = vipInfoRepository.findOne(vid);
        Bank bank = this.getBank(vid);

        double amount = 0;
        try {
            amount = NumberFormater.string2Integer(money);
        } catch (Exception e) {
            map.put("success", false);
            map.put("error", "金额格式不对！");
            return map;
        }

        if (amount < 1000.0) {
            map.put("success", false);
            map.put("error", "至少1000RMB！");
            return map;
        }

        if (!Utils.md5(password).equals(bank.getPassword())) {
            map.put("success", false);
            map.put("error", "银行卡密码错误！");
            return map;
        }

        if (bank.getBalance() < amount) {
            map.put("success", false);
            map.put("error", "银行卡余额不足！");
            return map;
        }

        String level = "普通会员";
        double discount = 0.9;
        if (amount >= 5000) {
            level = "黄金会员";
            discount = 0.7;
        } else if (amount >= 3000) {
            level = "白银会员";
            discount = 0.8;
        }

        info.setState("valid");
        VipLevel viplevel = info.getLevel();
        viplevel.setBalance(viplevel.getBalance() + amount);
        viplevel.setLevel(level);
        viplevel.setDiscount(discount);
        Date date = new Date(System.currentTimeMillis());
        date.setYear(date.getYear() + 1);
        viplevel.setTime(date);
        info.setLevel(viplevel);
        map.put("success", true);


        vipInfoRepository.saveAndFlush(info);
        vipLevelRepository.saveAndFlush(viplevel);
        this.transMoney(bank.getBankid(), this.admin, amount);
        return map;
    }

    @Override
    public Map<String, Object> recharge(String vid, String money, String password) {

        Map<String, Object> map = new HashMap<>();
        VipInfo info = vipInfoRepository.findOne(vid);
        Bank bank = this.getBank(vid);

        double amount = 0;
        try {
            amount = NumberFormater.string2Integer(money);
        } catch (Exception e) {
            map.put("success", false);
            map.put("error", "金额格式不对！");
            return map;
        }

        //尚未激活
        if ("invalid".equalsIgnoreCase(info.getState())) {
            map.put("success", false);
            map.put("error", "请激活账户！");
            return map;
        }

        if (amount < 100) {
            map.put("success", false);
            map.put("error", "充值金额不足100元！");
            return map;
        }

        if (!Utils.md5(password).equals(bank.getPassword())) {
            map.put("success", false);
            map.put("error", "银行卡密码错误！");
            return map;
        }

        String level = "普通会员";
        double discount = 0.9;
        if (amount >= 5000) {
            level = "黄金会员";
            discount = 0.7;
        } else if (amount >= 3000) {
            level = "白银会员";
            discount = 0.8;
        }

        info.setState("valid");
        VipLevel viplevel = info.getLevel();
        viplevel.setBalance(viplevel.getBalance() + amount);
        viplevel.setLevel(level);
        viplevel.setDiscount(discount);
        //判断是否升级
        double currentDiscount = info.getLevel().getDiscount();
        if (currentDiscount > discount) {
            viplevel.setLevel(level);
            viplevel.setDiscount(discount);
        }
        info.setLevel(viplevel);
        //续命
        Date date = new Date(System.currentTimeMillis());
        date.setYear(date.getYear() + 1);
        viplevel.setTime(date);

        vipInfoRepository.saveAndFlush(info);
        vipLevelRepository.saveAndFlush(viplevel);
        this.transMoney(bank.getBankid(), this.admin, amount);
        map.put("success", true);
        return map;
    }

    @Override
    public Map<String, Object> transMoney(String fromBankid, String toBankid, double amount) {
        Map<String, Object> map = new HashMap<>();
        Bank fromBank = bankRepository.findOne(fromBankid);
        Bank toBank = bankRepository.findOne(toBankid);

        if (fromBank == null) {
            map.put("success", false);
            map.put("error", "来源账户信息错误！");
            return map;
        } else if (toBank == null) {
            map.put("success", false);
            map.put("error", "目标账户信息错误！");
            return map;
        }
        if (fromBank.getBalance() < amount) {
            map.put("success", false);
            map.put("error", "来源账户余额不足！");
            return map;
        }
        fromBank.setBalance(NumberFormater.doubleStander(fromBank.getBalance() - amount));
        toBank.setBalance(NumberFormater.doubleStander(toBank.getBalance() + amount));
        bankRepository.saveAndFlush(fromBank);
        bankRepository.saveAndFlush(toBank);
        map.put("success", true);
        return map;
    }

}
