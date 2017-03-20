package nju.adrien.repository;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml"})
public class HotelPlanRepositoryTest {
    @Test
    public void getIdsByMonth() throws Exception {
        System.out.println(hotelPlanRepository.getIdsByMonth("1000001", 2017, 9));
    }

    @Autowired
    private HotelPlanRepository hotelPlanRepository;

    @Test
    public void findByHid() throws Exception {
        System.out.println(hotelPlanRepository.findByHid("1000001"));
    }

}