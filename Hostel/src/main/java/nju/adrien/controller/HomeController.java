package nju.adrien.controller;

import nju.adrien.model.HotelPlan;
import nju.adrien.service.ProductService;
import nju.adrien.vo.IndexProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/8.
 */
@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    //请求主界面:显示FrontPage
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView frontPage() {
        ModelAndView modelAndView = new ModelAndView("index");
        return modelAndView;
    }

    //酒店页面
    @RequestMapping(value = "/product", method = RequestMethod.GET)
    public ModelAndView productPage(String hid) {
        ModelAndView modelAndView = new ModelAndView("order/product");

        IndexProduct product = productService.getProductInfo(hid);
        List<HotelPlan> planItems = productService.getProductPlans(hid);

        modelAndView.addObject("product", product);
        modelAndView.addObject("planItems", planItems);

        return modelAndView;
    }

    // 获得产品、查找产品
    @RequestMapping(value="/getProducts", method= RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getProducts(String key) {
        Map<String, Object> map = new HashMap<>();

        List<IndexProduct> list = productService.getProductsBySearch(key);
        map.put("list", list);

        return map;
    }
}
