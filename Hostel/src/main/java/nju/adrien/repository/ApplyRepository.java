package nju.adrien.repository;

import nju.adrien.model.Apply;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ApplyRepository extends JpaRepository<Apply, String> {

    @Query("select a.applyid from Apply a where applyid=(select max(applyid) from Apply)")
    String getMaxApplyid();

    @Query("select a from Apply a where a.hid = '-1' ")
    List<Apply> getAllNewAplply();

    @Query("select a from Apply a where a.hid != '-1' ")
    List<Apply> getAllModifyAplply();
}
