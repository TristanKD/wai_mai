/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50556
Source Host           : localhost:3306
Source Database       : waimai

Target Server Type    : MYSQL
Target Server Version : 50556
File Encoding         : 65001

Date: 2020-07-04 08:25:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `add_id` varchar(20) NOT NULL,
  `user_id` varchar(20) DEFAULT NULL,
  `add_province` varchar(100) NOT NULL,
  `add_city` varchar(100) NOT NULL,
  `add_area` varchar(100) NOT NULL,
  `add_add` varchar(200) NOT NULL,
  `add_name` varchar(100) NOT NULL,
  `add_phone` varchar(100) NOT NULL,
  PRIMARY KEY (`add_id`),
  KEY `FK_live` (`user_id`),
  CONSTRAINT `FK_live` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection` (
  `shop_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `cou_id` varchar(20) NOT NULL,
  `collection_req_nub` int(11) DEFAULT NULL,
  `already_nub` int(11) DEFAULT NULL,
  PRIMARY KEY (`shop_id`,`user_id`,`cou_id`),
  KEY `FK_collection2` (`user_id`),
  KEY `FK_collection3` (`cou_id`),
  CONSTRAINT `FK_collection3` FOREIGN KEY (`cou_id`) REFERENCES `coupon_info` (`cou_id`),
  CONSTRAINT `FK_collection` FOREIGN KEY (`shop_id`) REFERENCES `seller_info` (`shop_id`),
  CONSTRAINT `FK_collection2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of collection
-- ----------------------------

-- ----------------------------
-- Table structure for coupon_hold
-- ----------------------------
DROP TABLE IF EXISTS `coupon_hold`;
CREATE TABLE `coupon_hold` (
  `shop_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `cou_id` varchar(20) NOT NULL,
  `cou_price` float DEFAULT NULL,
  `cou_hold_nub` int(11) DEFAULT NULL,
  `cou_hold_endtime` date DEFAULT NULL,
  PRIMARY KEY (`shop_id`,`user_id`,`cou_id`),
  KEY `FK_coupon_hold2` (`user_id`),
  KEY `FK_coupon_hold3` (`cou_id`),
  CONSTRAINT `FK_coupon_hold3` FOREIGN KEY (`cou_id`) REFERENCES `coupon_info` (`cou_id`),
  CONSTRAINT `FK_coupon_hold` FOREIGN KEY (`shop_id`) REFERENCES `seller_info` (`shop_id`),
  CONSTRAINT `FK_coupon_hold2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coupon_hold
-- ----------------------------

-- ----------------------------
-- Table structure for coupon_info
-- ----------------------------
DROP TABLE IF EXISTS `coupon_info`;
CREATE TABLE `coupon_info` (
  `cou_id` varchar(20) NOT NULL,
  `cou_price` float NOT NULL,
  `collection_req_nub` int(11) NOT NULL,
  `cou_start_date` date NOT NULL,
  `cou_end_date` date NOT NULL,
  PRIMARY KEY (`cou_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coupon_info
-- ----------------------------

