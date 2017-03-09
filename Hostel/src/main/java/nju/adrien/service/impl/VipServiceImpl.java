package nju.adrien.service.impl;

import nju.adrien.dao.VipDao;
import nju.adrien.model.VipInfo;
import nju.adrien.repository.HotelRepository;
import nju.adrien.util.exception.MyException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import nju.adrien.service.VipService;
import nju.adrien.util.Utils;
import nju.adrien.util.exception.MyException;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/7.
 */
@Service
public class VipServiceImpl implements VipService {

    @Autowired
    private VipDao vipDao;

    @Autowired
    private HotelRepository hotelRepository;

    @Override
    public Map<String, Object> register(String name, String phone, String password, String passwordAgain) {
        Map<String, Object> map = new HashMap<>();
        phone = phone.trim();
        password = password.trim();
        passwordAgain = passwordAgain.trim();
        if (name.length() == 0 || phone.length() == 0 || password.length() == 0 || passwordAgain.length() == 0) {
            map.put("success", false);
            map.put("error", "请把信息填写完整！");
        } else if (!Utils.isMobileNumber(phone)) {
            map.put("success", false);
            map.put("error", "请输入正确的手机号码！");
        } else if (!password.equals(passwordAgain)) {
            map.put("success", false);
            map.put("error", "两次输入的密码不对应！");
        } else if (vipDao.phoneExist(phone)) {
            map.put("success", false);
            map.put("error", "该手机号码已经注册了会员！");
        } else {
            VipInfo vip = null;
            try {
                vip = vipDao.create(name, phone, password, new Date(System.currentTimeMillis()));
            } catch (MyException e) {
                e.printStackTrace();
                map.put("error", e.getMessage());
                return map;
            }
            map.put("success", true);
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
            VipInfo vip = vipDao.findByPhone(phone);
            if (vip == null) {
                map.put("success", false);
                map.put("error", "手机号或密码错误！");
            } else {
                if (!Utils.md5(password).equals(vip.getPassword())) {
                    map.put("success", false);
                    map.put("error", "手机号或密码错误！");
                } else {
                    map.put("success", true);
                    map.put("customer_vid", vip.getVid());
                    map.put("customer_name", vip.getName());
                }
            }
        }
        return map;
    }

    @Override
    public VipInfo getVipById(String id) {
        //TODO
        return null;
    }

    @Override
    public Map<String, Object> password(int id, String old, String password, String passwordAgain) {
        //TODO
        return null;
    }
}
