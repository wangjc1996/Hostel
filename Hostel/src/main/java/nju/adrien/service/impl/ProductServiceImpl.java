package nju.adrien.service.impl;

import nju.adrien.model.HotelInfo;
import nju.adrien.model.HotelPlan;
import nju.adrien.model.VipLevel;
import nju.adrien.repository.HotelInfoRepository;
import nju.adrien.repository.HotelPlanRepository;
import nju.adrien.repository.HotelRepository;
import nju.adrien.repository.VipLevelRepository;
import nju.adrien.service.ProductService;
import nju.adrien.util.NumberFormater;
import nju.adrien.vo.BookVO;
import nju.adrien.vo.IndexProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private HotelRepository hotelRepository;
    @Autowired
    private HotelInfoRepository hotelInfoRepository;
    @Autowired
    private HotelPlanRepository hotelPlanRepository;
    @Autowired
    private VipLevelRepository vipLevelRepository;

    @Override
    public List<IndexProduct> getProductsBySearch(String key) {
        List<HotelInfo> infoList;
        List<IndexProduct> list = new ArrayList<>();
        if (key == null) {
            infoList = hotelInfoRepository.findAll();
            for (HotelInfo info : infoList) {
                list.add(new IndexProduct(info.getHid(), info.getName(), info.getLocation(), info.getPhone()));
            }
        } else {
            infoList = hotelInfoRepository.findByKey("%" + key + "%");
            for (HotelInfo info : infoList) {
                list.add(new IndexProduct(info.getHid(), info.getName(), info.getLocation(), info.getPhone()));
            }
        }
        return list;
    }

    @Override
    public IndexProduct getProduct(String hid) {
        HotelInfo info = hotelInfoRepository.findOne(hid);
        return new IndexProduct(info.getHid(), info.getName(), info.getLocation(), info.getPhone());
    }

    @Override
    public IndexProduct getProductInfo(String hid) {
        HotelInfo info = hotelInfoRepository.findOne(hid);
        return new IndexProduct(info.getHid(), info.getName(), info.getLocation(), info.getPhone());
    }

    @Override
    public HotelPlan getPlan(String planid) {
        return hotelPlanRepository.findOne(planid);
    }

    @Override
    public boolean subPlan(String planid) {
        HotelPlan plan = this.getPlan(planid);
        if (plan.getAvailable() == 0) {
            return false;
        } else {
            plan.setAvailable(plan.getAvailable() - 1);
            hotelPlanRepository.saveAndFlush(plan);
            return true;
        }
    }

    @Override
    public boolean addPlan(String planid) {
        HotelPlan plan = this.getPlan(planid);
        plan.setAvailable(plan.getAvailable() + 1);
        hotelPlanRepository.saveAndFlush(plan);
        return true;
    }

    @Override
    public List<HotelPlan> getProductPlans(String hid) {
        return hotelPlanRepository.findByHid(hid);
    }

    @Override
    public Map<String, Object> bookCheck(String planid, String names, String vip_name) {

        HotelPlan plan = hotelPlanRepository.findOne(planid);
        names = names.trim();
        String[] nameList = names.split("&");

        Map<String, Object> map = new HashMap<>();

        if (plan == null) {
            map.put("success", false);
            map.put("error", "错误的商家信息！");
        } else if (vip_name == null) {
            map.put("success", false);
            map.put("error", "请先登录！");
        } else if (nameList.length > 2) {
            map.put("success", false);
            map.put("error", "最多两人入住！");
        } else {
            map.put("success", true);
        }
        return map;
    }

    @Override
    public BookVO getBook(String planid, String names, String vid) {
        BookVO bookVO = new BookVO();
        HotelPlan plan = hotelPlanRepository.findOne(planid);
        HotelInfo info = hotelInfoRepository.findOne(plan.getHid());
        VipLevel level = vipLevelRepository.findOne(vid);

        bookVO.setPlanid(planid);
        bookVO.setVid(vid);
        bookVO.setHid(plan.getHid());
        bookVO.setHname(info.getName());
        bookVO.setNames(names);
        bookVO.setDate(plan.getDate());
        bookVO.setType(plan.getType());
        //折后价格
        bookVO.setPrice(NumberFormater.doubleStander(plan.getPrice() * level.getDiscount()));

        return bookVO;
    }
}
