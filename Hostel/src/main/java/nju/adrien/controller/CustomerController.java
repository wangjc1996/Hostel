package nju.adrien.controller;

import nju.adrien.model.Bank;
import nju.adrien.model.VipInfo;
import nju.adrien.service.CustomerService;
import nju.adrien.service.FianceService;
import nju.adrien.service.VipService;
import nju.adrien.util.NumberFormater;
import nju.adrien.vo.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class CustomerController {

    @Autowired
    private VipService vipService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private FianceService fianceService;

    // 我的账户页面
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public ModelAndView dashboard(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");

        if ("".equalsIgnoreCase(vid) || vid == null) {
            ModelAndView modelAndView = new ModelAndView("common/error");
            modelAndView.addObject("msg", new Message("请先进行登陆"));
            return modelAndView;
        }

        // 状态的检验、转换
        vipService.statusRecheck(vid);

        VipInfo info = vipService.getVipById(vid);

        if ("stop".equalsIgnoreCase(info.getState())) {
            ModelAndView modelAndView = new ModelAndView("common/error");
            modelAndView.addObject("msg", new Message("您的账号已停止使用"));
            return modelAndView;
        }

        ModelAndView modelAndView = new ModelAndView("customer/dashboard");
        modelAndView.addObject("info", info);
        return modelAndView;
    }

    // 充值并激活会员资格
    @RequestMapping(value = "/validate", method = RequestMethod.GET)
    public ModelAndView validatePage(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        VipInfo info = vipService.getVipById(vid);
        Bank bank = fianceService.getBank(vid);

        ModelAndView modelAndView = new ModelAndView("customer/validate");
        modelAndView.addObject("info", info);
        modelAndView.addObject("bank", bank);
        return modelAndView;
    }

    // 激活接口
    @RequestMapping(value = "/validate", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postValidate(String money, String password, HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        return fianceService.validate(vid, money, password);
    }

    // 个人信息页面
    @RequestMapping(value = "/user/info", method = RequestMethod.GET)
    public ModelAndView info(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        VipInfo info = vipService.getVipById(vid);
        Bank bank = fianceService.getBank(vid);
        ModelAndView modelAndView = new ModelAndView("customer/info");
        modelAndView.addObject("info", info);
        modelAndView.addObject("bank", bank);
        return modelAndView;
    }

    // 完善信息接口
    @RequestMapping(value = "/user/modifyInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postSupplyInfo(String name, String bankid, String password, HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        Map<String, Object> map = customerService.supplyInfo(vid, name, bankid, password);
        if ((boolean) map.get("success")) {
            session.setAttribute("vip_name", map.get("vip_name"));
        }
        return map;
    }

    // 修改密码页面
    @RequestMapping(value = "/user/password", method = RequestMethod.GET)
    public String password(HttpSession session) {
        return "customer/password";
    }

    // 修改密码操作
    @RequestMapping(value = "/user/password", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postPassword(String old, String password, String passwordAgain,
                                            HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        return vipService.password(vid, old, password, passwordAgain);
    }

    // 我的积分页面
    @RequestMapping(value = "/user/point", method = RequestMethod.GET)
    public ModelAndView point(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        VipInfo info = vipService.getVipById(vid);
        ModelAndView modelAndView = new ModelAndView("customer/point");
        modelAndView.addObject("info", info);
        return modelAndView;
    }

    // 积分兑换操作
    @RequestMapping(value = "/user/point/exchange", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> pointExchange(int point, HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        return customerService.exchangePoint(vid, point);
    }

    // 充值页面
    @RequestMapping(value = "/user/recharge", method = RequestMethod.GET)
    public ModelAndView rechargePage(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        VipInfo info = vipService.getVipById(vid);
        ModelAndView modelAndView = new ModelAndView("customer/recharge");
        modelAndView.addObject("info", info);
        return modelAndView;
    }

    // 充值操作
    @RequestMapping(value = "/user/recharge", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> recharge(String money, String password, HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        return fianceService.recharge(vid, money, password);
    }

    // 停止账户操作
    @RequestMapping(value = "/user/stop", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> stop(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        return vipService.stop(vid);
    }

    // 我的消费
    @RequestMapping(value = "/user/consume", method = RequestMethod.GET)
    public ModelAndView consume(HttpSession session) {
        String vid = (String) session.getAttribute("vip_vid");
        VipInfo info = vipService.getVipById(vid);
        ModelAndView modelAndView = new ModelAndView("customer/consume");
        modelAndView.addObject("msg", new Message(NumberFormater.formatDouble(info.getLevel().getIntegration())));
        return modelAndView;
    }

}
