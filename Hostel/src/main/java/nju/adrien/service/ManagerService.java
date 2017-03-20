package nju.adrien.service;

import nju.adrien.model.Apply;
import nju.adrien.model.VipInfo;
import nju.adrien.vo.FinanceVO;
import nju.adrien.vo.SettlementVO;

import java.util.List;
import java.util.Map;

/**
 * Created by JiachenWang on 2017/3/17.
 */
public interface ManagerService {

    Map<String, Object> login(String username, String password);

    List<VipInfo> getAllVip();

    /**
     * 手机号模糊查询
     *
     * @param phone
     * @return
     */
    List<VipInfo> getVip(String phone);

    List<Apply> getAllNewApply();

    List<Apply> getAllModifyApply();

    Map<String, Object> newHotel(String applyid);

    Map<String, Object> rejectApply(String applyid);

    Map<String, Object> modifyInfo(String applyid);

    List<SettlementVO> getSettlement(int year, int month);

    Map<String, Object> makeSettlement(int year, int month);

    boolean hasSettled(int year, int month);

    FinanceVO makeFinanceAnalyse(int year, int month);
}
