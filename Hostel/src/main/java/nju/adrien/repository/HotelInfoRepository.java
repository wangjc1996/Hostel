package nju.adrien.repository;

import nju.adrien.model.HotelInfo;
import nju.adrien.model.VipInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by JiachenWang on 2017/3/9.
 */
public interface HotelInfoRepository extends JpaRepository<HotelInfo, String> {

    @Query("select a.hid from HotelInfo a where hid=(select max(hid) from HotelInfo)")
    String getMaxHid();

    @Query("select a from HotelInfo a where a.name like ?1 or a.location like ?1")
    List<HotelInfo> findByKey(String key);

    @Query("select a from HotelInfo a where a.bankid = ?1")
    HotelInfo findByBankid(String bankid);

    @Query("select a.hid from HotelInfo a ")
    List<String> getAllHid();
}
