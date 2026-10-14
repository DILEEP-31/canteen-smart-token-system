/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 8.0.46 : Database - canteen_smart_token
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`canteen_smart_token` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `canteen_smart_token`;

/*Table structure for table `food_items` */

DROP TABLE IF EXISTS `food_items`;

CREATE TABLE `food_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `available` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `food_items` */

insert  into `food_items`(`item_id`,`item_name`,`category`,`price`,`available`) values 
(1,'Masala Dosa','Breakfast',45.00,1),
(2,'Idli','Breakfast',30.00,1),
(3,'Vada','Snacks',20.00,1),
(4,'Veg Meals','Lunch',70.00,1),
(5,'Fried Rice','Lunch',80.00,1),
(6,'Tea','Beverage',15.00,1),
(7,'Coffee','Beverage',20.00,1),
(8,'Samosa','Snacks',15.00,0),
(9,'Masala Dosa','Breakfast',40.00,1),
(10,'Idli','Breakfast',30.00,1),
(11,'Vada','Snacks',20.00,1),
(12,'Veg Meals','Lunch',70.00,1),
(13,'Fried Rice','Lunch',80.00,1),
(14,'Tea','Beverage',15.00,1),
(15,'Coffee','Beverage',20.00,1),
(16,'Samosa','Snacks',15.00,1),
(17,'Masala Dosa','Breakfast',40.00,1),
(18,'Idli','Breakfast',30.00,1),
(19,'Vada','Snacks',20.00,1),
(20,'Veg Meals','Lunch',70.00,1),
(21,'Fried Rice','Lunch',80.00,1),
(22,'Tea','Beverage',15.00,1),
(23,'Coffee','Beverage',20.00,1),
(24,'Samosa','Snacks',15.00,1);

/*Table structure for table `payments` */

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `token_id` int NOT NULL,
  `payment_method` enum('Cash','UPI','Card') NOT NULL,
  `payment_status` enum('Pending','Paid','Failed') DEFAULT 'Pending',
  `payment_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `token_id` (`token_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`token_id`) REFERENCES `tokens` (`token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `payments` */

insert  into `payments`(`payment_id`,`token_id`,`payment_method`,`payment_status`,`payment_time`) values 
(1,1,'UPI','Paid','2026-10-08 09:42:46'),
(2,2,'Cash','Paid','2026-10-08 09:42:46'),
(3,3,'UPI','Paid','2026-10-08 09:42:46'),
(4,1,'UPI','Paid','2026-10-08 12:16:47'),
(5,2,'Cash','Paid','2026-10-08 12:16:47'),
(6,3,'UPI','Paid','2026-10-08 12:16:47'),
(7,1,'UPI','Paid','2026-10-08 14:28:25'),
(8,2,'Cash','Paid','2026-10-08 14:28:25'),
(9,3,'UPI','Paid','2026-10-08 14:28:25');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `staff` */

insert  into `staff`(`staff_id`,`name`,`role`) values 
(1,'Ramesh','Manager'),
(2,'Suresh','Cashier'),
(3,'Mahesh','Cook'),
(4,'Ramesh','Manager'),
(5,'Suresh','Cashier'),
(6,'Mahesh','Cook'),
(7,'Ramesh','Manager'),
(8,'Suresh','Cashier'),
(9,'Mahesh','Cook'),
(10,'Ramesh','Manager'),
(11,'Suresh','Cashier'),
(12,'Mahesh','Cook');

/*Table structure for table `students` */

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `roll_no` varchar(30) NOT NULL,
  `department` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `roll_no` (`roll_no`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `students` */

insert  into `students`(`student_id`,`name`,`roll_no`,`department`,`phone`) values 
(1,'Rahul Kumar','CS101','CSE','9876543210'),
(2,'Arjun Raj','CS102','CSE','9876543211'),
(3,'Ananya Sharma','EC101','ECE','9876543212'),
(4,'Priya Nair','ME101','ME','9876543213');

/*Table structure for table `token_items` */

DROP TABLE IF EXISTS `token_items`;

CREATE TABLE `token_items` (
  `token_item_id` int NOT NULL AUTO_INCREMENT,
  `token_id` int NOT NULL,
  `item_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`token_item_id`),
  KEY `token_id` (`token_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `token_items_ibfk_1` FOREIGN KEY (`token_id`) REFERENCES `tokens` (`token_id`),
  CONSTRAINT `token_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `food_items` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `token_items` */

insert  into `token_items`(`token_item_id`,`token_id`,`item_id`,`quantity`,`price`,`subtotal`) values 
(1,1,1,1,40.00,40.00),
(2,1,6,1,15.00,15.00),
(3,1,8,1,15.00,15.00),
(4,2,5,1,80.00,80.00),
(5,2,6,1,15.00,15.00),
(6,3,4,1,70.00,70.00),
(7,1,1,1,40.00,40.00),
(8,1,6,1,15.00,15.00),
(9,1,8,1,15.00,15.00),
(10,2,5,1,80.00,80.00),
(11,2,6,1,15.00,15.00),
(12,3,4,1,70.00,70.00),
(13,4,2,1,30.00,30.00),
(14,1,1,1,40.00,40.00),
(15,1,6,1,15.00,15.00),
(16,1,8,1,15.00,15.00),
(17,2,5,1,80.00,80.00),
(18,2,6,1,15.00,15.00),
(19,3,4,1,70.00,70.00),
(20,4,2,1,30.00,30.00);

/*Table structure for table `tokens` */

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `token_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `token_date` date NOT NULL,
  `token_time` time NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('Pending','Preparing','Ready','Collected','Cancelled') DEFAULT 'Pending',
  PRIMARY KEY (`token_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `tokens` */

insert  into `tokens`(`token_id`,`student_id`,`token_date`,`token_time`,`total_amount`,`status`) values 
(1,1,'2026-10-08','09:42:21',75.00,'Collected'),
(2,2,'2026-10-08','09:42:21',100.00,'Preparing'),
(3,3,'2026-10-08','09:42:21',70.00,'Ready'),
(4,1,'2026-10-08','12:16:47',75.00,'Pending'),
(5,2,'2026-10-08','12:16:47',100.00,'Preparing'),
(6,3,'2026-10-08','12:16:47',70.00,'Ready'),
(7,1,'2026-10-08','14:28:25',75.00,'Pending'),
(8,2,'2026-10-08','14:28:25',100.00,'Preparing'),
(9,3,'2026-10-08','14:28:25',70.00,'Ready');

/*Table structure for table `token_details` */

DROP TABLE IF EXISTS `token_details`;

/*!50001 DROP VIEW IF EXISTS `token_details` */;
/*!50001 DROP TABLE IF EXISTS `token_details` */;

/*!50001 CREATE TABLE  `token_details`(
 `token_id` int ,
 `student_name` varchar(100) ,
 `roll_no` varchar(30) ,
 `item_name` varchar(100) ,
 `quantity` int ,
 `subtotal` decimal(10,2) ,
 `total_amount` decimal(10,2) ,
 `status` enum('Pending','Preparing','Ready','Collected','Cancelled') ,
 `token_date` date ,
 `token_time` time 
)*/;

/*View structure for view token_details */

/*!50001 DROP TABLE IF EXISTS `token_details` */;
/*!50001 DROP VIEW IF EXISTS `token_details` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `token_details` AS select `t`.`token_id` AS `token_id`,`s`.`name` AS `student_name`,`s`.`roll_no` AS `roll_no`,`f`.`item_name` AS `item_name`,`ti`.`quantity` AS `quantity`,`ti`.`subtotal` AS `subtotal`,`t`.`total_amount` AS `total_amount`,`t`.`status` AS `status`,`t`.`token_date` AS `token_date`,`t`.`token_time` AS `token_time` from (((`tokens` `t` join `students` `s` on((`t`.`student_id` = `s`.`student_id`))) join `token_items` `ti` on((`t`.`token_id` = `ti`.`token_id`))) join `food_items` `f` on((`ti`.`item_id` = `f`.`item_id`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
