-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: iot
-- ------------------------------------------------------
-- Server version	8.0.32


DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `deviceID` int NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Output` varchar(255) DEFAULT NULL,
  `Status` int DEFAULT NULL,
  PRIMARY KEY (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `device` WRITE;

UNLOCK TABLES;


DROP TABLE IF EXISTS `diagnose`;

CREATE TABLE `diagnose` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Link_image` text NOT NULL,
  `Diagnose` text NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `diagnose` WRITE;
INSERT INTO `diagnose` VALUES (1,'./upload/305819068_1131200254185802_4464402511030800070_n.jpg','Tomato - Bệnh đốm lá Septoria (Septoria Leaf Spot Disease)','2023-11-20 22:30:34');
UNLOCK TABLES;

DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Time` datetime NOT NULL,
  `Temperature` double NOT NULL,
  `Light` double NOT NULL,
  `Humidity` double NOT NULL,
  `Soil` double NOT NULL,
  `pump_state` varchar(45) NOT NULL,
  `light_state` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (1,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(2,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(3,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(4,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(5,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(6,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(7,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(8,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(9,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(10,'2023-11-20 21:39:33',24,6.666666508,46,37,'OFF','OFF'),(11,'2023-11-20 22:00:15',24,6.666666508,46,37,'OFF','OFF'),(12,'2023-11-20 22:00:15',24,6.666666508,46,37,'OFF','OFF'),(13,'2023-11-20 22:00:15',24,6.666666508,46,37,'OFF','OFF'),(14,'2023-11-20 22:00:15',24,6.666666508,46,37,'OFF','OFF'),(15,'2023-11-20 22:00:15',24,6.666666508,46,37,'OFF','OFF'),(16,'2023-11-20 22:00:15',24,6.666666508,46,37,'OFF','OFF'),(17,'2023-11-20 22:30:34',24,6.666666508,46,37,'OFF','OFF');
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `light`;

CREATE TABLE `light` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `State` varchar(255) NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `light` WRITE;
INSERT INTO `light` VALUES (1,'OFF','2023-11-20 21:39:33'),(2,'OFF','2023-11-20 21:39:33'),(3,'OFF','2023-11-20 21:39:33'),(4,'OFF','2023-11-20 21:39:33'),(5,'OFF','2023-11-20 21:39:33'),(6,'OFF','2023-11-20 21:39:33'),(7,'OFF','2023-11-20 21:39:33'),(8,'OFF','2023-11-20 21:39:33'),(9,'OFF','2023-11-20 21:39:33'),(10,'OFF','2023-11-20 21:39:33'),(11,'OFF','2023-11-20 22:00:15'),(12,'OFF','2023-11-20 22:00:15'),(13,'OFF','2023-11-20 22:00:15'),(14,'OFF','2023-11-20 22:00:15'),(15,'OFF','2023-11-20 22:00:15'),(16,'OFF','2023-11-20 22:00:15'),(17,'OFF','2023-11-20 22:30:34');
UNLOCK TABLES;

DROP TABLE IF EXISTS `lightsensor`;

CREATE TABLE `lightsensor` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Light_Intensity` double NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `lightsensor` WRITE;
INSERT INTO `lightsensor` VALUES (1,6.666666508,'2023-11-20 21:39:33'),(2,6.666666508,'2023-11-20 21:39:33'),(3,6.666666508,'2023-11-20 21:39:33'),(4,6.666666508,'2023-11-20 21:39:33'),(5,6.666666508,'2023-11-20 21:39:33'),(6,6.666666508,'2023-11-20 21:39:33'),(7,6.666666508,'2023-11-20 21:39:33'),(8,6.666666508,'2023-11-20 21:39:33'),(9,6.666666508,'2023-11-20 21:39:33'),(10,6.666666508,'2023-11-20 21:39:33'),(11,6.666666508,'2023-11-20 22:00:15'),(12,6.666666508,'2023-11-20 22:00:15'),(13,6.666666508,'2023-11-20 22:00:15'),(14,6.666666508,'2023-11-20 22:00:15'),(15,6.666666508,'2023-11-20 22:00:15'),(16,6.666666508,'2023-11-20 22:00:15'),(17,6.666666508,'2023-11-20 22:30:34');
UNLOCK TABLES;

