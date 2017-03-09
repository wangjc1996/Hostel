package nju.adrien.controller;

import nju.adrien.service.VipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/8.
 */
@Controller
public class MainController {

    @Autowired
    private VipService vipService;

    /**
     * 请求首页请求:显示FrontPage
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView index() {
        Map<String, Object> map = vipService.login("1852555088", "123456");
        return new ModelAndView("login", map);
    }

    /**
     * 请求首页请求:显示FrontPage
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView index1() {
        Map<String, Object> map = vipService.login("1852555088", "123456");
        return new ModelAndView("login", map);
    }
}
