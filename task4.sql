-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--
-- WHERE:  true order by help_keyword_id limit 100

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (0,'HELP_DATE'),(1,'HELP_VERSION'),(2,'DEFAULT'),(3,'SERIAL'),(4,'VALUE'),(5,'HELP'),(6,'FALSE'),(7,'TRUE'),(8,'BOOL'),(9,'BOOLEAN'),(10,'INT1'),(11,'UNSIGNED'),(12,'ZEROFILL'),(13,'INT2'),(14,'INT3'),(15,'MIDDLEINT'),(16,'INT4'),(17,'INTEGER'),(18,'INT8'),(19,'DEC'),(20,'FIXED'),(21,'NUMERIC'),(22,'DECIMAL'),(23,'FLOAT4'),(24,'FLOAT8'),(25,'PRECISION'),(26,'REAL'),(27,'DATE'),(28,'TIMESTAMP'),(29,'TIME'),(30,'CHARACTER'),(31,'NATIONAL'),(32,'NCHAR'),(33,'BYTE'),(34,'CHAR'),(35,'NVARCHAR'),(36,'VARCHARACTER'),(37,'VARYING'),(38,'LONG'),(39,'LONGBINARY'),(40,'ADD'),(41,'ALTER'),(42,'CREATE'),(43,'INDEX'),(44,'KEY'),(45,'TABLE'),(46,'<>'),(47,'AND'),(48,'BETWEEN'),(49,'IS'),(50,'NOT'),(51,'NULL'),(52,'OR'),(53,'CASE'),(54,'ELSE'),(55,'END'),(56,'THEN'),(57,'WHEN'),(58,'IF'),(59,'BIGINT'),(60,'FLOOR'),(61,'MOD'),(62,'CEIL'),(63,'CEILING'),(64,'POW'),(65,'POWER'),(66,'DATE_ADD'),(67,'DATE_SUB'),(68,'DAY'),(69,'DAY_HOUR'),(70,'DAY_MINUTE'),(71,'DAY_SECOND'),(72,'HOUR'),(73,'HOUR_MINUTE'),(74,'HOUR_SECOND'),(75,'INTERVAL'),(76,'MINUTE'),(77,'MINUTE_SECOND'),(78,'MONTH'),(79,'SECOND'),(80,'YEAR'),(81,'YEAR_MONTH'),(82,'INSERT'),(83,'LIKE'),(84,'SOUNDS'),(85,'BOTH'),(86,'FROM'),(87,'LEADING'),(88,'TRAILING'),(89,'ESCAPE'),(90,'RLIKE'),(91,'REGEXP_INSTR'),(92,'REGEXP_LIKE'),(93,'REGEXP_REPLACE'),(94,'REGEXP_SUBSTR'),(95,'AGAINST'),(96,'EXPANSION'),(97,'IN'),(98,'MATCH'),(99,'MODE');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-23 18:39:03
