-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2022 at 07:35 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `princebee`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) UNSIGNED NOT NULL,
  `cid` int(11) UNSIGNED NOT NULL,
  `status` varchar(100) DEFAULT 'pending',
  `notes` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `cid`, `status`, `notes`) VALUES
(12, 10, 'CANCELLED', NULL),
(13, 10, 'CANCELLED', NULL),
(14, 10, 'CANCELLED', NULL),
(15, 10, 'CONFIRMED', NULL),
(16, 10, 'CONFIRMED', NULL),
(17, 14, 'CONFIRMED', NULL),
(18, 14, 'CONFIRMED', NULL),
(19, 14, 'CONFIRMED', NULL),
(20, 14, 'CONFIRMED', NULL),
(21, 14, 'CONFIRMED', NULL),
(22, 14, 'CONFIRMED', NULL),
(23, 14, 'CONFIRMED', NULL),
(24, 14, 'PENDING', NULL),
(25, 14, 'PENDING', NULL),
(26, 14, 'PENDING', NULL),
(27, 14, 'PENDING', NULL),
(28, 14, 'PENDING', NULL),
(29, 14, 'PENDING', NULL),
(30, 14, 'PENDING', NULL),
(31, 14, 'PENDING', NULL),
(32, 14, 'PENDING', NULL),
(33, 14, 'PENDING', NULL),
(34, 14, 'PENDING', NULL),
(35, 14, 'PENDING', NULL),
(36, 14, 'PENDING', NULL),
(37, 14, 'PENDING', NULL),
(38, 14, 'PENDING', NULL),
(39, 14, 'PENDING', NULL),
(40, 14, 'PENDING', NULL),
(41, 14, 'PENDING', NULL),
(42, 14, 'PENDING', NULL),
(43, 14, 'PENDING', NULL),
(44, 14, 'PENDING', NULL),
(45, 14, 'PENDING', NULL),
(46, 14, 'PENDING', NULL),
(47, 14, 'PENDING', NULL),
(48, 14, 'PENDING', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cid` int(11) UNSIGNED NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(150) NOT NULL,
  `phone` varchar(25) NOT NULL,
  `isadmin` int(1) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cid`, `fullname`, `email`, `password`, `phone`, `isadmin`) VALUES
(11, 'admin@gmail.com', 'admin@gmail.com', '$2y$10$nfud5jYwEnMmqv8YgUF3p.wh3EVGAONlRUUiu2TqFiNW.GsU6QKGm', '', 1),
(12, 'admin@admin.com', 'admin@admin.com', '$2y$10$4FJtbVGCIpFnNxcDvSSXUueMESuDDoZvtygT/O4J9UHB1vfdO3Vza', '', 1),
(14, 'Mark Lowel Montealto', 'lowel@lowel.com', '$2y$10$O9OBz/GVvuO8kFN2woQXHuNStltk6QsL885jGzsve31LXQgFh9ara', '09659815484', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `id` int(11) UNSIGNED NOT NULL,
  `start` varchar(30) NOT NULL,
  `end` varchar(30) NOT NULL,
  `package` varchar(100) NOT NULL,
  `requirement` varchar(100) DEFAULT 'no preference',
  `host` int(2) NOT NULL,
  `popper` varchar(25) DEFAULT '0',
  `message` varchar(500) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `hash` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`id`, `start`, `end`, `package`, `requirement`, `host`, `popper`, `message`, `timestamp`, `hash`) VALUES
(12, '2018-05-09', '2018-05-11', 'double', 'non smoking', 2, '0', '', '2018-04-19 22:04:42', '5ad9127abbdf6'),
(13, '2018-04-24', '2018-04-25', 'deluxe', 'no preference', 1, '0', '', '2018-04-23 15:45:33', '5addff9dafa97'),
(14, '2018-04-27', '2018-04-30', 'deluxe', 'no preference', 1, '0', '', '2018-04-24 05:27:13', '5adec03166177'),
(15, '2022-12-07', '2022-12-08', 'Jessica', 'non smoking', 1, '1', 'asdasdas', '2022-12-05 19:01:48', '638e401c850c7'),
(16, '2022-12-08', '2022-12-17', 'Rona', 'with photo', 1, '0', '', '2022-12-05 19:03:06', '638e406adcc21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `booking_id_uindex` (`id`),
  ADD KEY `booking_customer__fk` (`cid`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `id_UNIQUE` (`cid`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_customer__fk` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`) ON DELETE CASCADE;

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_booking__fk` FOREIGN KEY (`id`) REFERENCES `booking` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
