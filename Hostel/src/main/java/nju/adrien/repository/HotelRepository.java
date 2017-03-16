package nju.adrien.repository;

import nju.adrien.model.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by JiachenWang on 2017/3/7.
 */
public interface HotelRepository extends JpaRepository<Hotel, String> {

    @Query("select a from Hotel a where a.name like ?1 or a.location like ?1")
    List<Hotel> findByKey(String key);
}