--
-- Table structure for table `soilhumiditysensor`
--

DROP TABLE IF EXISTS `soilhumiditysensor`;

CREATE TABLE `soilhumiditysensor` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `SoilHumidity` float NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `soilhumiditysensor` WRITE;
INSERT INTO `soilhumiditysensor` VALUES (1,37,'2023-11-20 21:39:33'),(2,37,'2023-11-20 21:39:33'),(3,37,'2023-11-20 21:39:33'),(4,37,'2023-11-20 21:39:33'),(5,37,'2023-11-20 21:39:33'),(6,37,'2023-11-20 21:39:33'),(7,37,'2023-11-20 21:39:33'),(8,37,'2023-11-20 21:39:33'),(9,37,'2023-11-20 21:39:33'),(10,37,'2023-11-20 21:39:33'),(11,37,'2023-11-20 22:00:15'),(12,37,'2023-11-20 22:00:15'),(13,37,'2023-11-20 22:00:15'),(14,37,'2023-11-20 22:00:15'),(15,37,'2023-11-20 22:00:15'),(16,37,'2023-11-20 22:00:15'),(17,37,'2023-11-20 22:30:34');

UNLOCK TABLES;


DROP TABLE IF EXISTS `temperaturehumidity`;

CREATE TABLE `temperaturehumidity` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Temperature` double NOT NULL,
  `Humidity` double NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `temperaturehumidity` WRITE;
INSERT INTO `temperaturehumidity` VALUES (1,24,46,'2023-11-20 21:39:33'),(2,24,46,'2023-11-20 21:39:33'),(3,24,46,'2023-11-20 21:39:33'),(4,24,46,'2023-11-20 21:39:33'),(5,24,46,'2023-11-20 21:39:33'),(6,24,46,'2023-11-20 21:39:33'),(7,24,46,'2023-11-20 21:39:33'),(8,24,46,'2023-11-20 21:39:33'),(9,24,46,'2023-11-20 21:39:33'),(10,24,46,'2023-11-20 21:39:33'),(11,24,46,'2023-11-20 22:00:15'),(12,24,46,'2023-11-20 22:00:15'),(13,24,46,'2023-11-20 22:00:15'),(14,24,46,'2023-11-20 22:00:15'),(15,24,46,'2023-11-20 22:00:15'),(16,24,46,'2023-11-20 22:00:15'),(17,24,46,'2023-11-20 22:30:34');

UNLOCK TABLES;

DROP TABLE IF EXISTS `waterpump`;

CREATE TABLE `waterpump` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `State` varchar(255) NOT NULL,
  `Time` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `waterpump` WRITE;

INSERT INTO `waterpump` VALUES (1,'OFF','2023-11-20 21:39:33'),(2,'OFF','2023-11-20 21:39:33'),(3,'OFF','2023-11-20 21:39:33'),(4,'OFF','2023-11-20 21:39:33'),(5,'OFF','2023-11-20 21:39:33'),(6,'OFF','2023-11-20 21:39:33'),(7,'OFF','2023-11-20 21:39:33'),(8,'OFF','2023-11-20 21:39:33'),(9,'OFF','2023-11-20 21:39:33'),(10,'OFF','2023-11-20 21:39:33'),(11,'OFF','2023-11-20 22:00:15'),(12,'OFF','2023-11-20 22:00:15'),(13,'OFF','2023-11-20 22:00:15'),(14,'OFF','2023-11-20 22:00:15'),(15,'OFF','2023-11-20 22:00:15'),(16,'OFF','2023-11-20 22:00:15'),(17,'OFF','2023-11-20 22:30:34');

UNLOCK TABLES;
DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOCK TABLES `account` WRITE;
INSERT INTO `account` VALUES (1,'admin','12345678',1),(3,'user','12345678',0);
UNLOCK TABLES;