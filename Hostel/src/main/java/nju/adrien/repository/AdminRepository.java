package nju.adrien.repository;

import nju.adrien.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by JiachenWang on 2017/3/17.
 */
public interface AdminRepository extends JpaRepository<Admin, String> {
}
