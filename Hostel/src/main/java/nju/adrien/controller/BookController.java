package nju.adrien.controller;


import nju.adrien.service.BookService;
import nju.adrien.service.ProductService;
import nju.adrien.vo.BookVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class BookController {

    @Autowired
    private ProductService productService;
    @Autowired
    private BookService bookService;

    // 预订检查
    @RequestMapping(value = "/product/check", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> bookCheck(String planid, String names, HttpSession session) {
        Map<String, Object> map = productService.bookCheck(planid, names, (String) session.getAttribute("vip_name"));

        return map;
    }

    // 预订操作
    @RequestMapping(value = "/product/book", method = RequestMethod.GET)
    public ModelAndView book(String planid, String names, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("order/book_pay");
        if (names == null || "".equalsIgnoreCase(names)) {
            names = (String) session.getAttribute("vip_name");
        }
        BookVO book = productService.getBook(planid, names, (String) session.getAttribute("vip_vid"));
        modelAndView.addObject("book", book);
        return modelAndView;
    }

    // 我的订单页面
    @RequestMapping(value = "/user/order", method = RequestMethod.GET)
    public ModelAndView orderPage(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        ModelAndView modelAndView = new ModelAndView("customer/order");

        List<BookVO> list = bookService.getBooksByCustomer(vid);
        modelAndView.addObject("list", list);
        return modelAndView;
    }

    // 取消订单操作
    @RequestMapping(value = "/user/order/cancel", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> book(String planid) {
        return bookService.cancelBook(planid);
    }

}
