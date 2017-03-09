package nju.adrien.repository;

import nju.adrien.model.Hotel;
import nju.adrien.model.HotelInfo;
import nju.adrien.model.HotelPlan;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by JiachenWang on 2017/3/7.
 */
public interface HotelRepository extends JpaRepository<Hotel, String>{

}
