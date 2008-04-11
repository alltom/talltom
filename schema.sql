-- MySQL dump 10.11
--
-- Host: localhost    Database: alltom
-- ------------------------------------------------------
-- Server version	5.0.51a
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `news_updates`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `news_updates` (
  `id` int(11) NOT NULL,
  `body` text NOT NULL,
  `created_on` datetime default NULL,
  PRIMARY KEY  (`id`)
);
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `page_versions`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `page_versions` (
  `id` int(11) NOT NULL,
  `page_id` int(11) default NULL,
  `version` int(11) default NULL,
  `body` text,
  `publish_date` datetime default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `show_on_front_page` tinyint(1) default NULL,
  `show_in_rss` tinyint(1) default '1',
  `edit_comment` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
);
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pages`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `current_version_id` int(11) default NULL,
  `allow_comments` tinyint(1) default '1',
  PRIMARY KEY  (`id`)
);
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `projects`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `page_id` int(11) default NULL,
  `status` varchar(100) default NULL,
  `updated_at` datetime default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
);
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-03-18  7:05:36
