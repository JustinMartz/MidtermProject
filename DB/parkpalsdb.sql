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
  `active` TINYINT NOT NULL,
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
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (1, 'admin', '1234', 'Cortnie', 'Wirtanen', 1, 'ADMIN', 1, 'Nature enthusiast and avid hiker. Always seeking new trails to explore and breathtaking vistas to capture with my camera. Let\'s embrace the beauty of the great outdoors together!', 'cortnie.jpg', '2020-01-01 10:10:10', '2020-03-01 10:11:20');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (2, 'Sam2', '4567', 'Sam', 'Fath', 1, 'user', 2, 'Environmental advocate and tree hugger. Passionate about sustainability and eco-conscious living. Join me in making a difference for our planet.\n\n', 'sam.jpg', '2023-02-02 10-10-10', '2023-02-02 10-10-10');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (3, 'Justin3', '8910', 'Justin ', 'Martz', 1, 'user', 3, 'Birdwatcher and wildlife lover. Excited to spot rare species and document the wonders of nature. Let\'s embark on birdwatching adventures!\n\n', 'justin.jpg', '2023-02-02 10-10-10', '2023-02-02 10-10-10');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (4, 'Dean4', '1112', 'Dean', 'Coffman', 1, 'user', 4, 'Nature artist and painter. Inspired by the colors of the wilderness, I express my creativity through art. Let\'s share our nature-inspired masterpieces.\n\n\n', 'deanjpg', '2023-02-02 10-10-10', '2023-02-02 10-10-10');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (13, 'kim24', '_4*a&Otpiw', 'Richard', 'Johnson', 1, 'user', 14, 'Gardening enthusiast with a green thumb. My happy place is in the garden, nurturing plants and cultivating a mini-Eden. Let\'s swap gardening tips!\n\n', 'mprofile4.jpeg', '2023-08-01 00:00:00', '2023-08-02 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (11, 'masonmatthew', '6_142QjVyf', 'Micheal', 'Russell', 1, 'user', 12, 'Stargazer and night sky observer. Fascinated by the cosmos and celestial events. Join me for stargazing under the vast night sky.\n\n', 'mprofile3.jpeg', '2023-08-06 00:00:00', '2023-08-09 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (12, 'leonardmichael', 'j6WU%ax(_W', 'Rickey', 'Davis', 0, 'user', 13, 'Forest bathing advocate and mindfulness seeker. Nature is my sanctuary, and I believe in the healing power of the woods. Let\'s find peace in nature together.\n\n', 'mprofile7.jpeg', '2023-08-11 00:00:00', '2023-08-13 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (17, 'kaitlynhughes', 'l$0Egmqtq7', 'Brandy', 'Smith', 1, 'user', 19, 'Mountain lover and summit chaser. Conquering peaks and embracing the majesty of mountains. Let\'s climb to new heights together!\n\n', 'profile1.jpeg', '2023-08-16 00:00:00', '2023-08-19 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (5, 'gabriel10', '4cOOyaC0@J', 'Christopher', 'Lewis', 0, 'user', 5, 'Ocean lover and beachcomber. Drawn to the rhythm of the waves and the mysteries of the deep sea. Let\'s explore coastal wonders.\n\n', 'profile9.jpeg', '2023-08-21 00:00:00', '2023-08-22 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (18, 'jordanandrew', 'E4cCy0$p+f', 'Jacob', 'Mercado', 1, 'user', 18, 'Botany enthusiast and plant collector. Fascinated by the diversity of flora and eager to learn more about botany. Let\'s delve into the world of plants!\n\n', 'mprofile6.jpeg', '2023-08-26 00:00:00', '2023-08-28 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (16, 'dawsonjessica', '*1H!Db%j$%', 'Kristen', 'Smith', 1, 'user', 17, 'Adventure seeker and adrenaline junkie. Whether it\'s kayaking, zip-lining, or rock climbing, I\'m up for the thrill. Let\'s push our limits!\n\n', 'profile1.jpeg', '2023-08-31 00:00:00', '2023-09-01 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (8, 'nespinoza', '#7CRmVBa56', 'Shelly', 'Cooley', 1, 'user', 9, 'Campfire storyteller and s\'mores lover. Camping is my favorite way to bond with nature and friends. Let\'s share campfire tales and laughter.\n\n', 'profile4.jpeg', '2023-09-05 00:00:00', '2023-09-09 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (15, 'medinabilly', 'bx03H$hLt&', 'Jesse', 'Summers', 1, 'user', 16, 'Photographer capturing nature\'s beauty. Through my lens, I aim to preserve nature\'s splendor forever. Let\'s embark on photo expeditions.\n\n', 'profile6.jpeg', '2023-09-10 00:00:00', '2023-09-12 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (14, 'jjohnson', 'df(6z%Mb7^', 'Stephanie', 'Lee', 0, 'user', 15, 'Nature writer and poet. Finding inspiration in the wilderness and expressing it through words. Let\'s connect through poetry and prose.\n\n', 'profile10.jpeg', '2023-09-15 00:00:00', '2023-09-17 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (9, 'ssmith', 'lS*0Kojubc', 'Patrick', 'Miller', 1, 'user', 10, 'Starfish collector and beach cleanup enthusiast. I believe in keeping our oceans clean and protecting marine life. Let\'s clean up beaches together!\n\n', 'mprofile5.jpeg', '2023-09-20 00:00:00', '2023-09-23 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (6, 'nealedwin', '&1dM0Gbh1Y', 'Diana', 'Jones', 1, 'user', 6, 'Nature educator and outdoor mentor. Sharing knowledge about wildlife and survival skills. Let\'s learn from nature and each other.\n\n', 'profile3.jpeg', '2023-09-25 00:00:00', '2023-09-27 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (10, 'scarter', 'net1(8TkzU', 'Lawrence', 'Phillips', 1, 'user', 11, 'Treehouse builder and outdoor DIY enthusiast. Turning nature into my playground with creative projects. Let\'s build and play!\n\n', 'mprofile2.jpeg', '2023-09-30 00:00:00', '2023-10-01 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (7, 'daniel10', '+3PQevjP#J', 'Matthew', 'Murphy', 1, 'user', 7, 'Wilderness survivalist and foraging expert. Exploring the wilderness and living off the land. Let\'s embrace our primal instincts.\n\n', 'mprofile1.jpeg', '2023-10-05 00:00:00', '2023-10-10 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (19, 'jacquelinewilson', 'y_4qMvdVDv', 'Christopher', 'Gilbert', 1, 'user', 8, 'Nature yoga practitioner and meditation advocate. Finding harmony in nature and within ourselves. Let\'s find peace through nature\'s embrace.\n\n\n', 'profile7.jpeg', '2023-10-10 00:00:00', '2023-10-13 00:00:00');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `active`, `role`, `address_id`, `aboutme`, `image_url`, `date_created`, `last_update`) VALUES (20, 'Bob11', '1234567', 'Bobby', 'Tables', 1, 'user', 1, 'Nature enthusiast, explorer, and conservationist. Finding joy in every rustle of leaves and every whisper of the wind. Embracing the beauty of Mother Earth and working to protect it. Let\'s tread lightly and preserve the wonders of nature for all to enjoy. ', 'profile8.jpeg', '2023-10-10 00:00:00', '2023-10-13 00:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `park`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (1, 'Grand Canyon National Park', 'The Grand Canyon is a vast and awe-inspiring natural wonder located in the southwestern United States. Carved over millions of years by the Colorado River, it is one of the most iconic and breathtaking landscapes on Earth. The canyon stretches approximately 277 miles (446 kilometers) long and reaches depths of over a mile (1.6 kilometers), exposing a geologic history that spans nearly two billion years. Its sheer cliffs and vibrant, multi-colored rock formations offer a mesmerizing display of geological beauty. The Grand Canyon is not only a popular tourist destination but also a designated UNESCO World Heritage Site, attracting millions of visitors each year who come to marvel at its splendor and explore its unique ecosystems.', 'Unique Geological Layers: The exposed rock layers in the Grand Canyon offer a remarkable geological history, displaying millions of years of Earth\'s history. These layers consist of different colors, textures, and compositions, providing valuable insights into the planet\'s geological evolution.', 'grandcanyon.jpg', 5, 1, 'https://www.casabonitadenver.com/');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (2, 'Yellowstone National Park', 'Yellowstone National Park is a renowned and vast natural wonder located primarily in the U.S. states of Wyoming, Montana, and Idaho. Established in 1872, it was the first national park in the world. The park\'s most distinctive feature is its geothermal activity, boasting more than 10,000 geysers, hot springs, and other hydrothermal features. The most famous geyser, Old Faithful, regularly erupts, drawing crowds to witness its impressive displays.\n\nYellowstone\'s diverse ecosystem supports a wide range of wildlife, including grizzly bears, wolves, elk, bison, and numerous bird species. The park\'s stunning landscapes encompass majestic mountains, expansive forests, winding rivers, and picturesque lakes.\n\nAdditionally, the Yellowstone Caldera, a massive volcanic crater, underlies much of the park and contributes to its geothermal activity. While the park\'s beauty and geological significance are its major draws, visitors also come to enjoy outdoor activities like hiking, camping, wildlife viewing, and photography. Yellowstone National Park stands as a cherished symbol of America\'s commitment to preserving its natural treasures for future generations.', 'Yellowstone Lake: As the largest high-altitude lake in North America, Yellowstone Lake covers over 130 square miles and provides breathtaking views and recreational opportunities.', 'Yellowstone.jpg', 6, 1, 'https://www.nps.gov/yell/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (3, 'Mesa Verde National Park', 'Mesa Verde National Park is a captivating and historically significant protected area located in the southwestern United States, specifically in the state of Colorado. Renowned for its well-preserved ancient cliff dwellings, it offers visitors a glimpse into the rich cultural heritage of the ancestral Puebloan people.\n\nThe park\'s main attraction is its impressive collection of ancient cliff dwellings, which were once inhabited by the Puebloan people over 700 years ago. These intricate structures were carved directly into the cliffs, showcasing remarkable architectural skills and a deep connection to the natural environment. Visitors can explore these dwellings through guided tours and learn about the lives and customs of the ancient inhabitants.\n\nAside from the cliff dwellings, Mesa Verde National Park boasts diverse landscapes with picturesque mesas, canyons, and woodlands, making it a perfect destination for outdoor enthusiasts and nature lovers. The park offers a range of recreational activities, including hiking, camping, and birdwatching, allowing visitors to immerse themselves in the breathtaking scenery.\n\nMesa Verde\'s cultural significance and stunning landscapes have earned it the designation as a UNESCO World Heritage Site and a cherished place for preserving and celebrating the ancient history of the Native American people. It continues to inspire awe and wonder in all who have the opportunity to experience its beauty and history firsthand.', 'Long House: This massive cliff dwelling contains more than 150 rooms and 21 kivas. It provides an excellent example of the elaborate architecture and engineering skills of the ancient Puebloan people.', 'mesaverde.jpg', 7, 1, 'https://www.nps.gov/meve/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (4, 'Great Smoky Mountains National Park', 'The Great Smoky Mountains National Park, located on the border of North Carolina and Tennessee, is a renowned natural treasure in the southeastern United States. Established in 1934, it is one of the most visited national parks in the country.\n\nEncompassing over 800 square miles of pristine wilderness, the park is named for the characteristic haze that often hovers over its ancient mountains. The park\'s breathtaking landscape is marked by lush forests, cascading waterfalls, diverse plant and animal life, and rugged mountain peaks, with Clingmans Dome standing as the highest point in the Smokies.\n\nThe Great Smoky Mountains are celebrated for their rich biodiversity, boasting a vast array of plant and animal species, including black bears, deer, elk, and more. The park is a haven for outdoor enthusiasts, offering over 800 miles of well-maintained hiking trails, from easy walks to challenging backcountry routes.\n\nVisitors to the park can explore historic structures that harken back to its early settlers, gaining insights into the region\'s cultural heritage. Additionally, the park\'s scenic drives provide breathtaking vistas and opportunities for photography and relaxation.\n\nWhether visitors seek adventure, nature appreciation, or a peaceful retreat, the Great Smoky Mountains National Park offers a remarkable and unforgettable experience that showcases the beauty and diversity of the Appalachian region.', 'Waterfalls: Great Smoky Mountains National Park is dotted with numerous waterfalls, varying in size and accessibility. Some well-known waterfalls include Abrams Falls, Rainbow Falls, and Grotto Falls.', 'smokeymountains.jpg', 8, 1, 'https://www.nps.gov/grsm/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (5, 'Everglades National Park', 'Everglades National Park is a unique and diverse natural wonder located in southern Florida, United States. Established in 1947, it is the third-largest national park in the lower 48 states, covering approximately 1.5 million acres of wetlands, mangroves, sawgrass prairies, and diverse ecosystems.\n\nKnown as the \'River of Grass,\' the park is a vast, slow-moving, shallow river system that provides a critical habitat for an abundance of wildlife, including alligators, crocodiles, manatees, and numerous bird species, making it one of the most biodiverse regions in the country. It is also home to endangered species such as the Florida panther and the West Indian manatee.\n\nEverglades National Park offers visitors a chance to explore its natural beauty through various activities, such as hiking, bird-watching, kayaking, and airboat tours. Moreover, it provides valuable educational opportunities to learn about the delicate balance of this fragile ecosystem and the importance of conservation efforts to preserve its natural treasures for future generations. The park is not only a sanctuary for wildlife but also a symbol of the unique and complex interplay between land, water, and life.', '\'River of Grass\': The Everglades is often referred to as the \'River of Grass\' due to the slow, shallow flow of water over the vast expanse of sawgrass prairies. This unique landscape is one of the defining characteristics of the park.', 'everglades.jpg', 9, 1, 'https://www.nps.gov/ever/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (6, 'Casa Bonita: An Enchanting Oasis of Fun', 'Nestled in the heart of Colorado, Casa Bonita stands as a one-of-a-kind destination, akin to a national park, where adventure, enchantment, and flavorsome delights converge. This unique establishment is not your typical park, but it embodies a distinctive charm that captivates visitors of all ages.\n\nCasa Bonita\'s facade hints at a mesmerizing Mexican village, complete with vibrant colors and intricate architectural details. Upon stepping inside, visitors are transported to a world of wonder and excitement. The interior is a sprawling wonderland, designed to evoke the essence of a bustling Mexican marketplace. A myriad of themed dining areas and attractions await around every corner, ensuring an immersive experience like no other.\n\nAs visitors explore Casa Bonita, they encounter an array of sights and sounds, from cascading waterfalls and glistening caves to lively mariachi bands and captivating live performances. Each themed dining area boasts its unique atmosphere, offering an escape into various Mexican-inspired backdrops.\n\nOne of the main highlights at Casa Bonita is the mesmerizing cliff divers, who gracefully leap from towering cliffs into a crystal-clear pool, leaving spectators in awe. The theatrical flair extends to the adventurous Black Bart\'s Cave, where daring guests embark on a simulated treasure hunt through mysterious caverns and hidden passages.\n\nTo satisfy appetites, Casa Bonita boasts a diverse menu of traditional Mexican dishes and Tex-Mex delights. From sizzling fajitas to mouthwatering enchiladas, the flavors reflect the vibrant culinary heritage of Mexico. Guests can savor their meals amidst the immersive ambiance, surrounded by cascading waterfalls and lush greenery, creating an unforgettable dining experience.\n\nAt Casa Bonita, visitors can embrace their inner child, diving into a colorful and whimsical world filled with magic and discovery. It\'s a place where laughter echoes through the halls and memories are etched in hearts forever.\n\nIn essence, Casa Bonita may not be an official national park, but it offers a unique and unparalleled adventure that beckons travelers from near and far. A sanctuary of fun, flavors, and enchantment, it captures the essence of a fantastical escape that promises to leave every guest enchanted and inspired.', 'Cliff Divers: One of the main attractions at Casa Bonita is the mesmerizing cliff diving show. Skilled divers leap from high cliffs into a large pool, demonstrating impressive acrobatics and creating a thrilling spectacle for the audience.', 'casabonita.jpg', 10, 1, 'https://www.casabonitadenver.com/');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (7, 'Glacier National Park', 'Glacier National Park, located in the U.S. state of Montana, is a breathtaking wilderness sanctuary known for its awe-inspiring alpine landscapes and pristine wilderness. The park is a UNESCO World Heritage Site and boasts over a million acres of stunning natural beauty, featuring towering snow-capped peaks, ancient glaciers, crystal-clear lakes, and lush forests. Visitors can explore a network of hiking trails, take scenic drives along the famous Going-to-the-Sun Road, and witness an abundance of wildlife, including grizzly bears, mountain goats, and elk. Glacier National Park is a haven for outdoor enthusiasts and nature lovers, offering a once-in-a-lifetime experience immersed in the untamed beauty of the rugged American wilderness.', 'Glaciers: As the name suggests, Glacier National Park is home to approximately 25 active glaciers, remnants of the last Ice Age. These ancient ice formations add to the park\'s allure and are a fascinating sight to behold.', 'glacier.jpg', 11, 1, 'https://www.nps.gov/glac/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (8, 'Acadia National Park', 'Acadia National Park is a stunning national park located primarily on Mount Desert Island along the coast of Maine, United States. Established in 1919, it encompasses 49,076 acres of diverse landscapes, including rugged coastline, rocky shorelines, woodlands, lakes, and granite peaks. The park is renowned for its breathtaking vistas, with Cadillac Mountain being the highest point on the East Coast of the United States.\n\nAcadia offers a wide range of recreational activities, making it a popular destination for nature enthusiasts and outdoor adventurers. Visitors can explore the park\'s extensive network of hiking trails, go biking, birdwatching, and enjoy picturesque views from various scenic spots. The park\'s coastline is dotted with beautiful sandy beaches and iconic rock formations such as Thunder Hole, where waves crash loudly during high tide.\n\nIn addition to its natural beauty, Acadia National Park features several historic sites and carriage roads built by philanthropist John D. Rockefeller Jr., adding to its charm and historical significance. With its unique blend of coastal wonders and mountainous landscapes, Acadia National Park offers visitors a memorable experience and remains one of the most visited national parks in the United States.', 'Sand Beach: A unique and scenic sandy beach nestled between rocky shores, providing a great place for relaxation and beachcombing. The cold waters of the Atlantic Ocean offer a refreshing swimming experience.', 'acadia.jpg', 12, 1, 'https://www.nps.gov/acad/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (9, 'American Samoa National Park', 'American Samoa National Park is a unique and remote national park located in the United States territory of American Samoa, in the South Pacific Ocean. Established in 1988, the park spans over 13,500 acres and encompasses rainforests, lush valleys, pristine beaches, and vibrant coral reefs.\n\nThe park consists of three main units: Tutuila, Ta\'u, and Ofu Islands. Each unit offers a distinct and diverse range of ecosystems, showcasing the region\'s rich cultural heritage and natural wonders. Visitors can explore ancient Samoan villages, encounter traditional customs, and learn about the local way of life.\n\nThe park\'s marine environment is teeming with marine life, making it a haven for snorkelers and scuba divers. Colorful coral reefs, sea turtles, and tropical fish create a captivating underwater world to explore.\n\nHiking trails wind through dense rainforests, leading to magnificent waterfalls, dramatic cliffs, and breathtaking viewpoints. Popular hikes include the Tutuila Shoreline Trail and the challenging but rewarding Mount Alava Trail, which offers sweeping vistas of Pago Pago Harbor.\n\nAmerican Samoa National Park offers a chance to experience an untouched and culturally rich paradise, where visitors can immerse themselves in the beauty of nature while gaining insight into the local Samoan way of life. The park\'s remote location preserves its pristine environment, making it a hidden gem for those seeking an off-the-beaten-path adventure.', 'Ta\'u Volcano: On the island of Ta\'u, there is a dormant volcano, called Lata Mountain, which offers breathtaking panoramic views of the surrounding landscape.', 'americasamoa.jpg', 13, 1, 'https://www.nps.gov/npsa/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (10, 'Badlands National Park', 'Badlands National Park is a captivating national park located in southwestern South Dakota, United States. Spanning over 244,000 acres, it showcases a unique and otherworldly landscape characterized by eroded buttes, spires, canyons, and vast prairies. The park\'s name originates from the Lakota Sioux term \'mako sica,\' meaning \'land bad.\'\n\nThe striking geological formations in the Badlands were shaped by millions of years of erosion, exposing colorful layers of sedimentary rock that offer a mesmerizing visual display. Visitors can explore a network of trails that lead to panoramic viewpoints, providing awe-inspiring vistas of the rugged terrain and expansive grasslands.\n\nApart from its geological wonders, Badlands National Park is home to diverse wildlife, including bison, bighorn sheep, pronghorn, coyotes, and prairie dogs. Birdwatchers can also spot various species of raptors and songbirds soaring through the skies.\n\nWith its surreal landscapes and abundant wildlife, Badlands National Park offers an extraordinary opportunity for outdoor enthusiasts, photographers, and nature lovers to immerse themselves in the untamed beauty of the American Great Plains.', 'Badlands Wall: The park\'s most prominent feature is the Badlands Wall, a distinctive escarpment formed by the erosion of layered rock formations. This rugged and colorful cliff runs for miles and creates a stunning backdrop to the park\'s landscapes.', 'badlands2.jpg', 14, 1, 'https://www.nps.gov/badl/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (11, 'Carlsbad Caverns National', 'Carlsbad Caverns National Park is located in the state of New Mexico, United States. It is renowned for its stunning underground cave system, which features an extensive network of limestone caverns and formations. The park offers visitors a unique opportunity to explore the fascinating world of stalactites, stalagmites, columns, and other speleothems that have been formed over millions of years through the natural process of dissolution and deposition.\n\nVisitors can take guided tours into the caverns to witness the incredible beauty and intricacy of the rock formations. The park\'s most famous chamber, the Big Room, is one of the largest cave chambers in North America and offers awe-inspiring views of the underground landscape.\n\nApart from its subterranean wonders, Carlsbad Caverns National Park also boasts a diverse above-ground desert landscape. Visitors can enjoy hiking trails, birdwatching, and scenic overlooks, providing an opportunity to appreciate the unique flora and fauna of the Chihuahuan Desert.\n\nIn addition to its natural attractions, the park offers educational programs, ranger-led tours, and opportunities for caving enthusiasts. Carlsbad Caverns National Park remains a remarkable destination for anyone seeking to immerse themselves in the fascinating world of caves and experience the wonders of the underground realm.', 'The Big Room: Carlsbad Cavern\'s Big Room is one of the largest cave chambers in North America. It covers around 8.2 acres (approximately 33,000 square meters) and offers visitors an awe-inspiring underground landscape. A paved trail allows easy access for visitors to explore the Big Room\'s captivating formations.', 'carlsbadcaverns.jpg', 15, 1, 'https://www.nps.gov/cave/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (12, 'Denali National Park and Preserve', 'Denali National Park and Preserve is a vast wilderness area located in the state of Alaska, USA. Encompassing over six million acres, it is one of the largest national parks in the United States. The park is centered around Denali, the highest peak in North America, formerly known as Mount McKinley.\n\nThe park\'s landscape is characterized by dramatic mountains, including Denali itself, sweeping tundra, dense forests, and glacier-carved valleys. It offers breathtaking views of pristine wilderness and a diverse range of wildlife, including grizzly bears, moose, caribou, wolves, and Dall sheep.\n\nVisitors to Denali National Park and Preserve can explore its rugged terrain through various activities, such as hiking, backcountry camping, mountaineering, and wildlife viewing. A popular way to experience the park is by taking a bus tour along the Denali Park Road, which provides access to the park\'s interior and offers opportunities to see wildlife and majestic landscapes.\n\nOne unique feature of Denali National Park is its emphasis on preserving the natural ecosystem and promoting minimal human impact. As a result, access to certain areas is restricted, and the park\'s wilderness remains largely untouched, providing a rare glimpse into the untamed beauty of the Alaskan wilderness.\n\nDenali National Park and Preserve is a paradise for outdoor enthusiasts and nature lovers, offering an unforgettable experience of Alaska\'s pristine and awe-inspiring wilderness.', 'Denali Park Road: The park\'s main access route, Denali Park Road, extends for approximately 92 miles into the park\'s interior. While most of the road is accessible only by park-operated buses, it offers travelers the chance to explore deep into the wilderness and encounter wildlife and breathtaking scenery.', 'denali.jpg', 16, 1, 'https://www.nps.gov/dena/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (13, 'Great Sand Dunes National Park and Preserve', 'Great Sand Dunes National Park and Preserve is located in southern Colorado, USA. It is renowned for its vast and awe-inspiring landscape of massive sand dunes, some reaching heights of over 750 feet (230 meters). The park\'s unique feature includes the tallest sand dunes in North America, which were formed by the accumulation of sand and sediment over thousands of years.\n\nThe park offers a striking contrast of diverse ecosystems, with not only the iconic sand dunes but also grasslands, wetlands, and alpine forests. Visitors can experience various recreational activities such as sandboarding, hiking, and camping, as well as exploring the diverse flora and fauna, including desert wildlife and rare plant species.\n\nGreat Sand Dunes National Park and Preserve is a destination that captivates visitors with its stunning natural beauty, providing an opportunity to immerse themselves in a remarkable blend of desert and mountain landscapes.', 'Medano Creek: In the spring and early summer, visitors can witness the unique phenomenon of Medano Creek flowing at the base of the sand dunes. The creek\'s flow varies throughout the year, creating a beach-like experience at the base of the dunes, perfect for wading and splashing.', 'greatsanddunes.jpg', 17, 1, 'https://www.nps.gov/grsa/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (14, 'Hot Springs National Park', 'Hot Springs National Park, located in the state of Arkansas, is a unique and historic park renowned for its naturally flowing hot springs. Established in 1832, it holds the distinction of being the oldest national park designated to protect a natural resource. The park encompasses a picturesque landscape with lush forests, scenic trails, and thermal waters that have been revered for their therapeutic properties for centuries.\n\nVisitors to Hot Springs National Park can explore the historic Bathhouse Row, a collection of beautifully preserved bathhouses built in the early 20th century, where they can experience traditional thermal baths and spa treatments. The park\'s soothing thermal waters are also channeled into numerous fountains, providing an opportunity for visitors to taste and enjoy the mineral-rich, warm waters.\n\nAside from the thermal attractions, the park offers a variety of recreational activities, including hiking, picnicking, and wildlife watching. Trails wind through the forested areas, leading to scenic overlooks and serene spots, offering a chance to connect with nature while experiencing the healing presence of the hot springs.\n\nHot Springs National Park is a unique destination where visitors can both immerse themselves in the area\'s rich history and indulge in the natural healing properties of its thermal waters, making it a popular spot for relaxation and rejuvenation amidst the beauty of the Arkansas landscape.', 'Hot Springs and Bathhouses: The park is centered around its famous hot springs, which are naturally heated by geothermal forces deep within the earth. Visitors can witness and even take a dip in these soothing, mineral-rich thermal waters, which are believed to have therapeutic properties. Historic bathhouses, built in the early 20th century, line Bathhouse Row and offer a glimpse into the spa culture of the past.', 'hotsprings.jpg', 18, 1, 'https://www.nps.gov/hosp/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (15, 'Joshua Tree National Park', 'Joshua Tree National Park is a stunning desert wilderness located in Southern California, USA. It is renowned for its unique landscape, characterized by striking rock formations, rugged mountains, and iconic Joshua trees (Yucca brevifolia). The park encompasses the convergence of two distinct desert ecosystems: the high Mojave Desert and the lower Colorado Desert. Visitors to Joshua Tree can experience a surreal and otherworldly setting, where massive boulders create a labyrinthine playground for hikers, climbers, and photographers. The Joshua trees, with their twisted branches and spiky leaves, provide an ethereal backdrop to the arid landscape. The park offers opportunities for stargazing, with its dark night skies showcasing a plethora of stars and celestial wonders. Outdoor enthusiasts can explore numerous hiking trails, wildlife sightings, and enjoy a serene retreat amidst the desert\'s rugged beauty. Joshua Tree National Park is a true gem of the American Southwest, attracting nature lovers, adventurers, and artists seeking inspiration from its extraordinary natural wonders.', 'Barker Dam: An easy hike leads to Barker Dam, a historic water-storage reservoir surrounded by picturesque desert scenery.', 'joshuatree.jpg', 19, 1, 'https://www.nps.gov/jotr/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (16, 'Redwood National and State Parks', 'Redwood National and State Parks is a designated protected area located in Northern California, United States. It is a unique and diverse national park complex that encompasses a series of parks, including Redwood National Park and three California state parks (Jedediah Smith, Del Norte Coast, and Prairie Creek Redwoods State Parks). Established in 1968, the primary purpose of the park is to preserve and protect the magnificent coast redwood forests, some of the tallest and oldest trees on Earth.\n\nThe park is renowned for its awe-inspiring old-growth redwood trees, which can reach heights of over 350 feet (107 meters) and have a lifespan of more than 2,000 years. The towering trees create a breathtaking, ancient forest landscape, with lush undergrowth, fern-covered floors, and a rich diversity of plant and animal species.\n\nRedwood National and State Parks also encompass a stunning coastal environment, featuring rugged cliffs, sandy beaches, and diverse wildlife habitats. The park\'s coastline stretches for about 40 miles (64 kilometers) and provides excellent opportunities for exploring tide pools, observing marine life, and enjoying scenic coastal views.\n\nVisitors to the park can experience a range of recreational activities, including hiking, camping, wildlife watching, and ranger-led programs that offer insights into the natural and cultural history of the redwood forest.\n\nThrough its conservation efforts, Redwood National and State Parks play a crucial role in safeguarding the iconic redwood ecosystem and providing visitors with a chance to connect with the awe-inspiring beauty of these ancient giants and the stunning coastal environment they call home.', 'Fern Canyon: This enchanting canyon is a lush wonderland of fern-covered walls that provide a unique and otherworldly hiking experience.', 'redwood.jpg', 20, 1, 'https://www.nps.gov/redw/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (17, 'Virgin Islands National Park', 'Virgin Islands National Park is a stunning tropical paradise located in the United States Virgin Islands, encompassing much of the island of St. John. Established in 1956, the park covers over 7,000 acres of land and underwater areas. It is renowned for its pristine beaches, crystal-clear waters, lush forests, and diverse marine life.\n\nThe park\'s attractions include beautiful coral reefs, hiking trails that lead to picturesque vistas, and historical ruins from sugar plantations dating back to the 18th century. Visitors can indulge in various recreational activities, such as snorkeling, scuba diving, kayaking, and camping.\n\nVirgin Islands National Park provides a sanctuary for numerous endangered and native species, making it an essential site for conservation efforts. With its remarkable natural beauty and rich cultural heritage, the park offers visitors an unforgettable experience of the Caribbean\'s enchanting landscapes and marine wonders.', 'Trunk Bay: One of the most famous and photographed beaches in the world, Trunk Bay is known for its idyllic beauty and an underwater snorkeling trail that guides visitors through an underwater coral garden.\n\n', 'virginislands.jpg', 21, 1, 'https://www.nps.gov/viis/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (18, 'Yosemite National Park', 'Yosemite National Park is a renowned national park located in the western Sierra Nevada Mountains of California, USA. It is internationally recognized for its breathtaking natural beauty and diverse ecosystems. The park covers an area of approximately 1,189 square miles (3,081 square kilometers) and is famous for its towering granite cliffs, stunning waterfalls, clear streams, giant sequoia trees, and pristine wilderness.\n\nOne of the park\'s most iconic landmarks is El Capitan, a massive granite monolith that attracts rock climbers from all over the world. Another famous attraction is Half Dome, a distinctively shaped granite dome that offers challenging hiking opportunities.\n\nYosemite is also home to several majestic waterfalls, including Yosemite Falls, North America\'s tallest waterfall, and Bridalveil Fall. The park\'s lush valleys, alpine meadows, and ancient groves of giant sequoias provide diverse habitats for a wide range of plant and animal species.\n\nThe park offers numerous recreational activities, such as hiking, camping, rock climbing, birdwatching, and photography, attracting millions of visitors each year. Yosemite\'s awe-inspiring landscapes have made it a UNESCO World Heritage Site and continue to captivate nature enthusiasts and outdoor adventurers from around the globe.', 'Half Dome: This iconic granite dome is one of the most recognizable features in Yosemite. It stands at about 4,737 feet (1,444 meters) above the valley floor and offers a challenging hike to the summit for adventurous visitors.', 'yosemite.jpg', 22, 1, 'https://www.nps.gov/yose/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (19, 'North Cascades National Park', 'North Cascades National Park is a breathtaking wilderness area located in the state of Washington, United States. Known for its rugged mountain landscapes, pristine lakes, and dense forests, the park is a haven for outdoor enthusiasts and nature lovers. The North Cascades mountain range, which includes numerous glaciers and towering peaks, dominates the park\'s scenery. It offers opportunities for hiking, backpacking, camping, and mountaineering, attracting adventurous visitors seeking to explore its untamed beauty. The park is also home to diverse wildlife, including grizzly bears, wolves, and eagles, making it a significant area for conservation efforts and wildlife observation. With its remote and wild character, North Cascades National Park provides a captivating experience for those seeking a true wilderness adventure in the Pacific Northwest.', 'North Cascades Scenic Byway: The park is accessible through the North Cascades Scenic Byway, also known as the \'Cascade Loop.\' This scenic drive takes visitors through breathtaking mountain passes, dense forests, and crystal-clear lakes, providing spectacular views of the park\'s natural beauty.', 'northcascades.jpg', 23, 1, 'https://www.nps.gov/noca/index.htm');
INSERT INTO `park` (`id`, `name`, `description`, `notable_features`, `image_url`, `address_id`, `active`, `website_url`) VALUES (20, 'Zion National Park', 'Zion National Park is a stunning and iconic national park located in southwestern Utah, United States. It is renowned for its majestic sandstone cliffs, deep narrow canyons, and lush forests. The park\'s centerpiece is Zion Canyon, carved over millions of years by the Virgin River. Visitors are captivated by the sheer beauty of the soaring red and white sandstone cliffs, some reaching over 2,000 feet in height.\n\nZion offers a wide range of outdoor activities, including hiking along scenic trails like the famous Angels Landing and The Narrows. The latter takes hikers through the river between towering canyon walls, creating a unique and unforgettable experience.\n\nThe park\'s diverse ecosystems support a variety of plant and animal species, making it a popular destination for nature enthusiasts and wildlife photographers. Zion\'s unique geology and stunning landscapes make it a must-visit destination for anyone seeking to explore the awe-inspiring beauty of America\'s national parks.', 'Weeping Rock: A short and easy hike leads to Weeping Rock, where water seeps out of the sandstone cliff face, creating a serene, dripping rock alcove.', 'zion.jpg', 24, 1, 'https://www.nps.gov/zion/index.htm');

COMMIT;


-- -----------------------------------------------------
-- Data for table `trail`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (1, 'Tanner Trail', 'Tanner Trail is a challenging and remote trail that provides a backcountry experience in the Grand Canyon. It\'s less crowded than the popular South Rim trails, but hikers should be well-prepared with proper equipment, water, and navigation skills. The trail leads to breathtaking viewpoints, such as Lipan Point and Cardenas Butte.', '-77.02303', '38.70734', 24.71, 1, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (2, 'Abrams Falls Trail', 'Abrams Falls Trail is a 5.2-mile roundtrip hike that leads to Abrams Falls, a powerful 20-foot waterfall with a large pool at its base. The trail follows Abrams Creek, offering several opportunities to enjoy the scenic beauty of the creek and its cascades.', '-73.99681', '40.94065', 24.14, 4, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (3, 'Gumbo Limbo Trail', 'The Gumbo Limbo Trail is a short and wheelchair-accessible 0.4-mile loop trail that meanders through a subtropical forest. Along the trail, you\'ll find the Gumbo Limbo tree, also known as the \"tourist tree\" due to its red and peeling bark, and an observation tower offering views of the surrounding landscape.', '-78.19444', '38.91817', 12.07, 5, 0, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (4, 'Cheesy Taco Trail', 'This mouthwatering trail takes you through the deep layers of cheese and spicy hamburger meat that will lift you to heights you\'ve never been to before. But beware of falling tomatoes and raining lettuce as this national park is known for its wild storm of taco toppings.', '-77.02303', '38.70734', 13.79, 6, 0, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (5, 'Mystic Falls Trail', 'The Mystic Falls Trail takes you through a picturesque forest to the beautiful Mystic Falls. The trail offers lovely views of the surrounding area and leads to the charming Fairy Creek and the Little Firehole River. It\'s a moderate hike suitable for most visitors.', '-117.23991', '47.64995', 11.42, 2, 0, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (6, 'Ocean Path', 'This easy and scenic trail runs parallel to the rocky coastline, providing stunning vistas of the crashing waves and dramatic cliffs. You\'ll pass by several landmarks, including Thunder Hole, where the waves create a resounding boom during high tide. The Ocean Path is perfect for a relaxing stroll or a memorable sunset hike.', '-84.62081', '42.7392', 23.07, 8, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (7, 'Blunts Point Trail', 'The Blunts Point Trail provides a leisurely walk along the coastline, where you can witness stunning sunsets and spot marine life, including turtles and dolphins, in the crystal-clear waters.', '-75.64963', '40.24537', 20.44, 9, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (8, 'Triple Lakes Trail', 'Length: Varies depending on route (6-12 miles round trip)\nDescription: This challenging trail takes hikers through diverse landscapes, including forests and open tundra, with the reward of three beautiful lakes at the end.', '-95.36969', '35.74788', 10.11, 12, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (9, 'King\'s Palace Trail', 'This trail takes you to the King\'s Palace, a regal chamber adorned with impressive formations and draperies. It\'s a moderately difficult hike that includes some steep sections and stairs. The reward is the chance to view incredible speleothems and hear ranger-led talks on the cave\'s history.', '-99.73314', '32.44874', 5.58, 11, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (10, 'Sunset Trail', 'The Sunset Trail is a 10.5-mile hike that leads to the West Mountain summit. It offers stunning vistas of the Ouachita Mountains and the surrounding countryside. This trail is more challenging and is recommended for experienced hikers.', '-70.92866', '42.52787', 3.1, 14, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (11, 'Fern Canyon Trail', 'Fern Canyon is a hidden gem within the park, and this trail takes you through its enchanting beauty. The canyon walls are adorned with a rich tapestry of ferns and mosses, creating a lush and otherworldly setting. Prepare to get your feet wet, as you\'ll need to cross a shallow creek several times, adding to the adventure of the hike.', '-88.31476', '36.61033', 22.04, 16, 0, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (12, 'Notch Trail', 'The Notch Trail is a moderate hike that leads you to a spectacular overlook of the White River Valley. This trail involves some climbing and a wooden ladder, but the stunning views make it well worth the effort.', '-84.23381', '33.54428', 14.44, 10, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (13, 'Iceberg Lake Trail', 'Iceberg Lake Trail takes you to a glacial lake where icebergs often float, even in the summer. The hike is considered moderate and offers impressive views of the surrounding mountains.', '-74.38987', '40.65538', 10.98, 7, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (14, 'Mosca Pass Trail', 'For more adventurous hikers, the Mosca Pass Trail is a challenging backcountry route that leads to the Mosca Pass Overlook. This hike takes you through diverse ecosystems, from the dunes to the forests, and rewards you with views of the surrounding mountains.', '-73.97069', '40.64621', 10.88, 13, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (15, 'Bordeaux Mountain Trail', 'For a more challenging hiking experience, the Bordeaux Mountain Trail leads you to the highest point on St. John\'s Island, offering breathtaking panoramic views of both the Atlantic Ocean and the Caribbean Sea. This hike is perfect for those seeking an adventurous journey through the island\'s diverse landscapes.\n\n', '-116.37697', '33.72255', 8.07, 17, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (16, 'Step House Trail', 'Located in Wetherill Mesa, the Step House Trail is a self-guided hike that leads to a fascinating site showcasing both cliff dwelling and mesa-top structures. The trail takes you through a beautiful canyon, and the Step House itself is an excellent example of the Ancestral Puebloan\'s sophisticated building techniques.\n\n', '-75.23266', '43.1009', 20.29, 3, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (17, 'Rainbow Falls Trail', 'The Rainbow Falls Trail is a challenging 5.4-mile roundtrip hike that leads to Rainbow Falls, a majestic 80-foot waterfall. The trail is known for its diverse flora and is especially popular in the spring when wildflowers are in bloom.', '-74.96933', '39.71734', 19.15, 4, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (18, 'Skull Rock Trai', 'This short loop trail, around 1.7 miles, takes you to the unique Skull Rock, a rock formation resembling a skull, perfect for photo opportunities.', '-97.54667', '30.5427', 14.76, 15, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (19, 'Mist Trail', 'The Mist Trail is one of the park\'s most popular hikes, offering stunning views of two majestic waterfalls: Vernal Fall and Nevada Fall. As you ascend, the mist from the cascading water creates a refreshing and invigorating experience.', '-120.93549', '37.73604', 24.99, 18, 1, '');
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (20, 'Emerald Pools Trail', 'A family-friendly hike that leads to three beautiful emerald pools. The Lower Emerald Pool is an easy walk, while the Middle and Upper pools require a bit more effort. The waterfalls and lush greenery create a serene atmosphere.', '-86.77917', '36.02506', 12.25, 20, 1, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (1, 'Meetup at Bright Angel Trail', '2020-12-01 ', '10:10:10', '10:10:10', 1, 1, 'Challenging route', 'https://www.alltrails.com/trail/us/arizona/bright-angel-trail--11', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (2, 'Jessica\'s Birthday hike', '2023-07-26 ', '10:10:10', '10:10:10', 1, 4, 'Easy route, here to have fun! Bring H2O', 'http://fakeurl.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (3, 'Trail Mountain', '2023-08-01', '06:00:00', '10:00:00', 18, 20, 'Star Waterfall Nature Journey', 'https://imagelink3.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (4, 'Photography Adventure', '2023-08-06', '06:00:00', '08:00:00', 7, 19, 'Star Lake Exploration Hike', 'https://imagelink4.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (5, 'Summit Photography', '2023-08-11', '06:00:00', '09:00:00', 12, 5, 'Echo Lake Runner Adventure', 'https://imagelink5.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (6, 'Nature Waterfall', '2023-08-16', '06:00:00', '11:00:00', 19, 6, 'Journey Exploration Sunset Summit', 'https://imagelink6.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (7, 'Excursion Sunset', '2023-08-21', '09:00:00', '11:00:00', 11, 7, 'Summit Scenery Excursion Photography', 'https://imagelink7.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (8, 'Mountain Adventure', '2023-08-26', '08:00:00', '12:00:00', 12, 9, 'Waterfall Forest Nature Photography', 'https://imagelink8.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (9, 'Scenery Morning', '2023-08-31', '09:00:00', '12:00:00', 20, 9, 'Morning Sunset Nature Exploration', 'https://imagelink9.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (10, 'Nature Sunset', '2023-09-05', '08:00:00', '13:00:00', 9, 9, 'Summit Forest Sunset Journey', 'https://imagelink10.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (11, 'Wildlife Summit', '2023-09-10', '09:00:00', '12:00:00', 9, 10, 'Trail Journey Sunset Summit', 'https://imagelink11.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (12, 'Sunset Journey', '2023-09-15', '08:00:00', '12:00:00', 6, 10, 'Sunset Hike Photography Adventure', 'https://imagelink12.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (13, 'Nature Excursion', '2023-09-20', '08:00:00', '12:00:00', 8, 11, 'Echo Excursion Scenery Exploration', 'https://imagelink13.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (14, 'Summit Echo', '2023-09-25', '09:00:00', '12:00:00', 12, 11, 'Journey Mountain Waterfall Morning', 'https://imagelink14.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (15, 'Photography Lake', '2023-09-30', '08:00:00', '13:00:00', 9, 11, 'Scenery Forest Echo Adventure', 'https://imagelink15.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (16, 'Excursion Scenery', '2023-10-05', '07:00:00', '12:00:00', 6, 12, 'Forest Lake Exploration Hike', 'https://imagelink16.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (17, 'Forest Journey', '2023-10-10', '08:00:00', '11:00:00', 19, 12, 'Summit Scenery Mountain Journey', 'https://imagelink17.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (18, 'Adventure Forest', '2023-10-15', '07:00:00', '09:00:00', 15, 12, 'Lake Mountain Nature Summit', 'https://imagelink18.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (19, 'Hike Exploration', '2023-10-20', '06:00:00', '10:00:00', 20, 13, 'Sunset Summit Lake Hike', 'https://imagelink19.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (20, 'Runner Echo', '2023-10-25', '08:00:00', '12:00:00', 5, 13, 'Journey Forest Echo Sunset', 'https://imagelink20.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (21, 'Exploration Trail', '2023-10-30', '09:00:00', '11:00:00', 7, 4, 'Star Photography Hike Morning', 'https://imagelink21.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (22, 'Trail Mountain', '2023-11-04', '08:00:00', '12:00:00', 1, 14, 'Photography Forest Adventure Journey', 'https://imagelink22.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (23, 'Trail Lake', '2023-11-09', '07:00:00', '09:00:00', 8, 14, 'Journey Sunset Excursion Echo', 'https://imagelink23.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (24, 'Journey Photography', '2023-11-14', '08:00:00', '13:00:00', 8, 15, 'Exploration Star Journey Sunset', 'https://imagelink24.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (25, 'Morning Nature', '2023-11-19', '07:00:00', '10:00:00', 13, 15, 'Nature Lake Echo Summit', 'https://imagelink25.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (26, 'Forest Mountain', '2023-11-24', '08:00:00', '11:00:00', 10, 2, 'Sunset Photography Summit Echo', 'https://imagelink26.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (27, 'Wildlife Mountain', '2023-11-29', '09:00:00', '11:00:00', 4, 2, 'Forest Lake Adventure Wildlife', 'https://imagelink27.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (28, 'Exploration Excursion', '2023-12-04', '06:00:00', '09:00:00', 2, 16, 'Runner Wildlife Echo Morning', 'https://imagelink28.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (29, 'Adventure Photography', '2023-12-09', '09:00:00', '11:00:00', 2, 16, 'Scenery Star Exploration Waterfall', 'https://imagelink29.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (30, 'Exploration Mountain', '2023-12-14', '07:00:00', '11:00:00', 3, 17, 'Summit Wildlife Runner Photography', 'https://imagelink30.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (31, 'Photography Exploration', '2023-12-19', '06:00:00', '10:00:00', 3, 19, 'Echo Hike Nature Sunset', 'https://imagelink31.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (32, 'Excursion Trail', '2023-12-24', '07:00:00', '12:00:00', 20, 17, 'Lake Sunset Exploration Hike', 'https://imagelink32.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (33, 'Sunset Hike', '2023-12-29', '08:00:00', '12:00:00', 12, 20, 'Adventure Echo Summit Waterfall', 'https://imagelink33.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (34, 'Summit Excursion', '2024-01-03', '06:00:00', '11:00:00', 12, 19, 'Nature Journey Echo Adventure', 'https://imagelink34.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (35, 'Lake Morning', '2024-01-08', '07:00:00', '09:00:00', 2, 5, 'Journey Hike Star Mountain', 'https://imagelink35.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (36, 'Excursion Mountain', '2024-01-13', '06:00:00', '10:00:00', 4, 7, 'Journey Forest Hike Adventure', 'https://imagelink36.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (37, 'Hike Morning', '2024-01-18', '07:00:00', '12:00:00', 11, 7, 'Waterfall Journey Lake Photography', 'https://imagelink37.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (38, 'Photography Scenery', '2024-01-23', '09:00:00', '13:00:00', 7, 7, 'Waterfall Star Lake Runner', 'https://imagelink38.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (39, 'Star Wildlife', '2024-01-28', '08:00:00', '11:00:00', 8, 8, 'Excursion Forest Echo Summit', 'https://imagelink39.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (40, 'Wildlife Echo', '2024-02-02', '06:00:00', '09:00:00', 15, 20, 'Excursion Summit Wildlife Adventure', 'https://imagelink40.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (41, 'Photography Star', '2024-02-07', '08:00:00', '12:00:00', 17, 7, 'Photography Nature Summit Scenery', 'https://imagelink41.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (42, 'Hike Morning', '2024-02-12', '06:00:00', '09:00:00', 6, 20, 'Echo Star Hike Exploration', 'https://imagelink42.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (43, 'Morning Waterfall', '2024-02-17', '09:00:00', '11:00:00', 19, 19, 'Mountain Trail Forest Scenery', 'https://imagelink43.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (44, 'Photography Echo', '2024-02-22', '06:00:00', '11:00:00', 11, 12, 'Trail Lake Runner Morning', 'https://imagelink44.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (45, 'Waterfall Star', '2024-02-27', '08:00:00', '10:00:00', 15, 8, 'Trail Lake Excursion Hike', 'https://imagelink45.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (46, 'Trail Mountain', '2024-03-03', '06:00:00', '09:00:00', 5, 9, 'Wildlife Lake Hike Summit', 'https://imagelink46.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (47, 'Exploration Morning', '2024-03-08', '08:00:00', '13:00:00', 5, 3, 'Sunset Excursion Forest Morning', 'https://imagelink47.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (48, 'Adventure Star', '2024-03-13', '08:00:00', '13:00:00', 12, 6, 'Excursion Summit Mountain Forest', 'https://imagelink48.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (49, 'Excursion Mountain', '2024-03-18', '07:00:00', '09:00:00', 17, 3, 'Runner Exploration Lake Wildlife', 'https://imagelink49.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (50, 'Sunset Hike', '2024-03-23', '07:00:00', '12:00:00', 9, 2, 'Nature Forest Waterfall Lake', 'https://imagelink50.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (51, 'Mountain Trail', '2024-03-28', '07:00:00', '11:00:00', 12, 9, 'Forest Journey Photography Adventure', 'https://imagelink51.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (52, 'Exploration Trail', '2024-04-02', '09:00:00', '11:00:00', 7, 8, 'Sunset Lake Mountain Forest', 'https://imagelink52.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (53, 'Hike Lake', '2024-04-07', '09:00:00', '13:00:00', 14, 5, 'Trail Star Exploration Summit', 'https://imagelink53.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (54, 'Mountain Sunset', '2024-04-12', '06:00:00', '10:00:00', 7, 7, 'Trail Lake Morning Journey', 'https://imagelink54.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (55, 'Star Wildlife', '2024-04-17', '08:00:00', '10:00:00', 6, 5, 'Echo Sunset Runner Photography', 'https://imagelink55.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (56, 'Hike Summit', '2024-04-22', '06:00:00', '09:00:00', 5, 3, 'Echo Adventure Summit Hike', 'https://imagelink56.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (57, 'Photography Star', '2024-04-27', '07:00:00', '09:00:00', 9, 1, 'Journey Morning Hike Echo', 'https://imagelink57.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (58, 'Trail Echo', '2024-05-02', '06:00:00', '10:00:00', 11, 8, 'Echo Morning Nature Excursion', 'https://imagelink58.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (59, 'Excursion Nature', '2024-05-07', '06:00:00', '10:00:00', 18, 3, 'Trail Excursion Star Mountain', 'https://imagelink59.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (60, 'Journey Adventure', '2024-05-12', '08:00:00', '10:00:00', 1, 1, 'Scenery Star Echo Morning', 'https://imagelink60.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (61, 'Sunset Lake', '2024-05-17', '06:00:00', '09:00:00', 9, 7, 'Wildlife Summit Photography Echo', 'https://imagelink61.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (62, 'Adventure Forest', '2024-05-22', '09:00:00', '13:00:00', 13, 5, 'Journey Sunset Wildlife Forest', 'https://imagelink62.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (63, 'Morning Star', '2024-05-27', '09:00:00', '11:00:00', 2, 2, 'Exploration Morning Summit Lake', 'https://imagelink63.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (64, 'Mountain Excursion', '2024-06-01', '09:00:00', '12:00:00', 19, 6, 'Star Runner Nature Journey', 'https://imagelink64.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (65, 'Trail Sunset', '2024-06-06', '08:00:00', '10:00:00', 11, 10, 'Forest Summit Star Photography', 'https://imagelink65.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (66, 'Nature Wildlife', '2024-06-11', '06:00:00', '09:00:00', 3, 4, 'Waterfall Exploration Runner Journey', 'https://imagelink66.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (67, 'Morning Photography', '2024-06-16', '09:00:00', '13:00:00', 5, 8, 'Adventure Waterfall Lake Echo', 'https://imagelink67.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (68, 'Waterfall Excursion', '2024-06-21', '08:00:00', '13:00:00', 7, 9, 'Star Sunset Trail Morning', 'https://imagelink68.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (69, 'Exploration Scenery', '2024-06-26', '09:00:00', '11:00:00', 12, 11, 'Nature Summit Star Runner', 'https://imagelink69.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (70, 'Photography Forest', '2024-07-01', '09:00:00', '14:00:00', 17, 4, 'Wildlife Scenery Trail Waterfall', 'https://imagelink70.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (71, 'Exploration Hike', '2024-07-06', '09:00:00', '13:00:00', 3, 4, 'Runner Trail Echo Wildlife', 'https://imagelink71.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (72, 'Scenery Sunset', '2024-07-11', '09:00:00', '13:00:00', 2, 4, 'Photography Lake Scenery Echo', 'https://imagelink72.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (73, 'Excursion Exploration', '2024-07-16', '07:00:00', '12:00:00', 13, 15, 'Star Waterfall Exploration Echo', 'https://imagelink73.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (74, 'Mountain Excursion', '2024-07-21', '08:00:00', '12:00:00', 1, 6, 'Wildlife Trail Exploration Photography', 'https://imagelink74.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (75, 'Exploration Waterfall', '2024-07-26', '09:00:00', '14:00:00', 6, 3, 'Lake Adventure Waterfall Mountain', 'https://imagelink75.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (76, 'Echo Exploration', '2024-07-31', '07:00:00', '11:00:00', 3, 5, 'Morning Wildlife Waterfall Exploration', 'https://imagelink76.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (77, 'Morning Waterfall', '2024-08-05', '07:00:00', '10:00:00', 1, 9, 'Star Hike Excursion Journey', 'https://imagelink77.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (78, 'Exploration Morning', '2024-08-10', '08:00:00', '13:00:00', 11, 8, 'Mountain Excursion Journey Summit', 'https://imagelink78.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (79, 'Adventure Echo', '2024-08-15', '09:00:00', '13:00:00', 18, 3, 'Wildlife Nature Morning Photography', 'https://imagelink79.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (80, 'Summit Excursion', '2024-08-20', '09:00:00', '13:00:00', 15, 16, 'Echo Star Summit Trail', 'https://imagelink80.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (81, 'Runner Excursion', '2024-08-25', '07:00:00', '12:00:00', 20, 3, 'Sunset Exploration Wildlife Forest', 'https://imagelink81.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (82, 'Forest Wildlife', '2024-08-30', '08:00:00', '12:00:00', 15, 18, 'Waterfall Scenery Wildlife Trail', 'https://imagelink82.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (83, 'Wildlife Exploration', '2024-09-04', '07:00:00', '11:00:00', 20, 18, 'Nature Runner Hike Journey', 'https://imagelink83.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (84, 'Waterfall Star', '2024-09-09', '08:00:00', '12:00:00', 1, 12, 'Journey Hike Summit Forest', 'https://imagelink84.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (85, 'Summit Lake', '2024-09-14', '09:00:00', '14:00:00', 6, 17, 'Adventure Hike Lake Waterfall', 'https://imagelink85.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (86, 'Trail Nature', '2024-09-19', '06:00:00', '08:00:00', 14, 17, 'Scenery Mountain Forest Photography', 'https://imagelink86.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (87, 'Star Echo', '2024-09-24', '07:00:00', '09:00:00', 13, 5, 'Hike Forest Mountain Exploration', 'https://imagelink87.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (88, 'Excursion Star', '2024-09-29', '06:00:00', '11:00:00', 20, 9, 'Journey Scenery Nature Runner', 'https://imagelink88.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (89, 'Mountain Photography', '2024-10-04', '09:00:00', '14:00:00', 8, 5, 'Lake Star Wildlife Runner', 'https://imagelink89.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (90, 'Nature Echo', '2024-10-09', '06:00:00', '10:00:00', 20, 5, 'Forest Star Waterfall Echo', 'https://imagelink90.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (91, 'Sunset Star', '2024-10-14', '08:00:00', '12:00:00', 9, 5, 'Journey Mountain Sunset Exploration', 'https://imagelink91.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (92, 'Nature Excursion', '2024-10-19', '06:00:00', '11:00:00', 13, 8, 'Trail Star Photography Hike', 'https://imagelink92.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (93, 'Star Adventure', '2024-10-24', '06:00:00', '09:00:00', 12, 10, 'Scenery Forest Waterfall Star', 'https://imagelink93.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (94, 'Scenery Hike', '2024-10-29', '08:00:00', '12:00:00', 16, 7, 'Wildlife Sunset Echo Waterfall', 'https://imagelink94.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (95, 'Photography Lake', '2024-11-03', '07:00:00', '11:00:00', 6, 7, 'Morning Photography Trail Sunset', 'https://imagelink95.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (96, 'Runner Summit', '2024-11-08', '09:00:00', '13:00:00', 17, 7, 'Trail Lake Journey Summit', 'https://imagelink96.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (97, 'Forest Summit', '2024-11-13', '06:00:00', '10:00:00', 8, 7, 'Adventure Trail Photography Star', 'https://imagelink97.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (98, 'Photography Excursion', '2024-11-18', '07:00:00', '11:00:00', 4, 7, 'Waterfall Star Hike Sunset', 'https://imagelink98.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (99, 'Exploration Scenery', '2024-11-23', '09:00:00', '14:00:00', 8, 7, 'Journey Star Scenery Echo', 'https://imagelink99.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (100, 'Morning Echo', '2024-11-28', '09:00:00', '13:00:00', 13, 9, 'Trail Journey Photography Star', 'https://imagelink100.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (101, 'Morning Sunset', '2024-12-03', '06:00:00', '08:00:00', 18, 9, 'Echo Scenery Wildlife Lake', 'https://imagelink101.com', 1);
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`, `active`) VALUES (102, 'Nature Mountain', '2024-12-08', '06:00:00', '11:00:00', 3, 9, 'Waterfall Runner Scenery Summit', 'https://imagelink102.com', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `meetup_rating` (`user_id`, `meetup_id`, `comment`, `rating`, `create_date`, `last_update`) VALUES (1, 1, 'blah blah blah', 2, '2020-01-01 10:10:10', '2020-02-01 10:10:10');
INSERT INTO `meetup_rating` (`user_id`, `meetup_id`, `comment`, `rating`, `create_date`, `last_update`) VALUES (1, 2, 'blahblah blah', 5, NULL, NULL);
INSERT INTO `meetup_rating` (`user_id`, `meetup_id`, `comment`, `rating`, `create_date`, `last_update`) VALUES (2, 4, 'blah', 3, NULL, NULL);

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
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (6, 'visitor center', 'visitor center');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (7, 'scenic overlook', 'multiple areas to overlook the park');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (8, 'cabins', '1-3 bedrooms, kitchen, and common area');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (9, 'interpretive signs', 'educational signs along trails');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (10, 'gift shop', 'buy gifts, snacks, and park merch at our gift shop');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (11, 'shuttle service', 'transportation within the park');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (12, 'accessibility features', 'facilities for visitors with disabilities');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (13, 'ranger programs', 'guided tours and educational activities');
INSERT INTO `amenity` (`id`, `name`, `description`) VALUES (14, 'biking ', 'trails designed for biking');

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
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (5, 2);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (6, 2);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (3, 2);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (2, 2);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (7, 3);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (8, 3);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (11, 3);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (12, 4);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (9, 5);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (1, 5);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (2, 5);
INSERT INTO `amenity_has_trail` (`amenity_id`, `trail_id`) VALUES (4, 6);

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
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 7);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 2);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 3);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (1, 4);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (2, 6);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (2, 8);
INSERT INTO `user_friend` (`user_id`, `friend_id`) VALUES (2, 3);

COMMIT;

