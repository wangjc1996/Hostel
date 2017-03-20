package nju.adrien.repository;

import nju.adrien.model.Cash;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CashRepository extends JpaRepository<Cash, String> {

    @Query("select a.cashid from Cash a where cashid=(select max(cashid) from Cash)")
    String getMaxCashid();

    /**
     * 非会员现金入住
     *
     * @param planid
     * @return
     */
    @Query("select a from Cash a where a.planid = ?1 and a.bookid = '-1' ")
    List<Cash> nonVip(String planid);

    @Query("select a from Cash a where a.bookid = ?1")
    Cash findByBookid(String bookid);
}
