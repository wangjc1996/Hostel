package nju.adrien.repository;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

/**
 * Created by JiachenWang on 2017/3/9.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml"})
public class VipInfoRepositoryTest {
    @Test
    public void findByPhone1() throws Exception {
        System.out.println(vipInfoRepository.findByPhone("185"));
    }

    @Autowired
    private VipInfoRepository vipInfoRepository;

    @Test
    public void findByPhone() throws Exception {
        System.out.println(vipInfoRepository.findByPhone("18525550880"));
        System.out.println("----------------------------------------------------------");
        System.out.println(vipInfoRepository.findByPhone("18525550980"));
    }

    @Test
    public void getMaxVid() throws Exception {
        System.out.println(vipInfoRepository.getMaxVid());
    }

}