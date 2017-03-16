package nju.adrien.controller;

import nju.adrien.service.HotelService;
import nju.adrien.service.ProductService;
import nju.adrien.vo.IndexProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/15.
 */
@Controller
public class HotelController {

    @Autowired
    private ProductService productService;
    @Autowired
    private HotelService hotelService;

    // 酒店信息页面
    @RequestMapping(value = "/admin/info", method = RequestMethod.GET)
    public ModelAndView hotelInfo(HttpSession session) {
        String hid = (String) session.getAttribute("hid");
        IndexProduct info = productService.getProductInfo(hid);
        ModelAndView modelAndView = new ModelAndView("admin/shop/edit_hotel");
        modelAndView.addObject("info", info);
        return modelAndView;
    }

    // 修改店面信息
    @RequestMapping(value = "/admin/shop/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> editShop(String hid, String name, String location, String phone) {
        return hotelService.editInfo(hid, name, location, phone);
    }


}
