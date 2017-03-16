package nju.adrien.controller;

import nju.adrien.model.HotelPlan;
import nju.adrien.service.HotelService;
import nju.adrien.service.ProductService;
import nju.adrien.vo.IndexProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/15.
 */
@Controller
public class PlanController {

    @Autowired
    private ProductService productService;
    @Autowired
    private HotelService hotelService;

    // 产品计划管理页面
    @RequestMapping(value = "/admin/plan", method = RequestMethod.GET)
    public ModelAndView planListPage(HttpSession session) {
        String hid = (String) session.getAttribute("hid");
        ModelAndView modelAndView = new ModelAndView("admin/plan/plan_list");

        IndexProduct product = productService.getProductInfo(hid);
        List<HotelPlan> planItems = productService.getProductPlans(hid);

        modelAndView.addObject("product", product);
        modelAndView.addObject("planItems", planItems);
        return modelAndView;
    }

    // 制定计划页面
    @RequestMapping(value = "/admin/plan/add", method = RequestMethod.GET)
    public ModelAndView addPlanPage(HttpSession session) {
        return new ModelAndView("admin/plan/add_plan");
    }

    // 制定计划操作
    @RequestMapping(value = "/admin/plan/add", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addPlan(@RequestParam Date date, @RequestParam String type, @RequestParam double price,
                                       @RequestParam int available, HttpSession session) {
        String hid = (String) session.getAttribute("hid");
        return hotelService.addPlan(hid, date, type, price, available);
    }

    // 编辑计划页面
    @RequestMapping(value = "/admin/plan/edit", method = RequestMethod.GET)
    public ModelAndView editPlanPage(String planid) {
        ModelAndView modelAndView = new ModelAndView("admin/plan/edit_plan");

        HotelPlan plan = hotelService.getPlan(planid);
        modelAndView.addObject("plan", plan);
        return modelAndView;
    }

    // 编辑计划操作
    @RequestMapping(value = "/admin/plan/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> editPlan(@RequestParam String planid, @RequestParam String hid, @RequestParam Date date,
                                        @RequestParam String type, @RequestParam double price, @RequestParam int available) {
        return hotelService.editPlan(planid, hid, date, type, price, available);
    }

}
