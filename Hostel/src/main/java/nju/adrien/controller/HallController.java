package nju.adrien.controller;

import nju.adrien.model.HotelPlan;
import nju.adrien.service.BookService;
import nju.adrien.service.HotelService;
import nju.adrien.vo.BookVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HallController {

    @Autowired
    private BookService bookService;
    @Autowired
    private HotelService hotelService;

    // 已预订的销售页面
    @RequestMapping(value = "/admin/hall", method = RequestMethod.GET)
    public ModelAndView orderSalePage(HttpSession session) {
        String hid = (String) session.getAttribute("hid");

        ModelAndView modelAndView = new ModelAndView("admin/hall/hall");
        return modelAndView;
    }

    // 通过手机号获得客户的订单
    @RequestMapping(value = "/admin/hall/getBooks", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBooks(String phone, HttpSession session) {
        String hid = (String) session.getAttribute("hid");
        Map<String, Object> map = new HashMap<>();

        List<BookVO> list = bookService.getBooksByPhone(phone, hid, new Date(System.currentTimeMillis()));
        map.put("list", list);

        return map;
    }

    // 获得当日所有客户的订单
    @RequestMapping(value = "/admin/hall/getAllBooks", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAllBooks(HttpSession session) {
        String hid = (String) session.getAttribute("hid");
        Map<String, Object> map = new HashMap<>();

        List<BookVO> list = bookService.getAllBooks(hid, new Date(System.currentTimeMillis()));
        map.put("list", list);

        return map;
    }

    // 获得当日所有房源
    @RequestMapping(value = "/admin/hall/getAvail", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAvail(HttpSession session) {
        String hid = (String) session.getAttribute("hid");
        Map<String, Object> map = new HashMap<>();

        List<HotelPlan> list = hotelService.getAvail(hid, new Date(System.currentTimeMillis()));
        map.put("list", list);

        return map;
    }
}
