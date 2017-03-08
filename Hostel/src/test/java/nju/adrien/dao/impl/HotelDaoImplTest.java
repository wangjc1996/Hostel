package nju.adrien.dao.impl;

import nju.adrien.dao.HotelDao;
import nju.adrien.model.HotelInfo;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by JiachenWang on 2017/3/7.
 */
public class HotelDaoImplTest {
    @Test
    public void updateHotelInfo() throws Exception {
        HotelDao dao = new HotelDaoImpl();
        HotelInfo info = dao.getHotelInfo("1000001");
        info.setPhone("025-88888887");
        System.out.println(dao.updateHotelInfo(info));
    }

    @Test
    public void getHotel() throws Exception {
        HotelDao dao = new HotelDaoImpl();
        System.out.println(dao.getHotel("1000001"));
    }

    @Test
    public void getHotelInfo() throws Exception {
        HotelDao dao = new HotelDaoImpl();
        System.out.println(dao.getHotelInfo("1000001"));
    }

    @Test
    public void createHotel() throws Exception {
        HotelDao dao = new HotelDaoImpl();
        System.out.println(dao.createHotel("测试酒店", "测试地点", "测试电话", "123456"));
    }


}