-- ----------------------------
-- Table structure for full_reduce
-- ----------------------------
DROP TABLE IF EXISTS `full_reduce`;
CREATE TABLE `full_reduce` (
  `full_re_id` varchar(20) NOT NULL,
  `shop_id` varchar(20) DEFAULT NULL,
  `full_re_price` float NOT NULL,
  `full_re_count` float NOT NULL,
  `full_re_coupon` tinyint(1) NOT NULL,
  PRIMARY KEY (`full_re_id`),
  KEY `FK_use` (`shop_id`),
  CONSTRAINT `FK_use` FOREIGN KEY (`shop_id`) REFERENCES `seller_info` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of full_reduce
-- ----------------------------

-- ----------------------------
-- Table structure for manage
-- ----------------------------
DROP TABLE IF EXISTS `manage`;
CREATE TABLE `manage` (
  `man_id` varchar(20) NOT NULL,
  `man_name` varchar(100) NOT NULL,
  `man_pwd` varchar(100) NOT NULL,
  PRIMARY KEY (`man_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of manage
-- ----------------------------

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `order_id` varchar(20) NOT NULL,
  `pro_id` varchar(10) NOT NULL,
  `number` int(11) NOT NULL,
  `order_price` float NOT NULL,
  `sin_discount_price` float NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_info
-- ----------------------------

-- ----------------------------
-- Table structure for pro_info
-- ----------------------------
DROP TABLE IF EXISTS `pro_info`;
CREATE TABLE `pro_info` (
  `pro_id` varchar(10) NOT NULL,
  `order_id` varchar(20) DEFAULT NULL,
  `sort_id` varchar(20) DEFAULT NULL,
  `pro_name` varchar(20) NOT NULL,
  `price` float NOT NULL,
  `dis_price` float DEFAULT NULL,
  PRIMARY KEY (`pro_id`),
  KEY `FK_contain` (`sort_id`),
  KEY `FK_order` (`order_id`),
  CONSTRAINT `FK_order` FOREIGN KEY (`order_id`) REFERENCES `order_info` (`order_id`),
  CONSTRAINT `FK_contain` FOREIGN KEY (`sort_id`) REFERENCES `pro_sort` (`sort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pro_info
-- ----------------------------

-- ----------------------------
-- Table structure for pro_order_info
-- ----------------------------
DROP TABLE IF EXISTS `pro_order_info`;
CREATE TABLE `pro_order_info` (
  `add_id` varchar(20) NOT NULL,
  `order_id` varchar(20) NOT NULL,
  `rid_id` varchar(20) NOT NULL,
  `full_re_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `cou_id` varchar(20) NOT NULL,
  `pro_order_original_price` float DEFAULT NULL,
  `pro_order_result_price` float DEFAULT NULL,
  `pro_order_buytime` date DEFAULT NULL,
  `pro_order_gettime` date DEFAULT NULL,
  `pro_order_status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`add_id`,`order_id`,`rid_id`,`full_re_id`,`user_id`,`cou_id`),
  KEY `FK_pro_order_info2` (`order_id`),
  KEY `FK_pro_order_info3` (`rid_id`),
  KEY `FK_pro_order_info4` (`full_re_id`),
  KEY `FK_pro_order_info5` (`user_id`),
  KEY `FK_pro_order_info6` (`cou_id`),
  CONSTRAINT `FK_pro_order_info6` FOREIGN KEY (`cou_id`) REFERENCES `coupon_info` (`cou_id`),
  CONSTRAINT `FK_pro_order_info` FOREIGN KEY (`add_id`) REFERENCES `address` (`add_id`),
  CONSTRAINT `FK_pro_order_info2` FOREIGN KEY (`order_id`) REFERENCES `order_info` (`order_id`),
  CONSTRAINT `FK_pro_order_info3` FOREIGN KEY (`rid_id`) REFERENCES `rid_info` (`rid_id`),
  CONSTRAINT `FK_pro_order_info4` FOREIGN KEY (`full_re_id`) REFERENCES `full_reduce` (`full_re_id`),
  CONSTRAINT `FK_pro_order_info5` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pro_order_info
-- ----------------------------

-- ----------------------------
-- Table structure for pro_review
-- ----------------------------
DROP TABLE IF EXISTS `pro_review`;
CREATE TABLE `pro_review` (
  `shop_id` varchar(20) NOT NULL,
  `pro_id` varchar(10) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `pro_review_content` varchar(100) DEFAULT NULL,
  `pro_review_date` date DEFAULT NULL,
  `pro_review_level` varchar(100) DEFAULT NULL,
  `Column_4` char(10) DEFAULT NULL,
  `Column_5` char(10) DEFAULT NULL,
  `Column_6` char(10) DEFAULT NULL,
  PRIMARY KEY (`shop_id`,`pro_id`,`user_id`),
  KEY `FK_pro_review2` (`pro_id`),
  KEY `FK_pro_review3` (`user_id`),
  CONSTRAINT `FK_pro_review3` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`),
  CONSTRAINT `FK_pro_review` FOREIGN KEY (`shop_id`) REFERENCES `seller_info` (`shop_id`),
  CONSTRAINT `FK_pro_review2` FOREIGN KEY (`pro_id`) REFERENCES `pro_info` (`pro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pro_review
-- ----------------------------

-- ----------------------------
-- Table structure for pro_sort
-- ----------------------------
DROP TABLE IF EXISTS `pro_sort`;
CREATE TABLE `pro_sort` (
  `sort_id` varchar(20) NOT NULL,
  `sort_name` varchar(10) NOT NULL,
  `pro_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`sort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pro_sort
-- ----------------------------

-- ----------------------------
-- Table structure for rid_credit
-- ----------------------------
DROP TABLE IF EXISTS `rid_credit`;
CREATE TABLE `rid_credit` (
  `rid_id` varchar(20) NOT NULL,
  `order_id` varchar(20) NOT NULL,
  `time` date DEFAULT NULL,
  `user_reviews` varchar(100) DEFAULT NULL,
  `sin_income` float DEFAULT NULL,
  PRIMARY KEY (`rid_id`,`order_id`),
  KEY `FK_rid_credit2` (`order_id`),
  CONSTRAINT `FK_rid_credit2` FOREIGN KEY (`order_id`) REFERENCES `order_info` (`order_id`),
  CONSTRAINT `FK_rid_credit` FOREIGN KEY (`rid_id`) REFERENCES `rid_info` (`rid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rid_credit
-- ----------------------------

-- ----------------------------
-- Table structure for rid_info
-- ----------------------------
DROP TABLE IF EXISTS `rid_info`;
CREATE TABLE `rid_info` (
  `rid_id` varchar(20) NOT NULL,
  `rid_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `rid_position` varchar(100) NOT NULL,
  PRIMARY KEY (`rid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rid_info
-- ----------------------------

-- ----------------------------
-- Table structure for seller_info
-- ----------------------------
DROP TABLE IF EXISTS `seller_info`;
CREATE TABLE `seller_info` (
  `shop_id` varchar(20) NOT NULL,
  `shop_name` varchar(100) NOT NULL,
  `shop_level` varchar(100) NOT NULL,
  `per_cost` float NOT NULL,
  `total_sales` float NOT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of seller_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` varchar(20) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_gender` tinyint(1) NOT NULL,
  `user_pwd` varchar(100) NOT NULL,
  `user_phone` varchar(20) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_city` varchar(50) NOT NULL,
  `user_start_datet` date NOT NULL,
  `user_vip` tinyint(1) NOT NULL,
  `user_vip_stopdate` date NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
