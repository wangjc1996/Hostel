package nju.adrien.service;

import nju.adrien.model.Bank;
import nju.adrien.vo.BookVO;

import java.util.Map;

public interface FianceService {

    Bank getBank(String vid);

    boolean bankOccupy(String bankid);

    Map<String, Object> validate(String vid, String money, String password);

    Map<String, Object> recharge(String vid, String money, String password);
}
