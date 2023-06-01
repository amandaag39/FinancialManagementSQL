CREATE DATABASE  IF NOT EXISTS `financialmanagement` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `financialmanagement`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: financialmanagement
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `account_type` varchar(50) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency` (
  `currency_id` int NOT NULL AUTO_INCREMENT,
  `currency_code` varchar(3) DEFAULT NULL,
  `currency_name` varchar(50) DEFAULT NULL,
  `symbol` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_rate`
--

DROP TABLE IF EXISTS `exchange_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_rate` (
  `exchange_rate_id` int NOT NULL AUTO_INCREMENT,
  `base_currency_id` int DEFAULT NULL,
  `target_currency_id` int DEFAULT NULL,
  `rate` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`exchange_rate_id`),
  UNIQUE KEY `base_currency_id_unique` (`base_currency_id`),
  UNIQUE KEY `target_currency_id_unique` (`target_currency_id`),
  KEY `base_currency_id_idx` (`base_currency_id`),
  KEY `target_currency_id_idx` (`target_currency_id`),
  CONSTRAINT `base_currency_id` FOREIGN KEY (`base_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE SET NULL,
  CONSTRAINT `target_currency_id` FOREIGN KEY (`target_currency_id`) REFERENCES `currency` (`currency_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `holdings`
--

DROP TABLE IF EXISTS `holdings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holdings` (
  `holding_id` int NOT NULL AUTO_INCREMENT,
  `portfolio_id` int DEFAULT NULL,
  `stock_symbol` varchar(10) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `purchase_price` decimal(10,2) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  PRIMARY KEY (`holding_id`),
  KEY `holdings_stock_symbol_idx` (`stock_symbol`),
  KEY `portfolio_id_idx` (`portfolio_id`),
  CONSTRAINT `holdings_stock_symbol` FOREIGN KEY (`stock_symbol`) REFERENCES `stock` (`stock_symbol`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolio` (`portfolio_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `stock_symbol` varchar(10) DEFAULT NULL,
  `order_type` varchar(10) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `account_id_idx` (`account_id`),
  KEY `stock_symbol_idx` (`stock_symbol`),
  CONSTRAINT `order_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `stock_symbol` FOREIGN KEY (`stock_symbol`) REFERENCES `stock` (`stock_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `order_detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `stock_symbol` varchar(10) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order_id_idx` (`order_id`),
  KEY `order_details_stock_symbol_idx` (`stock_symbol`),
  CONSTRAINT `order_details_stock_symbol` FOREIGN KEY (`stock_symbol`) REFERENCES `stock` (`stock_symbol`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `account_id_idx` (`account_id`),
  KEY `currency_id_idx` (`currency_id`),
  CONSTRAINT `fk_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `portfolio`
--

DROP TABLE IF EXISTS `portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portfolio` (
  `portfolio_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `portfolio_name` varchar(100) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  PRIMARY KEY (`portfolio_id`),
  KEY `portfolio_user_id_idx` (`user_id`),
  CONSTRAINT `portfolio_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `stock_symbol` varchar(10) NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `stock_description` varchar(255) DEFAULT NULL,
  `exchange` varchar(50) DEFAULT NULL,
  `sector` varchar(50) DEFAULT NULL,
  `market_cap` decimal(20,2) DEFAULT NULL,
  `dividend_yield` decimal(10,2) DEFAULT NULL,
  `p_e_ratio` decimal(10,2) DEFAULT NULL,
  `earnings_per_share` decimal(10,2) DEFAULT NULL,
  `beta` decimal(10,2) DEFAULT NULL,
  `high_price` decimal(10,2) DEFAULT NULL,
  `low_price` decimal(10,2) DEFAULT NULL,
  `last_trade_price` decimal(10,2) DEFAULT NULL,
  `volume` int DEFAULT NULL,
  PRIMARY KEY (`stock_symbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `transaction_type_id` int DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `account_id_idx` (`account_id`),
  KEY `currency_id_idx` (`currency_id`),
  KEY `transaction_type_id_idx` (`transaction_type_id`),
  CONSTRAINT `account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`),
  CONSTRAINT `fk_transaction_transaction_type` FOREIGN KEY (`transaction_type_id`) REFERENCES `transaction_type` (`transaction_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_type`
--

DROP TABLE IF EXISTS `transaction_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_type` (
  `transaction_type_id` int NOT NULL AUTO_INCREMENT,
  `transaction_type_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`transaction_type_id`),
  UNIQUE KEY `transaction_type_name_UNIQUE` (`transaction_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `registration_date` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-01 15:52:51
