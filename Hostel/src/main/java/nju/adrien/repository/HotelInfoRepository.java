package nju.adrien.repository;

import nju.adrien.model.HotelInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by JiachenWang on 2017/3/9.
 */
public interface HotelInfoRepository extends JpaRepository<HotelInfo, String> {

    @Query("select a from HotelInfo a where a.name like ?1 or a.location like ?1")
    List<HotelInfo> findByKey(String key);
}
