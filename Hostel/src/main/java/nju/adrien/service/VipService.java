package nju.adrien.service;

import nju.adrien.model.VipInfo;

import java.util.Map;

public interface VipService {

    Map<String, Object> register(String name, String phone, String password, String passwordAgain);

    Map<String, Object> login(String phone, String password);

    VipInfo getVipById(String id);

    Map<String, Object> password(int id, String old, String password, String passwordAgain);

}
