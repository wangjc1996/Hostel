package nju.adrien.dao.impl;

import nju.adrien.dao.HotelDao;
import nju.adrien.model.Hotel;
import nju.adrien.model.HotelInfo;
import nju.adrien.model.HotelPlan;
import nju.adrien.util.Utils;
import nju.adrien.util.exception.NotFoundException;
import nju.adrien.util.hibernate.HibernateUtils;
import nju.adrien.util.math.NumberFormater;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

/**
 * Created by JiachenWang on 2017/3/7.
 */
@Repository
public class HotelDaoImpl implements HotelDao {
    @Override
    public Hotel getHotel(String hid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from Hotel as hotel where hid=:hid");
        query.setString("hid", hid);
        if (query.list() == null || query.list().size() == 0) {
            return null;
        } else {
            return (Hotel) query.list().get(0);
        }
    }

    @Override
    public HotelInfo getHotelInfo(String hid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from HotelInfo as info where hid=:hid");
        query.setString("hid", hid);
        if (query.list() == null || query.list().size() == 0) {
            return null;
        } else {
            return (HotelInfo) query.list().get(0);
        }
    }

    @Override
    public synchronized HotelInfo updateHotelInfo(HotelInfo info) {
        Session session = HibernateUtils.getSession();
        session.save(info);
        return info;
    }

    @Override
    public synchronized HotelInfo createHotel(String name, String location, String phone, String password) {
        Session session = HibernateUtils.getSession();

        HotelInfo info = new HotelInfo();
        info.setName(name);
        info.setLocation(location);
        info.setPhone(phone);
        info.setPassword(Utils.md5(password));
        try {
            info.setHid(this.getNewHid());
        } catch (NotFoundException e) {
            e.printStackTrace();
        }

        session.save(info);
        return info;
    }

    @Override
    public void deleteHotelInfo(String hid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("delete HotelInfo where hid=:hid");
        query.setString("hid", hid);
        query.executeUpdate();
    }

    @Override
    public void deleteHotelPlan(String hid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("delete HotelPlan where hid=:hid");
        query.setString("hid", hid);
        query.executeUpdate();
    }

    @Override
    public HotelPlan updateHotelPlan(HotelPlan plan) {
        Session session = HibernateUtils.getSession();
        session.save(plan);
        return plan;
    }

    private String getNewHid() throws NotFoundException {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from HotelInfo where hid=(select max(hid) from HotelInfo) ");
        if (query.list() == null || query.list().size() == 0) {
            throw new NotFoundException("获取客栈编号发生错误");
        } else {
            HotelInfo info = (HotelInfo) query.list().get(0);
            int max = NumberFormater.string2Integer(info.getHid());
            String hid = NumberFormater.formatId(++max);
            return hid;
        }
    }
}
