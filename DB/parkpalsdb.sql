-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema parkpalsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `parkpalsdb` ;

-- -----------------------------------------------------
-- Schema parkpalsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parkpalsdb` DEFAULT CHARACTER SET utf8 ;
USE `parkpalsdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `street_2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `active` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  `aboutme` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `date_created` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_address_idx` (`address_id` ASC),
  CONSTRAINT `fk_user_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park` ;

CREATE TABLE IF NOT EXISTS `park` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `notable_features` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `address_id` INT NOT NULL,
  `active` TINYINT NULL,
  `website_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_park_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_park_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trail` ;

CREATE TABLE IF NOT EXISTS `trail` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `longitude` DOUBLE NULL,
  `latitude` DOUBLE NULL,
  `length_in_miles` DECIMAL NULL,
  `park_id` INT NOT NULL,
  `active` TINYINT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trail_park1_idx` (`park_id` ASC),
  CONSTRAINT `fk_trail_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meetup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup` ;

CREATE TABLE IF NOT EXISTS `meetup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `meetup_date` DATETIME NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NULL,
  `trail_id` INT NOT NULL,
  `creator_id` INT NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meet_up_trail1_idx` (`trail_id` ASC),
  INDEX `fk_meet_up_user1_idx` (`creator_id` ASC),
  CONSTRAINT `fk_meet_up_trail1`
    FOREIGN KEY (`trail_id`)
    REFERENCES `trail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meet_up_user1`
    FOREIGN KEY (`creator_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meetup_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup_rating` ;

CREATE TABLE IF NOT EXISTS `meetup_rating` (
  `user_id` INT NOT NULL,
  `meetup_id` INT NOT NULL,
  `comment` TEXT NULL,
  `rating` INT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`user_id`, `meetup_id`),
  INDEX `fk_user_has_meet_up_meet_up1_idx` (`meetup_id` ASC),
  INDEX `fk_user_has_meet_up_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_meet_up_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_meet_up_meet_up1`
    FOREIGN KEY (`meetup_id`)
    REFERENCES `meetup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `trail_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `trail_rating` ;

CREATE TABLE IF NOT EXISTS `trail_rating` (
  `user_id` INT NOT NULL,
  `trail_id` INT NOT NULL,
  `rating` INT NULL,
  `comment` TEXT NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`user_id`, `trail_id`),
  INDEX `fk_user_has_trail_trail1_idx` (`trail_id` ASC),
  INDEX `fk_user_has_trail_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_trail_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_trail_trail1`
    FOREIGN KEY (`trail_id`)
    REFERENCES `trail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park_rating` ;

CREATE TABLE IF NOT EXISTS `park_rating` (
  `user_id` INT NOT NULL,
  `park_id` INT NOT NULL,
  `rating` INT NULL,
  `comment` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `create_date` DATETIME NULL,
  `last_update` DATETIME NULL,
  PRIMARY KEY (`user_id`, `park_id`),
  INDEX `fk_user_has_park_park1_idx` (`park_id` ASC),
  INDEX `fk_user_has_park_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_park_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_park_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `park_visit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `park_visit` ;

CREATE TABLE IF NOT EXISTS `park_visit` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` TEXT NULL,
  `arrival_date` DATE NULL,
  `depart_date` DATE NULL,
  `user_id` INT NOT NULL,
  `park_id` INT NOT NULL,
  `wildlife_seen` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_park_visit_user1_idx` (`user_id` ASC),
  INDEX `fk_park_visit_park1_idx` (`park_id` ASC),
  CONSTRAINT `fk_park_visit_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_park_visit_park1`
    FOREIGN KEY (`park_id`)
    REFERENCES `park` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `visit_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `visit_image` ;

CREATE TABLE IF NOT EXISTS `visit_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(2000) NULL,
  `caption` VARCHAR(45) NULL,
  `park_visit_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_visit_image_park_visit1_idx` (`park_visit_id` ASC),
  CONSTRAINT `fk_visit_image_park_visit1`
    FOREIGN KEY (`park_visit_id`)
    REFERENCES `park_visit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amenity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `amenity` ;

CREATE TABLE IF NOT EXISTS `amenity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `amenity_has_trail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `amenity_has_trail` ;

CREATE TABLE IF NOT EXISTS `amenity_has_trail` (
  `amenity_id` INT NOT NULL,
  `trail_id` INT NOT NULL,
  PRIMARY KEY (`amenity_id`, `trail_id`),
  INDEX `fk_amenity_has_trail_trail1_idx` (`trail_id` ASC),
  INDEX `fk_amenity_has_trail_amenity1_idx` (`amenity_id` ASC),
  CONSTRAINT `fk_amenity_has_trail_amenity1`
    FOREIGN KEY (`amenity_id`)
    REFERENCES `amenity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_amenity_has_trail_trail1`
    FOREIGN KEY (`trail_id`)
    REFERENCES `trail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meetup_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup_comment` ;

CREATE TABLE IF NOT EXISTS `meetup_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_date` DATETIME NULL,
  `comment` TEXT NULL,
  `reply_id` INT NULL,
  `user_id` INT NOT NULL,
  `meetup_id` INT NOT NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meetup_comment_meetup_comment1_idx` (`reply_id` ASC),
  INDEX `fk_meetup_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_meetup_comment_meetup1_idx` (`meetup_id` ASC),
  CONSTRAINT `fk_meetup_comment_meetup_comment1`
    FOREIGN KEY (`reply_id`)
    REFERENCES `meetup_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meetup_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meetup_comment_meetup1`
    FOREIGN KEY (`meetup_id`)
    REFERENCES `meetup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_friend`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_friend` ;

CREATE TABLE IF NOT EXISTS `user_friend` (
  `user_id` INT NOT NULL,
  `user_id1` INT NOT NULL,
  PRIMARY KEY (`user_id`, `user_id1`),
  INDEX `fk_user_has_user_user2_idx` (`user_id1` ASC),
  INDEX `fk_user_has_user_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`user_id1`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS parkpalsuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'parkpalsuser'@'localhost' IDENTIFIED BY 'parkpals';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'parkpalsuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (1, '123 Main st', NULL, 'Smith', 'va', '23333', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (1, 'admin', '1234', 'Cortnie', 'Wirtanen', 1, 'ADMIN', 1, NULL, NULL, NULL, NULL);

COMMIT;

