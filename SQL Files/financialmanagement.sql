-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema financialmanagement
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema financialmanagement
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `financialmanagement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `financialmanagement` ;

-- -----------------------------------------------------
-- Table `financialmanagement`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `date_of_birth` DATE NULL DEFAULT NULL,
  `registration_date` DATETIME NULL DEFAULT NULL,
  `last_login` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '	';


-- -----------------------------------------------------
-- Table `financialmanagement`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`account` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `account_type` VARCHAR(50) NULL DEFAULT NULL,
  `balance` DECIMAL(10,2) NULL DEFAULT NULL,
  `date_created` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `financialmanagement`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`currency` (
  `currency_id` INT NOT NULL AUTO_INCREMENT,
  `currency_code` VARCHAR(3) NULL DEFAULT NULL,
  `currency_name` VARCHAR(50) NULL DEFAULT NULL,
  `symbol` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`currency_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = '		';


-- -----------------------------------------------------
-- Table `financialmanagement`.`exchange_rate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`exchange_rate` (
  `exchange_rate_id` INT NOT NULL AUTO_INCREMENT,
  `base_currency_id` INT NULL DEFAULT NULL,
  `target_currency_id` INT NULL DEFAULT NULL,
  `rate` DECIMAL(10,4) NULL DEFAULT NULL,
  PRIMARY KEY (`exchange_rate_id`),
  INDEX `base_currency_id_idx` (`base_currency_id` ASC) VISIBLE,
  INDEX `target_currency_id_idx` (`target_currency_id` ASC) VISIBLE,
  CONSTRAINT `base_currency_id`
    FOREIGN KEY (`base_currency_id`)
    REFERENCES `financialmanagement`.`currency` (`currency_id`),
  CONSTRAINT `target_currency_id`
    FOREIGN KEY (`target_currency_id`)
    REFERENCES `financialmanagement`.`currency` (`currency_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`stock` (
  `stock_symbol` VARCHAR(10) NOT NULL,
  `company_name` VARCHAR(100) NULL DEFAULT NULL,
  `stock_description` VARCHAR(255) NULL DEFAULT NULL,
  `exchange` VARCHAR(50) NULL DEFAULT NULL,
  `sector` VARCHAR(50) NULL DEFAULT NULL,
  `market_cap` DECIMAL(20,2) NULL DEFAULT NULL,
  `dividend_yield` DECIMAL(10,2) NULL DEFAULT NULL,
  `p_e_ratio` DECIMAL(10,2) NULL DEFAULT NULL,
  `earnings_per_share` DECIMAL(10,2) NULL DEFAULT NULL,
  `beta` DECIMAL(10,2) NULL DEFAULT NULL,
  `stockcol` DECIMAL(10,2) NULL DEFAULT NULL,
  `high_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `low_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `last_trade_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `volume` INT NULL DEFAULT NULL,
  PRIMARY KEY (`stock_symbol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`portfolio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`portfolio` (
  `portfolio_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL DEFAULT NULL,
  `portfolio_name` VARCHAR(100) NULL DEFAULT NULL,
  `date_created` DATE NULL DEFAULT NULL,
  `portfoliocol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`portfolio_id`),
  INDEX `portfolio_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `portfolio_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `financialmanagement`.`user` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`holdings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`holdings` (
  `holding_id` INT NOT NULL AUTO_INCREMENT,
  `portfolio_id` INT NULL DEFAULT NULL,
  `stock_symbol` VARCHAR(10) NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `purchase_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `purchase_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`holding_id`),
  INDEX `holdings_stock_symbol_idx` (`stock_symbol` ASC) VISIBLE,
  INDEX `portfolio_id_idx` (`portfolio_id` ASC) VISIBLE,
  CONSTRAINT `holdings_stock_symbol`
    FOREIGN KEY (`stock_symbol`)
    REFERENCES `financialmanagement`.`stock` (`stock_symbol`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `portfolio_id`
    FOREIGN KEY (`portfolio_id`)
    REFERENCES `financialmanagement`.`portfolio` (`portfolio_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NULL DEFAULT NULL,
  `stock_symbol` VARCHAR(10) NULL DEFAULT NULL,
  `order_type` VARCHAR(10) NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `order_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `account_id_idx` (`account_id` ASC) VISIBLE,
  INDEX `stock_symbol_idx` (`stock_symbol` ASC) VISIBLE,
  CONSTRAINT `order_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `financialmanagement`.`account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `stock_symbol`
    FOREIGN KEY (`stock_symbol`)
    REFERENCES `financialmanagement`.`stock` (`stock_symbol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`order_details` (
  `order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL DEFAULT NULL,
  `stock_symbol` VARCHAR(10) NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  INDEX `order_details_stock_symbol_idx` (`stock_symbol` ASC) VISIBLE,
  CONSTRAINT `order_details_stock_symbol`
    FOREIGN KEY (`stock_symbol`)
    REFERENCES `financialmanagement`.`stock` (`stock_symbol`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `financialmanagement`.`order` (`order_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `currency_id` INT NULL DEFAULT NULL,
  `payment_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `account_id_idx` (`account_id` ASC) VISIBLE,
  INDEX `currency_id_idx` (`currency_id` ASC) VISIBLE,
  CONSTRAINT `fk_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `financialmanagement`.`account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_currency_id`
    FOREIGN KEY (`currency_id`)
    REFERENCES `financialmanagement`.`currency` (`currency_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`transaction_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`transaction_type` (
  `transaction_type_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_type_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_type_id`),
  UNIQUE INDEX `transaction_type_name_UNIQUE` (`transaction_type_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `financialmanagement`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `financialmanagement`.`transaction` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `account_id` INT NULL DEFAULT NULL,
  `transactioncol` VARCHAR(45) NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `transaction_date` DATE NULL DEFAULT NULL,
  `currency_id` INT NULL DEFAULT NULL,
  `transaction_type_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `account_id_idx` (`account_id` ASC) VISIBLE,
  INDEX `currency_id_idx` (`currency_id` ASC) VISIBLE,
  INDEX `transaction_type_id_idx` (`transaction_type_id` ASC) VISIBLE,
  CONSTRAINT `account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `financialmanagement`.`account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `currency_id`
    FOREIGN KEY (`currency_id`)
    REFERENCES `financialmanagement`.`currency` (`currency_id`),
  CONSTRAINT `transaction_type_id`
    FOREIGN KEY (`transaction_type_id`)
    REFERENCES `financialmanagement`.`transaction_type` (`transaction_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
