package nju.adrien.service.impl;

import nju.adrien.model.HotelInfo;
import nju.adrien.model.HotelPlan;
import nju.adrien.repository.HotelInfoRepository;
import nju.adrien.repository.HotelPlanRepository;
import nju.adrien.service.HotelService;
import nju.adrien.util.NumberFormater;
import nju.adrien.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HotelServiceImpl implements HotelService {

    @Autowired
    private HotelInfoRepository hotelInfoRepository;
    @Autowired
    private HotelPlanRepository hotelPlanRepository;

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
                map.put("error", "酒店编号错误！");
            } else {
                if (!Utils.md5(password).equals(info.getPassword())) {
                    map.put("success", false);
                    map.put("error", "账号或密码错误！");
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

        HotelInfo info = hotelInfoRepository.findOne(hid);
        info.setName(name);
        info.setLocation(location);
        info.setPhone(phone);
        hotelInfoRepository.saveAndFlush(info);

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

}
