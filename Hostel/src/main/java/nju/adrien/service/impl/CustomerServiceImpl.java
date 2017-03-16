package nju.adrien.service.impl;

import nju.adrien.model.Bank;
import nju.adrien.model.VipInfo;
import nju.adrien.model.VipLevel;
import nju.adrien.repository.BankRepository;
import nju.adrien.repository.VipInfoRepository;
import nju.adrien.repository.VipLevelRepository;
import nju.adrien.service.CustomerService;
import nju.adrien.service.FianceService;
import nju.adrien.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private VipInfoRepository vipInfoRepository;
    @Autowired
    private VipLevelRepository vipLevelRepository;
    @Autowired
    private BankRepository bankRepository;
    @Autowired
    private FianceService fianceService;

    @Override
    public synchronized Map<String, Object> exchangePoint(String vid, int point) {
        Map<String, Object> map = new HashMap<>();

        VipLevel level = vipLevelRepository.findOne(vid);
        int currentPoint = level.getPoint();

        if (currentPoint < 100) {
            map.put("success", false);
            map.put("error", "积分不足100，无法兑换！");
            return map;
        }

        if (point < 100) {
            map.put("success", false);
            map.put("error", "一次兑换积分需大于100！");
            return map;
        }

        if (point > currentPoint) {
            map.put("success", false);
            map.put("error", "当前积分不足，无法兑换！");
            return map;
        }

        // 100积分兑换1元
        level.setPoint(level.getPoint() - point);
        level.setBalance(level.getBalance() + point * 1.0 / 100);

        vipLevelRepository.saveAndFlush(level);

        level = vipLevelRepository.findOne(vid);

        map.put("success", true);
        map.put("point", level.getPoint());

        return map;
    }

    @Override
    public Map<String, Object> supplyInfo(String vid, String name, String bankid, String password) {
        Map<String, Object> map = new HashMap<>();
        name = name.trim();
        bankid = bankid.trim();
        password = password.trim();

        Bank bank = bankRepository.findOne(bankid);
        VipInfo info = vipInfoRepository.findOne(vid);

        if (name.length() == 0 || bankid.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
            return map;
        }

        //不修改银行账户
        if (password.length() == 0 && info.getBankid().equals(bankid)) {
            info.setName(name);
            vipInfoRepository.saveAndFlush(info);

            map.put("vip_name", name);
            map.put("success", true);
            return map;
        }

        //修改银行账户
        if (bank == null) {
            map.put("success", false);
            map.put("error", "银行账户不存在！");
            return map;
        } else if (info.getBankid().equals(bankid)) {
            map.put("success", false);
            map.put("error", "为当前默认银行账户！");
            return map;
        } else if (fianceService.bankOccupy(bankid)) {
            map.put("success", false);
            map.put("error", "银行账户已被占用！");
            return map;
        } else if (!Utils.md5(password).equalsIgnoreCase(bank.getPassword())) {
            map.put("success", false);
            map.put("error", "银行账户密码不匹配！");
            return map;
        }

        info.setName(name);
        info.setBankid(bankid);
        vipInfoRepository.saveAndFlush(info);
        map.put("vip_name", name);
        map.put("success", true);
        return map;
    }

}
