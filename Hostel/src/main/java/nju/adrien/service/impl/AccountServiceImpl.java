package nju.adrien.service.impl;

import nju.adrien.model.Bank;
import nju.adrien.model.VipInfo;
import nju.adrien.model.VipLevel;
import nju.adrien.repository.BankRepository;
import nju.adrien.repository.VipInfoRepository;
import nju.adrien.repository.VipLevelRepository;
import nju.adrien.service.FianceService;
import nju.adrien.service.VipService;
import nju.adrien.util.NumberFormater;
import nju.adrien.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class AccountServiceImpl implements VipService {

    @Autowired
    private VipInfoRepository vipInfoRepository;
    @Autowired
    private VipLevelRepository vipLevelRepository;
    @Autowired
    private BankRepository bankRepository;
    @Autowired
    private FianceService fianceService;

    @Override
    public Map<String, Object> register(String name, String phone, String password, String passwordAgain, String bankid, String bankPassword) {
        Map<String, Object> map = new HashMap<>();
        phone = phone.trim();
        password = password.trim();
        passwordAgain = passwordAgain.trim();
        bankid = bankid.trim();
        bankPassword = bankPassword.trim();

        VipInfo vipByPhone = vipInfoRepository.findByPhone(phone);
        Bank bank = bankRepository.findOne(bankid);

        if (name.length() == 0 || phone.length() == 0 || password.length() == 0 ||
                passwordAgain.length() == 0 || bankid.length() == 0 || bankPassword.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
        } else if (!Utils.isMobileNumber(phone)) {
            map.put("success", false);
            map.put("error", "请输入正确的手机号码！");
        } else if (!password.equals(passwordAgain)) {
            map.put("success", false);
            map.put("error", "两次输入的密码不对应！");
        } else if (vipByPhone != null) {
            map.put("success", false);
            map.put("error", "该手机号码已经注册了会员！");
        } else if (bank == null) {
            map.put("success", false);
            map.put("error", "银行账户不存在！");
        } else if (fianceService.bankOccupy(bankid)) {
            map.put("success", false);
            map.put("error", "银行账户已被占用！");
            return map;
        } else if (!Utils.md5(bankPassword).equalsIgnoreCase(bank.getPassword())) {
            map.put("success", false);
            map.put("error", "银行卡密码错误！");
        } else {
            map.put("success", true);

            VipInfo vip = new VipInfo();
            vip.defaultValue();
            String vid = NumberFormater.formatId(NumberFormater.string2Integer(vipInfoRepository.getMaxVid()) + 1);
            vip.setVid(vid);
            vip.setName(name);
            vip.setPhone(phone);
            vip.setPassword(Utils.md5(password));
            VipLevel level = new VipLevel();
            level.defaultValue();
            level.setVid(vid);
            Date date = new Date(System.currentTimeMillis());
            date.setYear(date.getYear() + 1);
            level.setTime(date);
            vipInfoRepository.save(vip);
            vipLevelRepository.save(level);

            map.put("vip_vid", vip.getVid());
            map.put("vip_name", vip.getName());
            map.put("vip_phone", vip.getPhone());
        }
        return map;
    }

    @Override
    public Map<String, Object> login(String phone, String password) {
        Map<String, Object> map = new HashMap<>();
        phone = phone.trim();
        password = password.trim();
        if (phone.length() == 0 || password.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
        } else if (!Utils.isMobileNumber(phone)) {
            map.put("success", false);
            map.put("error", "请输入正确的手机号码！");
        } else {
            VipInfo vip = vipInfoRepository.findByPhone(phone);
            if (vip == null) {
                map.put("success", false);
                map.put("error", "手机号或密码错误！");
            } else {
                if (!Utils.md5(password).equals(vip.getPassword())) {
                    map.put("success", false);
                    map.put("error", "手机号或密码错误！");
                } else {
                    map.put("success", true);
                    map.put("vip_vid", vip.getVid());
                    map.put("vip_name", vip.getName());
                }
            }
        }
        return map;
    }

    @Override
    public Map<String, Object> confirm(String vid, String password) {
        Map<String, Object> map = new HashMap<>();
        vid = vid.trim();
        password = password.trim();

        if (password.length() == 0) {
            map.put("success", false);
            map.put("error", "请把密码填写完整！");
        } else {
            VipInfo vip = vipInfoRepository.findOne(vid);
            if (vip == null) {
                map.put("success", false);
                map.put("error", "账户异常！");
            } else {
                if (!Utils.md5(password).equals(vip.getPassword())) {
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
    public VipInfo getVipById(String vid) {
        return vipInfoRepository.findOne(vid);
    }

    @Override
    public Map<String, Object> password(String vid, String old, String password, String passwordAgain) {
        Map<String, Object> map = new HashMap<>();

        old = old.trim();
        password = password.trim();
        passwordAgain = passwordAgain.trim();
        if (vid == null || "".equalsIgnoreCase(vid)) {
            map.put("success", false);
            map.put("error", "尚未登陆！");
        } else if (old.length() == 0 || password.length() == 0 || passwordAgain.length() == 0) {
            map.put("success", false);
            map.put("error", "请把密码填写完整！");
        } else if (!password.equals(passwordAgain)) {
            map.put("success", false);
            map.put("error", "输入的新密码不匹配！");
        } else {
            VipInfo vip = vipInfoRepository.findOne(vid);
            old = Utils.md5(old);
            if (!vip.getPassword().equals(old)) {
                map.put("success", false);
                map.put("error", "旧密码不正确！");
            } else {
                vip.setPassword(Utils.md5(password));
                vipInfoRepository.saveAndFlush(vip);
                map.put("success", true);
            }
        }
        return map;
    }

    @Override
    public void statusRecheck(String vid) {
        VipInfo info = vipInfoRepository.findOne(vid);
        String state = info.getState();
        Date date = info.getLevel().getTime();
        double balance = info.getLevel().getBalance();
        boolean outOfDate = Utils.compareTime(date, new Date(System.currentTimeMillis()));

        if ("valid".equalsIgnoreCase(state) && balance < 10 && outOfDate) {
            info.setState("pause");
            date.setYear(date.getYear() + 1);
            info.getLevel().setTime(date);
            vipInfoRepository.saveAndFlush(info);
            this.statusRecheck(vid);
        } else if ("pause".equalsIgnoreCase(state) && outOfDate) {
            info.setState("stop");
            vipInfoRepository.saveAndFlush(info);
        }
    }

    @Override
    public Map<String, Object> stop(String vid) {
        Map<String, Object> map = new HashMap<>();
        VipInfo info = vipInfoRepository.findOne(vid);
        info.setState("stop");
        vipInfoRepository.saveAndFlush(info);
        map.put("success", true);
        return map;
    }

}
