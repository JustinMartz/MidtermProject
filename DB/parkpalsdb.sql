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

COMMIT;


-- -----------------------------------------------------
-- Data for table `trail`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `trail` (`id`, `name`, `description`, `longitude`, `latitude`, `length_in_miles`, `park_id`, `active`, `image_url`) VALUES (1, 'Gator hook trail', 'long trail, goes around a lake', '25.8315n', '81.1005w', 4.7, 1, 1, 'http://anotherfakeurl.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `meetup` (`id`, `name`, `meetup_date`, `start_time`, `end_time`, `trail_id`, `user_id`, `description`, `image_url`) VALUES (1, 'hike at goldminors trail', '2020-12-01 10:06:10', '10:10:10', '10:10:10', 1, 1, 'long and rough, bring water', 'http://fakefakeurl.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `parkpalsdb`;
INSERT INTO `meetup_rating` (`user_id`, `meetup_id`, `comment`, `rating`, `create_date`, `last_update`) VALUES (1, 1, 'blah blah blah', 2, '2020-01-01 10:10:10', '2020-02-01 10:10:10');

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

