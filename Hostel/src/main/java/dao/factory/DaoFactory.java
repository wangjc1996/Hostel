package dao.factory;

import data.factory.DataFactory;

/**
 * Created by JiachenWang on 2016/6/6.
 */
public class DaoFactory {

    /**
     * DAO层实现的提供工厂,单件模式
     * volatile确保实例被初始化的时候,多个线程正确处理实例变量
     */
    private volatile static DaoFactory daoFactory;

    private DaoFactory() {
    }

    public static DaoFactory getInstance() {
        if (daoFactory == null) {
            //如果实例没有被创建,进行同步,只有第一次同步加锁
            synchronized (DataFactory.class) {
                if (daoFactory == null)
                    daoFactory = new DaoFactory();
            }
        }
        return daoFactory;
    }

}
