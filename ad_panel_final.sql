-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ad_panel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ad_panel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ad_panel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ad_panel` ;

-- -----------------------------------------------------
-- Table `ad_panel`.`panel_procuder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`panel_procuder` (
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`region` (
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`city` (
  `name` VARCHAR(60) NOT NULL,
  `region_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `city_region` (`region_name` ASC) VISIBLE,
  CONSTRAINT `city_region`
    FOREIGN KEY (`region_name`)
    REFERENCES `ad_panel`.`region` (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`trademark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`trademark` (
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`shop` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `telephone` VARCHAR(12) NULL DEFAULT NULL,
  `manager` VARCHAR(100) NULL DEFAULT NULL,
  `description` VARCHAR(1000) NULL DEFAULT NULL,
  `time_open` TIME NOT NULL,
  `time_closed` TIME NULL DEFAULT NULL,
  `avg_visitors` INT NULL DEFAULT NULL,
  `square` INT NOT NULL,
  `city_name` VARCHAR(60) NOT NULL,
  `trademark_name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `shop_city` (`city_name` ASC) VISIBLE,
  INDEX `shop_trademark` (`trademark_name` ASC) VISIBLE,
  CONSTRAINT `shop_city`
    FOREIGN KEY (`city_name`)
    REFERENCES `ad_panel`.`city` (`name`),
  CONSTRAINT `shop_trademark`
    FOREIGN KEY (`trademark_name`)
    REFERENCES `ad_panel`.`trademark` (`name`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `info` TEXT NOT NULL,
  `producer` VARCHAR(100) NOT NULL,
  `company_presented` VARCHAR(50) NOT NULL,
  `duration` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`ad_panel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`ad_panel` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `diagonal` VARCHAR(5) NOT NULL,
  `color` VARCHAR(25) NULL DEFAULT NULL,
  `Hz` INT NOT NULL,
  `weight` INT NOT NULL,
  `department` VARCHAR(40) NULL DEFAULT NULL,
  `panel_procuder_name` VARCHAR(60) NOT NULL,
  `shop_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ad_panel_panel_procuder` (`panel_procuder_name` ASC) VISIBLE,
  INDEX `ad_panel_shop` (`shop_id` ASC) VISIBLE,
  INDEX `ad_panel_video` (`video_id` ASC) VISIBLE,
  CONSTRAINT `ad_panel_panel_procuder`
    FOREIGN KEY (`panel_procuder_name`)
    REFERENCES `ad_panel`.`panel_procuder` (`name`),
  CONSTRAINT `ad_panel_shop`
    FOREIGN KEY (`shop_id`)
    REFERENCES `ad_panel`.`shop` (`id`),
  CONSTRAINT `ad_panel_video`
    FOREIGN KEY (`video_id`)
    REFERENCES `ad_panel`.`video` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`shop_department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`shop_department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `shop_department_shop` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `shop_department_shop`
    FOREIGN KEY (`shop_id`)
    REFERENCES `ad_panel`.`shop` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ad_panel`.`visitor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ad_panel`.`visitor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `forename` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  `gender` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(35) NULL DEFAULT NULL,
  `telephone` VARCHAR(12) NOT NULL,
  `city_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `client_city` (`city_name` ASC) VISIBLE,
  CONSTRAINT `client_city`
    FOREIGN KEY (`city_name`)
    REFERENCES `ad_panel`.`city` (`name`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
