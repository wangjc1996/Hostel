package nju.adrien.controller;

import nju.adrien.model.Apply;
import nju.adrien.model.HotelInfo;
import nju.adrien.model.VipInfo;
import nju.adrien.service.BookService;
import nju.adrien.service.HotelService;
import nju.adrien.service.ManagerService;
import nju.adrien.service.VipService;
import nju.adrien.vo.BookVO;
import nju.adrien.vo.StatisticVO;
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
public class ManagerController {

    @Autowired
    private VipService vipService;
    @Autowired
    private ManagerService managerService;
    @Autowired
    private HotelService hotelService;
    @Autowired
    private BookService bookService;

    // 会员状态管理界面
    @RequestMapping(value = "/admin/manager/vip", method = RequestMethod.GET)
    public String vipPage() {
        return "admin/vip/vip_state";
    }

    // 通过手机号获得会员状态信息
    @RequestMapping(value = "/admin/manager/getVip", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getVip(String phone) {
        Map<String, Object> map = new HashMap<>();

        List<VipInfo> list = managerService.getVip(phone);
        map.put("list", list);

        return map;
    }

    // 获得所有会员状态信息
    @RequestMapping(value = "/admin/manager/getAllVip", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAllVip() {
        Map<String, Object> map = new HashMap<>();

        List<VipInfo> list = managerService.getAllVip();
        map.put("list", list);

        return map;
    }

    // 会员订单管理界面
    @RequestMapping(value = "/admin/manager/book", method = RequestMethod.GET)
    public String bookPage() {
        return "admin/vip/vip_book";
    }

    // 通过手机号获得会员订单信息
    @RequestMapping(value = "/admin/manager/book", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getVipBook(String phone) {
        Map<String, Object> map = new HashMap<>();

        VipInfo vipInfo = vipService.getVipByPhone(phone);
        if (vipInfo == null) {
            map.put("success", false);
            map.put("error", "会员不存在");
            return map;
        }
        List<BookVO> list = bookService.getBooksByPhone(phone);
        map.put("list", list);
        map.put("success", true);
        return map;
    }

    // 审批开店信息页面
    @RequestMapping(value = "/admin/manager/approval", method = RequestMethod.GET)
    public ModelAndView confirmPage(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("admin/shop/confirm_hotel");

        List<Apply> list = managerService.getAllNewApply();
        modelAndView.addObject("list", list);
        List<Apply> modify = managerService.getAllModifyApply();
        modelAndView.addObject("modify", modify);
        return modelAndView;
    }

    // 新店审批通过
    @RequestMapping(value = "/admin/manager/new/pass", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> pass(String applyid) {
        return managerService.newHotel(applyid);
    }

    // 修改信息审批通过
    @RequestMapping(value = "/admin/manager/modify/pass", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> modifyPass(String applyid) {
        return managerService.modifyInfo(applyid);
    }

    // 审批拒绝
    @RequestMapping(value = "/admin/manager/reject", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> reject(String applyid) {
        return managerService.rejectApply(applyid);
    }

    // 店面入住情况统计界面
    @RequestMapping(value = "/admin/manager/statistics", method = RequestMethod.GET)
    public String statisticsPage(HttpSession session) {
        return "admin/statistic/manager_statistic";
    }

    // 店面入住情况获取
    @RequestMapping(value = "/admin/manager/statistics", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> statisticsGet(String hid, Date date) {
        Map<String, Object> map = new HashMap<>();

        HotelInfo info = hotelService.getHotelInfo(hid);
        if (info == null) {
            map.put("success", false);
            map.put("error", "酒店不存在");
            return map;
        }

        List<StatisticVO> list = hotelService.getRoomStatistic(hid, date);
        map.put("success", true);
        map.put("list", list);

        return map;
    }

    // 分店结算界面
    @RequestMapping(value = "/admin/manager/settlement", method = RequestMethod.GET)
    public ModelAndView settlementPage() {
        ModelAndView modelAndView = new ModelAndView("admin/finance/settlement");
        Date date = new Date(System.currentTimeMillis());
        modelAndView.addObject("list", managerService.getSettlement(date.getYear() + 1900, date.getMonth() + 1));
        modelAndView.addObject("hasSettle", managerService.hasSettled(date.getYear() + 1900, date.getMonth() + 1));
        return modelAndView;
    }

    // 分店结算请求
    @RequestMapping(value = "/admin/manager/settlement", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> settlement(int year, int month) {
        return managerService.makeSettlement(year, month);
    }

    // HOSTEL财务信息界面
    @RequestMapping(value = "/admin/manager/fiance", method = RequestMethod.GET)
    public ModelAndView financePage(HttpSession session) {
        ModelAndView modelAndView = new ModelAndView("admin/finance/hostel_finance");
        Date date = new Date(System.currentTimeMillis());
        modelAndView.addObject("vo", managerService.makeFinanceAnalyse(date.getYear() + 1900, date.getMonth() + 1));
        return modelAndView;
    }

}
