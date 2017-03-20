package nju.adrien.service.impl;

import nju.adrien.model.Book;
import nju.adrien.model.Cash;
import nju.adrien.model.HotelPlan;
import nju.adrien.repository.BookRepository;
import nju.adrien.repository.CashRepository;
import nju.adrien.repository.HotelPlanRepository;
import nju.adrien.service.HallService;
import nju.adrien.service.ProductService;
import nju.adrien.util.NumberFormater;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class HallServiceImpl implements HallService {

    @Autowired
    private CashRepository cashRepository;
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private HotelPlanRepository hotelPlanRepository;
    @Autowired
    private ProductService productService;

    @Override
    public Map<String, Object> vipCheckin(String bookid) {
        Map<String, Object> map = new HashMap<>();
        //入住状态
        Book book = bookRepository.findOne(bookid);
        book.setCheckin(1);
        bookRepository.saveAndFlush(book);
        map.put("success", true);
        return map;
    }

    @Override
    public Map<String, Object> vipCashCheckin(String bookid) {
        Map<String, Object> map = new HashMap<>();
        //入住状态
        Book book = bookRepository.findOne(bookid);
        book.setCheckin(1);
        book.setPay(-1 * book.getPay());
        bookRepository.saveAndFlush(book);

        //现金流水单
        Cash cash = new Cash();
        cash.setCashid(NumberFormater.formatLongId(NumberFormater.string2Integer(cashRepository.getMaxCashid()) + 1));
        cash.setPlanid(book.getPlanid());
        cash.setAmount(book.getPay());
        cash.setBookid(bookid);
        cash.setNames(book.getNames());
        cashRepository.saveAndFlush(cash);

        map.put("success", true);
        return map;
    }

    @Override
    public Map<String, Object> nonVipCheckin(String planid, String names) {
        Map<String, Object> map = new HashMap<>();
        names = names.trim();

        HotelPlan plan = hotelPlanRepository.findOne(planid);
        if (plan == null) {
            map.put("success", false);
            map.put("error", "信息错误！");
            return map;
        } else if (!productService.subPlan(planid)) {
            map.put("success", false);
            map.put("error", "房源不足！");
            return map;
        } else if (names.length() == 0) {
            map.put("success", false);
            map.put("error", "请填写入住人！");
            return map;
        }

        //现金流水单
        Cash cash = new Cash();
        cash.setCashid(NumberFormater.formatLongId(NumberFormater.string2Integer(cashRepository.getMaxCashid()) + 1));
        cash.setPlanid(planid);
        cash.setAmount(plan.getPrice());
        cash.setBookid("-1");
        cash.setNames(names);
        cashRepository.saveAndFlush(cash);

        map.put("success", true);
        return map;
    }

}
