package nju.adrien.service;

import nju.adrien.model.Bank;
import nju.adrien.vo.BookVO;

import java.util.Map;

public interface FianceService {

    String admin = "admin";

    Bank getBank(String vid);

    /**
     * 账户占用
     * @param bankid
     * @return
     */
    boolean bankOccupy(String bankid);

    Map<String, Object> validate(String vid, String money, String password);

    Map<String, Object> recharge(String vid, String money, String password);

    Map<String, Object> transMoney(String fromBankid, String toBankid, double amount);
}
