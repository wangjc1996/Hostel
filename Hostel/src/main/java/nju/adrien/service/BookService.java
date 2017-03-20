package nju.adrien.service;

import nju.adrien.model.Book;
import nju.adrien.vo.BookVO;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public interface BookService {
    List<BookVO> getBooksByCustomer(String vid);

    List<BookVO> getBooksByPhone(String phone);

    List<BookVO> getBooksByPhone(String phone, String hid, Date date);

    List<BookVO> getAllBooks(String hid, Date date);

    Map<String, Object> payBook(BookVO book);

    Map<String, Object> bookCash(BookVO book);

    Map<String, Object> cancelBook(String bookid);

    List<Book> getBooksByPlanid(String planid);

}
