
CREATE TABLE IF NOT EXISTS `mdfishing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `fishing` int(10) DEFAULT 0,
  `illegalfish` int(10) DEFAULT 0,
  `magnetfish` int(10) DEFAULT 0,
  `fishxp` int(10) DEFAULT 0,
  `magxp` int(10) DEFAULT 0,
  `illfishxp` int(10) DEFAULT 0,
  `name` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
