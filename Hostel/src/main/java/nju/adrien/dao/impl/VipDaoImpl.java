package nju.adrien.dao.impl;

import nju.adrien.dao.VipDao;
import nju.adrien.model.VipInfo;
import nju.adrien.model.VipLevel;
import nju.adrien.util.exception.NotFoundException;
import nju.adrien.util.math.NumberFormater;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import nju.adrien.util.Utils;
import nju.adrien.util.exception.MyException;
import nju.adrien.util.hibernate.HibernateUtils;

import java.sql.Date;
import java.util.List;

/**
 * Created by JiachenWang on 2017/3/7.
 */
@Repository
public class VipDaoImpl implements VipDao {


    @Override
    public boolean phoneExist(String phone) {
        Session session = HibernateUtils.getSession();
        SQLQuery query = session.createSQLQuery("SELECT phone FROM vip_info WHERE phone=:phone");
        query.setString(phone, phone);
        if (query.uniqueResult() == null) return false;
        return true;
    }

    @Override
    public VipInfo findById(String vid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from VipInfo as user where vid=:vid");
        query.setString("vid", vid);
        if (query.list() == null || query.list().size() == 0) {
            return null;
        } else {
            return (VipInfo) query.list().get(0);
        }
    }

    @Override
    public VipInfo findByPhone(String phone) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from VipInfo as user where phone=:phone");
        query.setString("phone", phone);
        if (query.list() == null || query.list().size() != 1) {
            return null;
        } else {
            return (VipInfo) query.list().get(0);
        }
    }

    @Override
    public synchronized VipInfo update(VipInfo user) {
        Session session = HibernateUtils.getSession();
        session.save(user);
        return user;
    }

    @Override
    public synchronized VipInfo create(String name, String phone, String password, Date date) throws MyException {
        Session session = HibernateUtils.getSession();

        VipInfo user = new VipInfo();
        user.setName(name);
        user.setPhone(phone);
        user.setPassword(Utils.md5(password));
        try {
            user.setVid(this.getNewVid());
        } catch (NotFoundException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }

        VipLevel level = new VipLevel();
        level.setVid(user.getVid());
        level.setTime(date);
        user.setLevel(level);

        session.save(user);
        return user;
    }

    @Override
    public List<VipInfo> getAll() {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from VipInfo");
        List<VipInfo> userList = query.list();
        return userList;
    }

    @Override
    public void delete(String vid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("delete VipInfo where vid=:vid");
        query.setString("vid", vid);
        query.executeUpdate();
    }

    private String getNewVid() throws NotFoundException {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from VipInfo where vid=(select max(vid) from VipInfo) ");
        if (query.list() == null || query.list().size() == 0) {
            throw new NotFoundException("获取会员编号发生错误");
        } else {
            VipInfo user = (VipInfo) query.list().get(0);
            int max = NumberFormater.string2Integer(user.getVid());
            String vid = NumberFormater.formatId(++max);
            return vid;
        }
    }
}
