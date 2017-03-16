package nju.adrien.service;

import nju.adrien.model.HotelPlan;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public interface HotelService {

//    Map<String, Object> register(String name, String phone, String password, String passwordAgain, String bankid, String bankPassword);

    Map<String, Object> login(String hid, String password);

    Map<String, Object> editInfo(String hid, String name, String location, String phone);

    HotelPlan getPlan(String planid);

    Map<String, Object> editPlan(String planid, String hid, Date date, String type, double price, int available);

    Map<String, Object> addPlan(String hid, Date date, String type, double price, int available);

    List<HotelPlan> getAvail(String hid, Date date);
}
