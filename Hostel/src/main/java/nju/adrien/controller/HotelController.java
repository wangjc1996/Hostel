package nju.adrien.controller;

import nju.adrien.service.HotelService;
import nju.adrien.service.ProductService;
import nju.adrien.vo.IndexProduct;
import nju.adrien.vo.StatisticVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;
import java.util.Map;

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

    // 修改店面信息，提交申请
    @RequestMapping(value = "/admin/hotel/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> editShop(String hid, String name, String location, String phone) {
        return hotelService.editInfo(hid, name, location, phone);
    }

    // 申请开店界面
    @RequestMapping(value = "/admin/hotel/add", method = RequestMethod.GET)
    public String newShopPage() {
        return "admin/shop/add_hotel";
    }

    // 申请开店
    @RequestMapping(value = "/admin/hotel/add", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> newShop(String name, String location, String phone, String bankid, String bankpsd) {
        return hotelService.applyHotel(name, location, phone, bankid, bankpsd);
    }

    // 修改密码页面
    @RequestMapping(value = "/admin/password", method = RequestMethod.GET)
    public String password(HttpSession session) {
        return "/admin/auth/password";
    }

    // 修改密码操作
    @RequestMapping(value = "/admin/password", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postPassword(String old, String password, String passwordAgain,
                                            HttpSession session) {
        String hid = (String) session.getAttribute("hid");
        return hotelService.password(hid, old, password, passwordAgain);
    }

    // 店面入住情况统计界面
    @RequestMapping(value = "/admin/statistics", method = RequestMethod.GET)
    public ModelAndView statisticsPage(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("admin/statistic/statistic");

        String hid = (String) session.getAttribute("hid");

        List<StatisticVO> list = hotelService.getRoomStatistic(hid, new Date(System.currentTimeMillis()));
        modelAndView.addObject("list", list);

        return modelAndView;
    }

    // 财务信息界面
    @RequestMapping(value = "/admin/fiance", method = RequestMethod.GET)
    public ModelAndView financePage(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("admin/finance/finance");
        String hid = (String) session.getAttribute("hid");
        Date date = new Date(System.currentTimeMillis());
        modelAndView.addObject("vo", hotelService.makeFinanceAnalyse(hid, date.getYear() + 1900, date.getMonth() + 1));
        return modelAndView;
    }

}
