-- MySQL Script generated by MySQL Workbench
-- Tue Apr 17 13:17:41 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nmu
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nmu
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nmu` DEFAULT CHARACTER SET utf8 ;
USE `nmu` ;

-- -----------------------------------------------------
-- Table `nmu`.`Wholesaler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Wholesaler` (
  `wholesaler_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `description` VARCHAR(1000) NULL,
  `region` VARCHAR(45) NULL,
  `business_type` VARCHAR(45) NULL,
  `wholesaler_code` VARCHAR(45) NULL,
  PRIMARY KEY (`wholesaler_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Salesperson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Salesperson` (
  `salesperson_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `salesperson_code` VARCHAR(45) NOT NULL,
  `department_location` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `description` VARCHAR(500) NULL,
  `other_information` VARCHAR(1000) NULL,
  `gender` ENUM('M', 'F', 'UNKNOWN') NOT NULL,
  PRIMARY KEY (`salesperson_id`),
  UNIQUE INDEX `salesperson_code_UNIQUE` (`salesperson_code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`TouristGuide`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`TouristGuide` (
  `guide_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NOT NULL,
  `other_contact` VARCHAR(100) NULL,
  `gender` ENUM('M', 'F', 'UNKNOWN') NOT NULL,
  `descriptions` VARCHAR(500) NULL,
  `age` INT NULL,
  PRIMARY KEY (`guide_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`GroupTour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`GroupTour` (
  `group_tour_id` INT NOT NULL AUTO_INCREMENT,
  `group_code` VARCHAR(45) NOT NULL,
  `salesperson_id` INT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `duration` INT NOT NULL,
  `flight_number` VARCHAR(100) NULL,
  `bus_company` VARCHAR(100) NULL,
  `price` DECIMAL(11,2) NOT NULL,
  `reserve` DECIMAL(11,2) NOT NULL,
  `write_off` DECIMAL(11,2) NOT NULL,
  `total_cost` DECIMAL(11,2) NOT NULL COMMENT 'total cost = write off + reserve',
  `other_expense` DECIMAL(11,2) NULL,
  `note` VARCHAR(500) NULL,
  `agency_name` VARCHAR(45) NOT NULL,
  `guide_id` INT NULL,
  `leader_number` INT NOT NULL,
  `tourist_number` INT NOT NULL,
  PRIMARY KEY (`group_tour_id`),
  UNIQUE INDEX `tour_id_UNIQUE` (`group_tour_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `tg_fk_guide_id_idx` (`guide_id` ASC),
  UNIQUE INDEX `group_code_UNIQUE` (`group_code` ASC),
  CONSTRAINT `gt_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tg_fk_guide_id`
    FOREIGN KEY (`guide_id`)
    REFERENCES `nmu`.`TouristGuide` (`guide_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`CouponCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`CouponCode` (
  `cc_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(100) NOT NULL,
  `discount` DECIMAL(11,2) NOT NULL,
  `description` VARCHAR(500) NULL,
  `code_expired` ENUM('Y', 'N') NOT NULL COMMENT 'Y/N',
  `salesperson_id` INT NULL,
  PRIMARY KEY (`cc_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `cc_fk_salesperson_id_idx` (`salesperson_id` ASC),
  CONSTRAINT `cc_fk_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`IndividualTour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`IndividualTour` (
  `indiv_tour_id` INT NOT NULL AUTO_INCREMENT,
  `wholesaler_id` INT NULL,
  `salesperson_id` INT NULL,
  `indiv_number` INT NULL,
  `depart_date` DATETIME NULL,
  `arrival_date` DATETIME NULL,
  `note` VARCHAR(500) NULL,
  `product_code` VARCHAR(45) NOT NULL,
  `tour_name` VARCHAR(45) NULL,
  PRIMARY KEY (`indiv_tour_id`),
  INDEX `fk_wholesaler_id_idx` (`wholesaler_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  CONSTRAINT `fk_wholesaler_id`
    FOREIGN KEY (`wholesaler_id`)
    REFERENCES `nmu`.`Wholesaler` (`wholesaler_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `it_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `other_contact_type` VARCHAR(45) NULL,
  `other_contact_number` VARCHAR(45) NULL,
  `other_information` VARCHAR(500) NULL,
  `birth_date` DATETIME NULL,
  `gender` ENUM('M', 'F', 'UNKNOWN') NULL,
  `zipcode` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`AirticketTour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`AirticketTour` (
  `airticket_tour_id` INT NOT NULL AUTO_INCREMENT,
  `salesperson_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `flight_code` VARCHAR(45) NULL,
  `depart_location` VARCHAR(500) NULL COMMENT 'airport code',
  `depart_date` DATETIME NULL,
  `arrival_location` VARCHAR(500) NULL COMMENT 'airport code',
  `arrival_date` DATETIME NULL,
  `note` VARCHAR(500) NULL,
  `locators` VARCHAR(500) NOT NULL,
  `ticket_type` ENUM('group', 'individual') NULL COMMENT 'refund\nticketed\nrescheduled\n',
  `round_trip` ENUM('Y', 'N') NOT NULL,
  `adult_number` INT NOT NULL DEFAULT 0,
  `child_number` INT NOT NULL DEFAULT 0,
  `infant_number` INT NOT NULL DEFAULT 0,
  `refunded` ENUM('Y', 'N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`airticket_tour_id`),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  UNIQUE INDEX `locator_UNIQUE` (`locators` ASC),
  CONSTRAINT `at_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `at_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nmu`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`CustomerSource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`CustomerSource` (
  `source_id` INT NOT NULL AUTO_INCREMENT,
  `source_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`source_id`),
  UNIQUE INDEX `sourse_name_UNIQUE` (`source_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('airticket', 'group', 'individual') NOT NULL COMMENT 'type (selections provided on Web): \nadd ‘other type’',
  `group_tour_id` INT NULL,
  `indiv_tour_id` INT NULL,
  `airticket_tour_id` INT NULL,
  `salesperson_id` INT NOT NULL,
  `cc_id` INT NULL,
  `expense` DECIMAL(11,2) NOT NULL,
  `received` DECIMAL(11,2) NOT NULL,
  `received2` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `payment_type` ENUM('creditcard', 'mco', 'alipay', 'wechat', 'cash', 'check', 'other') NOT NULL COMMENT 'Payment (selections provided on Web): \ncredit card/mco/alipay/wechat pay/cash\n',
  `total_profit` DECIMAL(11,2) NOT NULL DEFAULT 0,
  `note` VARCHAR(1000) NULL,
  `create_time` DATETIME NOT NULL DEFAULT current_timestamp,
  `settle_time` DATETIME NULL DEFAULT current_timestamp,
  `source_id` INT NULL,
  `currency` ENUM('USD', 'RMB') NOT NULL,
  `lock_status` ENUM('Y', 'N') NOT NULL,
  `clear_status` ENUM('Y', 'N') NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC),
  INDEX `fk_cc_id_idx` (`cc_id` ASC),
  INDEX `fk_salesperson_id_idx` (`salesperson_id` ASC),
  INDEX `fk_indiv_id_idx` (`indiv_tour_id` ASC),
  INDEX `fk_airticket_id_idx` (`airticket_tour_id` ASC),
  INDEX `fk_source_id_idx` (`source_id` ASC),
  UNIQUE INDEX `group_tour_id_UNIQUE` (`group_tour_id` ASC),
  UNIQUE INDEX `indiv_tour_id_UNIQUE` (`indiv_tour_id` ASC),
  UNIQUE INDEX `airticket_tour_id_UNIQUE` (`airticket_tour_id` ASC),
  CONSTRAINT `fk_cc_id`
    FOREIGN KEY (`cc_id`)
    REFERENCES `nmu`.`CouponCode` (`cc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tr_salesperson_id`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `nmu`.`Salesperson` (`salesperson_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_indiv_id`
    FOREIGN KEY (`indiv_tour_id`)
    REFERENCES `nmu`.`IndividualTour` (`indiv_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_airticket_id`
    FOREIGN KEY (`airticket_tour_id`)
    REFERENCES `nmu`.`AirticketTour` (`airticket_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_source_id`
    FOREIGN KEY (`source_id`)
    REFERENCES `nmu`.`CustomerSource` (`source_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_id`
    FOREIGN KEY (`group_tour_id`)
    REFERENCES `nmu`.`GroupTour` (`group_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`TourDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`TourDetails` (
  `indiv_collection_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL,
  `indiv_tour_id` INT NULL,
  `join_date` DATETIME NULL,
  `leave_date` DATETIME NULL,
  `join_location` VARCHAR(45) NULL,
  `leave_location` VARCHAR(45) NULL,
  `note` VARCHAR(500) NULL,
  PRIMARY KEY (`indiv_collection_id`),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  INDEX `fk_indiv_tour_id_idx` (`indiv_tour_id` ASC),
  CONSTRAINT `ind_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nmu`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_indiv_tour_id`
    FOREIGN KEY (`indiv_tour_id`)
    REFERENCES `nmu`.`IndividualTour` (`indiv_tour_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Questions` (
  `question_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`question_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`LogRecords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`LogRecords` (
  `lr_id` INT NOT NULL,
  `user_id` VARCHAR(45) NULL,
  PRIMARY KEY (`lr_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`Rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`Rules` (
  `rule_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`rule_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`LeagueMember`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`LeagueMember` (
  `lm_id` INT NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `other_contact` VARCHAR(45) NULL,
  `other_contact_type` VARCHAR(45) NULL,
  `description` VARCHAR(500) NULL,
  `code` VARCHAR(45) NULL,
  `code_discount` VARCHAR(45) NULL,
  `code_discription` VARCHAR(500) NULL,
  `other_information` VARCHAR(1000) NULL,
  PRIMARY KEY (`lm_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  UNIQUE INDEX `code_discount_UNIQUE` (`code_discount` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`LeagueClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`LeagueClient` (
  `lc_id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NULL,
  `lname` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `other_contact` VARCHAR(45) NULL,
  `other_contact_type` VARCHAR(45) NULL,
  `option1` VARCHAR(45) NULL,
  `option2` VARCHAR(45) NULL,
  `option3` VARCHAR(45) NULL,
  `option4` VARCHAR(45) NULL,
  `depart_date` DATETIME NULL,
  `depart_location` VARCHAR(45) NULL,
  `arrival_date` DATETIME NULL,
  `arrival_location` VARCHAR(45) NULL,
  `other_preferences` VARCHAR(500) NULL,
  `note` VARCHAR(1000) NULL,
  `lm_id` INT NOT NULL,
  PRIMARY KEY (`lc_id`),
  INDEX `fk_pm_id_idx` (`lm_id` ASC),
  CONSTRAINT `fk_pm_id`
    FOREIGN KEY (`lm_id`)
    REFERENCES `nmu`.`LeagueMember` (`lm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nmu`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


-- -----------------------------------------------------
-- Table `nmu`.`timestamps_1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`timestamps_1` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);

USE `nmu` ;

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`AirticketOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`AirticketOrder` (`'create_time'` INT, `'settle_time'` INT, `transaction_id` INT, `type` INT, `lock_status` INT, `clear_status` INT, `salesperson_code` INT, `total_profit` INT, `expense` INT, `received` INT, `received2` INT, `flight_code` INT, `depart_date` INT, `depart_location` INT, `arrival_date` INT, `arrival_location` INT, `locators` INT, `adult_number` INT, `child_number` INT, `infant_number` INT, `ticket_type` INT, `round_trip` INT, `refunded` INT, `payment_type` INT, `code` INT, `source_name` INT, `note` INT, `full_name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`IndividualTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`IndividualTourOrder` (`'create_time'` INT, `'settle_time'` INT, `transaction_id` INT, `type` INT, `lock_status` INT, `clear_status` INT, `tour_name` INT, `product_code` INT, `salesperson_code` INT, `wholesaler_code` INT, `total_profit` INT, `expense` INT, `received` INT, `received2` INT, `payment_type` INT, `indiv_number` INT, `depart_date` INT, `arrival_date` INT, `code` INT, `source_name` INT, `note` INT, `c_list` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`GroupTourOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`GroupTourOrder` (`transaction_id` INT, `'create_time'` INT, `'settle_time'` INT, `group_tour_id` INT, `salesperson_code` INT, `price` INT, `'cost'` INT, `flight_number` INT, `bus_company` INT, `'schedule'` INT, `'guide_name'` INT, `'guide_phone'` INT, `agency_name` INT, `source_name` INT, `'coupon'` INT, `note` INT, `clear_status` INT, `lock_status` INT);

-- -----------------------------------------------------
-- Placeholder table for view `nmu`.`IndividualTourCustomerList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nmu`.`IndividualTourCustomerList` (`indiv_tour_id` INT, `'full_name'` INT, `'join_date'` INT, `join_location` INT, `'leave_date'` INT, `leave_location` INT, `phone` INT, `'other_contact'` INT, `note` INT);

-- -----------------------------------------------------
-- View `nmu`.`AirticketOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nmu`.`AirticketOrder`;
USE `nmu`;
CREATE  OR REPLACE VIEW `AirticketOrder` AS
select 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
date_format(t.settle_time, '%Y-%m-%d') as 'settle_time',
t.transaction_id, 
t.type, 
t.lock_status, 
t.clear_status, 
s.salesperson_code,
t.total_profit,
t.expense,
t.received,
t.received2,
at.flight_code,
at.depart_date,
at.depart_location,
at.arrival_date,
at.arrival_location,
at.locators,
at.adult_number,
at.child_number, 
at.infant_number,
at.ticket_type,
at.round_trip,
at.refunded, 
t.payment_type,
cc.code,
sn.source_name,
t.note,
cs.full_name
from Transactions t left join CustomerSource sn on t.source_id = sn.source_id 
left join CouponCode as cc on t.cc_id = cc.cc_id 
right join AirticketTour as at on t.airticket_tour_id = at.airticket_tour_id 
left join 
    (select c.customer_id, concat(c.lname, ' ',c.fname) as 'full_name' from Customer c) as cs on at.customer_id = cs.customer_id 
left join Salesperson s on t.salesperson_id = s.salesperson_id;

-- -----------------------------------------------------
-- View `nmu`.`IndividualTourOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nmu`.`IndividualTourOrder`;
USE `nmu`;
CREATE  OR REPLACE VIEW `IndividualTourOrder` AS
select date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
date_format(t.settle_time, '%Y-%m-%d') as 'settle_time', 
t.transaction_id, 
t.type, 
t.lock_status, 
t.clear_status, 
it.tour_name, 
it.product_code, 
s.salesperson_code, 
w.wholesaler_code, 
t.total_profit, 
t.expense, 
t.received, 
t.received2,
t.payment_type, 
it.indiv_number, 
it.depart_date, 
it.arrival_date,
cc.code, 
sn.source_name, 
t.note, gc.c_list
from Transactions as t left join CustomerSource as sn on t.source_id = sn.source_name 
left join Salesperson as s on t.salesperson_id = s.salesperson_id 
left join CouponCode as cc on t.cc_id = cc.cc_id right join IndividualTour as it on t.indiv_tour_id = it.indiv_tour_id 
left join Wholesaler as w on it.wholesaler_id = w.wholesaler_id 
left join 
    (select cs.indiv_tour_id, group_concat(cs.full_name separator ', ') as 'c_list' from 
    (select td.indiv_tour_id, concat(lname, ' ', fname) as 'full_name' from Customer as c 
    join TourDetails as td on c.customer_id = td.customer_id) as cs group by cs.indiv_tour_id) as gc on it.indiv_tour_id = gc.indiv_tour_id;

-- -----------------------------------------------------
-- View `nmu`.`GroupTourOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nmu`.`GroupTourOrder`;
USE `nmu`;
CREATE  OR REPLACE VIEW `GroupTourOrder` AS
SELECT 
t.transaction_id, 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
date_format(t.settle_time, '%Y-%m-%d') as 'settle_time', 
t.group_tour_id, 
s.salesperson_code, 
g.price,
concat(g.total_cost, ' (', g.reserve, ' / ', g.write_off, ')') AS 'cost', 
g.flight_number, 
g.bus_company, 
concat(date_format(g.start_date, '%Y-%m-%d'), ' / ', date_format(g.end_date, '%Y-%m-%d')) as 'schedule', 
concat(tg.fname, ' ', tg.lname) AS 'guide_name', 
tg.phone AS 'guide_phone', 
g.agency_name, 
cs.source_name, 
cc.discount AS 'coupon', 
t.note, 
t.clear_status, 
t.lock_status
FROM Transactions t 
INNER JOIN GroupTour g ON t.group_tour_id = g.group_tour_id
LEFT JOIN TouristGuide tg ON g.guide_id = tg.guide_id
LEFT JOIN CustomerSource cs ON t.source_id = cs.source_id
LEFT JOIN CouponCode cc ON t.cc_id = cc.cc_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id;

-- -----------------------------------------------------
-- View `nmu`.`IndividualTourCustomerList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nmu`.`IndividualTourCustomerList`;
USE `nmu`;
CREATE  OR REPLACE VIEW `IndividualTourCustomerList` AS
select td.indiv_tour_id, 
concat(c.fname, ' ', c.lname) as 'full_name', 
date_format(td.join_date, '%Y-%m-%d') as 'join_date', 
td.join_location, 
date_format(td.leave_date, '%Y-%m-%d') as 'leave_date', 
td.leave_location, 
c.phone, 
concat(c.other_contact_type, ': ', c.other_contact_number) as 'other_contact',
td.note
from TourDetails as td left join Customer as c on td.customer_id = c.customer_id;
USE `nmu`;

DELIMITER $$
USE `nmu`$$
CREATE DEFINER = CURRENT_USER TRIGGER `nmu`.`update_settle_time_and_ptofit` AFTER UPDATE ON `Transactions` FOR EACH ROW
BEGIN
update nmu.Transactions set new.settle_time = current_timestamp;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
