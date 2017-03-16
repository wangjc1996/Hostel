package nju.adrien.service;

import nju.adrien.model.HotelPlan;
import nju.adrien.vo.BookVO;
import nju.adrien.vo.IndexProduct;

import java.util.List;
import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/13.
 */
public interface ProductService {

    List<IndexProduct> getProductsBySearch(String key);

    IndexProduct getProduct(String hid);

    IndexProduct getProductInfo(String hid);

    HotelPlan getPlan(String planid);

    boolean subPlan(String planid);

    boolean addPlan(String planid);

    List<HotelPlan> getProductPlans(String hid);

    Map<String, Object> bookCheck(String planid, String names, String vip_name);

    BookVO getBook(String planid, String names, String vid);
}
