package nju.adrien.repository;

import nju.adrien.model.Bank;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BankRepository extends JpaRepository<Bank, String> {
}
