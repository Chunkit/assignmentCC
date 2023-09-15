-- --------------------------------------------------------
-- Host:                         internshipdatabase.cpkr5ofaey5p.us-east-1.rds.amazonaws.com
-- Server version:               10.6.14-MariaDB - managed by https://aws.amazon.com/rds/
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table internshipDatabase.Admin
DROP TABLE IF EXISTS `Admin`;
CREATE TABLE IF NOT EXISTS `Admin` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Admin: ~0 rows (approximately)
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` (`id`, `name`, `email`, `password`) VALUES
	('1', 'Admin', 'admin123@gmail.com', 'admin123');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.Application
DROP TABLE IF EXISTS `Application`;
CREATE TABLE IF NOT EXISTS `Application` (
  `app_id` varchar(50) NOT NULL,
  `stud_id` varchar(50) NOT NULL,
  `company_id` varchar(50) NOT NULL,
  `intern_id` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`app_id`),
  KEY `STUD_APP_FK` (`stud_id`),
  KEY `COM_APP_FK` (`company_id`),
  KEY `INTERN_APP_FK` (`intern_id`),
  CONSTRAINT `COM_APP_FK` FOREIGN KEY (`company_id`) REFERENCES `Company` (`com_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `INTERN_APP_FK` FOREIGN KEY (`intern_id`) REFERENCES `Internship` (`intern_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `STUD_APP_FK` FOREIGN KEY (`stud_id`) REFERENCES `Student` (`stud_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Application: ~0 rows (approximately)
/*!40000 ALTER TABLE `Application` DISABLE KEYS */;
/*!40000 ALTER TABLE `Application` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.ComApproval
DROP TABLE IF EXISTS `ComApproval`;
CREATE TABLE IF NOT EXISTS `ComApproval` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `com_id` varchar(50) NOT NULL DEFAULT '',
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `COM_APPROVE_FK` (`com_id`),
  CONSTRAINT `COM_APPROVE_FK` FOREIGN KEY (`com_id`) REFERENCES `Company` (`com_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.ComApproval: ~0 rows (approximately)
/*!40000 ALTER TABLE `ComApproval` DISABLE KEYS */;
/*!40000 ALTER TABLE `ComApproval` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.Company
DROP TABLE IF EXISTS `Company`;
CREATE TABLE IF NOT EXISTS `Company` (
  `com_id` varchar(50) NOT NULL,
  `com_name` varchar(50) DEFAULT NULL,
  `total_staff` int(11) DEFAULT NULL,
  `industry_involve` varchar(50) DEFAULT NULL,
  `product_service` varchar(50) DEFAULT NULL,
  `company_website` varchar(50) DEFAULT NULL,
  `OT_claim` double DEFAULT NULL,
  `nearest_station` varchar(50) DEFAULT NULL,
  `com_address` varchar(50) DEFAULT NULL,
  `logo` varchar(50) DEFAULT NULL,
  `ssm` varchar(50) DEFAULT NULL,
  `person_incharge` varchar(50) DEFAULT NULL,
  `contact_no` varchar(50) DEFAULT NULL,
  `e-mail` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`com_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Company: ~0 rows (approximately)
/*!40000 ALTER TABLE `Company` DISABLE KEYS */;
INSERT INTO `Company` (`com_id`, `com_name`, `total_staff`, `industry_involve`, `product_service`, `company_website`, `OT_claim`, `nearest_station`, `com_address`, `logo`, `ssm`, `person_incharge`, `contact_no`, `e-mail`, `password`) VALUES
	('1', 'CnoK', 5, 'IT', 'Website', 'CnoK@gmail.com', 0, 'No', 'PJ', NULL, NULL, 'Dr Kwo', '03494324523', 'ck@cnok.com', 'ck123456');
/*!40000 ALTER TABLE `Company` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.Internship
DROP TABLE IF EXISTS `Internship`;
CREATE TABLE IF NOT EXISTS `Internship` (
  `intern_id` varchar(50) NOT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `job_description` text DEFAULT NULL,
  `intern_salary` double DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `workingDay` varchar(50) DEFAULT NULL,
  `workingHour` varchar(50) DEFAULT NULL,
  `accommodation` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`intern_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Internship: ~0 rows (approximately)
/*!40000 ALTER TABLE `Internship` DISABLE KEYS */;
INSERT INTO `Internship` (`intern_id`, `job_title`, `job_description`, `intern_salary`, `location`, `workingDay`, `workingHour`, `accommodation`) VALUES
	('1', 'Software Engineer', 'Just Code', 500, 'PJ', 'Monday - Friday', '0800 - 1800', 'No');
/*!40000 ALTER TABLE `Internship` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.Report
DROP TABLE IF EXISTS `Report`;
CREATE TABLE IF NOT EXISTS `Report` (
  `report_id` varchar(50) NOT NULL,
  `stud_id` varchar(50) NOT NULL,
  `report_title` varchar(50) DEFAULT NULL,
  `report_type` varchar(50) DEFAULT NULL,
  `report` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `STUD_REP_FK` (`stud_id`),
  CONSTRAINT `STUD_REP_FK` FOREIGN KEY (`stud_id`) REFERENCES `Student` (`stud_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Report: ~0 rows (approximately)
/*!40000 ALTER TABLE `Report` DISABLE KEYS */;
/*!40000 ALTER TABLE `Report` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.StudApproval
DROP TABLE IF EXISTS `StudApproval`;
CREATE TABLE IF NOT EXISTS `StudApproval` (
  `id` varchar(50) NOT NULL,
  `stud_id` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `STUD_APPROVE_FK` (`stud_id`),
  CONSTRAINT `STUD_APPROVE_FK` FOREIGN KEY (`stud_id`) REFERENCES `Student` (`stud_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.StudApproval: ~0 rows (approximately)
/*!40000 ALTER TABLE `StudApproval` DISABLE KEYS */;
/*!40000 ALTER TABLE `StudApproval` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.Student
DROP TABLE IF EXISTS `Student`;
CREATE TABLE IF NOT EXISTS `Student` (
  `stud_id` varchar(50) NOT NULL,
  `stud_name` varchar(50) DEFAULT NULL,
  `ic` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `programme` varchar(50) DEFAULT NULL,
  `group` int(11) DEFAULT NULL,
  `cgpa` double DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `intern_batch` varchar(50) DEFAULT NULL,
  `ownTransport` varchar(50) DEFAULT NULL,
  `currentAddress` varchar(50) DEFAULT NULL,
  `contactNo` varchar(50) DEFAULT NULL,
  `personalEmail` varchar(50) DEFAULT NULL,
  `homeAddress` varchar(50) DEFAULT NULL,
  `homePhone` varchar(50) DEFAULT NULL,
  `profile_img` varchar(50) DEFAULT NULL,
  `resume` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`stud_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Student: ~0 rows (approximately)
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` (`stud_id`, `stud_name`, `ic`, `email`, `gender`, `programme`, `group`, `cgpa`, `password`, `intern_batch`, `ownTransport`, `currentAddress`, `contactNo`, `personalEmail`, `homeAddress`, `homePhone`, `profile_img`, `resume`) VALUES
	('22WMR05651', 'Hing Zi Hui', '020101010111', 'hingzh-wm20@student.tarc.edu.my', 'M', 'RSW', 6, 4, 'zihui123456', 'Y22July', 'Yes', 'No 123, PSN 123, TMN 123, 52111, KL', '0101234567', 'hingzihui@gmail.com', 'No 123, PSN 123, TMN 123, 52111, KL', '0365748264', 'img', 'resume'),
	('22WMR05654', 'Ho Wen Ting', '020101010111', 'howt-wm20@student.tarc.edu.my', 'F', 'RSW', 6, 4, 'wenting123456', 'Y22July', 'Yes', 'No 123, PSN 123, TMN 123, 52111, KL', '0101234567', 'howenting@gmail.com', 'No 123, PSN 123, TMN 123, 52111, KL', '0365748264', 'img', 'resume'),
	('22WMR05658', 'Hue Zhen Wei', '020202020222', 'huezw-wm@student.tarc.edu.my', 'M', 'RSW', 6, 4, 'zhenwei123456', 'Y22July', 'Yes', 'No 123, PSN 123, TMN 345, 647284, KL', '0123234345', 'huezhenwei@gmail.com', 'No 123, PSN 123, TMN 123, 52111, KL', '0453638234', 'img', 'resume'),
	('22WMR05661', 'Joshua Chong Zhiguang', '020101010111', 'joshuacz-wm20@student.tarc.edu.my', 'M', 'RSW', 6, 4, 'joshua123456', 'Y22July', 'Yes', 'No 123, PSN 123, TMN 123, 52111, KL', '0101234567', 'joshua@gmail.com', 'No 123, PSN 123, TMN 123, 52111, KL', '0365748264', 'img', 'resume'),
	('22WMR05665', 'Kwo Chun Kit', '020303033333', 'kwock-wm20@student.tarc.edu.my', 'M', 'RSW', 6, 4, 'chunkit123456', 'Y22July', 'Yes', 'No 123, PSN 123, TMN 123, 52111, KL', '0138573645', 'chunkit@gmail.com', 'No.123, PSN 1234, TMN 2, 48924, KL', '03857356284', 'img', 'resume');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.Student_List
DROP TABLE IF EXISTS `Student_List`;
CREATE TABLE IF NOT EXISTS `Student_List` (
  `list_id` varchar(50) NOT NULL,
  `sv_id` varchar(50) NOT NULL,
  `stud_id` varchar(50) NOT NULL,
  PRIMARY KEY (`list_id`),
  KEY `SV_LIST_FK` (`sv_id`),
  KEY `STUD_LIST_FK` (`stud_id`),
  CONSTRAINT `STUD_LIST_FK` FOREIGN KEY (`stud_id`) REFERENCES `Student` (`stud_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `SV_LIST_FK` FOREIGN KEY (`sv_id`) REFERENCES `Supervisor` (`sv_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Student_List: ~0 rows (approximately)
/*!40000 ALTER TABLE `Student_List` DISABLE KEYS */;
/*!40000 ALTER TABLE `Student_List` ENABLE KEYS */;

-- Dumping structure for table internshipDatabase.Supervisor
DROP TABLE IF EXISTS `Supervisor`;
CREATE TABLE IF NOT EXISTS `Supervisor` (
  `sv_id` varchar(50) NOT NULL,
  `sv_name` varchar(50) DEFAULT NULL,
  `sv_email` varchar(50) DEFAULT NULL,
  `programme` varchar(50) DEFAULT NULL,
  `faculty` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `profile_image` binary(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table internshipDatabase.Supervisor: ~0 rows (approximately)
/*!40000 ALTER TABLE `Supervisor` DISABLE KEYS */;
INSERT INTO `Supervisor` (`sv_id`, `sv_name`, `sv_email`, `programme`, `faculty`, `age`, `profile_image`, `password`) VALUES
	('1', 'Choon Keat Low', 'P001@tarc.edu.my', 'RSW', 'FOCS', 30, NULL, 'keatlow123456');
/*!40000 ALTER TABLE `Supervisor` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
