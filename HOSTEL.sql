-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.7.12


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema hostel
--

CREATE DATABASE IF NOT EXISTS hostel;
USE hostel;

--
-- Definition of table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`username`,`password`) VALUES 
 ('admin','21232f297a57a5a743894a0e4a801fc3');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;


--
-- Definition of table `apply`
--

DROP TABLE IF EXISTS `apply`;
CREATE TABLE `apply` (
  `applyid` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `bankid` varchar(45) NOT NULL,
  `hid` varchar(45) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`applyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `apply`
--

/*!40000 ALTER TABLE `apply` DISABLE KEYS */;
/*!40000 ALTER TABLE `apply` ENABLE KEYS */;


--
-- Definition of table `bank`
--

DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `bankid` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `balance` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`bankid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bank`
--

/*!40000 ALTER TABLE `bank` DISABLE KEYS */;
INSERT INTO `bank` (`bankid`,`password`,`balance`) VALUES 
 ('000000000','e10adc3949ba59abbe56e057f20f883e',6000),
 ('111111111','e10adc3949ba59abbe56e057f20f883e',50160),
 ('111111789','e10adc3949ba59abbe56e057f20f883e',800),
 ('123456000','e10adc3949ba59abbe56e057f20f883e',351160.3),
 ('123456111','e10adc3949ba59abbe56e057f20f883e',351000),
 ('123456789','e10adc3949ba59abbe56e057f20f883e',1500),
 ('222222222','e10adc3949ba59abbe56e057f20f883e',4000),
 ('333333789','e10adc3949ba59abbe56e057f20f883e',2500),
 ('admin','e10adc3949ba59abbe56e057f20f883e',4479.7);
/*!40000 ALTER TABLE `bank` ENABLE KEYS */;


--
-- Definition of table `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `bookid` varchar(45) CHARACTER SET utf8 NOT NULL,
  `vid` varchar(45) CHARACTER SET utf8 NOT NULL,
  `planid` varchar(45) CHARACTER SET utf8 NOT NULL,
  `checkin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pay` double NOT NULL DEFAULT '0',
  `names` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`bookid`),
  KEY `FK_book_1` (`vid`),
  KEY `FK_book_2` (`planid`) USING BTREE,
  CONSTRAINT `FK_book_1` FOREIGN KEY (`vid`) REFERENCES `vip_info` (`vid`),
  CONSTRAINT `FK_book_2` FOREIGN KEY (`planid`) REFERENCES `hotel_plan` (`planid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book`
--

/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` (`bookid`,`vid`,`planid`,`checkin`,`pay`,`names`) VALUES 
 ('000000000001','0000001','000000000004',0,160.3,'王新宇'),
 ('000000000002','0000001','000000000002',0,-500,'王嘉琛'),
 ('000000000003','0000001','000000000004',1,160.3,'王梦麟'),
 ('000000000004','0000001','000000000003',0,-451.5,'张瑞'),
 ('000000000005','0000004','000000000005',1,160,'张思');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;


--
-- Definition of table `cash`
--

DROP TABLE IF EXISTS `cash`;
CREATE TABLE `cash` (
  `cashid` varchar(45) NOT NULL,
  `planid` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  `bookid` varchar(45) NOT NULL DEFAULT '-1',
  `names` varchar(45) NOT NULL,
  PRIMARY KEY (`cashid`),
  KEY `FK_cash_1` (`planid`),
  CONSTRAINT `FK_cash_1` FOREIGN KEY (`planid`) REFERENCES `hotel_plan` (`planid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cash`
--

/*!40000 ALTER TABLE `cash` DISABLE KEYS */;
INSERT INTO `cash` (`cashid`,`planid`,`amount`,`bookid`,`names`) VALUES 
 ('000000000001','000000000004',220,'-1','陈俐俐'),
 ('000000000002','000000000004',160.3,'000000000003','王梦麟'),
 ('000000000003','000000000004',229,'-1','闫守琨'),
 ('000000000004','000000000004',229,'-1','刘浩'),
 ('000000000005','000000000004',229,'-1','孙康'),
 ('000000000006','000000000005',200,'-1','张1-张2');
/*!40000 ALTER TABLE `cash` ENABLE KEYS */;


--
-- Definition of table `hotel_info`
--

DROP TABLE IF EXISTS `hotel_info`;
CREATE TABLE `hotel_info` (
  `hid` varchar(45) CHARACTER SET utf8 NOT NULL,
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `location` varchar(45) CHARACTER SET utf8 NOT NULL,
  `phone` varchar(45) CHARACTER SET utf8 NOT NULL,
  `password` varchar(45) CHARACTER SET utf8 NOT NULL,
  `bankid` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`hid`),
  KEY `FK_hotel_info_1` (`bankid`),
  CONSTRAINT `FK_hotel_info_1` FOREIGN KEY (`bankid`) REFERENCES `bank` (`bankid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hotel_info`
--

/*!40000 ALTER TABLE `hotel_info` DISABLE KEYS */;
INSERT INTO `hotel_info` (`hid`,`name`,`location`,`phone`,`password`,`bankid`) VALUES 
 ('1000001','全季酒店','南京市鼓楼区龙蟠中路55号','025-88888888','e10adc3949ba59abbe56e057f20f883e','123456000'),
 ('1000002','汉庭酒店','汉口路22号','025-88888815','e10adc3949ba59abbe56e057f20f883e','123456111'),
 ('1000003','测试酒店','测试道123','026-1567898','e10adc3949ba59abbe56e057f20f883e','111111111');
/*!40000 ALTER TABLE `hotel_info` ENABLE KEYS */;


--
-- Definition of table `hotel_plan`
--

DROP TABLE IF EXISTS `hotel_plan`;
CREATE TABLE `hotel_plan` (
  `planid` varchar(45) NOT NULL,
  `hid` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `type` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `available` int(10) unsigned NOT NULL,
  PRIMARY KEY (`planid`),
  KEY `FK_hotel_plan_1` (`hid`),
  CONSTRAINT `FK_hotel_plan_1` FOREIGN KEY (`hid`) REFERENCES `hotel_info` (`hid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hotel_plan`
--

/*!40000 ALTER TABLE `hotel_plan` DISABLE KEYS */;
INSERT INTO `hotel_plan` (`planid`,`hid`,`date`,`type`,`price`,`available`) VALUES 
 ('000000000002','1000001','2017-03-22','套房',338,0),
 ('000000000003','1000001','2017-09-26','大床房',645,44),
 ('000000000004','1000001','2017-03-22','标准间',229,24),
 ('000000000005','1000003','2017-03-22','标准间',200,18);
/*!40000 ALTER TABLE `hotel_plan` ENABLE KEYS */;


--
-- Definition of table `settle`
--

DROP TABLE IF EXISTS `settle`;
CREATE TABLE `settle` (
  `month` varchar(45) CHARACTER SET utf8 NOT NULL,
  `hasSettled` int(10) unsigned NOT NULL,
  PRIMARY KEY (`month`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settle`
--

/*!40000 ALTER TABLE `settle` DISABLE KEYS */;
INSERT INTO `settle` (`month`,`hasSettled`) VALUES 
 ('2017-3',1);
/*!40000 ALTER TABLE `settle` ENABLE KEYS */;


--
-- Definition of table `vip_info`
--

DROP TABLE IF EXISTS `vip_info`;
CREATE TABLE `vip_info` (
  `vid` varchar(45) CHARACTER SET utf8 NOT NULL COMMENT '7位',
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `phone` varchar(45) CHARACTER SET utf8 NOT NULL,
  `state` varchar(45) CHARACTER SET utf8 NOT NULL DEFAULT 'invalid',
  `password` varchar(45) CHARACTER SET utf8 NOT NULL,
  `bankid` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`vid`),
  KEY `FK_vip_info_1` (`bankid`),
  CONSTRAINT `FK_vip_info_1` FOREIGN KEY (`bankid`) REFERENCES `bank` (`bankid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='会员基本信息';

--
-- Dumping data for table `vip_info`
--

/*!40000 ALTER TABLE `vip_info` DISABLE KEYS */;
INSERT INTO `vip_info` (`vid`,`name`,`phone`,`state`,`password`,`bankid`) VALUES 
 ('0000001','王嘉琛','18525550880','valid','e10adc3949ba59abbe56e057f20f883e','123456789'),
 ('0000002','王成昆','18641113380','pause','e10adc3949ba59abbe56e057f20f883e','111111789'),
 ('0000003','杨妍','18641113180','valid','e10adc3949ba59abbe56e057f20f883e','333333789'),
 ('0000004','张思','15641113180','valid','e10adc3949ba59abbe56e057f20f883e','000000000');
/*!40000 ALTER TABLE `vip_info` ENABLE KEYS */;


--
-- Definition of table `vip_level`
--

DROP TABLE IF EXISTS `vip_level`;
CREATE TABLE `vip_level` (
  `vid` varchar(45) CHARACTER SET utf8 NOT NULL,
  `level` varchar(45) CHARACTER SET utf8 NOT NULL DEFAULT '普通会员',
  `discount` double NOT NULL DEFAULT '0.9',
  `balance` double NOT NULL DEFAULT '0',
  `integration` double unsigned NOT NULL DEFAULT '0',
  `time` date NOT NULL,
  `point` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`vid`),
  CONSTRAINT `FK_vip_level_1` FOREIGN KEY (`vid`) REFERENCES `vip_info` (`vid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vip_level`
--

/*!40000 ALTER TABLE `vip_level` DISABLE KEYS */;
INSERT INTO `vip_level` (`vid`,`level`,`discount`,`balance`,`integration`,`time`,`point`) VALUES 
 ('0000001','黄金会员',0.7,782.4,320.6,'2018-03-01',520),
 ('0000002','普通会员',0.9,0,0,'2018-03-09',0),
 ('0000003','普通会员',0.9,6500,0,'2018-03-14',0),
 ('0000004','白银会员',0.8,2840,160,'2018-03-22',160);
/*!40000 ALTER TABLE `vip_level` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
