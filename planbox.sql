--
-- Database: `planbox`
--
--
-- Table structure for table `Contact`
--

CREATE TABLE `Contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(256) NOT NULL,
  `lastname` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Table structure for table `PhoneNumber`
--

CREATE TABLE `PhoneNumber` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `number` varchar(32) NOT NULL,
  `contact_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_id` (`contact_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Constraints for table `PhoneNumber`
--
ALTER TABLE `PhoneNumber`
  ADD CONSTRAINT `PhoneNumber_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `Contact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
