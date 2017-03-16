package nju.adrien.repository;

import nju.adrien.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Date;
import java.util.List;

public interface BookRepository extends JpaRepository<Book, String> {

    @Query("select a.bookid from Book a where bookid=(select max(bookid) from Book)")
    String getMaxBookid();

    @Query("select a from Book a where vid=?1")
    List<Book> findByVid(String vid);

}
