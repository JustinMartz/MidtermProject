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
  `id` INT NOT NULL AUTO_INCREMENT,
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
  `id` INT NOT NULL AUTO_INCREMENT,
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `longitude` VARCHAR(45) NULL,
  `latitude` VARCHAR(45) NULL,
  `length_in_miles` DOUBLE NULL,
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
  `user_id` INT NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_meet_up_trail1_idx` (`trail_id` ASC),
  INDEX `fk_meet_up_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_meet_up_trail1`
    FOREIGN KEY (`trail_id`)
    REFERENCES `trail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meet_up_user1`
    FOREIGN KEY (`user_id`)
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
  `friend_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `friend_id`),
  INDEX `fk_user_has_user_user2_idx` (`friend_id` ASC),
  INDEX `fk_user_has_user_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`friend_id`)
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
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (1, '123 Main st', NULL, 'Smith', 'va', '23333', '9999999999');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (2, '555 Jump st', NULL, 'cooldown', 'ca', '45621', '5555555555');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (3, '785 Place st', NULL, 'jumpup', 'va', '48631', '4444444444');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (4, '456 Street ln', NULL, 'runaround', 'ga', '78532', '3333333333');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (5, '20 South Entrance Road Grand Canyon', NULL, 'Flagstaff', 'AZ ', '86023', '9286387888');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (6, 'Yellowstone National Park', 'PO Box 168 ', 'N/A', 'WY', '82190', '3073447381');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (7, 'Mesa Verde National Park', 'PO Box 8\n', 'N/A', 'CO ', '81330', '9705294465');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (8, '107 Park Headquarters Road', NULL, 'Gatlinburg', 'TN', '37738', '8654361200');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (9, '40001 State Road 9336', NULL, 'Homestead', 'FL ', '33034', '3052427700');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (10, '6715 W Colfax Ave', NULL, 'Lakewood', 'CO', '80214', '3032325115');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (11, 'Glacier Park', 'PO Box 128', 'West Glacier', 'MT', '59936', '4068887800');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (12, '28867 Flowers Springs', 'PO Box 3632', 'New Jeremiahborough', 'MO', '81442', '9179647866');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (13, '815 Stafford Lakes', 'PO Box 8136', 'New Lisa', 'NE', '84660', '8232871346');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (14, '7666 Hubbard Mall', 'Apt 68', 'East Deborahview', 'AZ', '28079', '9675317789');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (15, '1649 Jillian Stravenue', 'Apt 39', 'Martinport', 'SC', '08389', '3659232572');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (16, '613 Allison Station', 'Apt 41', 'South Taraburgh', 'UT', '14901', '7910634481');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (17, '598 Smith Groves', 'Apt 66', 'East Maryborough', 'WA', '08611', '6905362574');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (18, '242 Ellis Bypass', 'PO Box 7874', 'North Feliciaton', 'HI', '56832', '1091132862');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (19, '213 Ruiz Trail', 'PO Box 8359', 'Paigeshire', 'WI', '40845', '9147888782');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (20, '4200 Jackie Forge', 'Apt 91', 'Stevensbury', 'GU', '85968', '4265047469');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (21, '385 Marie Shoals', 'PO Box 3934', 'Douglasburgh', 'NY', '23585', '9045203008');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (22, '61333 Deborah Greens', 'Apt 20', 'Port Angelaburgh', 'VT', '99749', '7875959623');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (23, '300 Lamb Throughway', 'Apt 34', 'East Jasmineside', 'FL', '55856', '6258640624');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (24, '20304 Miles Passage', 'PO Box 2167', 'Toddside', 'DC', '20925', '6377498255');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (25, '6775 Pena Landing', 'Apt 29', 'Lake Robert', 'WA', '37210', '6902271170');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (26, '6773 Allen Shore', 'Apt 43', 'Thompsonburgh', 'CA', '36186', '7425233717');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (27, '0199 Freeman Divide', 'Apt 57', 'Millermouth', 'ID', '43032', '9654116789');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (28, '11619 Carol Plaza', 'PO Box 7086', 'East Sarah', 'AK', '01445', '7112099952');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (29, '5926 Castillo Knoll', 'PO Box 7847', 'Lindsaychester', 'AZ', '15849', '8499833542');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (30, '652 Robert Summit', 'Apt 32', 'Port John', 'AL', '03638', '6389319795');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (31, '978 Martin Shoal', 'Apt 87', 'New Johnathanfort', 'AZ', '03544', '3675557249');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (32, '299 Washington Extensions', 'Apt 96', 'New Johnathan', 'MN', '68552', '4714157951');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (33, '764 Carrillo Creek', 'PO Box 3572', 'North Donna', 'MS', '81402', '8599780306');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (34, '09729 Gregory Vista', 'Apt 39', 'Tylerton', 'IN', '25659', '6181438584');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (35, '2173 Serrano Place', 'Apt 27', 'Johnsonton', 'HI', '33432', '7776052581');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (36, '93456 Cline Fields', 'Apt 27', 'Davisfurt', 'IA', '00898', '5827354971');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (37, '092 Marcus Burgs', 'Apt 31', 'Williamfort', 'HI', '93119', '6601405135');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (38, '772 Roberts Stravenue', 'PO Box 9712', 'Port Tammyland', 'VI', '41984', '3909671058');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (39, '518 Michael Club', 'Apt 85', 'Cynthiaport', 'MP', '88108', '7260047437');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (40, '2688 Matthew Stravenue', 'PO Box 3897', 'Matthewborough', 'GU', '38101', '4714941257');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (41, '33602 John Walks', 'Apt 27', 'Kellerport', 'DE', '72275', '4838379345');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (42, '2049 Christopher Square', 'PO Box 868', 'Lisashire', 'VI', '60508', '8472410444');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (43, '515 Alec Gateway', 'PO Box 1798', 'West Sherry', 'AK', '75488', '3847240789');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (44, '46833 Emily Path', 'Apt 34', 'Gonzalezhaven', 'VA', '94289', '1173703762');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (45, '65333 Christopher Road', 'PO Box 2525', 'Port Mistyton', 'AZ', '35476', '1200351107');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (46, '074 Vincent Parkway', 'Apt 91', 'Port Markchester', 'IL', '15177', '8264185906');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (47, '60790 Miranda Bridge', 'PO Box 3805', 'New Nicoleberg', 'ID', '15674', '6240710207');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (48, '5397 Veronica Prairie', 'Apt 56', 'Martinside', 'WV', '95100', '4638552838');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (49, '8432 Sherry Pines', 'Apt 88', 'Port Andrew', 'IA', '24338', '4148715487');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (50, '01469 Smith Grove', 'PO Box 4663', 'Mendozabury', 'CA', '05521', '9228500890');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (51, '364 Tammy Point', 'PO Box 6532', 'West Melissa', 'MO', '94886', '1550395892');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (52, '412 Mallory Club', 'PO Box 7034', 'Leonardtown', 'NC', '72259', '4385819337');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (53, '4898 Desiree Fields', 'PO Box 9433', 'Sharonbury', 'MA', '25685', '3149192809');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (54, '80312 Austin Heights', 'PO Box 5713', 'New Jackstad', 'CA', '20085', '2509575118');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (55, '1385 Daniel Islands', 'Apt 6', 'Brandihaven', 'AS', '73671', '9442037179');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (56, '3488 Brandy Crest', 'PO Box 8279', 'Port Christopher', 'OK', '53928', '5052143863');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (57, '52590 Rogers Crest', 'Apt 56', 'North Jayville', 'CO', '09093', '2699084653');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (58, '78365 Alexandra Throughway', 'Apt 9', 'Port Micheal', 'OK', '27451', '7828527346');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (59, '3928 Patel Shore', 'PO Box 2016', 'West Joshua', 'WY', '90424', '3929522266');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (60, '271 Haley Skyway', 'PO Box 4276', 'Lake Billyview', 'WV', '40987', '8642658400');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (61, '412 Nicole Ports', 'PO Box 3406', 'Michaelland', 'MD', '60218', '6340905292');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (62, '66168 Castillo Turnpike', 'PO Box 6627', 'Oscarburgh', 'NC', '45279', '2508380557');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (63, '271 Guerra Port', 'PO Box 9308', 'Meganburgh', 'MH', '68770', '1624788990');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (64, '89869 Mason Knoll', 'Apt 73', 'Cruzside', 'CA', '64952', '7289455315');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (65, '9185 Dorsey Fall', 'PO Box 2872', 'Kristyville', 'TN', '58556', '7820791130');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (66, '741 Marquez Lights', 'Apt 18', 'East Samantha', 'MS', '69008', '1775627005');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (67, '4214 Patricia Expressway', 'PO Box 9869', 'Ashleyburgh', 'HI', '04090', '9285027802');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (68, '841 Harvey Mall', 'Apt 21', 'Garciaside', 'DC', '83107', '4385759884');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (69, '38574 Clifford Mission', 'PO Box 9702', 'Elijahchester', 'NV', '22418', '3105553368');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (70, '99818 Thomas Lights', 'PO Box 8500', 'Elizabethhaven', 'NJ', '09723', '4680496393');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (71, '92535 Kidd Trafficway', 'Apt 52', 'South Michaelstad', 'CT', '89599', '6896894465');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (72, '62716 Michael Divide', 'Apt 63', 'West Ann', 'GU', '31290', '8649375068');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (73, '624 Davis Alley', 'PO Box 3129', 'Wheelermouth', 'WY', '05231', '6073015713');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (74, '084 Jessica Ville', 'PO Box 7975', 'Boydland', 'DC', '89491', '9135655457');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (75, '397 Amanda Unions', 'Apt 40', 'Stacyburgh', 'MN', '15819', '8190925347');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (76, '67589 Cynthia Land', 'Apt 40', 'New Jonathan', 'AR', '57061', '3147217536');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (77, '60995 Villegas Drive', 'PO Box 696', 'Lake Robert', 'NH', '31385', '5529232612');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (78, '763 Jackie Villages', 'Apt 8', 'New Michaelborough', 'HI', '16960', '1034521043');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (79, '03788 Ricardo Square', 'PO Box 1355', 'New Sara', 'NV', '31181', '6239479399');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (80, '404 Thomas Run', 'PO Box 1239', 'Stevenview', 'PA', '85581', '3291632855');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (81, '78657 Hanson Mews', 'PO Box 6889', 'West Justinton', 'IN', '42361', '9117238448');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (82, '631 Fox Run', 'Apt 71', 'Clarkmouth', 'VA', '85496', '7873464847');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (83, '0041 Christine Shore', 'Apt 53', 'West Autumnborough', 'PR', '90824', '1300338992');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (84, '3751 Paul Parkway', 'Apt 99', 'East Anthonychester', 'MD', '42808', '4205689889');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (85, '41347 Rebecca Trafficway', 'PO Box 144', 'New Michaelchester', 'NE', '08932', '5153115122');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (86, '056 Brian Views', 'PO Box 7603', 'Port Seantown', 'AR', '46383', '2724310728');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (87, '0283 Anita Village', 'PO Box 6002', 'West Annetteland', 'TN', '49725', '1533719115');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (88, '3080 Mccarthy Parkway', 'PO Box 4394', 'Gonzalestown', 'RI', '44112', '7607373450');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (89, '74229 Medina Via', 'PO Box 7561', 'Port Walterland', 'TN', '36210', '5563852049');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (90, '172 Thompson Locks', 'PO Box 3398', 'Acevedofort', 'MN', '19033', '3015018177');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (91, '00674 Carter Lodge', 'Apt 45', 'Walterstown', 'FL', '60768', '8882917858');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (92, '0914 Fox Points', 'PO Box 4030', 'East Monica', 'NJ', '30714', '4120418377');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (93, '142 Miller Ports', 'PO Box 1855', 'Reyesberg', 'IA', '12333', '4669957052');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (94, '4003 Salazar Valleys', 'PO Box 403', 'New Pamelaview', 'MN', '37250', '4296312816');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (95, '492 Figueroa Vista', 'Apt 56', 'Sellersport', 'KY', '86639', '6690989839');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (96, '711 Cox Forest', 'Apt 36', 'South Brandonburgh', 'DE', '61662', '7000470432');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (97, '5198 Mcknight Crescent', 'PO Box 5160', 'East Emily', 'MA', '93601', '7724664213');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (98, '78196 David Mission', 'Apt 52', 'Port Rachelland', 'MT', '05945', '8671188119');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (99, '63891 Lopez Bypass', 'Apt 70', 'Lake Clayton', 'NM', '44485', '2674401829');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (100, '828 Alexander Road', 'Apt 29', 'Kellymouth', 'AR', '58793', '7356169427');
INSERT INTO `address` (`id`, `street`, `street_2`, `city`, `state`, `zip_code`, `phone`) VALUES (101, '743 Holmes Field', 'Apt 25', 'Lake Joyceville', 'MS', '16573', '4542939999');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (1, 'admin', '1234', 'Cortnie', 'Wirtanen', 1, 'ADMIN', 1, 'cool calm collected', 'http://fakeurl.com', '2020-01-01 10:10:10', '2020-03-01 10:11:20');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (2, 'Sam2', '4567', 'Sam', 'Fath', 1, NULL, 2, 'cool calm collected', 'http://fakeurl.com', '2023-02-02 10-10-10', '2023-02-02 10-10-10');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (3, 'Justin3', '8910', 'Justin ', 'Martz', 1, NULL, 3, 'cool calm collected', 'http://fakeurl.com', '2023-02-02 10-10-10', '2023-02-02 10-10-10');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (4, 'Dean4', '1112', 'Dean', 'Coffman', 1, NULL, 4, 'cool calm collected', 'http://fakeurl.com', '2023-02-02 10-10-10', '2023-02-02 10-10-10');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (14, 'kim24', '_4*a&Otpiw', 'Richard', 'Johnson', 0, 'user', 14, 'Wildlife Lake Mountain Sunrise Canoeing Fishing', 'https://imagelink5.com', '2023-08-01 00:00:00', '2023-08-02 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (12, 'masonmatthew', '6_142QjVyf', 'Micheal', 'Russell', 1, 'user', 12, 'Stroll Recreation Lake Camping Outdoor Climbing', 'https://imagelink6.com', '2023-08-06 00:00:00', '2023-08-09 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (13, 'leonardmichael', 'j6WU%ax(_W', 'Rickey', 'Davis', 0, 'user', 13, 'Ocean Relaxation Trekking Picnic Swimming Yoga', 'https://imagelink7.com', '2023-08-11 00:00:00', '2023-08-13 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (18, 'kaitlynhughes', 'l$0Egmqtq7', 'Brandy', 'Smith', 0, 'user', 19, 'Sailing Summit Yoga Lake Forest Fun', 'https://imagelink8.com', '2023-08-16 00:00:00', '2023-08-19 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (5, 'gabriel10', '4cOOyaC0@J', 'Christopher', 'Lewis', 0, 'user', 5, 'Birdwatching Camping Explore Hike Waterfall Canoeing', 'https://imagelink9.com', '2023-08-21 00:00:00', '2023-08-22 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (19, 'jordanandrew', 'E4cCy0$p+f', 'Jacob', 'Mercado', 1, 'user', 18, 'Sailing Jogging Trail Snowboarding Night Yoga', 'https://imagelink10.com', '2023-08-26 00:00:00', '2023-08-28 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (17, 'dawsonjessica', '*1H!Db%j$%', 'Kristen', 'Smith', 1, 'user', 17, 'Scenery Sailing Trekking Kayaking Adventure Night', 'https://imagelink11.com', '2023-08-31 00:00:00', '2023-09-01 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (9, 'nespinoza', '#7CRmVBa56', 'Shelly', 'Cooley', 0, 'user', 9, 'Nature Climbing Camping Leisure Picnic Trekking', 'https://imagelink12.com', '2023-09-05 00:00:00', '2023-09-09 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (16, 'medinabilly', 'bx03H$hLt&', 'Jesse', 'Summers', 1, 'user', 16, 'Sailing Nature Birdwatching Night Ocean Relaxation', 'https://imagelink13.com', '2023-09-10 00:00:00', '2023-09-12 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (15, 'jjohnson', 'df(6z%Mb7^', 'Stephanie', 'Lee', 0, 'user', 15, 'Skiing Biking Swimming Sailing Photography Climbing', 'https://imagelink14.com', '2023-09-15 00:00:00', '2023-09-17 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (10, 'ssmith', 'lS*0Kojubc', 'Patrick', 'Miller', 1, 'user', 10, 'Meditation Journey River Nature Swimming Mountain', 'https://imagelink15.com', '2023-09-20 00:00:00', '2023-09-23 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (6, 'nealedwin', '&1dM0Gbh1Y', 'Diana', 'Jones', 1, 'user', 6, 'Surfing Star Sailing Scenery Meditation Waterfall', 'https://imagelink16.com', '2023-09-25 00:00:00', '2023-09-27 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (11, 'scarter', 'net1(8TkzU', 'Lawrence', 'Phillips', 1, 'user', 11, 'Holiday Mountain Star Leisure Sunrise Outdoor', 'https://imagelink17.com', '2023-09-30 00:00:00', '2023-10-01 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (7, 'daniel10', '+3PQevjP#J', 'Matthew', 'Murphy', 1, 'user', 7, 'Summit Birdwatching Camping Fun Vacation Sunset', 'https://imagelink18.com', '2023-10-05 00:00:00', '2023-10-10 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (20, 'jacquelinewilson', 'y_4qMvdVDv', 'Christopher', 'Gilbert', 1, 'user', 8, 'Biking Mountain Excursion Picnic Star Nature', 'https://imagelink19.com', '2023-10-10 00:00:00', '2023-10-13 00:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `park`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (1, 'Grand Canyon National Park', 'The Grand Canyon is a vast and awe-inspiring natural wonder located in the southwestern United States. Carved over millions of years by the Colorado River, it is one of the most iconic and breathtaking landscapes on Earth. The canyon stretches approximately 277 miles (446 kilometers) long and reaches depths of over a mile (1.6 kilometers), exposing a geologic history that spans nearly two billion years. Its sheer cliffs and vibrant, multi-colored rock formations offer a mesmerizing display of geological beauty. The Grand Canyon is not only a popular tourist destination but also a designated UNESCO World Heritage Site, attracting millions of visitors each year who come to marvel at its splendor and explore its unique ecosystems.', 'Unique Geological Layers: The exposed rock layers in the Grand Canyon offer a remarkable geological history, displaying millions of years of Earth\'s history. These layers consist of different colors, textures, and compositions, providing valuable insights into the planet\'s geological evolution.', 'https://www.outsideonline.com/adventure-travel/national-parks/grand-canyon-travel-guide/', 5, 1, 'https://www.casabonitadenver.com/');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (2, 'Yellowstone National Park', 'Yellowstone National Park is a renowned and vast natural wonder located primarily in the U.S. states of Wyoming, Montana, and Idaho. Established in 1872, it was the first national park in the world. The park\'s most distinctive feature is its geothermal activity, boasting more than 10,000 geysers, hot springs, and other hydrothermal features. The most famous geyser, Old Faithful, regularly erupts, drawing crowds to witness its impressive displays.\n\nYellowstone\'s diverse ecosystem supports a wide range of wildlife, including grizzly bears, wolves, elk, bison, and numerous bird species. The park\'s stunning landscapes encompass majestic mountains, expansive forests, winding rivers, and picturesque lakes.\n\nAdditionally, the Yellowstone Caldera, a massive volcanic crater, underlies much of the park and contributes to its geothermal activity. While the park\'s beauty and geological significance are its major draws, visitors also come to enjoy outdoor activities like hiking, camping, wildlife viewing, and photography. Yellowstone National Park stands as a cherished symbol of America\'s commitment to preserving its natural treasures for future generations.', 'Yellowstone Lake: As the largest high-altitude lake in North America, Yellowstone Lake covers over 130 square miles and provides breathtaking views and recreational opportunities.', 'https://www.nps.gov/yell/index.htm', 6, 1, 'https://www.nps.gov/yell/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (3, 'Mesa Verde National Park', 'Mesa Verde National Park is a captivating and historically significant protected area located in the southwestern United States, specifically in the state of Colorado. Renowned for its well-preserved ancient cliff dwellings, it offers visitors a glimpse into the rich cultural heritage of the ancestral Puebloan people.\n\nThe park\'s main attraction is its impressive collection of ancient cliff dwellings, which were once inhabited by the Puebloan people over 700 years ago. These intricate structures were carved directly into the cliffs, showcasing remarkable architectural skills and a deep connection to the natural environment. Visitors can explore these dwellings through guided tours and learn about the lives and customs of the ancient inhabitants.\n\nAside from the cliff dwellings, Mesa Verde National Park boasts diverse landscapes with picturesque mesas, canyons, and woodlands, making it a perfect destination for outdoor enthusiasts and nature lovers. The park offers a range of recreational activities, including hiking, camping, and birdwatching, allowing visitors to immerse themselves in the breathtaking scenery.\n\nMesa Verde\'s cultural significance and stunning landscapes have earned it the designation as a UNESCO World Heritage Site and a cherished place for preserving and celebrating the ancient history of the Native American people. It continues to inspire awe and wonder in all who have the opportunity to experience its beauty and history firsthand.', 'Long House: This massive cliff dwelling contains more than 150 rooms and 21 kivas. It provides an excellent example of the elaborate architecture and engineering skills of the ancient Puebloan people.', 'https://national-park.com/wp-content/uploads/2016/04/Welcome-to-Mesa-Verde-National-Park.jpg', 7, 1, 'https://www.nps.gov/meve/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (4, 'Great Smoky Mountains National Park', 'The Great Smoky Mountains National Park, located on the border of North Carolina and Tennessee, is a renowned natural treasure in the southeastern United States. Established in 1934, it is one of the most visited national parks in the country.\n\nEncompassing over 800 square miles of pristine wilderness, the park is named for the characteristic haze that often hovers over its ancient mountains. The park\'s breathtaking landscape is marked by lush forests, cascading waterfalls, diverse plant and animal life, and rugged mountain peaks, with Clingmans Dome standing as the highest point in the Smokies.\n\nThe Great Smoky Mountains are celebrated for their rich biodiversity, boasting a vast array of plant and animal species, including black bears, deer, elk, and more. The park is a haven for outdoor enthusiasts, offering over 800 miles of well-maintained hiking trails, from easy walks to challenging backcountry routes.\n\nVisitors to the park can explore historic structures that harken back to its early settlers, gaining insights into the region\'s cultural heritage. Additionally, the park\'s scenic drives provide breathtaking vistas and opportunities for photography and relaxation.\n\nWhether visitors seek adventure, nature appreciation, or a peaceful retreat, the Great Smoky Mountains National Park offers a remarkable and unforgettable experience that showcases the beauty and diversity of the Appalachian region.', 'Waterfalls: Great Smoky Mountains National Park is dotted with numerous waterfalls, varying in size and accessibility. Some well-known waterfalls include Abrams Falls, Rainbow Falls, and Grotto Falls.', 'https://patriotgetaways.com/blog/wp-content/uploads/2017/04/hiking-in-the-smoky-mountains.jpg', 8, 1, 'https://www.nps.gov/grsm/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (5, 'Everglades National Park', 'Everglades National Park is a unique and diverse natural wonder located in southern Florida, United States. Established in 1947, it is the third-largest national park in the lower 48 states, covering approximately 1.5 million acres of wetlands, mangroves, sawgrass prairies, and diverse ecosystems.\n\nKnown as the \"River of Grass,\" the park is a vast, slow-moving, shallow river system that provides a critical habitat for an abundance of wildlife, including alligators, crocodiles, manatees, and numerous bird species, making it one of the most biodiverse regions in the country. It is also home to endangered species such as the Florida panther and the West Indian manatee.\n\nEverglades National Park offers visitors a chance to explore its natural beauty through various activities, such as hiking, bird-watching, kayaking, and airboat tours. Moreover, it provides valuable educational opportunities to learn about the delicate balance of this fragile ecosystem and the importance of conservation efforts to preserve its natural treasures for future generations. The park is not only a sanctuary for wildlife but also a symbol of the unique and complex interplay between land, water, and life.', '\"River of Grass\": The Everglades is often referred to as the \"River of Grass\" due to the slow, shallow flow of water over the vast expanse of sawgrass prairies. This unique landscape is one of the defining characteristics of the park.', 'https://www.outsideonline.com/adventure-travel/national-parks/everglades-national-park-travel-guide/', 9, 1, 'https://www.nps.gov/ever/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (6, 'Casa Bonita: An Enchanting Oasis of Fun', 'Nestled in the heart of Colorado, Casa Bonita stands as a one-of-a-kind destination, akin to a national park, where adventure, enchantment, and flavorsome delights converge. This unique establishment is not your typical park, but it embodies a distinctive charm that captivates visitors of all ages.\n\nCasa Bonita\'s facade hints at a mesmerizing Mexican village, complete with vibrant colors and intricate architectural details. Upon stepping inside, visitors are transported to a world of wonder and excitement. The interior is a sprawling wonderland, designed to evoke the essence of a bustling Mexican marketplace. A myriad of themed dining areas and attractions await around every corner, ensuring an immersive experience like no other.\n\nAs visitors explore Casa Bonita, they encounter an array of sights and sounds, from cascading waterfalls and glistening caves to lively mariachi bands and captivating live performances. Each themed dining area boasts its unique atmosphere, offering an escape into various Mexican-inspired backdrops.\n\nOne of the main highlights at Casa Bonita is the mesmerizing cliff divers, who gracefully leap from towering cliffs into a crystal-clear pool, leaving spectators in awe. The theatrical flair extends to the adventurous Black Bart\'s Cave, where daring guests embark on a simulated treasure hunt through mysterious caverns and hidden passages.\n\nTo satisfy appetites, Casa Bonita boasts a diverse menu of traditional Mexican dishes and Tex-Mex delights. From sizzling fajitas to mouthwatering enchiladas, the flavors reflect the vibrant culinary heritage of Mexico. Guests can savor their meals amidst the immersive ambiance, surrounded by cascading waterfalls and lush greenery, creating an unforgettable dining experience.\n\nAt Casa Bonita, visitors can embrace their inner child, diving into a colorful and whimsical world filled with magic and discovery. It\'s a place where laughter echoes through the halls and memories are etched in hearts forever.\n\nIn essence, Casa Bonita may not be an official national park, but it offers a unique and unparalleled adventure that beckons travelers from near and far. A sanctuary of fun, flavors, and enchantment, it captures the essence of a fantastical escape that promises to leave every guest enchanted and inspired.', 'Cliff Divers: One of the main attractions at Casa Bonita is the mesmerizing cliff diving show. Skilled divers leap from high cliffs into a large pool, demonstrating impressive acrobatics and creating a thrilling spectacle for the audience.', 'https://en.wikipedia.org/wiki/Casa_Bonita#/media/File:Casabonitadenver.JPG', 10, 1, 'https://www.casabonitadenver.com/');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (7, 'Glacier National Park', 'Glacier National Park, located in the U.S. state of Montana, is a breathtaking wilderness sanctuary known for its awe-inspiring alpine landscapes and pristine wilderness. The park is a UNESCO World Heritage Site and boasts over a million acres of stunning natural beauty, featuring towering snow-capped peaks, ancient glaciers, crystal-clear lakes, and lush forests. Visitors can explore a network of hiking trails, take scenic drives along the famous Going-to-the-Sun Road, and witness an abundance of wildlife, including grizzly bears, mountain goats, and elk. Glacier National Park is a haven for outdoor enthusiasts and nature lovers, offering a once-in-a-lifetime experience immersed in the untamed beauty of the rugged American wilderness.', 'Glaciers: As the name suggests, Glacier National Park is home to approximately 25 active glaciers, remnants of the last Ice Age. These ancient ice formations add to the park\'s allure and are a fascinating sight to behold.', 'https://www.travel-experience-live.com/wp-content/uploads/2022/05/Grinnell-Glacier-Trail-panorama-at-Many-Glacier-Glacier-National-Park.jpg', 11, 1, 'https://www.nps.gov/glac/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (8, 'Acadia National Park', NULL, NULL, NULL, 12, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (9, 'American Samoa National Park', NULL, NULL, NULL, 13, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (10, 'Badlands National Park', NULL, NULL, NULL, 14, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (11, 'Carlsbad Caverns National', NULL, NULL, NULL, 15, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (12, 'Denali National Park and Preserve', NULL, NULL, NULL, 16, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (13, 'Great Sand Dunes National Park and Preserve', NULL, NULL, NULL, 17, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (14, 'Hot Springs National Park', NULL, NULL, NULL, 18, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (15, 'Joshua Tree National Park', NULL, NULL, NULL, 19, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (16, 'Redwood National and State Parks', NULL, NULL, NULL, 20, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (17, 'Virgin Islands National Park', NULL, NULL, NULL, 21, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (18, 'Yosemite National Park', NULL, NULL, NULL, 22, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (19, 'North Cascades National Park', NULL, NULL, NULL, 23, NULL, NULL);
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (20, 'Zion National Park', NULL, NULL, NULL, 24, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trail`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (1, 'Democrat Throughout Pay', 'Experience every including century dog sing.', '-77.02303', '38.70734', 24.71, 1, 1, 'https://picsum.photos/441/970');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (2, 'History Represent Event Red', 'Culture movement street artist large.', '-73.99681', '40.94065', 24.14, 4, 1, 'https://placekitten.com/455/554');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (3, 'Capital Want Save Decide Floor', 'Make home stop dark those land soon market.', '-78.19444', '38.91817', 12.07, 5, 0, 'https://placekitten.com/671/833');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (4, 'Sport Baby Special Instead', 'School day senior fly.', '-77.02303', '38.70734', 13.79, 6, 0, 'https://dummyimage.com/479x268');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (5, 'Become Once Dark Gas Music', 'Least range oil support bed education.', '-117.23991', '47.64995', 11.42, 2, 0, 'https://picsum.photos/978/641');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (6, 'Raise Tree Remember Job Become', 'Arrive watch part strategy its two ever.', '-84.62081', '42.7392', 23.07, 8, 1, 'https://placekitten.com/599/343');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (7, 'Stand Forward Room There Tend', 'Beautiful study film within across sound.', '-75.64963', '40.24537', 20.44, 9, 1, 'https://placekitten.com/276/930');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (8, 'Her Establish Sing', 'Without debate plant itself on movement capital reflect.', '-95.36969', '35.74788', 10.11, 12, 1, 'https://dummyimage.com/294x551');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (9, 'Foot Job Design', 'Two everything personal.', '-99.73314', '32.44874', 5.58, 11, 1, 'https://placekitten.com/672/761');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (10, 'Leave Chair Improve', 'Need member fight Democrat increase.', '-70.92866', '42.52787', 3.1, 14, 1, 'https://picsum.photos/670/781');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (11, 'Cut Friend Woman', 'Nor money cultural want word husband service.', '-88.31476', '36.61033', 22.04, 16, 0, 'https://picsum.photos/311/756');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (12, 'Still Prove Art Only Power', 'Middle professor look price.', '-84.23381', '33.54428', 14.44, 10, 1, 'https://dummyimage.com/476x192');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (13, 'Factor Especially Age Building', 'Green usually benefit improve.', '-74.38987', '40.65538', 10.98, 7, 1, 'https://placekitten.com/677/420');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (14, 'Quite Hand Together', 'Walk next travel some central.', '-73.97069', '40.64621', 10.88, 13, 1, 'https://placekitten.com/311/727');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (15, 'Blood Task Message Court', 'Who financial yourself out about ever affect.', '-116.37697', '33.72255', 8.07, 17, 1, 'https://picsum.photos/481/643');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (16, 'Score All Available Strategy', 'Audience detail finally.', '-75.23266', '43.1009', 20.29, 3, 1, 'https://placekitten.com/292/122');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (17, 'Fire Health Citizen', 'Type discover positive this.', '-74.96933', '39.71734', 19.15, 4, 1, 'https://placekitten.com/633/313');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (18, 'Thought View Involve', 'Ready new ok should expect just.', '-97.54667', '30.5427', 14.76, 15, 1, 'https://picsum.photos/841/298');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (19, 'Arm Play Laugh These', 'Upon catch man hope where.', '-120.93549', '37.73604', 24.99, 18, 1, 'https://picsum.photos/813/480');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (20, 'Determine Represent Police Capital Fall', 'Father often series address policy.', '-86.77917', '36.02506', 12.25, 20, 1, 'https://dummyimage.com/786x131');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (1, 'Meetup at Bright Angel Trail', '2020-12-01 ', '10:10:10', '10:10:10', 1, 1, 'Challenging route', 'https://www.alltrails.com/trail/us/arizona/bright-angel-trail--11');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (2, 'Jessica\'s Birthday hike', '2023-07-26 ', '10:10:10', '10:10:10', 1, 4, 'Easy route, here to have fun! Bring H2O', 'http://fakeurl.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (3, 'Trail Mountain', '2023-08-01', '06:00:00', '10:00:00', 18, 20, 'Star Waterfall Nature Journey', 'https://imagelink3.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (4, 'Photography Adventure', '2023-08-06', '06:00:00', '08:00:00', 7, 19, 'Star Lake Exploration Hike', 'https://imagelink4.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (5, 'Summit Photography', '2023-08-11', '06:00:00', '09:00:00', 12, 5, 'Echo Lake Runner Adventure', 'https://imagelink5.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (6, 'Nature Waterfall', '2023-08-16', '06:00:00', '11:00:00', 19, 6, 'Journey Exploration Sunset Summit', 'https://imagelink6.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (7, 'Excursion Sunset', '2023-08-21', '09:00:00', '11:00:00', 11, 7, 'Summit Scenery Excursion Photography', 'https://imagelink7.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (8, 'Mountain Adventure', '2023-08-26', '08:00:00', '12:00:00', 12, 9, 'Waterfall Forest Nature Photography', 'https://imagelink8.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (9, 'Scenery Morning', '2023-08-31', '09:00:00', '12:00:00', 20, 9, 'Morning Sunset Nature Exploration', 'https://imagelink9.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (10, 'Nature Sunset', '2023-09-05', '08:00:00', '13:00:00', 9, 9, 'Summit Forest Sunset Journey', 'https://imagelink10.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (11, 'Wildlife Summit', '2023-09-10', '09:00:00', '12:00:00', 9, 10, 'Trail Journey Sunset Summit', 'https://imagelink11.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (12, 'Sunset Journey', '2023-09-15', '08:00:00', '12:00:00', 6, 10, 'Sunset Hike Photography Adventure', 'https://imagelink12.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (13, 'Nature Excursion', '2023-09-20', '08:00:00', '12:00:00', 8, 11, 'Echo Excursion Scenery Exploration', 'https://imagelink13.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (14, 'Summit Echo', '2023-09-25', '09:00:00', '12:00:00', 12, 11, 'Journey Mountain Waterfall Morning', 'https://imagelink14.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (15, 'Photography Lake', '2023-09-30', '08:00:00', '13:00:00', 9, 11, 'Scenery Forest Echo Adventure', 'https://imagelink15.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (16, 'Excursion Scenery', '2023-10-05', '07:00:00', '12:00:00', 6, 12, 'Forest Lake Exploration Hike', 'https://imagelink16.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (17, 'Forest Journey', '2023-10-10', '08:00:00', '11:00:00', 19, 12, 'Summit Scenery Mountain Journey', 'https://imagelink17.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (18, 'Adventure Forest', '2023-10-15', '07:00:00', '09:00:00', 15, 12, 'Lake Mountain Nature Summit', 'https://imagelink18.com');
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (19, 'Hike Exploration', '2023-10-20', '06:00:00', '10:00:00', 20, 13, 'Sunset Summit Lake Hike', 'https://imagelink19.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `meetup_rating` (`user_id`, `meetup_id`, `comment`, `rating`, `create_date`, `last_update`) VALUES (1, 1, 'blah blah blah', 2, '2020-01-01 10:10:10', '2020-02-01 10:10:10');
INSERT INTO `meetup_rating` (`user_id`, `meetup_id`, `comment`, `rating`, `create_date`, `last_update`) VALUES (1, 2, 'blahblah blah', 5, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `trail_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `trail_rating` (`user_id`, `trail_id`, `rating`, `comment`, `create_date`, `last_update`) VALUES (1, 1, 5, 'it was great', '2020-01-01 10:10:10', '2020-02-01 10:10:10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `park_rating` (`user_id`, `park_id`, `rating`, `comment`, `image_url`, `create_date`, `last_update`) VALUES (1, 1, 5, 'this was nice', 'https://www.nps.gov/bicy/planyourvisit/images/birdon-road-sunset1_1.jpg?maxwidth=1300&autorotate=false&quality=78&format=webp', '2020-01-01 10:10:10', '2020-02-01 10:10:10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `park_visit`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `park_visit` (`id`, `title`, `description`, `arrival_date`, `depart_date`, `user_id`, `park_id`, `wildlife_seen`) VALUES (1, 'My first time', 'it was a great visit', '2020-01-01 ', '2020-01-01 ', 1, 1, 'I did not see anything out there');

COMMIT;


-- -----------------------------------------------------
-- Data for table `visit_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `visit_image` (`id`, `image_url`, `caption`, `park_visit_id`) VALUES (1, 'https://www.nps.gov/bicy/planyourvisit/images/birdon-road-sunset1_1.jpg?maxwidth=1300&autorotate=false&quality=78&format=webp', 'beautiful scene', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `amenity`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (1, 'restroom', 'indoor restroom ');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (2, 'food station', 'snacks and drinks');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (3, 'campground', 'many camping stations');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (4, 'playgrounds', 'play station for all ages ');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (5, 'pinic tables', 'pinic tables in many areas');

COMMIT;


-- -----------------------------------------------------
-- Data for table `amenity_has_trail`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (1, 1);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (2, 1);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (3, 1);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (4, 1);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `meetup_comment` (`id`, `comment_date`, `comment`, `reply_id`, `user_id`, `meetup_id`, `active`) VALUES (1, '2020-01-01 10:10:10', 'great hike!', 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_friend`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 1);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 2);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 3);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 4);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (2, 1);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (2, 2);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (2, 3);

COMMIT;

