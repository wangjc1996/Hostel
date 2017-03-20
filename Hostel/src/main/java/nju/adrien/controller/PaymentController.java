package nju.adrien.controller;

import nju.adrien.service.BookService;
import nju.adrien.service.ProductService;
import nju.adrien.service.VipService;
import nju.adrien.util.NumberFormater;
import nju.adrien.vo.BookVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class PaymentController {

    @Autowired
    private ProductService productService;
    @Autowired
    private VipService vipService;
    @Autowired
    private BookService bookService;

    //支付预定
    @RequestMapping(value = "/pay/book/vip", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> payBook(String planid, String names, String password, HttpSession session) {
        Map<String, Object> map = vipService.confirm((String) session.getAttribute("vip_vid"), password);
        if ((boolean) map.get("success")) {
            planid = NumberFormater.formatLongId(NumberFormater.string2Integer(planid));
            BookVO book = productService.getBook(planid, names, (String) session.getAttribute("vip_vid"));
            //支付并生成订单,房源数量-1
            Map<String, Object> fiance = bookService.payBook(book);
            if (!((boolean) fiance.get("success"))) {
                map.put("success", false);
                map.put("error", fiance.get("error"));
            }
        }
        return map;
    }

    //支付预定
    @RequestMapping(value = "/pay/book/cash", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> bookCash(String planid, String names, HttpSession session) {
        planid = NumberFormater.formatLongId(NumberFormater.string2Integer(planid));
        BookVO book = productService.getBook(planid, names, (String) session.getAttribute("vip_vid"));
        //(入住支付现金)生成订单,房源数量-1
        return bookService.bookCash(book);
    }

}
