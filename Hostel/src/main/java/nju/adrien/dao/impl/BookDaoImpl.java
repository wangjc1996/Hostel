package nju.adrien.dao.impl;

import nju.adrien.dao.BookDao;
import nju.adrien.model.Book;
import nju.adrien.util.exception.MyException;
import nju.adrien.util.exception.NotFoundException;
import nju.adrien.util.hibernate.HibernateUtils;
import nju.adrien.util.math.NumberFormater;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

/**
 * Created by JiachenWang on 2017/3/7.
 */
@Repository
public class BookDaoImpl implements BookDao {
    @Override
    public List getByHid(String hid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from Book where hid=:hid");
        query.setString("hid", hid);
        List<Book> userList = query.list();
        return userList;
    }

    @Override
    public List getByHid(String hid, Date date) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from Book where hid=:hid AND date=:date");
        query.setString("hid", hid);
        query.setDate("date", date);
        List<Book> userList = query.list();
        return userList;
    }

    @Override
    public List getByVid(String vid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from Book where vid=:vid");
        query.setString("vid", vid);
        List<Book> userList = query.list();
        return userList;
    }

    @Override
    public synchronized Book createBook(String vid, String hid, String type, Date date) throws MyException {
        Session session = HibernateUtils.getSession();

        Book book = new Book();
        book.setHid(hid);
        book.setVid(vid);
        book.setType(type);
        book.setDate(date);
        try {
            book.setBookid(this.getNewBookid());
        } catch (NotFoundException e) {
            e.printStackTrace();
            throw new MyException(e.getMessage());
        }

        session.save(book);
        return book;
    }

    @Override
    public synchronized Book updateBook(Book book) {
        Session session = HibernateUtils.getSession();
        session.save(book);
        return book;
    }

    @Override
    public void deleteBook(String bookid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("delete Book where bookid=:bookid");
        query.setString("bookid", bookid);
        query.executeUpdate();
    }

    @Override
    public void deleteHotelBooks(String hid) {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("delete Book where hid=:hid");
        query.setString("hid", hid);
        query.executeUpdate();
    }

    private String getNewBookid() throws NotFoundException {
        Session session = HibernateUtils.getSession();
        Query query = session.createQuery("from Book where bookid=(select max(bookid) from Book) ");
        if (query.list() == null || query.list().size() == 0) {
            throw new NotFoundException("获取预定单编号发生错误");
        } else {
            Book book = (Book) query.list().get(0);
            int max = NumberFormater.string2Integer(book.getBookid());
            String bookid = NumberFormater.formatBookId(++max);
            return bookid;
        }
    }
}
