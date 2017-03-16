package nju.adrien.service;

import java.util.Map;

public interface CustomerService {
    Map<String, Object> exchangePoint(String vid, int point);

    Map<String, Object> supplyInfo(String vid, String name, String bankid, String password);
}
