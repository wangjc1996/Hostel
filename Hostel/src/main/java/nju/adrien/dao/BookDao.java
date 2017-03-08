package nju.adrien.dao;

import nju.adrien.model.Book;
import nju.adrien.util.exception.MyException;
import nju.adrien.util.exception.MyException;

import java.sql.Date;
import java.util.List;

/**
 * Created by JiachenWang on 2017/3/7.
 */
public interface BookDao {

    List getByHid(String hid);

    List getByHid(String hid, Date date);

    List getByVid(String vid);

    Book createBook(String vid, String hid, String type, Date date) throws MyException;

    Book updateBook(Book book);

    void deleteBook(String bookid);

    void deleteHotelBooks(String hid);
}
