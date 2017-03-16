package nju.adrien.service.impl;

import nju.adrien.service.ProductService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml"})
public class ProductServiceImplTest {
    @Test
    public void getProductInfo() throws Exception {
        System.out.println(productService.getProductInfo("1000001"));
    }

    @Autowired
    private ProductService productService;

    @Test
    public void getProductsBySearch() throws Exception {
        System.out.println(productService.getProductsBySearch(null));
        System.out.println("-----------------");
        System.out.println(productService.getProductsBySearch("全"));
    }

}