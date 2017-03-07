package data.factory;

/**
 * Created by JiachenWang on 2016/6/6.
 */
public class DataFactory {

    /**
     * DATA层实现的提供工厂,单件模式
     * volatile确保实例被初始化的时候,多个线程正确处理实例变量
     */
    private volatile static DataFactory dataFactory;

    private DataFactory() {
    }

    public static DataFactory getInstance() {
        if (dataFactory == null) {
            //如果实例没有被创建,进行同步,只有第一次同步加锁
            synchronized (DataFactory.class) {
                if (dataFactory == null)
                    dataFactory = new DataFactory();
            }
        }
        return dataFactory;
    }

}
