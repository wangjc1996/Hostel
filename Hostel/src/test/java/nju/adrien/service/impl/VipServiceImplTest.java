package nju.adrien.service.impl;

import nju.adrien.service.VipService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by JiachenWang on 2017/3/9.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml"})
public class VipServiceImplTest {

    @Autowired
    VipService vipService;

    @Test
    public void register() throws Exception {
//        System.out.println(vipService.register("王成昆", "18525550880", "123456", "123456"));
    }

    @Test
    public void login() throws Exception {
        System.out.println(vipService.login("18525550880", "123456"));
    }

    @Test
    public void getVipById() throws Exception {

    }

    @Test
    public void password() throws Exception {

    }

}