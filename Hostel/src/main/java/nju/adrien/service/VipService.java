package nju.adrien.service;

import nju.adrien.model.VipInfo;

import java.util.Map;

public interface VipService {

    Map<String, Object> register(String name, String phone, String password, String passwordAgain, String bankid, String bankPassword);

    Map<String, Object> login(String phone, String password);

    Map<String, Object> confirm(String vid, String password);

    VipInfo getVipById(String vid);

    Map<String, Object> password(String vid, String old, String password, String passwordAgain);

    void statusRecheck(String vid);

    Map<String, Object> stop(String vid);

}
