package nju.adrien.dao;

import nju.adrien.model.VipInfo;
import nju.adrien.util.exception.MyException;
import nju.adrien.util.exception.MyException;

import java.sql.Date;
import java.util.List;

public interface VipDao {

    boolean phoneExist(String phone);

    VipInfo findById(String vid);

    VipInfo findByPhone(String phone);

    VipInfo update(VipInfo user);

    VipInfo create(String name, String phone, String password, Date date) throws MyException;

    List<VipInfo> getAll();

    void delete(String vid);

}
