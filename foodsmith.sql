-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2019 at 03:28 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foodsmith`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryID` int(11) NOT NULL,
  `categoryName` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryID`, `categoryName`) VALUES
(1, 'Food'),
(2, 'Drinks');

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE `coupon` (
  `couponCode` varchar(10) NOT NULL,
  `couponName` text NOT NULL,
  `couponAmount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `coupon`
--

INSERT INTO `coupon` (`couponCode`, `couponName`, `couponAmount`) VALUES
('11111', 'FoodSmith Cafe First Anniversary Coupon Ticket', 11.11),
('FFF2F', 'Game Collaboration - Final Fantasy VII Coupon Ticket', 77.7),
('GAEBOIS', 'free offer for gae bois', 9999),
('MTM02', 'Montly Coupon Ticket - Febuary', 22.22);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `itemID` int(11) NOT NULL,
  `categoryID` int(11) NOT NULL,
  `itemName` text NOT NULL,
  `itemPrice` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`itemID`, `categoryID`, `itemName`, `itemPrice`) VALUES
(1, 1, 'Burger', 8.5),
(2, 1, 'Sandwich', 6),
(3, 2, 'Boba Milk Tea', 6),
(4, 2, 'Latte', 3);

-- --------------------------------------------------------

--
-- Table structure for table `orderlist`
--

CREATE TABLE `orderlist` (
  `orderID` int(11) NOT NULL,
  `orderDate` date NOT NULL,
  `itemList` text NOT NULL,
  `itemQuantity` text NOT NULL,
  `itemRemarks` text NOT NULL,
  `totalPrice` float NOT NULL,
  `orderStatus` enum('Completed','Cancelled','Pending') NOT NULL,
  `couponCode` varchar(10) DEFAULT NULL,
  `tableID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orderlist`
--

INSERT INTO `orderlist` (`orderID`, `orderDate`, `itemList`, `itemQuantity`, `itemRemarks`, `totalPrice`, `orderStatus`, `couponCode`, `tableID`) VALUES
(1, '2019-10-21', 'Burger\nLatte\n', '1000\n1000000\n', 'Extra cheese\ncold\n', -9987.5, 'Completed', 'GAEBOIS', 4),
(2, '2019-10-21', 'Burger\nLatte\n', '11\n15\n', 'None\nNone\n', 0, 'Pending', NULL, 4);

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `reportID` int(11) NOT NULL,
  `reportDate` date NOT NULL,
  `orderAmount` int(11) NOT NULL,
  `profit` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`reportID`, `reportDate`, `orderAmount`, `profit`) VALUES
(1, '2019-10-01', 55, 120.5),
(2, '2019-10-02', 50, 105),
(3, '2019-10-03', 40, 95.5);

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `tableID` int(11) NOT NULL,
  `tableSeats` int(11) NOT NULL,
  `tableStatus` enum('Occupied','Vacant','Unavailable','Booked') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tables`
--

INSERT INTO `tables` (`tableID`, `tableSeats`, `tableStatus`) VALUES
(1, 5, 'Vacant'),
(2, 5, 'Vacant'),
(3, 5, 'Vacant'),
(4, 10, 'Vacant'),
(5, 10, 'Vacant');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` int(11) NOT NULL,
  `userType` text NOT NULL,
  `userName` text NOT NULL,
  `Password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `userType`, `userName`, `Password`) VALUES
(1, 'admin', 'admin', '$2y$10$N/rxKv/YjZyWO5.dZ0WgOu8tYthCYxTkDH.RfVkz1DmGCSkHPzS8W'),
(2, 'admin', 'bryan', '$2y$10$vwsH3/dfBC0R1n2eutcoBuNMCQ3knw5J3a2x.kSZwe.uJS9v6tM8C'),
(3, 'staff', 'user', '$2y$10$s088mOVQDN0wpdyjMR7dr.ja53JBt/G25el4.3ZenQxMdx19cOBee'),
(4, 'admin', 'lolipoplls', '$2y$10$tquRgebndH8xY66lZGSOd.TriaJ5TgsMzQyFyOSwMmQ.nHy4ib5pG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryID`),
  ADD UNIQUE KEY `categoryName` (`categoryName`) USING HASH;

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`couponCode`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`itemID`),
  ADD UNIQUE KEY `itemName` (`itemName`) USING HASH,
  ADD KEY `categoryID` (`categoryID`);

--
-- Indexes for table `orderlist`
--
ALTER TABLE `orderlist`
  ADD PRIMARY KEY (`orderID`),
  ADD KEY `tableID` (`tableID`),
  ADD KEY `orderlist_ibfk_1` (`couponCode`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`reportID`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`tableID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `userName` (`userName`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `itemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orderlist`
--
ALTER TABLE `orderlist`
  MODIFY `orderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `tableID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`);

--
-- Constraints for table `orderlist`
--
ALTER TABLE `orderlist`
  ADD CONSTRAINT `orderlist_ibfk_1` FOREIGN KEY (`couponCode`) REFERENCES `coupon` (`couponCode`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
