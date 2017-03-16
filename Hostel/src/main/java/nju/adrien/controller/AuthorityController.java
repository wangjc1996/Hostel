package nju.adrien.controller;

import nju.adrien.service.HotelService;
import nju.adrien.service.VipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/8.
 */
@Controller
public class AuthorityController {

    @Autowired
    private VipService vipService;
    @Autowired
    private HotelService hotelService;

    /**
     * 请求登录界面:显示LoginPage
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        return "auth/login";
    }

    /**
     * 店家登陆
     * @return
     */
    @RequestMapping(value="/admin/login", method= RequestMethod.GET)
    public String adminLogin() {
        return "admin/auth/login";
    }

    /**
     * 店家登陆
     * @return
     */
    @RequestMapping(value="/admin/login", method= RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postAdminLogin(String username, String password, HttpSession session) {
        Map<String, Object> map = hotelService.login(username, password);
        if ((boolean)map.get("success")) {
            session.setAttribute("hid", map.get("hid"));
            session.setAttribute("hname", map.get("hname"));
        }
        return map;
    }

    /**
     * 请求登录
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postLogin(String phone, String password, HttpSession session) {
        Map<String, Object> map = vipService.login(phone, password);
        if ((boolean) map.get("success")) {
            session.setAttribute("vip_vid", map.get("vip_vid"));
            session.setAttribute("vip_name", map.get("vip_name"));
        }
        return map;
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "auth/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postRegister(@RequestParam String name, @RequestParam String phone, @RequestParam String password,
                                            @RequestParam String passwordAgain, @RequestParam String bankid, @RequestParam String bankPassword,
                                            HttpSession session) {
        Map<String, Object> map = vipService.register(name, phone, password, passwordAgain, bankid, bankPassword);
        if ((boolean) map.get("success")) {
            session.setAttribute("vip_vid", map.get("vip_vid"));
            session.setAttribute("vip_name", map.get("vip_name"));
        }
        return map;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        Enumeration<String> em = session.getAttributeNames();
        while (em.hasMoreElements()) {
            session.removeAttribute(em.nextElement());
        }
        return "redirect:/";
    }
}
