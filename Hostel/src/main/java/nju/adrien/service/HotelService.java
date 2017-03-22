package nju.adrien.service;

import nju.adrien.model.HotelInfo;
import nju.adrien.model.HotelPlan;
import nju.adrien.vo.BillVO;
import nju.adrien.vo.FinanceVO;
import nju.adrien.vo.StatisticVO;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public interface HotelService {

//    Map<String, Object> register(String name, String phone, String password, String passwordAgain, String bankid, String bankPassword);

    Map<String, Object> login(String hid, String password);

    Map<String, Object> password(String hid, String old, String password, String passwordAgain);

    /**
     * 提交申请
     * @param hid
     * @param name
     * @param location
     * @param phone
     * @return
     */
    Map<String, Object> editInfo(String hid, String name, String location, String phone);

    Map<String, Object> applyHotel(String name, String location, String phone, String bankid, String bankpsd);

    HotelPlan getPlan(String planid);

    Map<String, Object> editPlan(String planid, String hid, Date date, String type, double price, int available);

    Map<String, Object> addPlan(String hid, Date date, String type, double price, int available);

    List<HotelPlan> getAvail(String hid, Date date);

    List<StatisticVO> getRoomStatistic(String hid, Date date);

    HotelInfo getHotelInfo(String hid);

    FinanceVO makeFinanceAnalyse(String hid, int year, int month);

    List<BillVO> makeFinanceList(String hid, int year, int month);
}
