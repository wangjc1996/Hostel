package nju.adrien.service.impl;

import nju.adrien.model.*;
import nju.adrien.repository.*;
import nju.adrien.service.BookService;
import nju.adrien.service.ProductService;
import nju.adrien.util.NumberFormater;
import nju.adrien.vo.BookVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.*;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private VipInfoRepository vipInfoRepository;
    @Autowired
    private VipLevelRepository vipLevelRepository;
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private HotelInfoRepository hotelInfoRepository;
    @Autowired
    private HotelPlanRepository hotelPlanRepository;
    @Autowired
    private ProductService productService;

    @Override
    public List<BookVO> getBooksByCustomer(String vid) {
        List<Book> list = bookRepository.findByVid(vid);
        List<BookVO> vos = new ArrayList<>();
        for (Book book : list) {
            BookVO bookVO = new BookVO();
            HotelPlan plan = hotelPlanRepository.findOne(book.getPlanid());
            HotelInfo info = hotelInfoRepository.findOne(plan.getHid());

            bookVO.setBookid(book.getBookid());
            bookVO.setPlanid(book.getPlanid());
            bookVO.setVid(book.getVid());
            bookVO.setHid(plan.getHid());
            bookVO.setHname(info.getName());
            bookVO.setNames(book.getNames());
            bookVO.setDate(plan.getDate());
            bookVO.setType(plan.getType());
            bookVO.setPrice(book.getPay());
            bookVO.setChenkin(book.getCheckin());

            vos.add(bookVO);
        }
        return vos;
    }

    @Override
    public List<BookVO> getBooksByPhone(String phone, String hid, Date date) {
        VipInfo vip = vipInfoRepository.findByPhone(phone);
        if (vip == null)
            return new ArrayList<>();

        List<BookVO> list = this.getBooksByCustomer(vip.getVid());
        Iterator iterator = list.iterator();
        while (iterator.hasNext()) {
            BookVO bookVO = (BookVO) iterator.next();
            if (!bookVO.getDate().toString().equalsIgnoreCase(date.toString()) || !bookVO.getHid().equalsIgnoreCase(hid)) {
                iterator.remove();
            }
        }
        return list;
    }

    @Override
    public List<BookVO> getAllBooks(String hid, Date date) {
        List<BookVO> vos = new ArrayList<>();
        List<Book> list = bookRepository.findAll();
        Iterator iterator = list.iterator();
        while (iterator.hasNext()) {
            Book book = (Book) iterator.next();
            HotelPlan plan = hotelPlanRepository.findOne(book.getPlanid());
            if (plan.getDate().toString().equalsIgnoreCase(date.toString()) && plan.getHid().equalsIgnoreCase(hid)) {
                BookVO bookVO = new BookVO();
                HotelInfo info = hotelInfoRepository.findOne(plan.getHid());

                bookVO.setBookid(book.getBookid());
                bookVO.setPlanid(book.getPlanid());
                bookVO.setVid(book.getVid());
                bookVO.setHid(plan.getHid());
                bookVO.setHname(info.getName());
                bookVO.setNames(book.getNames());
                bookVO.setDate(plan.getDate());
                bookVO.setType(plan.getType());
                bookVO.setPrice(book.getPay());
                bookVO.setChenkin(book.getCheckin());

                vos.add(bookVO);
            }
        }

        return vos;
    }

    @Override
    public synchronized Map<String, Object> payBook(BookVO book) {
        Map<String, Object> map = new HashMap<>();

        VipInfo vipInfo = vipInfoRepository.findOne(book.getVid());
        VipLevel level = vipLevelRepository.findOne(book.getVid());

        if (!"valid".equalsIgnoreCase(vipInfo.getState())) {
            map.put("success", false);
            map.put("error", "账户冻结！");
        } else if (level.getBalance() < book.getPrice()) {
            map.put("success", false);
            map.put("error", "账户余额不足！");
        } else if (!productService.subPlan(book.getPlanid())) {
            //房源不足
            map.put("success", false);
            map.put("error", "房源不足！");
        } else {
            map.put("success", true);
            //账户资金
            level.setBalance(level.getBalance() - book.getPrice());
            level.setIntegration(level.getIntegration() + book.getPrice());
            level.setPoint(level.getPoint() + (int) book.getPrice());
            vipLevelRepository.saveAndFlush(level);
            //新的订单
            Book model = book.toBook();
            model.setBookid(NumberFormater.formatLongId(NumberFormater.string2Integer(bookRepository.getMaxBookid()) + 1));
            bookRepository.saveAndFlush(model);
        }
        return map;
    }

    @Override
    public synchronized Map<String, Object> cancelBook(String bookid) {
        Map<String, Object> map = new HashMap<>();
        Book book = bookRepository.findOne(bookid);
        double money = book.getPay();

        VipLevel level = vipLevelRepository.findOne(book.getVid());
        //房源+1
        productService.addPlan(book.getPlanid());
        //反钱
        if (money > 0) {
            level.setBalance(level.getBalance() + money);
        } else if (money < 0) {
            money = -money;
        }
        //积分，消费总金额
        level.setPoint(level.getPoint() - (int) money);
        level.setIntegration(level.getIntegration() - money);
        vipLevelRepository.saveAndFlush(level);
        //删除订单
        bookRepository.delete(book);

        map.put("success", true);
        return map;
    }
}
