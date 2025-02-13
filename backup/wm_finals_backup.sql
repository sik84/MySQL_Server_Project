-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: wm_finals
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `finals`
--

DROP TABLE IF EXISTS `finals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `finals` (
  `year` int NOT NULL,
  `host_country` varchar(50) DEFAULT NULL,
  `winner` varchar(50) DEFAULT NULL,
  `runner_up` varchar(50) DEFAULT NULL,
  `score` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finals`
--

LOCK TABLES `finals` WRITE;
/*!40000 ALTER TABLE `finals` DISABLE KEYS */;
INSERT INTO `finals` VALUES (1930,'Uruguay','Uruguay','Argentinien','4-2'),(1934,'Italien','Italien','Tschechoslowakei','2-1'),(1938,'Frankreich','Italien','Ungarn','4-2'),(1950,'Brasilien','Uruguay','Brasilien','2-1'),(1954,'Schweiz','Deutschland','Ungarn','3-2'),(1958,'Schweden','Brasilien','Schweden','5-2'),(1962,'Chile','Brasilien','Tschechoslowakei','3-1'),(1966,'England','England','Deutschland','4-2'),(1970,'Mexiko','Brasilien','Italien','4-1'),(1974,'Deutschland','Deutschland','Niederlande','2-1'),(1978,'Argentinien','Argentinien','Niederlande','3-1'),(1982,'Spanien','Italien','Deutschland','3-1'),(1986,'Mexiko','Argentinien','Deutschland','3-2'),(1990,'Italien','Deutschland','Argentinien','1-0');
/*!40000 ALTER TABLE `finals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-13 18:26:34
