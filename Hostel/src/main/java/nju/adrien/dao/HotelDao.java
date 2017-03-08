package nju.adrien.dao;

import nju.adrien.model.Hotel;
import nju.adrien.model.HotelInfo;
import nju.adrien.model.HotelPlan;

/**
 * Created by JiachenWang on 2017/3/7.
 */
public interface HotelDao {

    Hotel getHotel(String hid);

    HotelInfo getHotelInfo(String hid);

    HotelInfo updateHotelInfo(HotelInfo info);

    HotelInfo createHotel(String name, String location, String phone, String password);

    void deleteHotelInfo(String hid);

    void deleteHotelPlan(String hid);

    HotelPlan updateHotelPlan(HotelPlan plan);
}
