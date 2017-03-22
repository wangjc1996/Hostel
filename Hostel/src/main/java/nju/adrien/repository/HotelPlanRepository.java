package nju.adrien.repository;

import nju.adrien.model.HotelPlan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Date;
import java.util.List;

public interface HotelPlanRepository extends JpaRepository<HotelPlan, String> {
    @Query("select a from HotelPlan a where a.hid = ?1 order by a.date")
    List<HotelPlan> findByHid(String hid);

    @Query("select a.planid from HotelPlan a where planid=(select max(planid) from HotelPlan)")
    String getMaxPlanid();

    @Query("select a from HotelPlan a where a.hid = ?1 and a.date = ?2 and a.type = ?3")
    HotelPlan findRepeat(String hid, Date date, String type);

    @Query("select a from HotelPlan a where a.hid = ?1 and a.date = ?2  order by a.date")
    List<HotelPlan> findByHidDate(String hid, Date date);

    @Query("select a.planid from HotelPlan a where a.hid = ?1 and Year(a.date) =  ?2 and Month(a.date) =  ?3")
    List<String> getIdsByMonth(String hid, int year, int month);
}
