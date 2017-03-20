package nju.adrien.service;

import java.util.Map;

public interface HallService {

    Map<String, Object> vipCheckin(String bookid);

    Map<String, Object> vipCashCheckin(String bookid);

    Map<String, Object> nonVipCheckin(String planid, String names);
}
