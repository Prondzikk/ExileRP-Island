-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 146.59.96.131:3306
-- Czas generowania: 29 Kwi 2022, 18:42
-- Wersja serwera: 10.7.3-MariaDB-1:10.7.3+maria~bullseye
-- Wersja PHP: 8.0.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `s1110_database`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('property_black_money', 'Mieszkanie', 0),
('society_ambulance', 'SAMS', 1),
('society_baker', 'Piekarz', 1),
('society_cardealer', 'Sprzedawca aut', 1),
('society_dtu', 'DTU', 1),
('society_farming', 'Farmer', 1),
('society_fisherman', 'Fisherman', 1),
('society_gopostal', 'Go Postal', 1),
('society_grower', 'Sadownik', 1),
('society_hwp', 'HWP', 1),
('society_kawiarnia', 'Kawiarnia', 1),
('society_kawiarnia_black', 'Kawiarnia', 1),
('society_krawiec', 'Fly Beliodas', 1),
('society_mechanik', 'Mechanik', 1),
('society_milkman', 'Milk Man', 1),
('society_miner', 'Górnik', 1),
('society_org1', 'org1', 1),
('society_org10', 'org10', 1),
('society_org10_black', 'org10', 1),
('society_org11', 'org11', 1),
('society_org11_black', 'org11', 1),
('society_org12', 'org12', 1),
('society_org12_black', 'org12', 1),
('society_org13', 'org13', 1),
('society_org13_black', 'org13', 1),
('society_org14', 'org14', 1),
('society_org14_black', 'org14', 1),
('society_org15', 'org15', 1),
('society_org15_black', 'org15', 1),
('society_org16', 'org16', 1),
('society_org16_black', 'org16', 1),
('society_org17', 'org17', 1),
('society_org17_black', 'org17', 1),
('society_org18', 'org18', 1),
('society_org18_black', 'org18', 1),
('society_org19', 'org19', 1),
('society_org19_black', 'org19', 1),
('society_org1_black', 'org1', 1),
('society_org2', 'org2', 1),
('society_org20', 'org20', 1),
('society_org20_black', 'org20', 1),
('society_org21', 'org21', 1),
('society_org21_black', 'org21', 1),
('society_org22', 'org22', 1),
('society_org22_black', 'org22', 1),
('society_org23', 'org23', 1),
('society_org23_black', 'org23', 1),
('society_org24', 'org24', 1),
('society_org24_black', 'org24', 1),
('society_org25', 'org25', 1),
('society_org25_black', 'org25', 1),
('society_org26', 'org26', 1),
('society_org26_black', 'org26', 1),
('society_org27', 'org27', 1),
('society_org27_black', 'org27', 1),
('society_org28', 'org28', 1),
('society_org28_black', 'org28', 1),
('society_org29', 'org29', 1),
('society_org29_black', 'org29', 1),
('society_org2_black', 'org2', 1),
('society_org3', 'org3', 1),
('society_org30', 'org30', 1),
('society_org30_black', 'org30', 1),
('society_org31', 'org31', 1),
('society_org31_black', 'org31', 1),
('society_org32', 'org32', 1),
('society_org32_black', 'org32', 1),
('society_org33', 'org33', 1),
('society_org33_black', 'org33', 1),
('society_org34', 'org34', 1),
('society_org34_black', 'org34', 1),
('society_org35', 'org35', 1),
('society_org35_black', 'org35', 1),
('society_org36', 'org36', 1),
('society_org36_black', 'org36', 1),
('society_org37', 'org37', 1),
('society_org37_black', 'org37', 1),
('society_org38', 'org38', 1),
('society_org38_black', 'org38', 1),
('society_org39', 'org39', 1),
('society_org39_black', 'org39', 1),
('society_org3_black', 'org3', 1),
('society_org4', 'org4', 1),
('society_org40', 'org40', 1),
('society_org40_black', 'org40', 1),
('society_org4_black', 'org4', 1),
('society_org5', 'org5', 1),
('society_org5_black', 'org5', 1),
('society_org6', 'org6', 1),
('society_org6_black', 'org6', 1),
('society_org7', 'org7', 1),
('society_org7_black', 'org7', 1),
('society_org8', 'org8', 1),
('society_org8_black', 'org8', 1),
('society_org9', 'org9', 1),
('society_org9_black', 'org9', 1),
('society_police', 'SASP', 1),
('society_sheriff', 'Sheriff', 1),
('society_slaughter', 'Rzeźnik', 1),
('society_strefy1', 'strefy1', 1),
('society_strefy2', 'strefy2', 1),
('society_strefy3', 'strefy3', 1),
('society_strefy4', 'strefy4', 1),
('society_strefy5', 'strefy5', 1),
('society_strefy6', 'strefy6', 1),
('society_strefy7', 'strefy7', 1),
('society_taxi', 'Taxi', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `account_money` int(11) DEFAULT 0,
  `owner` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `account_money`, `owner`) VALUES
(1, 'property_black_moneyMotel-LepszaMelina1', 0, 0, NULL),
(2, 'property_black_moneyMotel-LepszaMelina2', 0, 0, NULL),
(3, 'property_black_moneyMotel-LepszaMelina3', 0, 0, NULL),
(4, 'property_black_moneyMotel-LepszaMelina4', 0, 0, NULL),
(5, 'property_black_moneyMotel-LepszaMelina5', 0, 0, NULL),
(6, 'property_black_moneyMotel-LepszaMelina6', 0, 0, NULL),
(7, 'property_black_moneyMotel-LepszaMelina7', 0, 0, NULL),
(8, 'property_black_moneyMotel-LepszaMelina8', 0, 0, NULL),
(9, 'property_black_moneyMotel-LepszaMelina9', 0, 0, NULL),
(10, 'property_black_moneyMotel-LepszaMelina10', 0, 0, NULL),
(11, 'property_black_moneyMotel-LepszaMelina11', 0, 0, NULL),
(12, 'property_black_moneyMotel-LepszaMelina12', 0, 0, NULL),
(13, 'property_black_moneyMotel-LepszaMelina13', 0, 0, NULL),
(14, 'property_black_moneyMotel-LepszaMelina14', 0, 0, NULL),
(15, 'property_black_moneyMotel-LepszaMelina15', 0, 0, NULL),
(16, 'property_black_moneyMotel-LepszaMelina16', 0, 0, NULL),
(17, 'property_black_moneyMotel-LepszaMelina17', 0, 0, NULL),
(18, 'property_black_moneyMotel-LepszaMelina18', 0, 0, NULL),
(19, 'property_black_moneyMotel-LepszaMelina19', 0, 0, NULL),
(20, 'property_black_moneyMotel-LepszaMelina20', 0, 0, NULL),
(21, 'property_black_moneyMotel-LepszaMelina21', 0, 0, NULL),
(22, 'property_black_moneyMotel-LepszaMelina22', 0, 0, NULL),
(23, 'property_black_moneyMotel-LepszaMelina23', 0, 0, NULL),
(24, 'property_black_moneyMotel-LepszaMelina24', 0, 0, NULL),
(25, 'property_black_moneyMotel-LepszaMelina25', 0, 0, NULL),
(26, 'property_black_moneyMotel-LepszaMelina26', 0, 0, NULL),
(27, 'property_black_moneyMotel-LepszaMelina27', 0, 0, NULL),
(28, 'property_black_moneyMotel-LepszaMelina28', 0, 0, NULL),
(29, 'property_black_moneyMotel-LepszaMelina29', 0, 0, NULL),
(30, 'property_black_moneyMotel-LepszaMelina31', 0, 0, NULL),
(31, 'property_black_moneyMotel-LepszaMelina32', 0, 0, NULL),
(32, 'property_black_moneyMotel-LepszaMelina33', 0, 0, NULL),
(33, 'property_black_moneyMotel-LepszaMelina34', 0, 0, NULL),
(34, 'property_black_moneyMotel-LepszaMelina35', 0, 0, NULL),
(35, 'property_black_moneyMotel-LepszaMelina36', 0, 0, NULL),
(36, 'property_black_moneyMotel-LepszaMelina37', 0, 0, NULL),
(37, 'property_black_moneyMotel-LepszaMelina38', 0, 0, NULL),
(38, 'property_black_moneyMotel-LepszaMelina39', 0, 0, NULL),
(39, 'property_black_moneyMotel-LepszaMelina40', 0, 0, NULL),
(40, 'property_black_moneyMotel-LepszaMelina41', 0, 0, NULL),
(41, 'property_black_moneyMotel-LepszaMelina42', 0, 0, NULL),
(42, 'property_black_moneyMotel-LepszaMelina43', 0, 0, NULL),
(43, 'property_black_moneyMotel-LepszaMelina44', 0, 0, NULL),
(44, 'property_black_moneyMotel-LepszaMelina45', 0, 0, NULL),
(45, 'property_black_moneyMotel-LepszaMelina46', 0, 0, NULL),
(46, 'property_black_moneyMotel-LepszaMelina47', 0, 0, NULL),
(47, 'property_black_moneyMotel-LepszaMelina48', 0, 0, NULL),
(48, 'property_black_moneyMotel-LepszaMelina49', 0, 0, NULL),
(49, 'property_black_moneyMotel-LepszaMelina50', 0, 0, NULL),
(50, 'property_black_moneyMotel-LepszaMelina51', 0, 0, NULL),
(51, 'property_black_moneyMotel-LepszaMelina52', 0, 0, NULL),
(52, 'property_black_moneyMotel-LepszaMelina53', 0, 0, NULL),
(53, 'property_black_moneyMotel-LepszaMelina54', 0, 0, NULL),
(54, 'property_black_moneyMotel-LepszaMelina55', 0, 0, NULL),
(55, 'property_black_moneyMotel-LepszaMelina56', 0, 0, NULL),
(56, 'property_black_moneyMotel-LepszaMelina57', 0, 0, NULL),
(57, 'property_black_moneyMotel-LepszaMelina58', 0, 0, NULL),
(58, 'property_black_moneyMotel-LepszaMelina59', 0, 0, NULL),
(59, 'property_black_moneyMotel-LepszaMelina60', 0, 0, NULL),
(60, 'property_black_moneyMotel-LepszaMelina61', 0, 0, NULL),
(61, 'property_black_moneyMotel-LepszaMelina62', 0, 0, NULL),
(62, 'property_black_moneyMotel-LepszaMelina63', 0, 0, NULL),
(63, 'property_black_moneyMotel-LepszaMelina64', 0, 0, NULL),
(64, 'property_black_moneyMotel-LepszaMelina65', 0, 0, NULL),
(65, 'property_black_moneyMotel-LepszaMelina66', 0, 0, NULL),
(66, 'property_black_moneyMotel-LepszaMelina67', 0, 0, NULL),
(67, 'property_black_moneyMotel-LepszaMelina68', 0, 0, NULL),
(68, 'property_black_moneyMotel-LepszaMelina69', 0, 0, NULL),
(69, 'property_black_moneyMotel-LepszaMelina70', 0, 0, NULL),
(70, 'property_black_moneyMotel-LepszaMelina71', 0, 0, NULL),
(71, 'property_black_moneyMotel-LepszaMelina72', 0, 0, NULL),
(72, 'property_black_moneyMotel-LepszaMelina73', 0, 0, NULL),
(73, 'property_black_moneyMotel-LepszaMelina74', 0, 0, NULL),
(74, 'property_black_moneyMotel-LepszaMelina75', 0, 0, NULL),
(75, 'property_black_moneyMotel-LepszaMelina76', 0, 0, NULL),
(76, 'property_black_moneyMotel-LepszaMelina77', 0, 0, NULL),
(77, 'property_black_moneyMotel-LepszaMelina79', 0, 0, NULL),
(78, 'property_black_moneyMotel-LepszaMelina80', 0, 0, NULL),
(79, 'property_black_moneyMotel-LepszaMelina81', 0, 0, NULL),
(80, 'property_black_moneyMotel-LepszaMelina82', 0, 0, NULL),
(81, 'property_black_moneyMotel-LepszaMelina83', 0, 0, NULL),
(82, 'property_black_moneyMotel-LepszaMelina84', 0, 0, NULL),
(83, 'property_black_moneyMotel-LepszaMelina85', 0, 0, NULL),
(84, 'property_black_moneyMotel-LepszaMelina86', 0, 0, NULL),
(85, 'property_black_moneyMotel-LepszaMelina87', 0, 0, NULL),
(86, 'property_black_moneyMotel-LepszaMelina88', 0, 0, NULL),
(87, 'property_black_moneyMotel-LepszaMelina89', 0, 0, NULL),
(88, 'property_black_moneyMotel-LepszaMelina90', 0, 0, NULL),
(89, 'property_black_moneyMotel-LepszaMelina91', 0, 0, NULL),
(90, 'property_black_moneyMotel-LepszaMelina92', 0, 0, NULL),
(91, 'property_black_moneyMotel-LepszaMelina93', 0, 0, NULL),
(92, 'property_black_moneyMotel-LepszaMelina94', 0, 0, NULL),
(93, 'property_black_moneyMotel-LepszaMelina95', 0, 0, NULL),
(94, 'property_black_moneyMotel-LepszaMelina96', 0, 0, NULL),
(95, 'property_black_moneyMotel-LepszaMelina97', 0, 0, NULL),
(96, 'property_black_moneyMotel-LepszaMelina98', 0, 0, NULL),
(97, 'property_black_moneyMotel-LepszaMelina99', 0, 0, NULL),
(98, 'property_black_moneyMotel-LepszaMelina100', 0, 0, NULL),
(99, 'property_black_moneyMotel-LepszaMelina101', 0, 0, NULL),
(100, 'property_black_moneyMotel-LepszaMelina102', 0, 0, NULL),
(101, 'property_black_moneyMotel-LepszaMelina103', 0, 0, NULL),
(102, 'property_black_moneyMotel-LepszaMelina104', 0, 0, NULL),
(103, 'property_black_moneyMotel-LepszaMelina105', 0, 0, NULL),
(104, 'property_black_moneyMotel-LepszaMelina106', 0, 0, NULL),
(105, 'property_black_moneyMotel-LepszaMelina107', 0, 0, NULL),
(106, 'property_black_moneyMotel-LepszaMelina108', 0, 0, NULL),
(107, 'property_black_moneyMotel-LepszaMelina109', 0, 0, NULL),
(108, 'property_black_moneyMotel-LepszaMelina110', 0, 0, NULL),
(109, 'property_black_moneyMotel-LepszaMelina111', 0, 0, NULL),
(110, 'property_black_moneyMotel-LepszaMelina112', 0, 0, NULL),
(111, 'property_black_moneyMotel-LepszaMelina113', 0, 0, NULL),
(112, 'property_black_moneyMotel-LepszaMelina114', 0, 0, NULL),
(113, 'property_black_moneyMotel-LepszaMelina115', 0, 0, NULL),
(114, 'property_black_moneyMotel-LepszaMelina116', 0, 0, NULL),
(115, 'property_black_moneyMotel-LepszaMelina117', 0, 0, NULL),
(116, 'property_black_moneyMotel-LepszaMelina118', 0, 0, NULL),
(117, 'property_black_moneyMotel-LepszaMelina119', 0, 0, NULL),
(118, 'property_black_moneyMotel-LepszaMelina120', 0, 0, NULL),
(119, 'property_black_moneyMotel-LepszaMelina121', 0, 0, NULL),
(120, 'property_black_moneyMotel-LepszaMelina122', 0, 0, NULL),
(121, 'property_black_moneyMotel-LepszaMelina123', 0, 0, NULL),
(122, 'property_black_moneyMotel-LepszaMelina124', 0, 0, NULL),
(123, 'property_black_moneyMotel-LepszaMelina125', 0, 0, NULL),
(124, 'property_black_moneyMotel-LepszaMelina126', 0, 0, NULL),
(125, 'property_black_moneyMotel-LepszaMelina127 ', 0, 0, NULL),
(126, 'property_black_moneyMotel-LepszaMelina128', 0, 0, NULL),
(127, 'property_black_moneyMotel-LepszaMelina129', 0, 0, NULL),
(128, 'property_black_moneyMotel-LepszaMelina130', 0, 0, NULL),
(129, 'property_black_moneyMotel-LepszaMelina131', 0, 0, NULL),
(130, 'property_black_moneyMotel-LepszaMelina132', 0, 0, NULL),
(131, 'property_black_moneyMotel-LepszaMelina133', 0, 0, NULL),
(132, 'property_black_moneyMotel-LepszaMelina134', 0, 0, NULL),
(133, 'property_black_moneyMotel-LepszaMelina135', 0, 0, NULL),
(134, 'property_black_moneyMotel-LepszaMelina136', 0, 0, NULL),
(135, 'property_black_moneyMotel-LepszaMelina137', 0, 0, NULL),
(136, 'property_black_moneyMotel-LepszaMelina138', 0, 0, NULL),
(137, 'property_black_moneyMotel-LepszaMelina141', 0, 0, NULL),
(138, 'property_black_moneyMotel-LepszaMelina142', 0, 0, NULL),
(139, 'property_black_moneyMotel-LepszaMelina143', 0, 0, NULL),
(140, 'property_black_moneyMotel-LepszaMelina144', 0, 0, NULL),
(141, 'property_black_moneyMotel-LepszaMelina145', 0, 0, NULL),
(142, 'property_black_moneyMotel-LepszaMelina146', 0, 0, NULL),
(143, 'property_black_moneyMotel-LepszaMelina147', 0, 0, NULL),
(144, 'property_black_moneyCarson AveLowApartament79', 0, 0, NULL),
(145, 'property_black_moneyJamestown StLowApartament80', 0, 0, NULL),
(146, 'property_black_moneyJamestown StLowApartament81', 0, 0, NULL),
(147, 'property_black_moneyJamestown StLowApartament82', 0, 0, NULL),
(148, 'property_black_moneyJamestown StLowApartament83', 0, 0, NULL),
(149, 'property_black_moneyJamestown StLowApartament84', 0, 0, NULL),
(150, 'property_black_moneyJamestown StLowApartament85', 0, 0, NULL),
(151, 'property_black_moneyJamestown StLowApartament86', 0, 0, NULL),
(152, 'property_black_moneyJamestown StLowApartament87', 0, 0, NULL),
(153, 'property_black_moneyJamestown StLowApartament88', 0, 0, NULL),
(154, 'property_black_moneyCarson AveLowApartament89', 0, 0, NULL),
(155, 'property_black_moneyCarson AveLowApartament90', 0, 0, NULL),
(156, 'property_black_moneyDutch London StLowApartament91', 0, 0, NULL),
(157, 'property_black_moneyDutch London StLowApartament92', 0, 0, NULL),
(158, 'property_black_moneyDutch London StLowApartament93', 0, 0, NULL),
(159, 'property_black_moneyJamestown StLowApartament94', 0, 0, NULL),
(160, 'property_black_moneyJamestown StLowApartament95', 0, 0, NULL),
(161, 'property_black_moneyJamestown StLowApartament96', 0, 0, NULL),
(162, 'property_black_moneyJamestown StLowApartament98', 0, 0, NULL),
(163, 'property_black_moneyJamestown StLowApartament99', 0, 0, NULL),
(164, 'property_black_moneyJamestown StLowApartament100', 0, 0, NULL),
(165, 'property_black_moneyJamestown StLowApartament101', 0, 0, NULL),
(166, 'property_black_moneyDutch London StLowApartament102', 0, 0, NULL),
(167, 'property_black_moneyDutch London StLowApartament103', 0, 0, NULL),
(168, 'property_black_moneyDutch London StLowApartament104', 0, 0, NULL),
(169, 'property_black_moneyDutch London StLowApartament105', 0, 0, NULL),
(170, 'property_black_moneyDutch London StLowApartament106', 0, 0, NULL),
(171, 'property_black_moneyDutch London StLowApartament107', 0, 0, NULL),
(172, 'property_black_moneyDutch London StLowApartament108', 0, 0, NULL),
(173, 'property_black_moneyGrove StLowApartament109', 0, 0, NULL),
(174, 'property_black_moneyGrove StLowApartament110', 0, 0, NULL),
(175, 'property_black_moneyGrove StLowApartament111', 0, 0, NULL),
(176, 'property_black_moneyGrove StLowApartament112', 0, 0, NULL),
(177, 'property_black_moneyGrove StLowApartament113', 0, 0, NULL),
(178, 'property_black_moneyGrove StLowApartament114', 0, 0, NULL),
(179, 'property_black_moneyGrove StLowApartament115', 0, 0, NULL),
(180, 'property_black_moneyGrove StLowApartament116', 0, 0, NULL),
(181, 'property_black_moneyGrove StLowApartament117', 0, 0, NULL),
(182, 'property_black_moneyGrove StLowApartament118', 0, 0, NULL),
(183, 'property_black_moneyGrove StLowApartament119', 0, 0, NULL),
(184, 'property_black_moneyGrove StLowApartament120', 0, 0, NULL),
(185, 'property_black_moneyGrove StLowApartament121', 0, 0, NULL),
(186, 'property_black_moneyForum DrLowApartament122', 0, 0, NULL),
(187, 'property_black_moneyForum DrLowApartament123', 0, 0, NULL),
(188, 'property_black_moneyForum DrLowApartament124', 0, 0, NULL),
(189, 'property_black_moneyForum DrLowApartament125', 0, 0, NULL),
(190, 'property_black_moneyForum DrLowApartament126', 0, 0, NULL),
(191, 'property_black_moneyCarson AveLowApartament127', 0, 0, NULL),
(192, 'property_black_moneyCarson AveLowApartament128', 0, 0, NULL),
(193, 'property_black_moneyCarson AveLowApartament129', 0, 0, NULL),
(194, 'property_black_moneyCarson AveLowApartament130', 0, 0, NULL),
(195, 'property_black_moneyCarson AveLowApartament131', 0, 0, NULL),
(196, 'property_black_moneyForum DrLowApartament132', 0, 0, NULL),
(197, 'property_black_moneyForum DrLowApartament133', 0, 0, NULL),
(198, 'property_black_moneyForum DrLowApartament134', 0, 0, NULL),
(199, 'property_black_moneyCarson AveLowApartament135', 0, 0, NULL),
(200, 'property_black_moneyCarson AveLowApartament136', 0, 0, NULL),
(201, 'property_black_moneyCarson AveLowApartament137', 0, 0, NULL),
(202, 'property_black_moneyCarson AveLowApartament138', 0, 0, NULL),
(203, 'property_black_moneyCarson AveLowApartament139', 0, 0, NULL),
(204, 'property_black_moneyForum DrLowApartament140', 0, 0, NULL),
(205, 'property_black_moneyForum DrLowApartament141', 0, 0, NULL),
(206, 'property_black_moneyForum DrLowApartament142', 0, 0, NULL),
(207, 'property_black_moneyForum DrMotel143', 0, 0, NULL),
(208, 'property_black_moneyForum DrMotel144', 0, 0, NULL),
(209, 'property_black_moneyForum DrMotel145', 0, 0, NULL),
(210, 'property_black_moneyForum DrMotel146', 0, 0, NULL),
(211, 'property_black_moneyForum DrMotel147', 0, 0, NULL),
(212, 'property_black_moneyForum DrMotel148', 0, 0, NULL),
(213, 'property_black_moneyForum DrLowApartament149', 0, 0, NULL),
(214, 'property_black_moneyForum DrLowApartament150', 0, 0, NULL),
(215, 'property_black_moneyFantastic PlApartment151', 0, 0, NULL),
(216, 'property_black_moneyVespucci BlvdApartment152', 0, 0, NULL),
(217, 'property_black_moneyVespucci BlvdApartment153', 0, 0, NULL),
(218, 'property_black_moneyZach. Mirror DriveApartment154', 0, 0, NULL),
(219, 'property_black_moneyZach. Mirror DriveApartment155', 0, 0, NULL),
(220, 'property_black_moneyZach. Mirror DriveApartment156', 0, 0, NULL),
(221, 'property_black_moneyZach. Mirror DriveLuxApartment157', 0, 0, NULL),
(222, 'property_black_moneyZach. Mirror DriveApartment158', 0, 0, NULL),
(223, 'property_black_moneyZach. Mirror DriveApartment159', 0, 0, NULL),
(224, 'property_black_moneyZach. Mirror DriveLuxApartment160', 0, 0, NULL),
(225, 'property_black_moneyZach. Mirror DriveApartment161', 0, 0, NULL),
(226, 'property_black_moneyZach. Mirror DriveApartment162', 0, 0, NULL),
(227, 'property_black_moneyZach. Mirror DriveLuxApartment163', 0, 0, NULL),
(228, 'property_black_moneyZach. Mirror DriveApartment164', 0, 0, NULL),
(229, 'property_black_moneyZach. Mirror DriveApartment165', 0, 0, NULL),
(230, 'property_black_moneyZach. Mirror DriveApartment166', 0, 0, NULL),
(231, 'property_black_moneyZach. Mirror DriveLuxApartment167', 0, 0, NULL),
(232, 'property_black_moneyZach. Mirror DriveApartment168', 0, 0, NULL),
(233, 'property_black_moneyZach. Mirror DriveApartment169', 0, 0, NULL),
(234, 'property_black_moneyZach. Mirror DriveApartment170', 0, 0, NULL),
(235, 'property_black_moneyZach. Mirror DriveLuxApartment171', 0, 0, NULL),
(236, 'property_black_moneyZach. Mirror DriveApartment172', 0, 0, NULL),
(237, 'property_black_moneyZach. Mirror DriveApartment173', 0, 0, NULL),
(238, 'property_black_moneyBridge StLowApartament174', 0, 0, NULL),
(239, 'property_black_moneyZach. Mirror DriveLowApartament175', 0, 0, NULL),
(240, 'property_black_moneyBridge StLuxApartment176', 0, 0, NULL),
(241, 'property_black_moneyBridge StApartment177', 0, 0, NULL),
(242, 'property_black_moneyBridge StApartment178', 0, 0, NULL),
(243, 'property_black_moneyBridge StApartment179', 0, 0, NULL),
(244, 'property_black_moneyBridge StApartment180', 0, 0, NULL),
(245, 'property_black_moneyZach. Mirror DriveApartment181', 0, 0, NULL),
(246, 'property_black_moneyZach. Mirror DriveApartment182', 0, 0, NULL),
(247, 'property_black_moneyZach. Mirror DriveApartment183', 0, 0, NULL),
(248, 'property_black_moneyZach. Mirror DriveLowApartament184', 0, 0, NULL),
(249, 'property_black_moneyZach. Mirror DriveLowApartament185', 0, 0, NULL),
(250, 'property_black_moneyNikola AveApartment186', 0, 0, NULL),
(251, 'property_black_moneyZach. Mirror DriveApartment187', 0, 0, NULL),
(252, 'property_black_moneyMirror Park BlvdLowApartament188', 0, 0, NULL),
(253, 'property_black_moneyMirror Park BlvdApartment189', 0, 0, NULL),
(254, 'property_black_moneyMirror Park BlvdApartment190', 0, 0, NULL),
(255, 'property_black_moneyMirror Park BlvdApartment191', 0, 0, NULL),
(256, 'property_black_moneyMirror Park BlvdApartment192', 0, 0, NULL),
(257, 'property_black_moneyMirror Park BlvdApartment193', 0, 0, NULL),
(258, 'property_black_moneyWsch. Mirror DrApartment194', 0, 0, NULL),
(259, 'property_black_moneyWsch. Mirror DrLowApartament195', 0, 0, NULL),
(260, 'property_black_moneyWsch. Mirror DrApartment196', 0, 0, NULL),
(261, 'property_black_moneyWsch. Mirror DrApartment197', 0, 0, NULL),
(262, 'property_black_moneyWsch. Mirror DrApartment198', 0, 0, NULL),
(263, 'property_black_moneyWsch. Mirror DrApartment199', 0, 0, NULL),
(264, 'property_black_moneyWsch. Mirror DrApartment200', 0, 0, NULL),
(265, 'property_black_moneyNikola PlApartment201', 0, 0, NULL),
(266, 'property_black_moneyNikola PlApartment202', 0, 0, NULL),
(267, 'property_black_moneyNikola PlApartment203', 0, 0, NULL),
(268, 'property_black_moneyNikola PlApartment204', 0, 0, NULL),
(269, 'property_black_moneyNikola PlApartment205', 0, 0, NULL),
(270, 'property_black_moneyNikola PlApartment206', 0, 0, NULL),
(271, 'property_black_moneyNikola PlApartment207', 0, 0, NULL),
(272, 'property_black_moneyNikola PlApartment208', 0, 0, NULL),
(273, 'property_black_moneyNikola PlApartment209', 0, 0, NULL),
(274, 'property_black_moneyNikola PlApartment210', 0, 0, NULL),
(275, 'property_black_moneyGentry LaneApartment223', 0, 0, NULL),
(276, 'property_black_moneyGentry LaneApartment224', 0, 0, NULL),
(277, 'property_black_moneyLas Lagunas BlvdApartment225', 0, 0, NULL),
(278, 'property_black_moneySan Vitus BlvdLuxApartment230', 0, 0, NULL),
(279, 'property_black_moneySpanish AveLuxApartment231', 0, 0, NULL),
(280, 'property_black_moneySpanish AveLuxApartment232', 0, 0, NULL),
(281, 'property_black_moneySpanish AveLuxApartment233', 0, 0, NULL),
(282, 'property_black_moneyLas Lagunas BlvdApartment234', 0, 0, NULL),
(283, 'property_black_moneyLas Lagunas BlvdLowApartament235', 0, 0, NULL),
(284, 'property_black_moneyLas Lagunas BlvdApartment236', 0, 0, NULL),
(285, 'property_black_moneyLas Lagunas BlvdApartment237', 0, 0, NULL),
(286, 'property_black_moneyLas Lagunas BlvdLowApartament238', 0, 0, NULL),
(287, 'property_black_moneyLas Lagunas BlvdApartment239', 0, 0, NULL),
(288, 'property_black_moneyLas Lagunas BlvdLowApartament240', 0, 0, NULL),
(289, 'property_black_moneyLas Lagunas BlvdLowApartament241', 0, 0, NULL),
(290, 'property_black_moneyMeteor StMotel242', 0, 0, NULL),
(291, 'property_black_moneyMeteor StMotel243', 0, 0, NULL),
(292, 'property_black_moneyMeteor StMotel244', 0, 0, NULL),
(293, 'property_black_moneyMeteor StMotel245', 0, 0, NULL),
(294, 'property_black_moneyMeteor StMotel246', 0, 0, NULL),
(295, 'property_black_moneyMeteor StMotel247', 0, 0, NULL),
(296, 'property_black_moneyMeteor StMotel248', 0, 0, NULL),
(297, 'property_black_moneyMeteor StLowApartament249', 0, 0, NULL),
(298, 'property_black_moneyHawick AveLowApartament250', 0, 0, NULL),
(299, 'property_black_moneyHawick AveMotel251', 0, 0, NULL),
(300, 'property_black_moneyMeteor StMotel252', 0, 0, NULL),
(301, 'property_black_moneyMeteor StLowApartament253', 0, 0, NULL),
(302, 'property_black_moneyMeteor StLowApartament254', 0, 0, NULL),
(303, 'property_black_moneyMeteor StMotel255', 0, 0, NULL),
(304, 'property_black_moneyMeteor StMotel256', 0, 0, NULL),
(305, 'property_black_moneyMeteor StMotel257', 0, 0, NULL),
(306, 'property_black_moneyMeteor StMotel258', 0, 0, NULL),
(307, 'property_black_moneyMeteor StMotel259', 0, 0, NULL),
(308, 'property_black_moneyMeteor StLuxApartment260', 0, 0, NULL),
(309, 'property_black_moneyMeteor StMotel261', 0, 0, NULL),
(310, 'property_black_moneyMeteor StMotel262', 0, 0, NULL),
(311, 'property_black_moneyHawick AveMotel263', 0, 0, NULL),
(312, 'property_black_moneyHawick AveMotel264', 0, 0, NULL),
(313, 'property_black_moneyHawick AveMotel265', 0, 0, NULL),
(314, 'property_black_moneyHawick AveMotel266', 0, 0, NULL),
(315, 'property_black_moneyHawick AveLowApartament267', 0, 0, NULL),
(316, 'property_black_moneyHawick AveMotel268', 0, 0, NULL),
(317, 'property_black_moneyHawick AveMotel269', 0, 0, NULL),
(318, 'society_ambulance', 0, 0, NULL),
(319, 'society_baker', 0, 0, NULL),
(320, 'society_cardealer', 0, 0, NULL),
(321, 'society_farming', 0, 0, NULL),
(322, 'society_fisherman', 0, 0, NULL),
(323, 'society_grower', 0, 0, NULL),
(325, 'society_krawiec', 0, 0, NULL),
(326, 'society_mechanik', 0, 0, NULL),
(327, 'society_milkman', 0, 0, NULL),
(328, 'society_miner', 0, 0, NULL),
(329, 'society_police', 0, 0, NULL),
(330, 'society_slaughter', 0, 0, NULL),
(331, 'society_taxi', 0, 0, NULL),
(332, 'society_org1', 10000000, 0, NULL),
(333, 'society_org10', 0, 0, NULL),
(334, 'society_org11', 0, 0, NULL),
(335, 'society_org12', 0, 0, NULL),
(336, 'society_org13', 0, 0, NULL),
(337, 'society_org14', 0, 0, NULL),
(338, 'society_org16', 0, 0, NULL),
(339, 'society_org17', 0, 0, NULL),
(340, 'society_org18', 0, 0, NULL),
(341, 'society_org19', 0, 0, NULL),
(342, 'society_org2', 0, 0, NULL),
(343, 'society_org20', 0, 0, NULL),
(344, 'society_org21', 0, 0, NULL),
(345, 'society_org23', 0, 0, NULL),
(346, 'society_org24', 0, 0, NULL),
(347, 'society_org25', 0, 0, NULL),
(348, 'society_org26', 0, 0, NULL),
(349, 'society_org27', 0, 0, NULL),
(350, 'society_org28', 0, 0, NULL),
(351, 'society_org29', 0, 0, NULL),
(352, 'society_org3', 0, 0, NULL),
(353, 'society_org30', 0, 0, NULL),
(354, 'society_org31', 0, 0, NULL),
(355, 'society_org32', 0, 0, NULL),
(356, 'society_org33', 0, 0, NULL),
(357, 'society_org34', 0, 0, NULL),
(358, 'society_org35', 0, 0, NULL),
(359, 'society_org36', 0, 0, NULL),
(360, 'society_org37', 0, 0, NULL),
(361, 'society_org38', 0, 0, NULL),
(362, 'society_org39', 0, 0, NULL),
(363, 'society_org4', 0, 0, NULL),
(364, 'society_org40', 0, 0, NULL),
(365, 'society_org5', 0, 0, NULL),
(366, 'society_org6', 0, 0, NULL),
(367, 'society_org7', 0, 0, NULL),
(368, 'society_org8', 0, 0, NULL),
(369, 'society_org9', 0, 0, NULL),
(412, 'property_black_moneyFcie', 0, 0, NULL),
(413, 'property_black_moneyVip', 0, 0, NULL),
(414, 'society_strefy1', 0, 0, NULL),
(415, 'society_strefy2', 0, 0, NULL),
(416, 'society_strefy3', 0, 0, NULL),
(417, 'society_strefy4', 0, 0, NULL),
(418, 'society_strefy5', 0, 0, NULL),
(419, 'society_strefy6', 0, 0, NULL),
(420, 'society_strefy7', 0, 0, NULL),
(421, 'society_org2_black', 0, 0, NULL),
(422, 'society_org10_black', 0, 0, NULL),
(423, 'society_org11_black', 0, 0, NULL),
(424, 'society_org12_black', 0, 0, NULL),
(425, 'society_org13_black', 0, 0, NULL),
(426, 'society_org14_black', 0, 0, NULL),
(427, 'society_org16_black', 0, 0, NULL),
(428, 'society_org17_black', 0, 0, NULL),
(429, 'society_org18_black', 0, 0, NULL),
(430, 'society_org19_black', 0, 0, NULL),
(431, 'society_org1_black', 0, 0, NULL),
(432, 'society_org20_black', 0, 0, NULL),
(433, 'society_org21_black', 0, 0, NULL),
(434, 'society_org23_black', 0, 0, NULL),
(435, 'society_org24_black', 0, 0, NULL),
(436, 'society_org25_black', 0, 0, NULL),
(437, 'society_org26_black', 0, 0, NULL),
(438, 'society_org27_black', 0, 0, NULL),
(439, 'society_org28_black', 0, 0, NULL),
(440, 'society_org29_black', 0, 0, NULL),
(441, 'society_org30_black', 0, 0, NULL),
(442, 'society_org31_black', 0, 0, NULL),
(443, 'society_org32_black', 0, 0, NULL),
(444, 'society_org33_black', 0, 0, NULL),
(445, 'society_org34_black', 0, 0, NULL),
(446, 'society_org35_black', 0, 0, NULL),
(447, 'society_org36_black', 0, 0, NULL),
(448, 'society_org37_black', 0, 0, NULL),
(449, 'society_org38_black', 0, 0, NULL),
(450, 'society_org39_black', 0, 0, NULL),
(451, 'society_org3_black', 0, 0, NULL),
(452, 'society_org40_black', 0, 0, NULL),
(453, 'society_org41_black', 0, 0, NULL),
(454, 'society_org42_black', 0, 0, NULL),
(455, 'society_org43_black', 0, 0, NULL),
(456, 'society_org44_black', 0, 0, NULL),
(457, 'society_org45_black', 0, 0, NULL),
(458, 'society_org4_black', 0, 0, NULL),
(459, 'society_org5_black', 0, 0, NULL),
(460, 'society_org6_black', 0, 0, NULL),
(461, 'society_org7_black', 0, 0, NULL),
(462, 'society_org8_black', 0, 0, NULL),
(463, 'society_org9_black', 0, 0, NULL),
(464, 'society_org_black', 0, 0, NULL),
(465, 'society_gopostal', 0, 0, NULL),
(466, 'property_black_moneyEl Partizante', 0, 0, NULL),
(467, 'society_org15', 0, 0, NULL),
(468, 'society_org15_black', 0, 0, NULL),
(469, 'society_org22', 0, 0, NULL),
(470, 'society_org22_black', 0, 0, NULL),
(471, 'society_dtu', 0, 0, NULL),
(472, 'society_hwp', 0, 0, NULL),
(473, 'society_sheriff', 0, 0, NULL),
(474, 'society_kawiarnia', 0, 0, NULL),
(6936, 'society_kawiarnia_black', 0, 0, NULL),
(6937, 'property_black_money', 0, NULL, 'steam:110000147973fd2'),
(6938, 'property_black_money', 0, NULL, 'steam:1100001033ab0e1'),
(6939, 'property_black_money', 0, NULL, 'steam:11000014c3cf3e2'),
(6940, 'property_black_money', 0, NULL, 'steam:1100001491a53e6'),
(6941, 'property_black_money', 0, NULL, 'steam:110000106271c89');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('property', 'Mieszkanie', 1),
('society_ambulance', 'SAMS', 1),
('society_baker', 'Piekarz', 1),
('society_cardealer', 'Sprzedawca aut', 1),
('society_dtu', 'DTU', 1),
('society_farming', 'Farmer', 1),
('society_fisherman', 'Fisherman', 1),
('society_gopostal', 'Go Postal', 1),
('society_grower', 'Sadownik', 1),
('society_hwp', 'HWP', 1),
('society_kawiarnia', 'Kawiarnia', 1),
('society_kawiarnia_black', 'Kawiarnia', 1),
('society_krawiec', 'Fly Beliodas', 1),
('society_mechanik', 'Mechanik', 1),
('society_milkman', 'Milk Man', 1),
('society_miner', 'Górnik', 1),
('society_org1', 'org1', 1),
('society_org10', 'org10', 1),
('society_org11', 'org11', 1),
('society_org12', 'org12', 1),
('society_org13', 'org13', 1),
('society_org14', 'org14', 1),
('society_org15', 'org15', 1),
('society_org16', 'org16', 1),
('society_org17', 'org17', 1),
('society_org18', 'org18', 1),
('society_org19', 'org19', 1),
('society_org2', 'org2', 1),
('society_org20', 'org20', 1),
('society_org21', 'org21', 1),
('society_org22', 'org22', 1),
('society_org22_black', 'org22', 1),
('society_org23', 'org23', 1),
('society_org23_black', 'org23', 1),
('society_org24', 'org24', 1),
('society_org24_black', 'org24', 1),
('society_org25', 'org25', 1),
('society_org25_black', 'org25', 1),
('society_org26', 'org26', 1),
('society_org26_black', 'org26', 1),
('society_org27', 'org27', 1),
('society_org27_black', 'org27', 1),
('society_org28', 'org28', 1),
('society_org28_black', 'org28', 1),
('society_org29', 'org29', 1),
('society_org29_black', 'org29', 1),
('society_org3', 'org3', 1),
('society_org30', 'org30', 1),
('society_org30_black', 'org30', 1),
('society_org31', 'org31', 1),
('society_org31_black', 'org31', 1),
('society_org32', 'org32', 1),
('society_org32_black', 'org32', 1),
('society_org33', 'org33', 1),
('society_org33_black', 'org33', 1),
('society_org34', 'org34', 1),
('society_org34_black', 'org34', 1),
('society_org35', 'org35', 1),
('society_org35_black', 'org35', 1),
('society_org36', 'org36', 1),
('society_org36_black', 'org36', 1),
('society_org37', 'org37', 1),
('society_org37_black', 'org37', 1),
('society_org38', 'org38', 1),
('society_org38_black', 'org38', 1),
('society_org39', 'org39', 1),
('society_org39_black', 'org39', 1),
('society_org4', 'org4', 1),
('society_org40', 'org40', 1),
('society_org40_black', 'org40', 1),
('society_org5', 'org5', 1),
('society_org6', 'org6', 1),
('society_org7', 'org7', 1),
('society_org8', 'org8', 1),
('society_org9', 'org9', 1),
('society_police', 'SASP', 1),
('society_sheriff', 'Sheriff', 1),
('society_slaughter', 'Rzeźnik', 1),
('society_strefy1', 'strefy1', 1),
('society_strefy2', 'strefy2', 1),
('society_strefy3', 'strefy3', 1),
('society_strefy4', 'strefy4', 1),
('society_strefy5', 'strefy5', 1),
('society_strefy6', 'strefy6', 1),
('society_strefy7', 'strefy7', 1),
('society_taxi', 'Taxi', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `baninfo`
--

CREATE TABLE `baninfo` (
  `id` int(11) NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Zrzut danych tabeli `baninfo`
--

INSERT INTO `baninfo` (`id`, `license`, `identifier`, `liveid`, `xblid`, `discord`, `playername`) VALUES
(1, 'license:77ab6549b47cd50aa65077c7506ac25d63edb4f7', 'steam:110000106271c89', NULL, NULL, 'discord:969292409567604736', 'F4ko'),
(2, 'license:04af6205e168837588dcbf8375258bdc7831d91f', 'steam:1100001033ab0e1', 'live:844426178677092', NULL, 'discord:645646222576713738', 'Fr0z3n'),
(3, 'license:5cf7e28c0330934c00e31f57c4666edfeea2d87f', 'steam:1100001491a53e6', NULL, NULL, 'discord:659833778583371776', 'Das');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `banlist`
--

CREATE TABLE `banlist` (
  `license` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `expiration` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `permanent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `banlisthistory`
--

CREATE TABLE `banlisthistory` (
  `id` int(11) NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` varchar(40) COLLATE utf8mb4_bin NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `sender` varchar(40) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(40) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `characters`
--

CREATE TABLE `characters` (
  `identifier` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofbirth` varchar(255) NOT NULL,
  `sex` varchar(1) NOT NULL DEFAULT 'f',
  `height` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('property', 'Mieszkanie', 0),
('society_ambulance', 'SAMS', 1),
('society_baker', 'Piekarz', 1),
('society_cardealer', 'Sprzedawca aut', 1),
('society_dtu', 'DTU', 1),
('society_farming', 'Farmer', 1),
('society_fisherman', 'Fisherman', 1),
('society_gopostal', 'Go Postal', 1),
('society_grower', 'Sadownik', 1),
('society_hwp', 'HWP', 1),
('society_kawiarnia', 'Kawiarnia', 1),
('society_kawiarnia_black', 'Kawiarnia', 1),
('society_krawiec', 'Fly Beliodas', 1),
('society_mechanik', 'Mechanik', 1),
('society_milkman', 'Milk Man', 1),
('society_miner', 'Górnik', 1),
('society_org1', 'org1', 1),
('society_org10', 'org10', 1),
('society_org11', 'org11', 1),
('society_org12', 'org12', 1),
('society_org13', 'org13', 1),
('society_org14', 'org14', 1),
('society_org15', 'org15', 1),
('society_org16', 'org16', 1),
('society_org17', 'org17', 1),
('society_org18', 'org18', 1),
('society_org19', 'org19', 1),
('society_org2', 'org2', 1),
('society_org20', 'org20', 1),
('society_org21', 'org21', 1),
('society_org22', 'org22', 1),
('society_org22_black', 'org22', 1),
('society_org23', 'org23', 1),
('society_org23_black', 'org23', 1),
('society_org24', 'org24', 1),
('society_org24_black', 'org24', 1),
('society_org25', 'org25', 1),
('society_org25_black', 'org25', 1),
('society_org26', 'org26', 1),
('society_org26_black', 'org26', 1),
('society_org27', 'org27', 1),
('society_org27_black', 'org27', 1),
('society_org28', 'org28', 1),
('society_org28_black', 'org28', 1),
('society_org29', 'org29', 1),
('society_org29_black', 'org29', 1),
('society_org3', 'org3', 1),
('society_org30', 'org30', 1),
('society_org30_black', 'org30', 1),
('society_org31', 'org31', 1),
('society_org31_black', 'org31', 1),
('society_org32', 'org32', 1),
('society_org32_black', 'org32', 1),
('society_org33', 'org33', 1),
('society_org33_black', 'org33', 1),
('society_org34', 'org34', 1),
('society_org34_black', 'org34', 1),
('society_org35', 'org35', 1),
('society_org35_black', 'org35', 1),
('society_org36', 'org36', 1),
('society_org36_black', 'org36', 1),
('society_org37', 'org37', 1),
('society_org37_black', 'org37', 1),
('society_org38', 'org38', 1),
('society_org38_black', 'org38', 1),
('society_org39', 'org39', 1),
('society_org39_black', 'org39', 1),
('society_org4', 'org4', 1),
('society_org40', 'org40', 1),
('society_org40_black', 'org40', 1),
('society_org5', 'org5', 1),
('society_org6', 'org6', 1),
('society_org7', 'org7', 1),
('society_org8', 'org8', 1),
('society_org9', 'org9', 1),
('society_police', 'SASP', 1),
('society_sheriff', 'Sheriff', 1),
('society_slaughter', 'Rzeźnik', 1),
('society_taxi', 'Taxi', 1),
('user_ears', 'Kolczyki', 0),
('user_glasses', 'Okulary', 0),
('user_helmet', 'Czapka', 0),
('user_mask', 'Maska', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'propertyMotel-LepszaMelina1', NULL, '{}'),
(2, 'propertyMotel-LepszaMelina2', NULL, '{}'),
(3, 'propertyMotel-LepszaMelina3', NULL, '{}'),
(4, 'propertyMotel-LepszaMelina4', NULL, '{}'),
(5, 'propertyMotel-LepszaMelina5', NULL, '{}'),
(6, 'propertyMotel-LepszaMelina6', NULL, '{}'),
(7, 'propertyMotel-LepszaMelina7', NULL, '{}'),
(8, 'propertyMotel-LepszaMelina8', NULL, '{}'),
(9, 'propertyMotel-LepszaMelina9', NULL, '{}'),
(10, 'propertyMotel-LepszaMelina10', NULL, '{}'),
(11, 'propertyMotel-LepszaMelina11', NULL, '{}'),
(12, 'propertyMotel-LepszaMelina12', NULL, '{}'),
(13, 'propertyMotel-LepszaMelina13', NULL, '{}'),
(14, 'propertyMotel-LepszaMelina14', NULL, '{}'),
(15, 'propertyMotel-LepszaMelina15', NULL, '{}'),
(16, 'propertyMotel-LepszaMelina16', NULL, '{}'),
(17, 'propertyMotel-LepszaMelina17', NULL, '{}'),
(18, 'propertyMotel-LepszaMelina18', NULL, '{}'),
(19, 'propertyMotel-LepszaMelina19', NULL, '{}'),
(20, 'propertyMotel-LepszaMelina20', NULL, '{}'),
(21, 'propertyMotel-LepszaMelina21', NULL, '{}'),
(22, 'propertyMotel-LepszaMelina22', NULL, '{}'),
(23, 'propertyMotel-LepszaMelina23', NULL, '{}'),
(24, 'propertyMotel-LepszaMelina24', NULL, '{}'),
(25, 'propertyMotel-LepszaMelina25', NULL, '{}'),
(26, 'propertyMotel-LepszaMelina26', NULL, '{}'),
(27, 'propertyMotel-LepszaMelina27', NULL, '{}'),
(28, 'propertyMotel-LepszaMelina28', NULL, '{}'),
(29, 'propertyMotel-LepszaMelina29', NULL, '{}'),
(30, 'propertyMotel-LepszaMelina31', NULL, '{}'),
(31, 'propertyMotel-LepszaMelina32', NULL, '{}'),
(32, 'propertyMotel-LepszaMelina33', NULL, '{}'),
(33, 'propertyMotel-LepszaMelina34', NULL, '{}'),
(34, 'propertyMotel-LepszaMelina35', NULL, '{}'),
(35, 'propertyMotel-LepszaMelina36', NULL, '{}'),
(36, 'propertyMotel-LepszaMelina37', NULL, '{}'),
(37, 'propertyMotel-LepszaMelina38', NULL, '{}'),
(38, 'propertyMotel-LepszaMelina39', NULL, '{}'),
(39, 'propertyMotel-LepszaMelina40', NULL, '{}'),
(40, 'propertyMotel-LepszaMelina41', NULL, '{}'),
(41, 'propertyMotel-LepszaMelina42', NULL, '{}'),
(42, 'propertyMotel-LepszaMelina43', NULL, '{}'),
(43, 'propertyMotel-LepszaMelina44', NULL, '{}'),
(44, 'propertyMotel-LepszaMelina45', NULL, '{}'),
(45, 'propertyMotel-LepszaMelina46', NULL, '{}'),
(46, 'propertyMotel-LepszaMelina47', NULL, '{}'),
(47, 'propertyMotel-LepszaMelina48', NULL, '{}'),
(48, 'propertyMotel-LepszaMelina49', NULL, '{}'),
(49, 'propertyMotel-LepszaMelina50', NULL, '{}'),
(50, 'propertyMotel-LepszaMelina51', NULL, '{}'),
(51, 'propertyMotel-LepszaMelina52', NULL, '{}'),
(52, 'propertyMotel-LepszaMelina53', NULL, '{}'),
(53, 'propertyMotel-LepszaMelina54', NULL, '{}'),
(54, 'propertyMotel-LepszaMelina55', NULL, '{}'),
(55, 'propertyMotel-LepszaMelina56', NULL, '{}'),
(56, 'propertyMotel-LepszaMelina57', NULL, '{}'),
(57, 'propertyMotel-LepszaMelina58', NULL, '{}'),
(58, 'propertyMotel-LepszaMelina59', NULL, '{}'),
(59, 'propertyMotel-LepszaMelina60', NULL, '{}'),
(60, 'propertyMotel-LepszaMelina61', NULL, '{}'),
(61, 'propertyMotel-LepszaMelina62', NULL, '{}'),
(62, 'propertyMotel-LepszaMelina63', NULL, '{}'),
(63, 'propertyMotel-LepszaMelina64', NULL, '{}'),
(64, 'propertyMotel-LepszaMelina65', NULL, '{}'),
(65, 'propertyMotel-LepszaMelina66', NULL, '{}'),
(66, 'propertyMotel-LepszaMelina67', NULL, '{}'),
(67, 'propertyMotel-LepszaMelina68', NULL, '{}'),
(68, 'propertyMotel-LepszaMelina69', NULL, '{}'),
(69, 'propertyMotel-LepszaMelina70', NULL, '{}'),
(70, 'propertyMotel-LepszaMelina71', NULL, '{}'),
(71, 'propertyMotel-LepszaMelina72', NULL, '{}'),
(72, 'propertyMotel-LepszaMelina73', NULL, '{}'),
(73, 'propertyMotel-LepszaMelina74', NULL, '{}'),
(74, 'propertyMotel-LepszaMelina75', NULL, '{}'),
(75, 'propertyMotel-LepszaMelina76', NULL, '{}'),
(76, 'propertyMotel-LepszaMelina77', NULL, '{}'),
(77, 'propertyMotel-LepszaMelina79', NULL, '{}'),
(78, 'propertyMotel-LepszaMelina80', NULL, '{}'),
(79, 'propertyMotel-LepszaMelina81', NULL, '{}'),
(80, 'propertyMotel-LepszaMelina82', NULL, '{}'),
(81, 'propertyMotel-LepszaMelina83', NULL, '{}'),
(82, 'propertyMotel-LepszaMelina84', NULL, '{}'),
(83, 'propertyMotel-LepszaMelina85', NULL, '{}'),
(84, 'propertyMotel-LepszaMelina86', NULL, '{}'),
(85, 'propertyMotel-LepszaMelina87', NULL, '{}'),
(86, 'propertyMotel-LepszaMelina88', NULL, '{}'),
(87, 'propertyMotel-LepszaMelina89', NULL, '{}'),
(88, 'propertyMotel-LepszaMelina90', NULL, '{}'),
(89, 'propertyMotel-LepszaMelina91', NULL, '{}'),
(90, 'propertyMotel-LepszaMelina92', NULL, '{}'),
(91, 'propertyMotel-LepszaMelina93', NULL, '{}'),
(92, 'propertyMotel-LepszaMelina94', NULL, '{}'),
(93, 'propertyMotel-LepszaMelina95', NULL, '{}'),
(94, 'propertyMotel-LepszaMelina96', NULL, '{}'),
(95, 'propertyMotel-LepszaMelina97', NULL, '{}'),
(96, 'propertyMotel-LepszaMelina98', NULL, '{}'),
(97, 'propertyMotel-LepszaMelina99', NULL, '{}'),
(98, 'propertyMotel-LepszaMelina100', NULL, '{}'),
(99, 'propertyMotel-LepszaMelina101', NULL, '{}'),
(100, 'propertyMotel-LepszaMelina102', NULL, '{}'),
(101, 'propertyMotel-LepszaMelina103', NULL, '{}'),
(102, 'propertyMotel-LepszaMelina104', NULL, '{}'),
(103, 'propertyMotel-LepszaMelina105', NULL, '{}'),
(104, 'propertyMotel-LepszaMelina106', NULL, '{}'),
(105, 'propertyMotel-LepszaMelina107', NULL, '{}'),
(106, 'propertyMotel-LepszaMelina108', NULL, '{}'),
(107, 'propertyMotel-LepszaMelina109', NULL, '{}'),
(108, 'propertyMotel-LepszaMelina110', NULL, '{}'),
(109, 'propertyMotel-LepszaMelina111', NULL, '{}'),
(110, 'propertyMotel-LepszaMelina112', NULL, '{}'),
(111, 'propertyMotel-LepszaMelina113', NULL, '{}'),
(112, 'propertyMotel-LepszaMelina114', NULL, '{}'),
(113, 'propertyMotel-LepszaMelina115', NULL, '{}'),
(114, 'propertyMotel-LepszaMelina116', NULL, '{}'),
(115, 'propertyMotel-LepszaMelina117', NULL, '{}'),
(116, 'propertyMotel-LepszaMelina118', NULL, '{}'),
(117, 'propertyMotel-LepszaMelina119', NULL, '{}'),
(118, 'propertyMotel-LepszaMelina120', NULL, '{}'),
(119, 'propertyMotel-LepszaMelina121', NULL, '{}'),
(120, 'propertyMotel-LepszaMelina122', NULL, '{}'),
(121, 'propertyMotel-LepszaMelina123', NULL, '{}'),
(122, 'propertyMotel-LepszaMelina124', NULL, '{}'),
(123, 'propertyMotel-LepszaMelina125', NULL, '{}'),
(124, 'propertyMotel-LepszaMelina126', NULL, '{}'),
(125, 'propertyMotel-LepszaMelina127 ', NULL, '{}'),
(126, 'propertyMotel-LepszaMelina128', NULL, '{}'),
(127, 'propertyMotel-LepszaMelina129', NULL, '{}'),
(128, 'propertyMotel-LepszaMelina130', NULL, '{}'),
(129, 'propertyMotel-LepszaMelina131', NULL, '{}'),
(130, 'propertyMotel-LepszaMelina132', NULL, '{}'),
(131, 'propertyMotel-LepszaMelina133', NULL, '{}'),
(132, 'propertyMotel-LepszaMelina134', NULL, '{}'),
(133, 'propertyMotel-LepszaMelina135', NULL, '{}'),
(134, 'propertyMotel-LepszaMelina136', NULL, '{}'),
(135, 'propertyMotel-LepszaMelina137', NULL, '{}'),
(136, 'propertyMotel-LepszaMelina138', NULL, '{}'),
(137, 'propertyMotel-LepszaMelina141', NULL, '{}'),
(138, 'propertyMotel-LepszaMelina142', NULL, '{}'),
(139, 'propertyMotel-LepszaMelina143', NULL, '{}'),
(140, 'propertyMotel-LepszaMelina144', NULL, '{}'),
(141, 'propertyMotel-LepszaMelina145', NULL, '{}'),
(142, 'propertyMotel-LepszaMelina146', NULL, '{}'),
(143, 'propertyMotel-LepszaMelina147', NULL, '{}'),
(144, 'propertyCarson AveLowApartament79', NULL, '{}'),
(145, 'propertyJamestown StLowApartament80', NULL, '{}'),
(146, 'propertyJamestown StLowApartament81', NULL, '{}'),
(147, 'propertyJamestown StLowApartament82', NULL, '{}'),
(148, 'propertyJamestown StLowApartament83', NULL, '{}'),
(149, 'propertyJamestown StLowApartament84', NULL, '{}'),
(150, 'propertyJamestown StLowApartament85', NULL, '{}'),
(151, 'propertyJamestown StLowApartament86', NULL, '{}'),
(152, 'propertyJamestown StLowApartament87', NULL, '{}'),
(153, 'propertyJamestown StLowApartament88', NULL, '{}'),
(154, 'propertyCarson AveLowApartament89', NULL, '{}'),
(155, 'propertyCarson AveLowApartament90', NULL, '{}'),
(156, 'propertyDutch London StLowApartament91', NULL, '{}'),
(157, 'propertyDutch London StLowApartament92', NULL, '{}'),
(158, 'propertyDutch London StLowApartament93', NULL, '{}'),
(159, 'propertyJamestown StLowApartament94', NULL, '{}'),
(160, 'propertyJamestown StLowApartament95', NULL, '{}'),
(161, 'propertyJamestown StLowApartament96', NULL, '{}'),
(162, 'propertyJamestown StLowApartament98', NULL, '{}'),
(163, 'propertyJamestown StLowApartament99', NULL, '{}'),
(164, 'propertyJamestown StLowApartament100', NULL, '{}'),
(165, 'propertyJamestown StLowApartament101', NULL, '{}'),
(166, 'propertyDutch London StLowApartament102', NULL, '{}'),
(167, 'propertyDutch London StLowApartament103', NULL, '{}'),
(168, 'propertyDutch London StLowApartament104', NULL, '{}'),
(169, 'propertyDutch London StLowApartament105', NULL, '{}'),
(170, 'propertyDutch London StLowApartament106', NULL, '{}'),
(171, 'propertyDutch London StLowApartament107', NULL, '{}'),
(172, 'propertyDutch London StLowApartament108', NULL, '{}'),
(173, 'propertyGrove StLowApartament109', NULL, '{}'),
(174, 'propertyGrove StLowApartament110', NULL, '{}'),
(175, 'propertyGrove StLowApartament111', NULL, '{}'),
(176, 'propertyGrove StLowApartament112', NULL, '{}'),
(177, 'propertyGrove StLowApartament113', NULL, '{}'),
(178, 'propertyGrove StLowApartament114', NULL, '{}'),
(179, 'propertyGrove StLowApartament115', NULL, '{}'),
(180, 'propertyGrove StLowApartament116', NULL, '{}'),
(181, 'propertyGrove StLowApartament117', NULL, '{}'),
(182, 'propertyGrove StLowApartament118', NULL, '{}'),
(183, 'propertyGrove StLowApartament119', NULL, '{}'),
(184, 'propertyGrove StLowApartament120', NULL, '{}'),
(185, 'propertyGrove StLowApartament121', NULL, '{}'),
(186, 'propertyForum DrLowApartament122', NULL, '{}'),
(187, 'propertyForum DrLowApartament123', NULL, '{}'),
(188, 'propertyForum DrLowApartament124', NULL, '{}'),
(189, 'propertyForum DrLowApartament125', NULL, '{}'),
(190, 'propertyForum DrLowApartament126', NULL, '{}'),
(191, 'propertyCarson AveLowApartament127', NULL, '{}'),
(192, 'propertyCarson AveLowApartament128', NULL, '{}'),
(193, 'propertyCarson AveLowApartament129', NULL, '{}'),
(194, 'propertyCarson AveLowApartament130', NULL, '{}'),
(195, 'propertyCarson AveLowApartament131', NULL, '{}'),
(196, 'propertyForum DrLowApartament132', NULL, '{}'),
(197, 'propertyForum DrLowApartament133', NULL, '{}'),
(198, 'propertyForum DrLowApartament134', NULL, '{}'),
(199, 'propertyCarson AveLowApartament135', NULL, '{}'),
(200, 'propertyCarson AveLowApartament136', NULL, '{}'),
(201, 'propertyCarson AveLowApartament137', NULL, '{}'),
(202, 'propertyCarson AveLowApartament138', NULL, '{}'),
(203, 'propertyCarson AveLowApartament139', NULL, '{}'),
(204, 'propertyForum DrLowApartament140', NULL, '{}'),
(205, 'propertyForum DrLowApartament141', NULL, '{}'),
(206, 'propertyForum DrLowApartament142', NULL, '{}'),
(207, 'propertyForum DrMotel143', NULL, '{}'),
(208, 'propertyForum DrMotel144', NULL, '{}'),
(209, 'propertyForum DrMotel145', NULL, '{}'),
(210, 'propertyForum DrMotel146', NULL, '{}'),
(211, 'propertyForum DrMotel147', NULL, '{}'),
(212, 'propertyForum DrMotel148', NULL, '{}'),
(213, 'propertyForum DrLowApartament149', NULL, '{}'),
(214, 'propertyForum DrLowApartament150', NULL, '{}'),
(215, 'propertyFantastic PlApartment151', NULL, '{}'),
(216, 'propertyVespucci BlvdApartment152', NULL, '{}'),
(217, 'propertyVespucci BlvdApartment153', NULL, '{}'),
(218, 'propertyZach. Mirror DriveApartment154', NULL, '{}'),
(219, 'propertyZach. Mirror DriveApartment155', NULL, '{}'),
(220, 'propertyZach. Mirror DriveApartment156', NULL, '{}'),
(221, 'propertyZach. Mirror DriveLuxApartment157', NULL, '{}'),
(222, 'propertyZach. Mirror DriveApartment158', NULL, '{}'),
(223, 'propertyZach. Mirror DriveApartment159', NULL, '{}'),
(224, 'propertyZach. Mirror DriveLuxApartment160', NULL, '{}'),
(225, 'propertyZach. Mirror DriveApartment161', NULL, '{}'),
(226, 'propertyZach. Mirror DriveApartment162', NULL, '{}'),
(227, 'propertyZach. Mirror DriveLuxApartment163', NULL, '{}'),
(228, 'propertyZach. Mirror DriveApartment164', NULL, '{}'),
(229, 'propertyZach. Mirror DriveApartment165', NULL, '{}'),
(230, 'propertyZach. Mirror DriveApartment166', NULL, '{}'),
(231, 'propertyZach. Mirror DriveLuxApartment167', NULL, '{}'),
(232, 'propertyZach. Mirror DriveApartment168', NULL, '{}'),
(233, 'propertyZach. Mirror DriveApartment169', NULL, '{}'),
(234, 'propertyZach. Mirror DriveApartment170', NULL, '{}'),
(235, 'propertyZach. Mirror DriveLuxApartment171', NULL, '{}'),
(236, 'propertyZach. Mirror DriveApartment172', NULL, '{}'),
(237, 'propertyZach. Mirror DriveApartment173', NULL, '{}'),
(238, 'propertyBridge StLowApartament174', NULL, '{}'),
(239, 'propertyZach. Mirror DriveLowApartament175', NULL, '{}'),
(240, 'propertyBridge StLuxApartment176', NULL, '{}'),
(241, 'propertyBridge StApartment177', NULL, '{}'),
(242, 'propertyBridge StApartment178', NULL, '{}'),
(243, 'propertyBridge StApartment179', NULL, '{}'),
(244, 'propertyBridge StApartment180', NULL, '{}'),
(245, 'propertyZach. Mirror DriveApartment181', NULL, '{}'),
(246, 'propertyZach. Mirror DriveApartment182', NULL, '{}'),
(247, 'propertyZach. Mirror DriveApartment183', NULL, '{}'),
(248, 'propertyZach. Mirror DriveLowApartament184', NULL, '{}'),
(249, 'propertyZach. Mirror DriveLowApartament185', NULL, '{}'),
(250, 'propertyNikola AveApartment186', NULL, '{}'),
(251, 'propertyZach. Mirror DriveApartment187', NULL, '{}'),
(252, 'propertyMirror Park BlvdLowApartament188', NULL, '{}'),
(253, 'propertyMirror Park BlvdApartment189', NULL, '{}'),
(254, 'propertyMirror Park BlvdApartment190', NULL, '{}'),
(255, 'propertyMirror Park BlvdApartment191', NULL, '{}'),
(256, 'propertyMirror Park BlvdApartment192', NULL, '{}'),
(257, 'propertyMirror Park BlvdApartment193', NULL, '{}'),
(258, 'propertyWsch. Mirror DrApartment194', NULL, '{}'),
(259, 'propertyWsch. Mirror DrLowApartament195', NULL, '{}'),
(260, 'propertyWsch. Mirror DrApartment196', NULL, '{}'),
(261, 'propertyWsch. Mirror DrApartment197', NULL, '{}'),
(262, 'propertyWsch. Mirror DrApartment198', NULL, '{}'),
(263, 'propertyWsch. Mirror DrApartment199', NULL, '{}'),
(264, 'propertyWsch. Mirror DrApartment200', NULL, '{}'),
(265, 'propertyNikola PlApartment201', NULL, '{}'),
(266, 'propertyNikola PlApartment202', NULL, '{}'),
(267, 'propertyNikola PlApartment203', NULL, '{}'),
(268, 'propertyNikola PlApartment204', NULL, '{}'),
(269, 'propertyNikola PlApartment205', NULL, '{}'),
(270, 'propertyNikola PlApartment206', NULL, '{}'),
(271, 'propertyNikola PlApartment207', NULL, '{}'),
(272, 'propertyNikola PlApartment208', NULL, '{}'),
(273, 'propertyNikola PlApartment209', NULL, '{}'),
(274, 'propertyNikola PlApartment210', NULL, '{}'),
(275, 'propertyGentry LaneApartment223', NULL, '{}'),
(276, 'propertyGentry LaneApartment224', NULL, '{}'),
(277, 'propertyLas Lagunas BlvdApartment225', NULL, '{}'),
(278, 'propertySan Vitus BlvdLuxApartment230', NULL, '{}'),
(279, 'propertySpanish AveLuxApartment231', NULL, '{}'),
(280, 'propertySpanish AveLuxApartment232', NULL, '{}'),
(281, 'propertySpanish AveLuxApartment233', NULL, '{}'),
(282, 'propertyLas Lagunas BlvdApartment234', NULL, '{}'),
(283, 'propertyLas Lagunas BlvdLowApartament235', NULL, '{}'),
(284, 'propertyLas Lagunas BlvdApartment236', NULL, '{}'),
(285, 'propertyLas Lagunas BlvdApartment237', NULL, '{}'),
(286, 'propertyLas Lagunas BlvdLowApartament238', NULL, '{}'),
(287, 'propertyLas Lagunas BlvdApartment239', NULL, '{}'),
(288, 'propertyLas Lagunas BlvdLowApartament240', NULL, '{}'),
(289, 'propertyLas Lagunas BlvdLowApartament241', NULL, '{}'),
(290, 'propertyMeteor StMotel242', NULL, '{}'),
(291, 'propertyMeteor StMotel243', NULL, '{}'),
(292, 'propertyMeteor StMotel244', NULL, '{}'),
(293, 'propertyMeteor StMotel245', NULL, '{}'),
(294, 'propertyMeteor StMotel246', NULL, '{}'),
(295, 'propertyMeteor StMotel247', NULL, '{}'),
(296, 'propertyMeteor StMotel248', NULL, '{}'),
(297, 'propertyMeteor StLowApartament249', NULL, '{}'),
(298, 'propertyHawick AveLowApartament250', NULL, '{}'),
(299, 'propertyHawick AveMotel251', NULL, '{}'),
(300, 'propertyMeteor StMotel252', NULL, '{}'),
(301, 'propertyMeteor StLowApartament253', NULL, '{}'),
(302, 'propertyMeteor StLowApartament254', NULL, '{}'),
(303, 'propertyMeteor StMotel255', NULL, '{}'),
(304, 'propertyMeteor StMotel256', NULL, '{}'),
(305, 'propertyMeteor StMotel257', NULL, '{}'),
(306, 'propertyMeteor StMotel258', NULL, '{}'),
(307, 'propertyMeteor StMotel259', NULL, '{}'),
(308, 'propertyMeteor StLuxApartment260', NULL, '{}'),
(309, 'propertyMeteor StMotel261', NULL, '{}'),
(310, 'propertyMeteor StMotel262', NULL, '{}'),
(311, 'propertyHawick AveMotel263', NULL, '{}'),
(312, 'propertyHawick AveMotel264', NULL, '{}'),
(313, 'propertyHawick AveMotel265', NULL, '{}'),
(314, 'propertyHawick AveMotel266', NULL, '{}'),
(315, 'propertyHawick AveLowApartament267', NULL, '{}'),
(316, 'propertyHawick AveMotel268', NULL, '{}'),
(317, 'propertyHawick AveMotel269', NULL, '{}'),
(318, 'society_ambulance', NULL, '{}'),
(319, 'society_baker', NULL, '{}'),
(320, 'society_cardealer', NULL, '{}'),
(321, 'society_farming', NULL, '{}'),
(322, 'society_fisherman', NULL, '{}'),
(323, 'society_grower', NULL, '{}'),
(324, 'society_krawiec', NULL, '{}'),
(325, 'society_mechanik', NULL, '{}'),
(326, 'society_milkman', NULL, '{}'),
(327, 'society_miner', NULL, '{}'),
(328, 'society_police', NULL, '{}'),
(329, 'society_slaughter', NULL, '{}'),
(330, 'society_taxi', NULL, '{}'),
(331, 'propertyFcie', NULL, '{}'),
(332, 'propertyVip', NULL, '{}'),
(333, 'society_gopostal', NULL, '{}'),
(334, 'propertyEl Partizante', NULL, '{}'),
(335, 'society_org10', NULL, '{}'),
(336, 'society_org11', NULL, '{}'),
(337, 'society_org12', NULL, '{}'),
(338, 'society_org13', NULL, '{}'),
(339, 'society_org14', NULL, '{}'),
(340, 'society_org15', NULL, '{}'),
(341, 'society_org16', NULL, '{}'),
(342, 'society_org17', NULL, '{}'),
(343, 'society_org18', NULL, '{}'),
(344, 'society_org19', NULL, '{}'),
(345, 'society_org2', NULL, '{}'),
(346, 'society_org20', NULL, '{}'),
(347, 'society_org21', NULL, '{}'),
(348, 'society_org22', NULL, '{}'),
(349, 'society_org23', NULL, '{}'),
(350, 'society_org24', NULL, '{}'),
(351, 'society_org25', NULL, '{}'),
(352, 'society_org26', NULL, '{}'),
(353, 'society_org27', NULL, '{}'),
(354, 'society_org28', NULL, '{}'),
(355, 'society_org29', NULL, '{}'),
(356, 'society_org3', NULL, '{}'),
(357, 'society_org30', NULL, '{}'),
(358, 'society_org31', NULL, '{}'),
(359, 'society_org32', NULL, '{}'),
(360, 'society_org33', NULL, '{}'),
(361, 'society_org34', NULL, '{}'),
(362, 'society_org35', NULL, '{}'),
(363, 'society_org36', NULL, '{}'),
(364, 'society_org37', NULL, '{}'),
(365, 'society_org38', NULL, '{}'),
(366, 'society_org39', NULL, '{}'),
(367, 'society_org4', NULL, '{}'),
(368, 'society_org40', NULL, '{}'),
(369, 'society_org5', NULL, '{}'),
(370, 'society_org6', NULL, '{}'),
(371, 'society_org7', NULL, '{}'),
(372, 'society_org8', NULL, '{}'),
(373, 'society_org9', NULL, '{}'),
(374, 'society_kawiarnia', NULL, '{}'),
(375, 'society_org1', NULL, '{}'),
(376, 'society_dtu', NULL, '{}'),
(377, 'society_hwp', NULL, '{}'),
(378, 'society_sheriff', NULL, '{}'),
(379, 'society_cafe', NULL, '{}'),
(380, 'society_kawiarnia_black', NULL, '{}'),
(12736, 'society_org22_black', NULL, '{}'),
(12737, 'society_org23_black', NULL, '{}'),
(12738, 'society_org24_black', NULL, '{}'),
(12739, 'society_org25_black', NULL, '{}'),
(12740, 'society_org26_black', NULL, '{}'),
(12741, 'society_org27_black', NULL, '{}'),
(12742, 'society_org28_black', NULL, '{}'),
(12743, 'society_org29_black', NULL, '{}'),
(12744, 'society_org30_black', NULL, '{}'),
(12745, 'society_org31_black', NULL, '{}'),
(12746, 'society_org32_black', NULL, '{}'),
(12747, 'society_org33_black', NULL, '{}'),
(12748, 'society_org34_black', NULL, '{}'),
(12749, 'society_org35_black', NULL, '{}'),
(12750, 'society_org36_black', NULL, '{}'),
(12751, 'society_org37_black', NULL, '{}'),
(12752, 'society_org38_black', NULL, '{}'),
(12753, 'society_org39_black', NULL, '{}'),
(12754, 'society_org40_black', NULL, '{}'),
(32705, 'property', 'steam:110000147973fd2', '{}'),
(32706, 'user_ears', 'steam:110000147973fd2', '{}'),
(32707, 'user_glasses', 'steam:110000147973fd2', '{}'),
(32708, 'user_helmet', 'steam:110000147973fd2', '{}'),
(32709, 'user_mask', 'steam:110000147973fd2', '{}'),
(32710, 'user_ears', 'steam:1100001033ab0e1', '{}'),
(32711, 'user_glasses', 'steam:1100001033ab0e1', '{}'),
(32712, 'property', 'steam:1100001033ab0e1', '{}'),
(32713, 'user_helmet', 'steam:1100001033ab0e1', '{}'),
(32714, 'user_mask', 'steam:1100001033ab0e1', '{}'),
(32715, 'property', 'steam:11000014c3cf3e2', '{}'),
(32716, 'user_ears', 'steam:11000014c3cf3e2', '{}'),
(32717, 'user_glasses', 'steam:11000014c3cf3e2', '{}'),
(32718, 'user_helmet', 'steam:11000014c3cf3e2', '{}'),
(32719, 'user_mask', 'steam:11000014c3cf3e2', '{}'),
(32720, 'property', 'steam:1100001491a53e6', '{}'),
(32721, 'user_glasses', 'steam:1100001491a53e6', '{}'),
(32722, 'user_mask', 'steam:1100001491a53e6', '{}'),
(32723, 'user_helmet', 'steam:1100001491a53e6', '{}'),
(32724, 'user_ears', 'steam:1100001491a53e6', '{}'),
(32725, 'property', 'steam:110000106271c89', '{}'),
(32726, 'user_ears', 'steam:110000106271c89', '{}'),
(32727, 'user_helmet', 'steam:110000106271c89', '{}'),
(32728, 'user_mask', 'steam:110000106271c89', '{}'),
(32729, 'user_glasses', 'steam:110000106271c89', '{}');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `emstablet_history`
--

CREATE TABLE `emstablet_history` (
  `owner` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `surname` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `treatment` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `price` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `doctor` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `exile_org`
--

CREATE TABLE `exile_org` (
  `id` int(11) NOT NULL,
  `orgname` varchar(100) DEFAULT NULL,
  `level` int(2) NOT NULL DEFAULT 0,
  `safe` int(2) NOT NULL DEFAULT 0,
  `items` int(2) NOT NULL DEFAULT 0,
  `addoncloakroom` int(2) NOT NULL DEFAULT 0,
  `menuf7` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `exile_org`
--

INSERT INTO `exile_org` (`id`, `orgname`, `level`, `safe`, `items`, `addoncloakroom`, `menuf7`) VALUES
(1, 'society_org1', 0, 0, 0, 0, 0),
(2, 'society_org2', 0, 0, 0, 0, 0),
(3, 'society_org3', 0, 0, 0, 0, 0),
(4, 'society_org4', 0, 0, 0, 0, 0),
(5, 'society_org5', 0, 0, 0, 0, 0),
(6, 'society_org6', 0, 0, 0, 0, 0),
(7, 'society_org7', 0, 0, 0, 0, 0),
(8, 'society_org8', 0, 0, 0, 0, 0),
(9, 'society_org9', 0, 0, 0, 0, 0),
(10, 'society_org10', 0, 0, 0, 0, 0),
(11, 'society_org11', 0, 0, 0, 0, 0),
(12, 'society_org12', 0, 0, 0, 0, 0),
(13, 'society_org13', 0, 0, 0, 0, 0),
(14, 'society_org14', 0, 0, 0, 0, 0),
(15, 'society_org15', 0, 0, 0, 0, 0),
(16, 'society_org16', 0, 0, 0, 0, 0),
(17, 'society_org17', 0, 0, 0, 0, 0),
(18, 'society_org18', 0, 0, 0, 0, 0),
(19, 'society_org19', 0, 0, 0, 0, 0),
(20, 'society_org20', 0, 0, 0, 0, 0),
(21, 'society_org21', 0, 0, 0, 0, 0),
(22, 'society_org22', 0, 0, 0, 0, 0),
(23, 'society_org23', 0, 0, 0, 0, 0),
(24, 'society_org24', 0, 0, 0, 0, 0),
(25, 'society_org25', 0, 0, 0, 0, 0),
(26, 'society_org26', 0, 0, 0, 0, 0),
(27, 'society_org27', 0, 0, 0, 0, 0),
(28, 'society_org28', 0, 0, 0, 0, 0),
(29, 'society_org29', 0, 0, 0, 0, 0),
(30, 'society_org30', 0, 0, 0, 0, 0),
(31, 'society_org31', 0, 0, 0, 0, 0),
(32, 'society_org32', 0, 0, 0, 0, 0),
(33, 'society_org33', 0, 0, 0, 0, 0),
(34, 'society_org34', 0, 0, 0, 0, 0),
(35, 'society_org35', 0, 0, 0, 0, 0),
(36, 'society_org36', 0, 0, 0, 0, 0),
(37, 'society_org37', 0, 0, 0, 0, 0),
(38, 'society_org38', 0, 0, 0, 0, 0),
(39, 'society_org39', 0, 0, 0, 0, 0),
(40, 'society_org40', 0, 0, 0, 0, 0),
(1000, 'police', 0, 0, 0, 0, 0),
(1001, 'ambulance', 0, 0, 0, 0, 0),
(1002, 'mechanik', 0, 0, 0, 0, 0),
(1003, 'kawiarnia', 0, 0, 0, 0, 0),
(1004, 'milkman', 0, 0, 0, 0, 0),
(1005, 'krawiec', 0, 0, 0, 0, 0),
(1006, 'hwp', 0, 0, 0, 0, 0),
(1007, 'fisherman', 0, 0, 0, 0, 0),
(1008, 'cardealer', 0, 0, 0, 0, 0),
(1009, 'baker', 0, 0, 0, 0, 0),
(1010, 'slaughter', 0, 0, 0, 0, 0),
(1011, 'taxi', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `exile_transfers`
--

CREATE TABLE `exile_transfers` (
  `id` int(11) NOT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `from_label` varchar(50) DEFAULT NULL,
  `money` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `exile_zones`
--

CREATE TABLE `exile_zones` (
  `name` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taken` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `exile_zones`
--

INSERT INTO `exile_zones` (`name`, `owner`, `label`, `taken`) VALUES
('zone_1', 'org1', 'BRAK', 1647369876);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `fine_types`
--

CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `items`
--

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('alive_chicken', 'Kurczak', 10, 0, 1),
('appistol', 'Pistolet ppanc.', 5, 0, 1),
('apple', 'Jabłko', 100, 0, 1),
('assaultrifle', 'AK-47', 3, 0, 1),
('bagniak', 'Blant OG', 3, 0, 1),
('banan', 'Banan', 20, 0, 1),
('bandage', 'Bandaż', 20, 0, 1),
('bat', 'Kij bejsbolowy', 1, 0, 1),
('beer', 'Harnaś 0.5L', 100, 0, 1),
('bletka', 'Bletka', 30, 0, 1),
('blowpipe', 'Palnik', 5, 0, 1),
('bodycam', 'Bodycam', 5, 0, 1),
('bottle', 'Bottle', 5, 0, 1),
('bread', 'Chleb', 150, 0, 1),
('breads', 'Bochenek chleba ', 80, 0, 1),
('bron_magazynek', 'Magazynek', 5, 0, 1),
('bron_magazynek_powiekszony', 'Powiększony magazynek', 5, 0, 1),
('brzoskwinia', 'Brzoskwinia', 150, 0, 1),
('bulletproof', 'Kamizelka kuloodporna', 2, 0, 1),
('burbon', 'Szklanka Burbonu', 10, 0, 1),
('bzgas', 'Gaz łzawiący', 3, 0, 1),
('cake', 'Porcja ciasta', 80, 0, 1),
('carbinerifle', 'Karabin szturmowy', 3, 0, 1),
('carokit', 'Karoseria', 5, 0, 1),
('carotool', 'Cześć karoserii', 5, 0, 1),
('ceramicpistol', 'Pistolet ceramiczny', 5, 0, 1),
('chipsy', 'Chipsy', 20, 0, 1),
('chocolate', 'Czekolada', 30, 0, 1),
('cigarette', 'Papieros', 20, 0, 1),
('clip', 'Magazynek', 10, 0, 1),
('coke', 'Kokaina', 125, 0, 1),
('coke_pooch', 'Porcja kokainy', 25, 0, 1),
('cola', 'Coca Cola', 20, 0, 1),
('combatpdw', 'PDW', 5, 0, 1),
('combatpistol', 'Pistolet bojowy', 5, 0, 1),
('compactrifle', 'Kompaktowy karabinek', 3, 0, 1),
('contract', 'Kontrakt', 1, 0, 1),
('crowbar', 'Łom', 5, 0, 1),
('crusher', 'Crusher', 30, 0, 1),
('csgocase', 'Zwykła skrzynka', 150, 0, 1),
('csgocase2', 'Diamentowa skrzynka', 150, 0, 1),
('cupcake', 'Babeczka', 20, 0, 1),
('cydr', 'Butelka Cydru', 10, 0, 1),
('cytryna', 'Cytryna', 150, 0, 1),
('dagger', 'Sztylet', 3, 0, 1),
('donut', 'Donut', 20, 0, 1),
('doubleaction', 'Double action revolver', 5, 0, 1),
('drill', 'Wiertło', 2, 0, 1),
('drink', 'Drink Północno-Amerykański', 10, 0, 1),
('exctasy', 'Exctasy', 125, 0, 1),
('exctasy_pooch', 'Porcja exctasy', 25, 0, 1),
('fixkit', 'Zestaw naprawczy', 5, 0, 1),
('fixtool', 'Część naprawcza', 5, 0, 1),
('flare', 'Raca', 10, 0, 1),
('flaregun', 'Pistolet na race', 5, 0, 1),
('flare_ammo', 'Race', 100, 0, 1),
('flashlight', 'Latarka', 3, 0, 1),
('flavour', 'Mąka', 80, 0, 1),
('garbagebag', 'garbagebag', -1, 0, 1),
('gazbottle', 'Butla z gazem', 5, 0, 1),
('gbs', 'Kawa GBS', 15, 0, 1),
('gin', 'Gin', 15, 0, 1),
('golfclub', 'Kij golfowy', 5, 0, 1),
('gopro', 'GoPro', 5, 0, 1),
('gps', 'GPS', 1, 0, 1),
('grip', 'Uchwyt', 10, 0, 1),
('gzgas_ammo', 'gzgas_ammo', 100, 0, 1),
('hamburger', 'Hamburger', 30, 0, 1),
('hammer', 'Młotek', 5, 0, 1),
('handcuffs', 'Kajdanki', 3, 0, 1),
('hatchet', 'Topór', 5, 0, 1),
('heavypistol', 'Ciężki pistolet', 5, 0, 1),
('hifi', 'Boombox', 2, 0, 1),
('icetea', 'Ice Tea', 20, 0, 1),
('jablko', 'Jabłko', 50, 0, 1),
('kamizelka', 'Kamizelka (25%)', 3, 0, 1),
('kamizelka2', 'Kamizelka (50%)', -1, 0, 1),
('kamizelka3', 'Kamizelka (90%)', 3, 0, 1),
('kawa', 'X-Gamer', 15, 0, 1),
('kawa2', 'Zabezpieczony X-Gamer', 15, 0, 1),
('knife', 'Nóż', 5, 0, 1),
('knuckle', 'Kastet', 5, 0, 1),
('kocyk', 'Kocyk', 3, 0, 1),
('koniak', 'Koniak 200ml', 10, 0, 1),
('krotkofalowka', 'Krótkofalówka', 3, 0, 1),
('lekemeryt', 'Lek dla Seniora', 5, 0, 1),
('liquid', 'Liquid', 3, 0, 1),
('lockpick', 'Wytrych', 3, 0, 1),
('lornetka', 'Lornetka', 5, 0, 1),
('machete', 'Maczeta', 5, 0, 1),
('machinepistol', 'Pistolet maszynowy', 5, 0, 1),
('maka', 'Mąka', 100, 0, 1),
('mandarynka', 'Mandarynka', 150, 0, 1),
('material_krawiec', 'Materiał', 100, 0, 1),
('medikit', 'Apteczka', 20, 0, 1),
('meth', 'Metafetamina', 125, 0, 1),
('meth_pooch', 'Porcja metafetaminy', 25, 0, 1),
('microsmg', 'Kompaktowe SMG', 5, 0, 1),
('milk', 'Mleko', 100, 0, 1),
('milk_in_pail', 'Mleko w wiadrze', 10, 0, 1),
('minismg', 'Mini SMG', 5, 0, 1),
('molotov', 'Koktajl mołotowa', 10, 0, 1),
('molotov_ammo', 'molotov_ammo', 100, 0, 1),
('musket', 'Muszkiet', 5, 0, 1),
('nightstick', 'Pałka teleskopowa', 5, 0, 1),
('nightvision', 'Noktowizor', 1, 0, 1),
('opium', 'Opium', 125, 0, 1),
('opium_pooch', 'Porcja opium', 25, 0, 1),
('oxygenmask', 'Maska tlenowa', 1, 0, 1),
('packaged_chicken', 'Zapakowany kurczak', 10, 0, 1),
('panicbutton', 'Panic Button', 1, 0, 1),
('papieros', 'Papieros', 30, 0, 1),
('parachute', 'Spadochron', 2, 0, 1),
('petrolcan', 'Petrol Can', 2, 0, 1),
('phone', 'Telefon', 3, 0, 1),
('pierscionek1', 'Pierścionek zaręczynowy', 5, 0, 1),
('pierscionek2', 'Pierścionek ślubny', 5, 0, 1),
('pistol', 'Pistolet', 5, 0, 1),
('pistol50', 'Pistolet .50', 5, 0, 1),
('pistol_ammo', 'Amunicja do pistoletu', 250, 0, 1),
('pistol_mk2', 'Pistolet.wer 2', 5, 0, 1),
('pomarancza', 'Pomarańcza', 150, 0, 1),
('przyneta', 'Przynęta', 50, 0, 1),
('pszenica', 'Pszenica', 100, 0, 1),
('pumpshotgun', 'Strzelba', 2, 0, 1),
('pumpshotgun_mk2', 'Strzelba wer.2', 2, 0, 1),
('radio', 'Radio', 3, 0, 1),
('redbull', 'Redbull', 15, 0, 1),
('repairkit', 'Zestaw naprawczy', 5, 0, 1),
('revolver', 'Revolver', 5, 0, 1),
('rifle_ammo', 'Amunicja do karabinu', 150, 0, 1),
('roll', 'Bułka', 80, 0, 1),
('roza', 'Róża', 5, 0, 1),
('ryba', 'Ryba', 100, 0, 1),
('sandwich', 'Kanapka', 20, 0, 1),
('scope', 'Celownik', 3, 0, 1),
('scope2', 'Zaawansowany celownik', 3, 0, 1),
('scratchcard', 'Zdrapka Silver', 30, 0, 1),
('scratchcarddiamond', 'Zdrapka Diamond', 30, 0, 1),
('scratchcardgold', 'Zdrapka Gold', 30, 0, 1),
('ser', 'Ser', 20, 0, 1),
('shot', 'Shot czystej wódki 30ml', 10, 0, 1),
('shotgun_ammo', 'Amunicja do strzelby', 20, 0, 1),
('silencieux', 'Tłumik', 3, 0, 1),
('sim', 'Karta SIM', 1, 0, 1),
('skarpetka', 'Skarpeta na głowe', 5, 0, 1),
('slaughtered_chicken', 'Pocięty kurczak', 10, 0, 1),
('smg', 'SMG', 3, 0, 1),
('smg_ammo', 'Amunicja do SMG', 200, 0, 1),
('smg_mk2', 'SMG wer.2', 5, 0, 1),
('smietana', 'Śmietana', 100, 0, 1),
('smokegrenade', 'Granat dymny', 3, 0, 1),
('smokegrenade_ammo', 'smokegrenade_ammo', 100, 0, 1),
('snspistol', 'Pukawka', 5, 0, 1),
('snspistol_mk2', 'Pukawka.wer 2', 5, 0, 1),
('sok', 'Sok', 100, 0, 1),
('stungun', 'Paralizator', 5, 0, 1),
('stungun_ammo', 'Stungun Ammo', 100, 0, 1),
('switchblade', 'Scyzoryk', 5, 0, 1),
('tank_ammo', 'tank_ammo', 100, 0, 1),
('tequila', 'Tequila 0.7L', 100, 0, 1),
('tirekit', 'Zestaw naprawczy', 5, 0, 1),
('ubrania_krawiec', 'Ubrania', 100, 0, 1),
('untransformed_apple', 'Nieprzetworzone jabłko', 100, 0, 1),
('vape', 'E-Papieros', 2, 0, 1),
('vintagepistol', 'Pistolet vintage', 5, 0, 1),
('vodka', 'Soplica 0.7L', 100, 0, 1),
('water', 'Woda', 150, 0, 1),
('wedka', 'Wędka', 2, 0, 1),
('weed', 'Marihuana', 125, 0, 1),
('weed_pooch', 'Porcja marihuany', 25, 0, 1),
('whisky', 'Jack Daniels 0.7L', 100, 0, 1),
('wino', 'Wino', 15, 0, 1),
('winogrono', 'Winogrono', 150, 0, 1),
('worek', 'Worek', 5, 0, 1),
('zapalniczka', 'Zapalniczka', 5, 0, 1),
('ziarna', 'Ziarna kawy', 100, 0, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `jail`
--

CREATE TABLE `jail` (
  `identifier` varchar(100) CHARACTER SET utf8mb3 NOT NULL,
  `jail_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  `win` int(11) NOT NULL DEFAULT 0,
  `lose` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `whitelisted`, `win`, `lose`) VALUES
('ambulance', 'San Andreas Medical Service', 1, 0, 0),
('baker', 'Piekarz', 1, 0, 0),
('cardealer', 'Premium Deluxe Motorsport', 1, 0, 0),
('fisherman', 'Lets Fish', 0, 0, 0),
('grower', 'Sadownik', 1, 0, 0),
('hwp', 'Highway Patrol', 1, 0, 0),
('kawiarnia', 'Bean Machine Coffe', 0, 0, 0),
('krawiec', 'Fly Beliodas', 1, 0, 0),
('mechanik', 'Moltisanti Garage', 1, 0, 0),
('milkman', 'Milkman', 0, 0, 0),
('offambulance', 'SAMS | Poza Służbą', 1, 0, 0),
('offpolice', 'SASP | Poza Służbą', 1, 0, 0),
('org1', 'PDW', 1, 0, 0),
('org10', 'GMW', 1, 0, 0),
('org11', 'GROM', 1, 0, 0),
('org12', 'PG', 1, 0, 0),
('org13', 'The Family', 1, 0, 0),
('org14', 'ZPL', 1, 0, 0),
('org15', 'Camorra', 1, 0, 0),
('org16', '808', 1, 0, 0),
('org17', 'YUNG', 1, 0, 0),
('org18', 'BERLINKI', 1, 0, 0),
('org19', 'MD', 1, 0, 0),
('org2', 'ICB', 1, 0, 0),
('org20', 'SZABLUSIE', 1, 0, 0),
('org21', '05', 1, 0, 0),
('org22', 'Mokotów', 1, 0, 0),
('org23', 'MR', 1, 0, 0),
('org24', 'HRC', 1, 0, 0),
('org25', 'Brak', 1, 0, 0),
('org26', 'Brak', 1, 0, 0),
('org27', 'Brak', 1, 0, 0),
('org28', 'Brak', 1, 0, 0),
('org29', 'Brak', 1, 0, 0),
('org3', 'GHOST', 1, 0, 0),
('org30', 'Brak', 1, 0, 0),
('org31', 'Brak', 1, 0, 0),
('org32', 'Brak', 1, 0, 0),
('org33', 'Brak', 1, 0, 0),
('org34', 'Brak', 1, 0, 0),
('org35', 'Brak', 1, 0, 0),
('org36', 'Brak', 1, 0, 0),
('org37', 'Brak', 1, 0, 0),
('org38', 'Brak', 1, 0, 0),
('org39', 'Brak', 1, 0, 0),
('org4', 'DSG', 1, 0, 0),
('org40', 'Brak', 1, 0, 0),
('org5', 'TRIADA', 1, 0, 0),
('org6', 'SUB', 1, 0, 0),
('org7', 'SWO', 1, 0, 0),
('org8', 'ECPU', 1, 0, 0),
('org9', 'VEIN', 1, 0, 0),
('police', 'San Andreas State Police', 1, 0, 0),
('slaughter', 'Rzeznik', 1, 0, 0),
('taxi', 'Taxi Casino Royale', 1, 0, 0),
('unemployed', 'Bezrobotny', 1, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Na zasiłku', 300, '{}', '{}'),
(2, 'mechanik', 0, 'praktykant', 'Praktykant', 1000, '{}', '{}'),
(3, 'mechanik', 1, 'nowicjusz', 'Nowicjusz', 1500, '{}', '{}'),
(4, 'mechanik', 2, 'mechanik', 'Mechanik', 2000, '{}', '{}'),
(5, 'mechanik', 3, 'smechanik', 'Starszy Mechanik', 2500, '{}', '{}'),
(6, 'mechanik', 4, 'dmechanik', 'Doświadczony Mechanik', 3000, '{}', '{}'),
(7, 'taxi', 0, 'recrue', 'Rekrut', 750, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":400,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":158,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":12,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(8, 'taxi', 1, 'novice', 'Nowicjusz', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":400,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":158,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":12,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(9, 'taxi', 2, 'experimente', 'Zawodowiec', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":400,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":158,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":12,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(10, 'taxi', 3, 'uber', 'Zastepca Szefa', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":400,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":158,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":12,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(11, 'taxi', 4, 'boss', 'Szef', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":400,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":158,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":12,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(12, 'cardealer', 0, 'recruit', 'Nowicjusz', 1000, '{}', '{}'),
(13, 'cardealer', 1, 'novice', 'Sprzedawca', 2500, '{}', '{}'),
(14, 'cardealer', 2, 'experienced', 'Kierownik', 4000, '{}', '{}'),
(15, 'cardealer', 3, 'boss', 'Szef', 5000, '{}', '{}'),
(16, 'ambulance', 0, 'ambulance', 'Stażysta', 850, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(17, 'ambulance', 1, 'ambulance', 'Pielęgniarz', 1100, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(18, 'ambulance', 2, 'ambulance', 'Ratownik', 1600, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(19, 'ambulance', 3, 'doctor', 'Ratownik Medyczny', 2350, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(20, 'ambulance', 4, 'doctor', 'Lekarz', 2600, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(21, 'ambulance', 5, 'chief_doctor', 'Lekarz Specjalista', 2850, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(22, 'ambulance', 6, 'chief_doctor', 'Doktor', 2850, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(23, 'ambulance', 7, 'boss', 'Chirurg', 4200, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(24, 'ambulance', 8, 'boss', 'Zastępca Ordynatora', 4700, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(25, 'ambulance', 9, 'boss', 'Ordynator', 5500, '{\"tshirt_1\":19,\"tshirt_2\":1,\"torso_1\":477\"torso_2\":1,\"shoes_1\":47\"shoes_2\":1,\"pants_1\":146, \"pants_2\":0, \"arms\":85}', '{}'),
(26, 'offambulance', 0, 'ambulance', 'Stażysta', 500, '{}', '{}'),
(27, 'offambulance', 1, 'ambulance', 'Pielęgniarz', 500, '{}', '{}'),
(28, 'offambulance', 2, 'ambulance', 'Ratownik', 500, '{}', '{}'),
(29, 'offambulance', 3, 'doctor', 'Ratownik Medyczny', 500, '{}', '{}'),
(30, 'offambulance', 4, 'doctor', 'Lekarz', 500, '{}', '{}'),
(31, 'offambulance', 5, 'chief_doctor', 'Lekarz Specjalista', 500, '{}', '{}'),
(32, 'offambulance', 6, 'chief_doctor', 'Doktor', 500, '{}', '{}'),
(33, 'offambulance', 7, 'boss', 'Chirurg', 500, '{}', '{}'),
(34, 'offambulance', 8, 'boss', 'Zastępca Ordynatora', 500, '{}', '{}'),
(35, 'offambulance', 9, 'boss', 'Ordynator', 500, '{}', '{}'),
(36, 'police', 0, 'recruit', 'Cadet', 400, '{}', '{}'),
(37, 'police', 1, 'officer', 'Trooper', 650, '{}', '{}'),
(38, 'police', 2, 'officer', 'Senior Trooper', 1000, '{}', '{}'),
(39, 'police', 3, 'officer', 'Master Trooper', 1250, '{}', '{}'),
(40, 'police', 4, 'sergeant', 'Senior Sergeant', 1500, '{}', '{}'),
(41, 'police', 5, 'sergeant', 'Staff Sergeant', 1750, '{}', '{}'),
(42, 'police', 6, 'lieutenant', 'Lieutenant I', 2000, '{}', '{}'),
(43, 'police', 7, 'lieutenant', 'Lieutenant II', 2250, '{}', '{}'),
(44, 'police', 8, 'intendent', 'Captain I', 2500, '{}', '{}'),
(45, 'police', 9, 'intendent', 'Captain II', 2750, '{}', '{}'),
(46, 'police', 10, 'chief', 'Deputy Commander', 4000, '{}', '{}'),
(47, 'police', 11, 'chief', 'Commander', 4600, '{}', '{}'),
(48, 'police', 12, 'boss', 'Assistant Chief of Police', 5000, '{}', '{}'),
(49, 'police', 13, 'boss', 'Deputy Chief Of Police', 5500, '{}', '{}'),
(50, 'police', 14, 'boss', 'Chief Of Police', 6000, '{}', '{}'),
(51, 'offpolice', 0, 'recruit', 'Cadet', 400, '{}', '{}'),
(52, 'offpolice', 1, 'officer', 'Trooper', 650, '{}', '{}'),
(53, 'offpolice', 2, 'officer', 'Senior Trooper', 1000, '{}', '{}'),
(54, 'offpolice', 3, 'officer', 'Master Trooper', 1250, '{}', '{}'),
(55, 'offpolice', 4, 'sergeant', 'Senior Sergeant', 1500, '{}', '{}'),
(56, 'offpolice', 5, 'sergeant', 'Staff Sergeant', 1750, '{}', '{}'),
(57, 'offpolice', 6, 'lieutenant', 'Lieutenant I', 2000, '{}', '{}'),
(58, 'offpolice', 7, 'lieutenant', 'Lieutenant II', 2250, '{}', '{}'),
(59, 'offpolice', 8, 'lieutenant', 'Captain I', 2500, '{}', '{}'),
(60, 'offpolice', 9, 'intendent', 'Captain II', 2750, '{}', '{}'),
(61, 'offpolice', 10, 'chief', 'Deputy Commander', 4000, '{}', '{}'),
(62, 'offpolice', 11, 'chief', 'Commander', 4600, '{}', '{}'),
(63, 'offpolice', 12, 'boss', 'Assistant Chief of Police', 5000, '{}', '{}'),
(64, 'offpolice', 13, 'boss', 'Deputy Chief Of Police', 5500, '{}', '{}'),
(65, 'offpolice', 14, 'boss', 'Chief Of Police', 6000, '{}', '{}'),
(66, 'milkman', 0, 'pracownik', 'Rekrut', 750, '{}', '{}'),
(67, 'milkman', 1, 'pracownik', 'Nowicjusz', 1000, '{}', '{}'),
(68, 'milkman', 2, 'pracownik', 'Pracownik', 1500, '{}', '{}'),
(69, 'milkman', 3, 'pracownik', 'Fachowiec', 2000, '{}', '{}'),
(70, 'milkman', 4, 'pracownik', 'Zawodowiec', 2500, '{}', '{}'),
(71, 'milkman', 5, 'pracownik', 'Specjalista', 3000, '{}', '{}'),
(72, 'milkman', 6, 'boss', 'Koordynator', 4000, '{}', '{}'),
(73, 'grower', 0, 'pracownik', 'Rekrut', 750, '{}', '{}'),
(74, 'grower', 1, 'pracownik', 'Nowicjusz', 1000, '{}', '{}'),
(75, 'grower', 2, 'pracownik', 'Pracownik', 1500, '{}', '{}'),
(76, 'grower', 3, 'pracownik', 'Fachowiec', 2000, '{}', '{}'),
(77, 'grower', 4, 'pracownik', 'Zawodowiec', 2500, '{}', '{}'),
(78, 'grower', 5, 'pracownik', 'Specjalista', 3000, '{}', '{}'),
(79, 'grower', 6, 'boss', 'Koordynator', 4000, '{}', '{}'),
(80, 'fisherman', 0, 'pracownik', 'Rekrut', 750, '{}', '{}'),
(81, 'fisherman', 1, 'pracownik', 'Nowicjusz', 1200, '{}', '{}'),
(82, 'fisherman', 2, 'pracownik', 'Pracownik', 1500, '{}', '{}'),
(83, 'fisherman', 3, 'pracownik', 'Fachowiec', 2200, '{}', '{}'),
(84, 'fisherman', 4, 'pracownik', 'Zawodowiec', 2800, '{}', '{}'),
(85, 'fisherman', 5, 'pracownik', 'Specjalista', 3500, '{}', '{}'),
(86, 'fisherman', 6, 'boss', 'Koordynator', 4900, '{}', '{}'),
(87, 'baker', 0, 'pracownik', 'Rekrut', 750, '{}', '{}'),
(88, 'baker', 1, 'pracownik', 'Nowicjusz', 1200, '{}', '{}'),
(89, 'baker', 2, 'pracownik', 'Pracownik', 1500, '{}', '{}'),
(90, 'baker', 3, 'pracownik', 'Fachowiec', 2200, '{}', '{}'),
(91, 'baker', 4, 'pracownik', 'Zawodowiec', 2800, '{}', '{}'),
(92, 'baker', 5, 'pracownik', 'Specjalista', 3500, '{}', '{}'),
(93, 'baker', 6, 'boss', 'Koordynator', 4900, '{}', '{}'),
(94, 'krawiec', 0, 'pracownik', 'Rekrut', 750, '{}', '{}'),
(95, 'krawiec', 1, 'pracownik', 'Nowicjusz', 1200, '{}', '{}'),
(96, 'krawiec', 2, 'pracownik', 'Pracownik', 1500, '{}', '{}'),
(97, 'krawiec', 3, 'pracownik', 'Fachowiec', 2200, '{}', '{}'),
(98, 'krawiec', 4, 'pracownik', 'Zawodowiec', 2800, '{}', '{}'),
(99, 'krawiec', 5, 'pracownik', 'Specjalista', 3500, '{}', '{}'),
(100, 'krawiec', 6, 'boss', 'Koordynator', 4900, '{}', '{}'),
(101, 'slaughter', 0, 'pracownik', 'Rekrut', 750, '{}', '{}'),
(102, 'slaughter', 1, 'pracownik', 'Nowicjusz', 1200, '{}', '{}'),
(103, 'slaughter', 2, 'pracownik', 'Pracownik', 1500, '{}', '{}'),
(104, 'slaughter', 3, 'pracownik', 'Fachowiec', 2200, '{}', '{}'),
(105, 'slaughter', 4, 'pracownik', 'Zawodowiec', 2800, '{}', '{}'),
(106, 'slaughter', 5, 'pracownik', 'Specjalista', 3500, '{}', '{}'),
(107, 'slaughter', 6, 'boss', 'Koordynator', 4900, '{}', '{}'),
(108, 'kawiarnia', 0, 'pracownik', 'Rekrut', 750, '{}', '{}'),
(109, 'kawiarnia', 1, 'pracownik', 'Nowicjusz', 1200, '{}', '{}'),
(110, 'kawiarnia', 2, 'pracownik', 'Pracownik', 1500, '{}', '{}'),
(111, 'kawiarnia', 3, 'pracownik', 'Fachowiec', 2200, '{}', '{}'),
(112, 'kawiarnia', 4, 'pracownik', 'Zawodowiec', 2800, '{}', '{}'),
(113, 'kawiarnia', 5, 'pracownik', 'Specjalista', 3500, '{}', '{}'),
(114, 'kawiarnia', 6, 'boss', 'Koordynator', 4900, '{}', '{}'),
(115, 'org4', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(116, 'org4', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(117, 'org4', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(118, 'org4', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(119, 'org4', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(120, 'org4', 5, 'boss', 'Szef', 0, '{}', '{}'),
(121, 'org5', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(122, 'org5', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(123, 'org5', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(124, 'org5', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(125, 'org5', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(126, 'org5', 5, 'boss', 'Szef', 0, '{}', '{}'),
(127, 'org6', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(128, 'org6', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(129, 'org6', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(130, 'org6', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(131, 'org6', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(132, 'org6', 5, 'boss', 'Szef', 0, '{}', '{}'),
(133, 'org8', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(134, 'org8', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(135, 'org8', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(136, 'org8', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(137, 'org8', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(138, 'org8', 5, 'boss', 'Szef', 0, '{}', '{}'),
(139, 'org7', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(140, 'org7', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(141, 'org7', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(142, 'org7', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(143, 'org7', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(144, 'org7', 5, 'boss', 'Szef', 0, '{}', '{}'),
(145, 'org10', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(146, 'org10', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(147, 'org10', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(148, 'org10', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(149, 'org10', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(150, 'org10', 5, 'boss', 'Szef', 0, '{}', '{}'),
(151, 'org9', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(152, 'org9', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(153, 'org9', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(154, 'org9', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(155, 'org9', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(156, 'org9', 5, 'boss', 'Szef', 0, '{}', '{}'),
(157, 'org1', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(158, 'org1', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(159, 'org1', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(160, 'org1', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(161, 'org1', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(162, 'org1', 5, 'boss', 'Szef', 0, '{}', '{}'),
(163, 'org2', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(164, 'org2', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(165, 'org2', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(166, 'org2', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(167, 'org2', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(168, 'org2', 5, 'boss', 'Szef', 0, '{}', '{}'),
(169, 'org3', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(170, 'org3', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(171, 'org3', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(172, 'org3', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(173, 'org3', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(174, 'org3', 5, 'boss', 'Szef', 0, '{}', '{}'),
(175, 'org14', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(176, 'org14', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(177, 'org14', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(178, 'org14', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(179, 'org14', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(180, 'org14', 5, 'boss', 'Szef', 0, '{}', '{}'),
(181, 'org15', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(182, 'org15', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(183, 'org15', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(184, 'org15', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(185, 'org15', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(186, 'org15', 5, 'boss', 'Szef', 0, '{}', '{}'),
(187, 'org16', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(188, 'org16', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(189, 'org16', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(190, 'org16', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(191, 'org16', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(192, 'org16', 5, 'boss', 'Szef', 0, '{}', '{}'),
(193, 'org19', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(194, 'org19', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(195, 'org19', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(196, 'org19', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(197, 'org19', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(198, 'org19', 5, 'boss', 'Szef', 0, '{}', '{}'),
(199, 'org13', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(200, 'org13', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(201, 'org13', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(202, 'org13', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(203, 'org13', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(204, 'org13', 5, 'boss', 'Szef', 0, '{}', '{}'),
(205, 'org17', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(206, 'org17', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(207, 'org17', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(208, 'org17', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(209, 'org17', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(210, 'org17', 5, 'boss', 'Szef', 0, '{}', '{}'),
(211, 'org11', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(212, 'org11', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(213, 'org11', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(214, 'org11', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(215, 'org11', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(216, 'org11', 5, 'boss', 'Szef', 0, '{}', '{}'),
(217, 'org20', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(218, 'org20', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(219, 'org20', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(220, 'org20', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(221, 'org20', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(222, 'org20', 5, 'boss', 'Szef', 0, '{}', '{}'),
(223, 'org18', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(224, 'org18', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(225, 'org18', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(226, 'org18', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(227, 'org18', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(228, 'org18', 5, 'boss', 'Szef', 0, '{}', '{}'),
(229, 'org12', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(230, 'org12', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(231, 'org12', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(232, 'org12', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(233, 'org12', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(234, 'org12', 5, 'boss', 'Szef', 0, '{}', '{}'),
(235, 'org25', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(236, 'org25', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(237, 'org25', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(238, 'org25', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(239, 'org25', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(240, 'org25', 5, 'boss', 'Szef', 0, '{}', '{}'),
(241, 'org28', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(242, 'org28', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(243, 'org28', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(244, 'org28', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(245, 'org28', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(246, 'org28', 5, 'boss', 'Szef', 0, '{}', '{}'),
(247, 'org27', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(248, 'org27', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(249, 'org27', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(250, 'org27', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(251, 'org27', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(252, 'org27', 5, 'boss', 'Szef', 0, '{}', '{}'),
(253, 'org29', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(254, 'org29', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(255, 'org29', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(256, 'org29', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(257, 'org29', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(258, 'org29', 5, 'boss', 'Szef', 0, '{}', '{}'),
(259, 'org26', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(260, 'org26', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(261, 'org26', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(262, 'org26', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(263, 'org26', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(264, 'org26', 5, 'boss', 'Szef', 0, '{}', '{}'),
(265, 'org21', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(266, 'org21', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(267, 'org21', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(268, 'org21', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(269, 'org21', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(270, 'org21', 5, 'boss', 'Szef', 0, '{}', '{}'),
(271, 'org30', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(272, 'org30', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(273, 'org30', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(274, 'org30', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(275, 'org30', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(276, 'org30', 5, 'boss', 'Szef', 0, '{}', '{}'),
(277, 'org22', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(278, 'org22', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(279, 'org22', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(280, 'org22', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(281, 'org22', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(282, 'org22', 5, 'boss', 'Szef', 0, '{}', '{}'),
(283, 'org24', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(284, 'org24', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(285, 'org24', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(286, 'org24', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(287, 'org24', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(288, 'org24', 5, 'boss', 'Szef', 0, '{}', '{}'),
(289, 'org23', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(290, 'org23', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(291, 'org23', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(292, 'org23', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(293, 'org23', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(294, 'org23', 5, 'boss', 'Szef', 0, '{}', '{}'),
(295, 'org37', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(296, 'org37', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(297, 'org37', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(298, 'org37', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(299, 'org37', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(300, 'org37', 5, 'boss', 'Szef', 0, '{}', '{}'),
(301, 'org36', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(302, 'org36', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(303, 'org36', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(304, 'org36', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(305, 'org36', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(306, 'org36', 5, 'boss', 'Szef', 0, '{}', '{}'),
(307, 'org40', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(308, 'org40', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(309, 'org40', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(310, 'org40', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(311, 'org40', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(312, 'org40', 5, 'boss', 'Szef', 0, '{}', '{}'),
(313, 'org39', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(314, 'org39', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(315, 'org39', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(316, 'org39', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(317, 'org39', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(318, 'org39', 5, 'boss', 'Szef', 0, '{}', '{}'),
(319, 'org38', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(320, 'org38', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(321, 'org38', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(322, 'org38', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(323, 'org38', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(324, 'org38', 5, 'boss', 'Szef', 0, '{}', '{}'),
(325, 'org35', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(326, 'org35', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(327, 'org35', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(328, 'org35', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(329, 'org35', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(330, 'org35', 5, 'boss', 'Szef', 0, '{}', '{}'),
(331, 'org33', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(332, 'org33', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(333, 'org33', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(334, 'org33', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(335, 'org33', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(336, 'org33', 5, 'boss', 'Szef', 0, '{}', '{}'),
(337, 'org31', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(338, 'org31', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(339, 'org31', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(340, 'org31', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(341, 'org31', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(342, 'org31', 5, 'boss', 'Szef', 0, '{}', '{}'),
(343, 'org34', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(344, 'org34', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(345, 'org34', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(346, 'org34', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(347, 'org34', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(348, 'org34', 5, 'boss', 'Szef', 0, '{}', '{}'),
(349, 'org32', 0, 'prospect', 'Rekrut', 0, '{}', '{}'),
(350, 'org32', 1, 'enforcer', 'Zolnierz', 0, '{}', '{}'),
(351, 'org32', 2, 'lieutenant', 'Sierzant', 0, '{}', '{}'),
(352, 'org32', 3, 'vicepresident', 'Kapitan', 0, '{}', '{}'),
(353, 'org32', 4, 'boss', 'Podszef', 0, '{}', '{}'),
(354, 'org32', 5, 'boss', 'Szef', 0, '{}', '{}'),
(355, 'fisherman', 7, 'boss', 'Szef', 5500, '{}', '{}'),
(356, 'baker', 7, 'boss', 'Szef', 5500, '{}', '{}'),
(357, 'kawiarnia', 7, 'boss', 'Szef', 5500, '{}', '{}'),
(358, 'milkman', 7, 'boss', 'Szef', 5500, '{}', '{}'),
(359, 'slaughter', 7, 'boss', 'Szef', 5500, '{}', '{}'),
(360, 'krawiec', 7, 'boss', 'Szef', 5500, '{}', '{}'),
(361, 'grower', 7, 'boss', 'Szef', 5500, '{}', '{}'),
(362, 'kawiarnia', 7, 'boss', 'Szef', 4900, '{}', '{}'),
(363, 'mechanik', 5, 'boss', 'Koordynator', 3500, '{}', '{}'),
(364, 'mechanik', 6, 'boss', 'Menadżer Mechaników', 4000, '{}', '{}'),
(365, 'mechanik', 7, 'boss', 'Zastępca Szefa', 4500, '{}', '{}'),
(366, 'mechanik', 8, 'boss', 'Szef', 5000, '{}', '{}');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('aiad', 'AIAD'),
('dmv', 'Test teoretyczny'),
('drive', 'Prawo jazdy kat. B'),
('drive_bike', 'Prawo jazdy kat. A'),
('drive_truck', 'Prawo jazdy kat. C'),
('dtu', 'DTU'),
('eagle', 'Eagle'),
('ems_insurance', 'Ubezpieczenie Zdrowotne'),
('heli', 'HELI'),
('oc_insurance', 'Ubezpieczenie na Pojazd'),
('sert', 'SERT'),
('seu', 'SEU'),
('swat', 'SWAT'),
('usms', 'USMS'),
('weapon', 'Licencja na broń'),
('wmk2', 'Pozwolenie na broń MK2');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lscmtablet_history`
--

CREATE TABLE `lscmtablet_history` (
  `owner` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `surname` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `treatment` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `price` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `date` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `doctor` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lspd_mdc_judgments_suggestion`
--

CREATE TABLE `lspd_mdc_judgments_suggestion` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `length` int(11) NOT NULL,
  `fee` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `showName` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Zrzut danych tabeli `lspd_mdc_judgments_suggestion`
--

INSERT INTO `lspd_mdc_judgments_suggestion` (`id`, `name`, `description`, `length`, `fee`, `categoryId`, `showName`) VALUES
(1, 'Zabójstwo', '', 75, 100000, 1, NULL),
(2, 'Próba zabójstwa', '', 25, 35000, 1, NULL),
(3, 'Grożenie pozbawieniem życia lub zdrowia', '', 20, 20000, 1, NULL),
(4, 'Nieumyślne spowodowanie uszczerbku na zdrowiu', '', 5, 10000, 1, NULL),
(5, 'Umyślne spowodowanie uszczerbku na zdrowiu', '', 15, 20000, 1, NULL),
(6, 'Dystrybucja broni palnej', '', 20, 20000, 2, NULL),
(7, 'Posiadanie broni nielegalnej klasy 1', '', 15, 25000, 2, NULL),
(8, 'Posiadanie broni nielegalnej klasy 2', '', 25, 45000, 2, NULL),
(9, 'Posiadanie broni nielegalnej klasy 3', '', 40, 75000, 2, NULL),
(10, 'Bezpodstawne użycie broni palnej', '', 15, 25000, 2, NULL),
(11, 'Groźby bronią białą\\palna', '', 10, 20000, 2, NULL),
(12, 'Przestępstwa związane z narkotykami', '', 15, 15000, 3, NULL),
(13, 'Produkcja narkotyków', '', 15, 20000, 3, NULL),
(14, 'Dystrybucja narkotyków', '', 20, 25000, 3, NULL),
(15, 'Posiadanie narkotyków', '', 15, 20000, 3, NULL),
(16, 'Naruszenie nietykalności cielesnej', '', 10, 2500, 4, NULL),
(18, 'Napad na bank', '', 50, 55000, 4, NULL),
(19, 'Przywłaszczenie cudzego mienia', '', 5, 10000, 4, NULL),
(20, 'Porwanie', '', 20, 20000, 4, NULL),
(21, 'Prowokacja policji', '', 10, 10000, 4, NULL),
(22, 'Ucieczka', '', 15, 30000, 4, NULL),
(23, 'Posiadanie sprzętu Policyjnego', '', 5, 15000, 4, NULL),
(24, 'Kasetka', '', 10, 10000, 4, NULL),
(25, 'Napad na sklep', '', 15, 20000, 4, NULL),
(26, 'Spożywanie alkoholu w miejscu publicznym', '', 0, 1000, 4, NULL),
(27, 'Napasc na FP', '', 10, 15000, 4, NULL),
(28, 'Porwanie lub usiłowanie porwania policjanta', '', 15, 25000, 4, NULL),
(29, 'Próba zabójstwa Funkcjonariusza Policji ', '', 20, 50000, 4, NULL),
(30, 'Zabójstwo Funkcjonariusza Policji', '', 50, 150000, 4, NULL),
(31, 'Fałszywe zgłoszenie', '', 0, 10000, 5, NULL),
(32, 'Podszywanie się pod funkcjonariuszy publicznych', '', 20, 50000, 5, NULL),
(33, 'Posiadanie brudnych pieniędzy', '', 20, 50000, 5, NULL),
(34, 'Składanie fałszywych zeznań', '', 10, 30000, 5, NULL),
(35, 'Niszczenie cudzej własności', '', 0, 10000, 5, NULL),
(36, 'Działanie w zorganizowanej grupie przestępczej', '', 100, 500000, 5, NULL),
(37, 'Kradzież pojazdu ', 'Kradzież pojazdu ', 0, 15000, 5, NULL),
(38, 'Podżeganie do popełnienia przestępstwa', '', 5, 1500, 5, NULL),
(39, 'Wykonywanie pracy adwokata bez licencji', '', 10, 25000, 5, NULL),
(40, 'Niszczenie mienia publicznego', '', 5, 15000, 6, NULL),
(41, 'Niewykonowynie poleceń funkcjonariuszy', '', 5, 10000, 6, NULL),
(42, 'Obraza funkcjonariuszy', '', 0, 20000, 6, NULL),
(43, 'Zakłócanie porządku publicznego', '', 0, 4000, 6, NULL),
(44, 'Obnażanie się', '', 0, 3500, 6, NULL),
(45, 'Utrudnianie pracy służbom publicznym', '', 0, 25000, 6, NULL),
(46, 'Nieustępowanie pierwsz. poj. uprzywilejowanemu', '', 0, 10000, 7, NULL),
(47, 'Brawurowa Jazda', '', 0, 6000, 7, NULL),
(48, 'Wymuszanie pierwszeństwa', '', 0, 1000, 7, NULL),
(49, 'Przechodzenie przez jezdnię w miejscu niewyznaczonym', '', 0, 500, 7, NULL),
(50, 'Nielegalna kolumna', '', 10, 10000, 7, NULL),
(51, 'Przekroczenie prędkości w mieście od 50 - 100 km/h', '', 0, 2000, 7, NULL),
(52, 'Przekroczenie prędkości w mieście powyżej 100 km/h', '', 0, 7500, 7, NULL),
(53, 'Przekroczenie prędkości poza miastem powyżej 100 km/h', '', 0, 2500, 7, NULL),
(54, 'Agresywna jazda', '', 0, 5000, 7, NULL),
(71, 'Pomoc w ucieczce (konwój)', '', 15, 25000, 4, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lspd_mdc_judgments_suggestion_category`
--

CREATE TABLE `lspd_mdc_judgments_suggestion_category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Zrzut danych tabeli `lspd_mdc_judgments_suggestion_category`
--

INSERT INTO `lspd_mdc_judgments_suggestion_category` (`id`, `name`, `color`) VALUES
(1, 'Przestępstwa związane z pozbawieniem życia', NULL),
(2, 'Przestępstwa związane z posiadaniem broni', NULL),
(3, 'Przestępstwa związane z narkotykami', NULL),
(4, 'Główne przestępstwa', NULL),
(5, 'Inne przestępstwa', NULL),
(6, 'Wykroczenia', NULL),
(7, 'Przewinienia ruchu drogowego', NULL),
(8, 'Wykroczenia związane z bezpieczeństwem ruchu lotniczego', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lspd_mdc_tag_suggestion`
--

CREATE TABLE `lspd_mdc_tag_suggestion` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lspd_mdc_user_notes`
--

CREATE TABLE `lspd_mdc_user_notes` (
  `id` int(11) NOT NULL,
  `userId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `addedBy` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lspd_mdc_vehicle_notes`
--

CREATE TABLE `lspd_mdc_vehicle_notes` (
  `id` int(11) NOT NULL,
  `vehicleId` int(11) NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `addedBy` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lspd_odznaki`
--

CREATE TABLE `lspd_odznaki` (
  `identifier` varchar(55) NOT NULL,
  `nrodznaki` varchar(255) DEFAULT NULL,
  `jednostka` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lspd_user_judgments`
--

CREATE TABLE `lspd_user_judgments` (
  `id` int(11) NOT NULL,
  `userId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `crimes` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `note` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL,
  `addedBy` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `length` int(11) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `owned_properties`
--

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL,
  `shared` varchar(60) DEFAULT NULL,
  `arleady_owned` int(11) NOT NULL DEFAULT 0,
  `co_owner1` varchar(60) DEFAULT NULL,
  `co_owner2` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `id` int(11) NOT NULL,
  `owner` varchar(51) COLLATE utf8mb4_bin NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `owner_type` int(11) NOT NULL DEFAULT 1,
  `state` int(11) NOT NULL DEFAULT 0,
  `plate` varchar(12) COLLATE utf8mb4_bin NOT NULL,
  `vehicleid` int(11) DEFAULT NULL,
  `strefa` int(11) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Zrzut danych tabeli `phone_messages`
--

INSERT INTO `phone_messages` (`id`, `transmitter`, `receiver`, `message`, `time`, `isRead`, `owner`) VALUES
(1, '2133', '34572', '.', '2022-04-22 12:06:34', 1, 1),
(2, '2133', '34572', 'https://questionable.link/5ub2oaLK1.jpeg', '2022-04-22 12:06:37', 1, 1),
(3, '2133', '34572', 'https://questionable.link/5ub2qQvoz.jpeg', '2022-04-22 12:06:47', 1, 1),
(4, '2133', '34572', 'https://questionable.link/5ub2uizlS.jpeg', '2022-04-22 12:07:01', 1, 1),
(5, '2133', '34572', 'https://questionable.link/5ub2yiaQH.jpeg', '2022-04-22 12:07:15', 1, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `ownernumber` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `owned` int(11) DEFAULT 0,
  `free` int(11) NOT NULL DEFAULT 0,
  `garage` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `properties`
--

INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`, `owned`, `free`, `garage`) VALUES
(3, 'Motel-LepszaMelina1', 'Dom 1', '{\"x\":1142.1,\"y\":2654.68,\"z\":38.15}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1139.9,\"y\":2654.66,\"z\":38.0}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(4, 'Motel-LepszaMelina2', 'Dom 2', '{\"x\":1142.15,\"y\":2651.12,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1140.39,\"y\":2651.26,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(5, 'Motel-LepszaMelina3', 'Dom 3', '{\"x\":1142.04,\"y\":2643.65,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1140.46,\"y\":2644.18,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(6, 'Motel-LepszaMelina4', 'Dom 4', '{\"x\":1141.13,\"y\":2642.09,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1140.46,\"y\":2644.18,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(7, 'Motel-LepszaMelina5', 'Dom 5', '{\"x\":1136.27,\"y\":2642.03,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1136.45,\"y\":2643.69,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(9, 'Motel-LepszaMelina7', 'Dom 7', '{\"x\":1125.27,\"y\":2642.24,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1125.32,\"y\":2643.87,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(10, 'Motel-LepszaMelina8', 'Dom 8', '{\"x\":1121.43,\"y\":2642.32,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1121.48,\"y\":2643.92,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(11, 'Motel-LepszaMelina9', 'Dom 9', '{\"x\":1114.69,\"y\":2642.42,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1114.85,\"y\":2643.96,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(12, 'Motel-LepszaMelina10', 'Dom 10', '{\"x\":1107.23,\"y\":2642.46,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1107.63,\"y\":2644.1,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(13, 'Motel-LepszaMelina11', 'Dom 11', '{\"x\":1107.13,\"y\":2649.02,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1108.5,\"y\":2649.08,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(14, 'Motel-LepszaMelina12', 'Dom 12', '{\"x\":1107.07,\"y\":2652.81,\"z\":38.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1108.51,\"y\":2653.94,\"z\":38.14}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(15, 'Motel-LepszaMelina13', 'Dom 13', '{\"x\":980.36,\"y\":2667.57,\"z\":40.06}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":980.36,\"y\":2669.57,\"z\":40.06}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(16, 'Motel-LepszaMelina14', 'Dom 14', '{\"x\":471.18,\"y\":2607.75,\"z\":44.48}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":470.56,\"y\":2611.06,\"z\":43.27}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(17, 'Motel-LepszaMelina15', 'Dom 15', '{\"x\":346.51,\"y\":2619.05,\"z\":44.69}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":346.51,\"y\":2620.12,\"z\":44.54}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(18, 'Motel-LepszaMelina16', 'Dom 16', '{\"x\":341.19,\"y\":2615.96,\"z\":44.66}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":340.41,\"y\":2617.26,\"z\":44.54}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(19, 'Motel-LepszaMelina17', 'Dom 17', '{\"x\":353.91,\"y\":2620.52,\"z\":44.67}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":352.18,\"y\":2621.89,\"z\":44.55}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(20, 'Motel-LepszaMelina18', 'Dom 18', '{\"x\":359.3,\"y\":2623.62,\"z\":44.69}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":359.3,\"y\":2624.98,\"z\":44.53}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(21, 'Motel-LepszaMelina19', 'Dom 19', '{\"x\":366.71,\"y\":2625.12,\"z\":44.67}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":365.89,\"y\":2626.64,\"z\":44.55}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(22, 'Motel-LepszaMelina20', 'Dom 20', '{\"x\":372.25,\"y\":2628.13,\"z\":44.69}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":372.25,\"y\":2629.18,\"z\":27.96}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(23, 'Motel-LepszaMelina21', 'Dom 21', '{\"x\":379.46,\"y\":2629.97,\"z\":44.67}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":379.97,\"y\":2630.80,\"z\":44.63}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(24, 'Motel-LepszaMelina22', 'Dom 22', '{\"x\":384.79,\"y\":2633.12,\"z\":44.69}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":384.3,\"y\":2634.2,\"z\":44.63}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(25, 'Motel-LepszaMelina23', 'Dom 23', '{\"x\":392.07,\"y\":2634.8,\"z\":44.67}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":392.07,\"y\":2635.7,\"z\":44.61}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(26, 'Motel-LepszaMelina24', 'Dom 24', '{\"x\":397.53,\"y\":2637.93,\"z\":44.69}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":397.53,\"y\":2639,\"z\":44.62}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(27, 'Motel-LepszaMelina25', 'Dom 25', '{\"x\":35.27,\"y\":6662.82,\"z\":32.19}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":34.57,\"y\":6660.63,\"z\":31.72}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(28, 'Motel-LepszaMelina26', 'Dom 26', '{\"x\":499.62,\"y\":2606.49,\"z\":43.07}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":506.58,\"y\":2612.0,\"z\":42.96}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(29, 'Motel-LepszaMelina27', 'Dom 27', '{\"x\":-9.46,\"y\":6654.09,\"z\":31.48}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-8.67,\"y\":6652.16,\"z\":31.11}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(30, 'Motel-LepszaMelina28', 'Dom 28', '{\"x\":1.55,\"y\":6612.53,\"z\":32.08}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":0.28,\"y\":6615.39,\"z\":31.47}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(31, 'Motel-LepszaMelina29', 'Dom 29', '{\"x\":-41.17,\"y\":6636.99,\"z\":31.09}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-38.43,\"y\":6635.14,\"z\":30.32}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(33, 'Motel-LepszaMelina31', 'Dom 30', '{\"x\":-130.74,\"y\":6551.91,\"z\":29.87}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-129.43,\"y\":6550.66,\"z\":29.52}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(34, 'Motel-LepszaMelina32', 'Dom 31', '{\"x\":403.9,\"y\":2584.31,\"z\":43.52}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":401.44,\"y\":2584.41,\"z\":43.52}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(35, 'Motel-LepszaMelina33', 'Dom 32', '{\"x\":-105.58,\"y\":6528.76,\"z\":30.17}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-106.86,\"y\":6530.41,\"z\":29.86}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(36, 'Motel-LepszaMelina34', 'Dom 33', '{\"x\":382.48,\"y\":2576.49,\"z\":44.32}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":380.19,\"y\":2576.23,\"z\":43.52}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(37, 'Motel-LepszaMelina35', 'Dom 34', '{\"x\":366.8,\"y\":2571.27,\"z\":44.32}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":363.45,\"y\":2570.8,\"z\":43.52}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(38, 'Motel-LepszaMelina36', 'Dom 35', '{\"x\":-229.98,\"y\":6444.98,\"z\":31.2}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-230.91,\"y\":6444.98,\"z\":31.2}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(39, 'Motel-LepszaMelina37', 'Dom 36', '{\"x\":348.18,\"y\":2565.57,\"z\":43.52}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":345.79,\"y\":2565.62,\"z\":43.52}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(40, 'Motel-LepszaMelina38', 'Dom 37', '{\"x\":-167.41,\"y\":6439.17,\"z\":31.92}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-168.24,\"y\":-6438.25,\"z\":31.92}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(41, 'Motel-LepszaMelina39', 'Dom 38', '{\"x\":201.24,\"y\":2442.26,\"z\":60.45}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":206.38,\"y\":2441.15,\"z\":58.89}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(42, 'Motel-LepszaMelina40', 'Dom 39', '{\"x\":-160.24,\"y\":6432.2,\"z\":31.92}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-161.17,\"y\":6431.65,\"z\":31.92}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(43, 'Motel-LepszaMelina41', 'Dom 40', '{\"x\":-43.87,\"y\":1960.1,\"z\":190.35}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-45.08,\"y\":1961.91,\"z\":190.07}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(44, 'Motel-LepszaMelina42', 'Dom 41', '{\"x\":-150.16,\"y\":6422.23,\"z\":31.92}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-150.73,\"y\":6421.69,\"z\":31.92}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(45, 'Motel-LepszaMelina43', 'Dom 42', '{\"x\":-150.73,\"y\":6416.87,\"z\":31.92}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-151.64,\"y\":6417.7,\"z\":31.92}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(46, 'Motel-LepszaMelina44', 'Dom 43', '{\"x\":-263.74,\"y\":2196.45,\"z\":130.4}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-260.44,\"y\":2194.4,\"z\":129.9}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(47, 'Motel-LepszaMelina45', 'Dom 44', '{\"x\":-157.51,\"y\":6409.67,\"z\":31.92}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-158.35,\"y\":6410.51,\"z\":31.92}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(48, 'Motel-LepszaMelina46', 'Dom 45', '{\"x\":-35.66,\"y\":2871.12,\"z\":59.6}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-37.63,\"y\":2867.88,\"z\":59.15}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(49, 'Motel-LepszaMelina47', 'Dom 46', '{\"x\":-189.01,\"y\":6409.72,\"z\":32.3}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-190.16,\"y\":6411.17,\"z\":31.91}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(50, 'Motel-LepszaMelina48', 'Dom 47', '{\"x\":194.98,\"y\":3030.99,\"z\":43.89}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":198.18,\"y\":3031.35,\"z\":43.59}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(51, 'Motel-LepszaMelina49', 'Dom 48', '{\"x\":-214.14,\"y\":6396.59,\"z\":33.09}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-217.61,\"y\":6398.85,\"z\":31.68}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(52, 'Motel-LepszaMelina50', 'Dom 49', '{\"x\":191.29,\"y\":3082.04,\"z\":43.47}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":194.26,\"y\":3082.16,\"z\":43.02}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(53, 'Motel-LepszaMelina51', 'Dom 50', '{\"x\":-238.09,\"y\":6423.29,\"z\":31.46}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-237.34,\"y\":6422.45,\"z\":31.18}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(54, 'Motel-LepszaMelina52', 'Dom 51', '{\"x\":241.68,\"y\":3107.94,\"z\":42.49}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":238.09,\"y\":3108.02,\"z\":42.41}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(55, 'Motel-LepszaMelina53', 'Dom 52', '{\"x\":-227.88,\"y\":6378.24,\"z\":31.76}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-229.14,\"y\":6379.41,\"z\":31.56}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(56, 'Motel-LepszaMelina54', 'Dom 53', '{\"x\":259.94,\"y\":3176.53,\"z\":42.75}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":263.36,\"y\":3176.02,\"z\":42.6}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(57, 'Motel-LepszaMelina55', 'Dom 54', '{\"x\":361.71,\"y\":2977.02,\"z\":41.84}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":359.03,\"y\":2975.61,\"z\":40.94}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(58, 'Motel-LepszaMelina56', 'Dom 55', '{\"x\":-246.23,\"y\":6414.21,\"z\":31.46}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-247.45,\"y\":6413.39,\"z\":31.19}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(59, 'Motel-LepszaMelina57', 'Dom 56', '{\"x\":412.47,\"y\":2965.08,\"z\":41.89}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":409.9,\"y\":2965.01,\"z\":41.89}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(60, 'Motel-LepszaMelina58', 'Dom 57', '{\"x\":436.26,\"y\":2996.22,\"z\":41.28}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":429.36,\"y\":2993.69,\"z\":40.95}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 450000, 0, 0, ''),
(61, 'Motel-LepszaMelina59', 'Dom 58', '{\"x\":-272.21,\"y\":6400.62,\"z\":31.5}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-271.39,\"y\":6399.09,\"z\":31.34}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(62, 'Motel-LepszaMelina60', 'Dom 59', '{\"x\":-248.03,\"y\":6370.27,\"z\":31.85}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-249.23,\"y\":6370.73,\"z\":31.48}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(63, 'Motel-LepszaMelina61', 'Dom 60', '{\"x\":524.49,\"y\":3080.52,\"z\":40.66}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":522.97,\"y\":3077.53,\"z\":40.28}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(64, 'Motel-LepszaMelina62', 'Dom 61', '{\"x\":508.78,\"y\":3100.06,\"z\":41.31}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":506.78,\"y\":3099.65,\"z\":41.31}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(65, 'Motel-LepszaMelina63', 'Dom 62', '{\"x\":-280.67,\"y\":6351.01,\"z\":32.6}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":280.67,\"y\":6351.42,\"z\":32.49}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(66, 'Motel-LepszaMelina64', 'Dom 63', '{\"x\":848.23,\"y\":2864.02,\"z\":58.49}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":851.79,\"y\":2857.95,\"z\":58.39}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(67, 'Motel-LepszaMelina65', 'Dom 64', '{\"x\":-302.8,\"y\":6327.59,\"z\":32.89}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-303.30,\"y\":6328.86,\"z\":32.49}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(68, 'Motel-LepszaMelina66', 'Dom 65', '{\"x\":858.9,\"y\":2877.46,\"z\":57.98}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":866.7,\"y\":2878.48,\"z\":57.88}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(69, 'Motel-LepszaMelina67', 'Dom 66', '{\"x\":-364.74,\"y\":6337.28,\"z\":29.85}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-365.42,\"y\":6339.37,\"z\":39.85}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(70, 'Motel-LepszaMelina68', 'Dom 67', '{\"x\":890.81,\"y\":2854.73,\"z\":57.0}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":888.99,\"y\":2854.16,\"z\":57.0}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(71, 'Motel-LepszaMelina69', 'Dom 68', '{\"x\":722.38,\"y\":2330.76,\"z\":51,75}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":721.72,\"y\":2335.59,\"z\":50.18}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(72, 'Motel-LepszaMelina70', 'Dom 69', '{\"x\":-333.07,\"y\":6302.51,\"z\":33.09}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-335,\"y\":6304.86,\"z\":32.49}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(73, 'Motel-LepszaMelina71', 'Dom 70', '{\"x\":791.53,\"y\":2176.56,\"z\":52.65}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":792.56,\"y\":2178.89,\"z\":52.65}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(74, 'Motel-LepszaMelina72', 'Dom 71', '{\"x\":-407.14,\"y\":6313.78,\"z\":28.94}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-405.51,\"y\":6321.92,\"z\":28.95}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(75, 'Motel-LepszaMelina73', 'Dom 72', '{\"x\":-379.72,\"y\":6253.02,\"z\":31.85}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-379.12,\"y\":6254.68,\"z\":31.54}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(76, 'Motel-LepszaMelina74', 'Dom 73', '{\"x\":1400.76,\"y\":2169.98,\"z\":97.89}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1403.3,\"y\":2169.56,\"z\":97.77}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(77, 'Motel-LepszaMelina75', 'Dom 74', '{\"x\":-359.95,\"y\":6260.86,\"z\":31.86}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-358.55,\"y\":6261.78,\"z\":31.49}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(78, 'Motel-LepszaMelina76', 'Dom 75', '{\"x\":1535.81,\"y\":2232.05,\"z\":77.7}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1528.59,\"y\":2232.47,\"z\":75.64}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(79, 'Motel-LepszaMelina77', 'Dom 76', '{\"x\":1586.19,\"y\":2906.93,\"z\":57.97}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1584.05,\"y\":2905.45,\"z\":56.91}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(80, 'Motel-LepszaMelina79', 'Dom 77', '{\"x\":-451.04,\"y\":6269.86,\"z\":30.04}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-452.71,\"y\":6265.8,\"z\":30.04}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(81, 'Motel-LepszaMelina79', 'Dom 78', '{\"x\":2588.4,\"y\":3167.77,\"z\":51.37}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2591.3,\"y\":3169.36,\"z\":50.95}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(82, 'Motel-LepszaMelina80', 'Dom 79', '{\"x\":-454.71,\"y\":6197.61,\"z\":29.55}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-453.75,\"y\":6200.2,\"z\":29.55}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(83, 'Motel-LepszaMelina81', 'Dom 80', '{\"x\":2632.36,\"y\":3257.86,\"z\":55.46}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2635.26,\"y\":3259.7,\"z\":55.25}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(84, 'Motel-LepszaMelina82', 'Dom 81', '{\"x\":-374.13,\"y\":6190.6,\"z\":31.73}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-372.49\"y\":6189.24,\"z\":31.54}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(85, 'Motel-LepszaMelina83', 'Dom 82', '{\"x\":-356.6,\"y\":6207.33,\"z\":31.84}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-355.94,\"y\":6206.67,\"z\":31.49}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(86, 'Motel-LepszaMelina84', 'Dom 83', '{\"x\":2618.26,\"y\":3275.38,\"z\":55.74}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2620.66,\"y\":3273.57,\"z\":55.25}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(87, 'Motel-LepszaMelina85', 'Dom 84', '{\"x\":-347.14,\"y\":6224.99,\"z\":31.88}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-346.52,\"y\":6223.85,\"z\":31.5}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(88, 'Motel-LepszaMelina86', 'Dom 85', '{\"x\":2634.47,\"y\":3292.11,\"z\":55.73}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2632.23,\"y\":3289.01,\"z\":55.25}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(89, 'Motel-LepszaMelina87', 'Dom 86', '{\"x\":2200.57,\"y\":3318.03,\"z\":47.05}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2202.33,\"y\":3319.18,\"z\":46.18}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(90, 'Motel-LepszaMelina88', 'Dom 87', '{\"x\":2175.21,\"y\":3322.22,\"z\":46.47}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2176.52,\"y\":3319.89,\"z\":45.97}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(91, 'Motel-LepszaMelina89', 'Dom 88', '{\"x\":2166.16,\"y\":3379.98,\"z\":46.43}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2162.76,\"y\":3374.87,\"z\":46.46}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(92, 'Motel-LepszaMelina90', 'Dom 89', '{\"x\":2179.17,\"y\":3496.45,\"z\":46.01}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2177.12,\"y\":3498.95,\"z\":45.46}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(93, 'Motel-LepszaMelina91', 'Dom 90', '{\"x\":1932.86,\"y\":3804.99,\"z\":32.91}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1929.23,\"y\":3803.64,\"z\":32.04}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(94, 'Motel-LepszaMelina92', 'Dom 91', '{\"x\":-15.08,\"y\":6557.76,\"z\":33.24}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-12.6,\"y\":6560.26,\"z\":31.97}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(95, 'Motel-LepszaMelina93', 'Dom 92', '{\"x\":1925.01,\"y\":3824.68,\"z\":32.44}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1916.52,\"y\":3823.83,\"z\":32.44}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(96, 'Motel-LepszaMelina94', 'Dom 93', '{\"x\":4.23,\"y\":6568.19,\"z\":33.08}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":3.13,\"y\":6566.5,\"z\":32.79}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(97, 'Motel-LepszaMelina95', 'Dom 94', '{\"x\":1902.32,\"y\":3866.98,\"z\":33.07}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1907.94,\"y\":3870.12,\"z\":32.89}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(98, 'Motel-LepszaMelina96', 'Dom 95', '{\"x\":31.19,\"y\":6596.55,\"z\":32.82}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":32.25,\"y\":6595.99,\"z\":32.47}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(99, 'Motel-LepszaMelina97', 'Dom 96', '{\"x\":1895.48,\"y\":3873.49,\"z\":32.58}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1899.07,\"y\":3875.84,\"z\":32.75}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(100, 'Motel-LepszaMelina98', 'Dom 97', '{\"x\":1936.59,\"y\":3891.74,\"z\":32.97}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1937.08,\"y\":3889.44,\"z\":32.4}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(101, 'Motel-LepszaMelina99', 'Dom 98', '{\"x\":1915.79,\"y\":3909.33,\"z\":33.44}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1915.84,\"y\":3905.87,\"z\":32.72}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(102, 'Motel-LepszaMelina100', 'Dom 99', '{\"x\":1880.42,\"y\":3920.69,\"z\":33.21}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1876.77,\"y\":3919.98,\"z\":33.1}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(103, 'Motel-LepszaMelina101', 'Dom 100', '{\"x\":1838.66,\"y\":3907.56,\"z\":33.46}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1837.46,\"y\":3905.6,\"z\":33.23}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(104, 'Motel-LepszaMelina102', 'Dom 101', '{\"x\":1841.75,\"y\":3928.59,\"z\":33.72}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1843.65,\"y\":3926.32,\"z\":32.98}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(105, 'Motel-LepszaMelina103', 'Dom 102', '{\"x\":1808.94,\"y\":3907.98,\"z\":33.74}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1809.64,\"y\":3904.63,\"z\":33.73}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(106, 'Motel-LepszaMelina104', 'Dom 103', '{\"x\":1786.47,\"y\":3912.98,\"z\":34.91}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1786.66,\"y\":3918.12,\"z\":34.4}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(107, 'Motel-LepszaMelina105', 'Dom 104', '{\"x\":1813.57,\"y\":3854.02,\"z\":34.35}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1807.71,\"y\":3851.01,\"z\":34.35}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(108, 'Motel-LepszaMelina106', 'Dom 105', '{\"x\":1832.62,\"y\":3868.59,\"z\":34.3}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1834.47,\"y\":3863.43,\"z\":34.3}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(109, 'Motel-LepszaMelina107', 'Dom 106', '{\"x\":-3190.61,\"y\":1297.64,\"z\":19.07}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3183,\"y\":1294.5,\"z\":14.59}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(110, 'Motel-LepszaMelina108', 'Dom 107', '{\"x\":1859.36,\"y\":3865.07,\"z\":33.06}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1863.21,\"y\":3867.2,\"z\":32.95}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(111, 'Motel-LepszaMelina109', 'Dom 108', '{\"x\":-3197.42,\"y\":1274.43,\"z\":12.67}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3196.89,\"y\":1273.73,\"z\":12.67}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(112, 'Motel-LepszaMelina110', 'Dom 109', '{\"x\":-3200.2,\"y\":1232.65,\"z\":10.05}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3198.02,\"y\":1232.75,\"z\":10.05}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(113, 'Motel-LepszaMelina111', 'Dom 110', '{\"x\":1733.57,\"y\":3895.35,\"z\":35.56}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1737.93,\"y\":3898.2,\"z\":35.56}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(114, 'Motel-LepszaMelina112', 'Dom 111', '{\"x\":1728.36,\"y\":3851.7,\"z\":34.79}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1729.9,\"y\":3849.08,\"z\":34.75}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(115, 'Motel-LepszaMelina113', 'Dom 112', '{\"x\":-3193.68,\"y\":1208.88,\"z\":9.43}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3191.91,\"y\":1208.95,\"z\":9.43}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(116, 'Motel-LepszaMelina114', 'Dom 113', '{\"x\":1691.83,\"y\":3865.87,\"z\":34.91}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1688.55,\"y\":3868.56,\"z\":34.84}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(117, 'Motel-LepszaMelina115', 'Dom 114', '{\"x\":-3205.58,\"y\":1186.4,\"z\":9.66}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3203.94,\"y\":1188.69,\"z\":9.66}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(118, 'Motel-LepszaMelina116', 'Dom 115', '{\"x\":-3199.55,\"y\":1164.97,\"z\":9.65}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3197.87,\"y\":1163.39,\"z\":9.55}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(119, 'Motel-LepszaMelina117', 'Dom 116', '{\"x\":1661.24,\"y\":3820.13,\"z\":35.47}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1664.36,\"y\":3822.22,\"z\":34.8}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(120, 'Motel-LepszaMelina118', 'Dom 117', '{\"x\":-3214.62,\"y\":1149.17,\"z\":9.9}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3212.75,\"y\"1148.77,\"z\":9.9}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(121, 'Motel-LepszaMelina119', 'Dom 118', '{\"x\":1760.37,\"y\":3821.64,\"z\":34.77}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1763.79,\"y\":3823.61,\"z\":34.77}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(122, 'Motel-LepszaMelina120', 'Dom 119', '{\"x\":-3224.88,\"y\":1113.51,\"z\":10.58}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3223,\"y\":1112.76,\"z\":10.58}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(123, 'Motel-LepszaMelina121', 'Dom 120', '{\"x\":-3228.13,\"y\":1092.48,\"z\":10.76}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3226.74,\"y\":1091.5,\"z\":10.71}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(124, 'Motel-LepszaMelina122', 'Dom 121', '{\"x\":-3231.67,\"y\":1081.61,\"z\":10.81}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3229.58,\"y\":1081.53,\"z\":10.82}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(125, 'Motel-LepszaMelina123', 'Dom 122', '{\"x\":1777.46,\"y\":3800.07,\"z\":34.52}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1774.27,\"y\":3799.08,\"z\":33.96}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(126, 'Motel-LepszaMelina124', 'Dom 123', '{\"x\":-3231.91,\"y\":1067.99,\"z\":11.01}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3230.3,\"y\":1067.52,\"z\":10.96}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(127, 'Motel-LepszaMelina125', 'Dom 124', '{\"x\":1748.89,\"y\":3783.45,\"z\":34.83}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1746.12,\"y\":3788.16,\"z\":34.83}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(128, 'Motel-LepszaMelina126', 'Dom 125', '{\"x\":-3254.48,\"y\":1064.33,\"z\":11.15}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3252.88,\"y\":1063.91,\"z\":11.15}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(129, 'Motel-LepszaMelina127 ', 'Dom 126', '{\"x\":1733.63,\"y\":3808.71,\"z\":35.12}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1731.92,\"y\":3812.47,\"z\":34.66}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(130, 'Motel-LepszaMelina128', 'Dom 127', '{\"x\":-3250.57,\"y\":1027.22,\"z\":11.76}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3250.57,\"y\":1027.22,\"z\":11.76}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(131, 'Motel-LepszaMelina129', 'Dom 128', '{\"x\":1774.68,\"y\":3742.83,\"z\":34.66}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1777.28,\"y\":3738.25,\"z\":34.66}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(132, 'Motel-LepszaMelina130', 'Dom 129', '{\"x\":-3237.36,\"y\":952.81,\"z\":13.14}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3236.19,\"y\":963.16,\"z\":13.17}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(133, 'Motel-LepszaMelina131', 'Dom 130', '{\"x\":1826.65,\"y\":3729.56,\"z\":33.96}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1830.72,\"y\":3738.11,\"z\":33.96}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(134, 'Motel-LepszaMelina132', 'Dom 131', '{\"x\":-3243.21,\"y\":931.34,\"z\":17.22}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3241.64,\"y\":930.89,\"z\":17.22}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(135, 'Motel-LepszaMelina133', 'Dom 132', '{\"x\":1843.35,\"y\":3778.32,\"z\":33.59}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1840.78,\"y\":3776.46,\"z\":33.16}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(136, 'Motel-LepszaMelina134', 'Dom 133', '{\"x\":1864.27,\"y\":3790.8,\"z\":32.85}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1867.33,\"y\":3792.54,\"z\":32.72}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(137, 'Motel-LepszaMelina135', 'Dom 134', '{\"x\":-3228.85,\"y\":927.62,\"z\":13.97}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3227.3,\"y\":928.97,\"z\":13.96}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(138, 'Motel-LepszaMelina136', 'Dom 135', '{\"x\":1880.8,\"y\":3810.3,\"z\":32.78}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1884.29,\"y\":3812.54,\"z\":32.78}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(139, 'Motel-LepszaMelina137', 'Dom 136', '{\"x\":-3226.07,\"y\":911.61,\"z\":13.99}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-3224.99,\"y\":912.92,\"z\":13.99}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(140, 'Motel-LepszaMelina138', 'Dom 137', '{\"x\":1900.15,\"y\":3773.45,\"z\":32.88}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1898.91,\"y\":3781.82,\"z\":32.88}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(143, 'Motel-LepszaMelina141', 'Dom 138', '{\"x\":3311.17,\"y\":5176.31,\"z\":19.91}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":3312.68,\"y\":5175.34,\"z\":19.61}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(144, 'Motel-LepszaMelina142', 'Dom 139', '{\"x\":1725.5,\"y\":4642.34,\"z\":43.88}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1721.17,\"y\":4640.08,\"z\":43.31}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(145, 'Motel-LepszaMelina143', 'Dom 140', '{\"x\":3688.75,\"y\":4562.8,\"z\":25.18}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":3690.02,\"y\":4562.81,\"z\":25.18}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(146, 'Motel-LepszaMelina144', 'Dom 141', '{\"x\":3725.35,\"y\":4525.23,\"z\":22.47}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":3725.3,\"y\":4524.77,\"z\":22.47}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(147, 'Motel-LepszaMelina145', 'Dom 142', '{\"x\":2638.97,\"y\":4246.62,\"z\":44.77}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2639.54,\"y\":4246.36,\"z\": 44.75}\r\n', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(148, 'Motel-LepszaMelina146', 'Dom 143', '{\"x\":2567.13,\"y\":4273.85,\"z\":41.99}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2569.24,\"y\":4275.41,\"z\":41.75}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(149, 'Motel-LepszaMelina147', 'Dom 144', '{\"x\":2482.34,\"y\":3722.52,\"z\":43.92}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":2480.48,\"y\":3724.73,\"z\":43.24}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(152, 'Carson AveLowApartament79', 'Carson Ave', '{\"x\":383.40365600586,\"y\":-2006.2657470703,\"z\":24.270454406738}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":383.40365600586,\"y\":-2006.2657470703,\"z\":24.270454406738}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(153, 'Jamestown StLowApartament80', 'Jamestown St', '{\"x\":335.83441162109,\"y\":-1994.7410888672,\"z\":23.860265731812}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":335.83441162109,\"y\":-1994.7410888672,\"z\":23.860265731812}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(154, 'Jamestown StLowApartament81', 'Jamestown St', '{\"x\":337.46868896484,\"y\":-1991.8511962891,\"z\":24.091711044312}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":337.46868896484,\"y\":-1991.8511962891,\"z\":24.091711044312}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(155, 'Jamestown StLowApartament82', 'Jamestown St', '{\"x\":330.52615356445,\"y\":-2000.0477294922,\"z\":24.046085357666}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":330.52615356445,\"y\":-2000.0477294922,\"z\":24.046085357666}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(156, 'Jamestown StLowApartament83', 'Jamestown St', '{\"x\":332.28271484375,\"y\":-2018.3122558594,\"z\":22.339241027832}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":332.28271484375,\"y\":-2018.3122558594,\"z\":22.339241027832}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(157, 'Jamestown StLowApartament84', 'Jamestown St', '{\"x\":335.95648193359,\"y\":-2021.7100830078,\"z\":22.353445053101}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":335.95648193359,\"y\":-2021.7100830078,\"z\":22.353445053101}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(158, 'Jamestown StLowApartament85', 'Jamestown St', '{\"x\":343.31442260742,\"y\":-2027.8319091797,\"z\":22.348613739014}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":343.31442260742,\"y\":-2027.8319091797,\"z\":22.348613739014}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(159, 'Jamestown StLowApartament86', 'Jamestown St', '{\"x\":344.66683959961,\"y\":-2028.8187255859,\"z\":22.354291915894}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":344.66683959961,\"y\":-2028.8187255859,\"z\":22.354291915894}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(160, 'Jamestown StLowApartament87', 'Jamestown St', '{\"x\":351.8212890625,\"y\":-2034.6939697266,\"z\":22.35333442688}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":351.8212890625,\"y\":-2034.6939697266,\"z\":22.35333442688}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(161, 'Jamestown StLowApartament88', 'Jamestown St', '{\"x\":353.2809753418,\"y\":-2036.0550537109,\"z\":22.354290008545}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":353.2809753418,\"y\":-2036.0550537109,\"z\":22.354290008545}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(162, 'Carson AveLowApartament89', 'Carson Ave', '{\"x\":360.71578979492,\"y\":-2042.3269042969,\"z\":22.32578086853}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":360.71578979492,\"y\":-2042.3269042969,\"z\":22.32578086853}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(163, 'Carson AveLowApartament90', 'Carson Ave', '{\"x\":364.27310180664,\"y\":-2045.2885742188,\"z\":22.304235458374}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":364.27310180664,\"y\":-2045.2885742188,\"z\":22.304235458374}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(164, 'Dutch London StLowApartament91', 'Dutch London St', '{\"x\":345.57626342773,\"y\":-2067.6726074219,\"z\":20.938505172729}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":345.57626342773,\"y\":-2067.6726074219,\"z\":20.938505172729}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(165, 'Dutch London StLowApartament92', 'Dutch London St', '{\"x\":342.35177612305,\"y\":-2064.1850585938,\"z\":20.955694198608}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":342.35177612305,\"y\":-2064.1850585938,\"z\":20.955694198608}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(166, 'Dutch London StLowApartament93', 'Dutch London St', '{\"x\":334.72622680664,\"y\":-2058.3698730469,\"z\":20.884420394897}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":334.72622680664,\"y\":-2058.3698730469,\"z\":20.884420394897}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(167, 'Jamestown StLowApartament94', 'Jamestown St', '{\"x\":333.38208007813,\"y\":-2057.2873535156,\"z\":20.93639755249}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":333.38208007813,\"y\":-2057.2873535156,\"z\":20.93639755249}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, '');
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`, `owned`, `free`, `garage`) VALUES
(168, 'Jamestown StLowApartament95', 'Jamestown St', '{\"x\":325.86862182617,\"y\":-2050.9602050781,\"z\":20.929265975952}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":325.86862182617,\"y\":-2050.9602050781,\"z\":20.929265975952}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(169, 'Jamestown StLowApartament96', 'Jamestown St', '{\"x\":324.29385375977,\"y\":-2049.6906738281,\"z\":20.93639755249}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":324.29385375977,\"y\":-2049.6906738281,\"z\":20.93639755249}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(170, 'Jamestown StLowApartament96', 'Jamestown St', '{\"x\":316.9733581543,\"y\":-2043.4692382813,\"z\":20.933631896973}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":316.9733581543,\"y\":-2043.4692382813,\"z\":20.933631896973}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(171, 'Jamestown StLowApartament98', 'Jamestown St', '{\"x\":316.9482421875,\"y\":-2043.5344238281,\"z\":20.930603027344}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":316.9482421875,\"y\":-2043.5344238281,\"z\":20.930603027344}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(172, 'Jamestown StLowApartament99', 'Jamestown St', '{\"x\":313.13327026367,\"y\":-2040.2905273438,\"z\":20.92286491394}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":313.13327026367,\"y\":-2040.2905273438,\"z\":20.92286491394}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(173, 'Jamestown StLowApartament100', 'Jamestown St', '{\"x\":293.93231201172,\"y\":-2044.0550537109,\"z\":19.645299911499}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":293.93231201172,\"y\":-2044.0550537109,\"z\":19.645299911499}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(174, 'Jamestown StLowApartament101', 'Jamestown St', '{\"x\":290.7790222168,\"y\":-2047.1657714844,\"z\":19.682783126831}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":290.7790222168,\"y\":-2047.1657714844,\"z\":19.682783126831}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(175, 'Dutch London StLowApartament102', 'Dutch London St', '{\"x\":301.25653076172,\"y\":-2076.326171875,\"z\":17.711999893188}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":301.25653076172,\"y\":-2076.326171875,\"z\":17.711999893188}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(176, 'Dutch London StLowApartament103', 'Dutch London St', '{\"x\":302.80471801758,\"y\":-2080.5908203125,\"z\":17.704746246338}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":302.80471801758,\"y\":-2080.5908203125,\"z\":17.704746246338}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(177, 'Dutch London StLowApartament104', 'Dutch London St', '{\"x\":304.89813232422,\"y\":-2086.1220703125,\"z\":17.660192489624}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":304.89813232422,\"y\":-2086.1220703125,\"z\":17.660192489624}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(178, 'Dutch London StLowApartament105', 'Dutch London St', '{\"x\":320.36682128906,\"y\":-2100.8762207031,\"z\":18.203077316284}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":320.36682128906,\"y\":-2100.8762207031,\"z\":18.203077316284}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(179, 'Dutch London StLowApartament106', 'Dutch London St', '{\"x\":321.61642456055,\"y\":-2100.2255859375,\"z\":18.244071960449}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":321.61642456055,\"y\":-2100.2255859375,\"z\":18.244071960449}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(180, 'Dutch London StLowApartament107', 'Dutch London St', '{\"x\":329.95742797852,\"y\":-2095.341796875,\"z\":18.203369140625}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":329.95742797852,\"y\":-2095.341796875,\"z\":18.203369140625}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(181, 'Dutch London StLowApartament108', 'Dutch London St', '{\"x\":334.32632446289,\"y\":-2092.8256835938,\"z\":18.226135253906}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":334.32632446289,\"y\":-2092.8256835938,\"z\":18.226135253906}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(182, 'Grove StLowApartament109', 'Grove St', '{\"x\":72.066207885742,\"y\":-1938.8315429688,\"z\":21.318336486816}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":72.066207885742,\"y\":-1938.8315429688,\"z\":21.318336486816}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(183, 'Grove StLowApartament110', 'Grove St', '{\"x\":56.806182861328,\"y\":-1922.8514404297,\"z\":21.864446640015}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":56.806182861328,\"y\":-1922.8514404297,\"z\":21.864446640015}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(184, 'Grove StLowApartament111', 'Grove St', '{\"x\":39.119342803955,\"y\":-1911.4829101563,\"z\":21.953189849854}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":39.119342803955,\"y\":-1911.4829101563,\"z\":21.953189849854}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(185, 'Grove StLowApartament112', 'Grove St', '{\"x\":54.273559570313,\"y\":-1872.8765869141,\"z\":22.795989990234}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":54.273559570313,\"y\":-1872.8765869141,\"z\":22.795989990234}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(186, 'Grove StLowApartament113', 'Grove St', '{\"x\":23.810745239258,\"y\":-1896.4846191406,\"z\":22.962953567505}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":23.810745239258,\"y\":-1896.4846191406,\"z\":22.962953567505}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(187, 'Grove StLowApartament114', 'Grove St', '{\"x\":4.6479043960571,\"y\":-1884.2307128906,\"z\":23.695264816284}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":4.6479043960571,\"y\":-1884.2307128906,\"z\":23.695264816284}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(188, 'Grove StLowApartament115', 'Grove St', '{\"x\":-5.1101131439209,\"y\":-1872.6765136719,\"z\":24.150009155273}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-5.1101131439209,\"y\":-1872.6765136719,\"z\":24.150009155273}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(189, 'Grove StLowApartament116', 'Grove St', '{\"x\":-20.96152305603,\"y\":-1858.9113769531,\"z\":25.405124664307}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-20.96152305603,\"y\":-1858.9113769531,\"z\":25.405124664307}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(190, 'Grove StLowApartament117', 'Grove St', '{\"x\":-34.014827728271,\"y\":-1846.9061279297,\"z\":26.194311141968}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-34.014827728271,\"y\":-1846.9061279297,\"z\":26.194311141968}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(191, 'Grove StLowApartament118', 'Grove St', '{\"x\":21.024168014526,\"y\":-1844.1767578125,\"z\":24.60139465332}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":21.024168014526,\"y\":-1844.1767578125,\"z\":24.60139465332}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 1, ''),
(192, 'Grove StLowApartament119', 'Grove St', '{\"x\":29.919626235962,\"y\":-1854.4770507813,\"z\":24.051856994629}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":29.919626235962,\"y\":-1854.4770507813,\"z\":24.051856994629}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(193, 'Grove StLowApartament120', 'Grove St', '{\"x\":45.887538909912,\"y\":-1863.9820556641,\"z\":23.258590698242}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":45.887538909912,\"y\":-1863.9820556641,\"z\":23.258590698242}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(194, 'Grove StLowApartament121', 'Grove St', '{\"x\":54.36364364624,\"y\":-1872.9622802734,\"z\":22.837244033813}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":54.36364364624,\"y\":-1872.9622802734,\"z\":22.837244033813}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(195, 'Forum DrLowApartament122', 'Forum Dr', '{\"x\":16.587633132935,\"y\":-1443.8271484375,\"z\":30.949342727661}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":16.587633132935,\"y\":-1443.8271484375,\"z\":30.949342727661}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(196, 'Forum DrLowApartament123', 'Forum Dr', '{\"x\":-1.8025776147842,\"y\":-1442.1154785156,\"z\":30.942817687988}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-1.8025776147842,\"y\":-1442.1154785156,\"z\":30.942817687988}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(197, 'Forum DrLowApartament124', 'Forum Dr', '{\"x\":-32.325984954834,\"y\":-1446.1834716797,\"z\":31.890336990356}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-32.325984954834,\"y\":-1446.1834716797,\"z\":31.890336990356}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(198, 'Forum DrLowApartament125', 'Forum Dr', '{\"x\":-45.556591033936,\"y\":-1444.9697265625,\"z\":32.428642272949}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-45.556591033936,\"y\":-1444.9697265625,\"z\":32.428642272949}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 1, 0, ''),
(199, 'Forum DrLowApartament126', 'Forum Dr', '{\"x\":-64.548027038574,\"y\":-1449.2867431641,\"z\":32.525363922119}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-64.548027038574,\"y\":-1449.2867431641,\"z\":32.525363922119}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 1, 0, ''),
(200, 'Carson AveLowApartament127', 'Carson Ave', '{\"x\":-69.343765258789,\"y\":-1526.7075195313,\"z\":34.235866546631}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-69.343765258789,\"y\":-1526.7075195313,\"z\":34.235866546631}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(201, 'Carson AveLowApartament128', 'Carson Ave', '{\"x\":-59.501083374023,\"y\":-1530.2554931641,\"z\":34.235233306885}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-59.501083374023,\"y\":-1530.2554931641,\"z\":34.235233306885}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(202, 'Carson AveLowApartament129', 'Carson Ave', '{\"x\":-52.990871429443,\"y\":-1523.4920654297,\"z\":33.437713623047}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-52.990871429443,\"y\":-1523.4920654297,\"z\":33.437713623047}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(203, 'Carson AveLowApartament130', 'Carson Ave', '{\"x\":-52.975898742676,\"y\":-1523.3658447266,\"z\":33.436141967773}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-52.975898742676,\"y\":-1523.3658447266,\"z\":33.436141967773}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(204, 'Carson AveLowApartament131', 'Carson Ave', '{\"x\":-59.716499328613,\"y\":-1517.3901367188,\"z\":33.436946868896}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-59.716499328613,\"y\":-1517.3901367188,\"z\":33.436946868896}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(205, 'Forum DrLowApartament132', 'Forum Dr', '{\"x\":-64.846946716309,\"y\":-1513.0908203125,\"z\":33.436138153076}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-64.846946716309,\"y\":-1513.0908203125,\"z\":33.436138153076}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(206, 'Forum DrLowApartament133', 'Forum Dr', '{\"x\":-71.382942199707,\"y\":-1507.7313232422,\"z\":33.436134338379}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-71.382942199707,\"y\":-1507.7313232422,\"z\":33.436134338379}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(207, 'Forum DrLowApartament134', 'Forum Dr', '{\"x\":-77.387870788574,\"y\":-1514.8916015625,\"z\":34.272193908691}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-77.387870788574,\"y\":-1514.8916015625,\"z\":34.272193908691}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(208, 'Carson AveLowApartament135', 'Carson Ave', '{\"x\":-69.353958129883,\"y\":-1526.697265625,\"z\":37.419570922852}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-69.353958129883,\"y\":-1526.697265625,\"z\":37.419570922852}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(209, 'Carson AveLowApartament136', 'Carson Ave', '{\"x\":-62.509960174561,\"y\":-1532.4509277344,\"z\":37.419570922852}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-62.509960174561,\"y\":-1532.4509277344,\"z\":37.419570922852}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(210, 'Carson AveLowApartament137', 'Carson Ave', '{\"x\":-59.263675689697,\"y\":-1530.7897949219,\"z\":37.419570922852}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-59.263675689697,\"y\":-1530.7897949219,\"z\":37.419570922852}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(211, 'Carson AveLowApartament138', 'Carson Ave', '{\"x\":-53.116802215576,\"y\":-1523.5495605469,\"z\":36.62491607666}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-53.116802215576,\"y\":-1523.5495605469,\"z\":36.62491607666}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(212, 'Carson AveLowApartament139', 'Carson Ave', '{\"x\":-59.80912399292,\"y\":-1517.3100585938,\"z\":36.62491607666}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-59.80912399292,\"y\":-1517.3100585938,\"z\":36.62491607666}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(213, 'Forum DrLowApartament140', 'Forum Dr', '{\"x\":-65.103309631348,\"y\":-1512.9510498047,\"z\":36.62491607666}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-65.103309631348,\"y\":-1512.9510498047,\"z\":36.62491607666}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(214, 'Forum DrLowApartament141', 'Forum Dr', '{\"x\":-71.757369995117,\"y\":-1507.9320068359,\"z\":36.62491607666}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-71.757369995117,\"y\":-1507.9320068359,\"z\":36.62491607666}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(215, 'Forum DrLowApartament142', 'Forum Dr', '{\"x\":-77.254653930664,\"y\":-1514.6298828125,\"z\":37.414482116699}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-77.254653930664,\"y\":-1514.6298828125,\"z\":37.414482116699}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(216, 'Forum DrMotel143', 'Forum Dr', '{\"x\":-147.96473693848,\"y\":-1687.5128173828,\"z\":33.066989898682}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-147.96473693848,\"y\":-1687.5128173828,\"z\":33.066989898682}', '[]', NULL, 1, 1, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(217, 'Forum DrMotel144', 'Forum Dr', '{\"x\":-147.06523132324,\"y\":-1688.2677001953,\"z\":33.068099975586}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-147.06523132324,\"y\":-1688.2677001953,\"z\":33.068099975586}', '[]', NULL, 1, 1, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(218, 'Forum DrMotel145', 'Forum Dr', '{\"x\":-141.32919311523,\"y\":-1693.2037353516,\"z\":36.166248321533}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-141.32919311523,\"y\":-1693.2037353516,\"z\":36.166248321533}', '[]', NULL, 1, 1, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(219, 'Forum DrMotel146', 'Forum Dr', '{\"x\":-146.85954284668,\"y\":-1688.5709228516,\"z\":36.166343688965}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-146.85954284668,\"y\":-1688.5709228516,\"z\":36.166343688965}', '[]', NULL, 1, 1, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(220, 'Forum DrMotel147', 'Forum Dr', '{\"x\":-147.95179748535,\"y\":-1687.65234375,\"z\":36.166427612305}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-147.95179748535,\"y\":-1687.65234375,\"z\":36.166427612305}', '[]', NULL, 1, 1, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(221, 'Forum DrMotel148', 'Forum Dr', '{\"x\":-158.25318908691,\"y\":-1679.0382080078,\"z\":36.966747283936}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-158.25318908691,\"y\":-1679.0382080078,\"z\":36.966747283936}', '[]', NULL, 1, 1, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(222, 'Forum DrLowApartament149', 'Forum Dr', '{\"x\":-212.29153442383,\"y\":-1660.6958007813,\"z\":34.463180541992}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-212.29153442383,\"y\":-1660.6958007813,\"z\":34.463180541992}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(223, 'Forum DrLowApartament150', 'Forum Dr', '{\"x\":-216.69250488281,\"y\":-1648.5177001953,\"z\":37.636993408203}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-216.69250488281,\"y\":-1648.5177001953,\"z\":37.636993408203}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(224, 'Fantastic PlApartment151', 'Fantastic Pl', '{\"x\":288.13690185547,\"y\":-1094.8648681641,\"z\":29.419576644897}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":288.13690185547,\"y\":-1094.8648681641,\"z\":29.419576644897}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 1, 0, ''),
(225, 'Vespucci BlvdApartment152', 'Vespucci Blvd', '{\"x\":264.38519287109,\"y\":-1026.9343261719,\"z\":29.215644836426}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":264.38519287109,\"y\":-1026.9343261719,\"z\":29.215644836426}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(226, 'Vespucci BlvdApartment153', 'Vespucci Blvd', '{\"x\":296.16122436523,\"y\":-1027.4051513672,\"z\":29.210781097412}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":296.16122436523,\"y\":-1027.4051513672,\"z\":29.210781097412}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 1, 0, ''),
(227, 'Zach. Mirror DriveApartment154', 'Zach. Mirror Drive', '{\"x\":996.79266357422,\"y\":-729.46325683594,\"z\":57.815753936768}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":996.79266357422,\"y\":-729.46325683594,\"z\":57.815753936768}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(228, 'Zach. Mirror DriveApartment155', 'Zach. Mirror Drive', '{\"x\":979.21502685547,\"y\":-716.27844238281,\"z\":58.209381103516}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":979.21502685547,\"y\":-716.27844238281,\"z\":58.209381103516}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(229, 'Zach. Mirror DriveApartment156', 'Zach. Mirror Drive', '{\"x\":970.96228027344,\"y\":-701.10363769531,\"z\":58.47728729248}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":970.96228027344,\"y\":-701.10363769531,\"z\":58.47728729248}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(230, 'Zach. Mirror DriveLuxApartment157', 'Zach. Mirror Drive', '{\"x\":959.96002197266,\"y\":-670.04302978516,\"z\":58.449813842773}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":959.96002197266,\"y\":-670.04302978516,\"z\":58.449813842773}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(231, 'Zach. Mirror DriveApartment158', 'Zach. Mirror Drive', '{\"x\":943.30218505859,\"y\":-653.25494384766,\"z\":58.654243469238}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":943.30218505859,\"y\":-653.25494384766,\"z\":58.654243469238}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(232, 'Zach. Mirror DriveApartment159', 'Zach. Mirror Drive', '{\"x\":928.61322021484,\"y\":-639.65985107422,\"z\":58.236789703369}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":928.61322021484,\"y\":-639.65985107422,\"z\":58.236789703369}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(233, 'Zach. Mirror DriveLuxApartment160', 'Zach. Mirror Drive', '{\"x\":903.04278564453,\"y\":-615.36413574219,\"z\":58.45361328125}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":903.04278564453,\"y\":-615.36413574219,\"z\":58.45361328125}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(234, 'Zach. Mirror DriveApartment161', 'Zach. Mirror Drive', '{\"x\":886.63043212891,\"y\":-608.060546875,\"z\":58.429683685303}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":886.63043212891,\"y\":-608.060546875,\"z\":58.429683685303}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(235, 'Zach. Mirror DriveApartment162', 'Zach. Mirror Drive', '{\"x\":861.85589599609,\"y\":-583.47546386719,\"z\":58.152458190918}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":861.85589599609,\"y\":-583.47546386719,\"z\":58.152458190918}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(236, 'Zach. Mirror DriveLuxApartment163', 'Zach. Mirror Drive', '{\"x\":844.04522705078,\"y\":-562.64337158203,\"z\":57.983592987061}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":844.04522705078,\"y\":-562.64337158203,\"z\":57.983592987061}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(237, 'Zach. Mirror DriveApartment164', 'Zach. Mirror Drive', '{\"x\":850.24560546875,\"y\":-532.98883056641,\"z\":57.905414581299}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":850.24560546875,\"y\":-532.98883056641,\"z\":57.905414581299}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(238, 'Zach. Mirror DriveApartment165', 'Zach. Mirror Drive', '{\"x\":861.75415039063,\"y\":-508.9075012207,\"z\":57.675872802734}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":861.75415039063,\"y\":-508.9075012207,\"z\":57.675872802734}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(239, 'Zach. Mirror DriveApartment166', 'Zach. Mirror Drive', '{\"x\":878.41809082031,\"y\":-497.89752197266,\"z\":58.09061050415}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":878.41809082031,\"y\":-497.89752197266,\"z\":58.09061050415}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(240, 'Zach. Mirror DriveLuxApartment167', 'Zach. Mirror Drive', '{\"x\":906.38745117188,\"y\":-489.39755249023,\"z\":59.439510345459}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":906.38745117188,\"y\":-489.39755249023,\"z\":59.439510345459}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(241, 'Zach. Mirror DriveApartment168', 'Zach. Mirror Drive', '{\"x\":921.53784179688,\"y\":-477.91351318359,\"z\":61.082221984863}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":921.53784179688,\"y\":-477.91351318359,\"z\":61.082221984863}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(242, 'Zach. Mirror DriveApartment169', 'Zach. Mirror Drive', '{\"x\":944.55255126953,\"y\":-463.36758422852,\"z\":61.541667938232}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":944.55255126953,\"y\":-463.36758422852,\"z\":61.541667938232}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(243, 'Zach. Mirror DriveApartment170', 'Zach. Mirror Drive', '{\"x\":967.66076660156,\"y\":-452.12747192383,\"z\":62.417942047119}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":967.66076660156,\"y\":-452.12747192383,\"z\":62.417942047119}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(244, 'Zach. Mirror DriveLuxApartment171', 'Zach. Mirror Drive', '{\"x\":987.58624267578,\"y\":-433.03594970703,\"z\":63.930599212646}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":987.58624267578,\"y\":-433.03594970703,\"z\":63.930599212646}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(245, 'Zach. Mirror DriveApartment172', 'Zach. Mirror Drive', '{\"x\":1010.7333374023,\"y\":-423.34469604492,\"z\":65.272941589355}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1010.7333374023,\"y\":-423.34469604492,\"z\":65.272941589355}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(246, 'Zach. Mirror DriveApartment173', 'Zach. Mirror Drive', '{\"x\":1028.8151855469,\"y\":-408.42437744141,\"z\":66.183464050293}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1028.8151855469,\"y\":-408.42437744141,\"z\":66.183464050293}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(247, 'Bridge StLowApartament174', 'Bridge St', '{\"x\":1060.5174560547,\"y\":-378.07046508789,\"z\":68.219215393066}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1060.5174560547,\"y\":-378.07046508789,\"z\":68.219215393066}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(248, 'Zach. Mirror DriveLowApartament175', 'Zach. Mirror Drive', '{\"x\":1114.3569335938,\"y\":-391.44332885742,\"z\":68.950172424316}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1114.3569335938,\"y\":-391.44332885742,\"z\":68.950172424316}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(249, 'Bridge StLuxApartment176', 'Bridge St', '{\"x\":1101.0465087891,\"y\":-411.42715454102,\"z\":67.554679870605}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1101.0465087891,\"y\":-411.42715454102,\"z\":67.554679870605}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(250, 'Bridge StApartment177', 'Bridge St', '{\"x\":1099.3088378906,\"y\":-438.59521484375,\"z\":67.72998046875}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1099.3088378906,\"y\":-438.59521484375,\"z\":67.72998046875}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(251, 'Bridge StApartment178', 'Bridge St', '{\"x\":1099.7847900391,\"y\":-450.77474975586,\"z\":67.788497924805}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1099.7847900391,\"y\":-450.77474975586,\"z\":67.788497924805}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(252, 'Bridge StApartment179', 'Bridge St', '{\"x\":1098.5411376953,\"y\":-464.51058959961,\"z\":67.319404602051}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1098.5411376953,\"y\":-464.51058959961,\"z\":67.319404602051}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(253, 'Bridge StApartment180', 'Bridge St', '{\"x\":1090.3992919922,\"y\":-484.31219482422,\"z\":65.652938842773}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1090.3992919922,\"y\":-484.31219482422,\"z\":65.652938842773}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(254, 'Zach. Mirror DriveApartment181', 'Zach. Mirror Drive', '{\"x\":1014.294921875,\"y\":-469.58657836914,\"z\":64.546905517578}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1014.294921875,\"y\":-469.58657836914,\"z\":64.546905517578}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(255, 'Zach. Mirror DriveApartment182', 'Zach. Mirror Drive', '{\"x\":970.37951660156,\"y\":-502.43286132813,\"z\":62.137275695801}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":970.37951660156,\"y\":-502.43286132813,\"z\":62.137275695801}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(256, 'Zach. Mirror DriveApartment183', 'Zach. Mirror Drive', '{\"x\":945.66949462891,\"y\":-518.79614257813,\"z\":60.627426147461}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":945.66949462891,\"y\":-518.79614257813,\"z\":60.627426147461}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(257, 'Zach. Mirror DriveLowApartament184', 'Zach. Mirror Drive', '{\"x\":924.39556884766,\"y\":-526.00518798828,\"z\":59.819549560547}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":924.39556884766,\"y\":-526.00518798828,\"z\":59.819549560547}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(258, 'Zach. Mirror DriveLowApartament185', 'Zach. Mirror Drive', '{\"x\":893.19232177734,\"y\":-540.70196533203,\"z\":58.506671905518}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":893.19232177734,\"y\":-540.70196533203,\"z\":58.506671905518}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(259, 'Nikola AveApartment186', 'Nikola Ave', '{\"x\":919.92663574219,\"y\":-569.54907226563,\"z\":58.366718292236}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":919.92663574219,\"y\":-569.54907226563,\"z\":58.366718292236}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(260, 'Zach. Mirror DriveApartment187', 'Zach. Mirror Drive', '{\"x\":980.48675537109,\"y\":-627.45385742188,\"z\":59.235843658447}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":980.48675537109,\"y\":-627.45385742188,\"z\":59.235843658447}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(261, 'Mirror Park BlvdLowApartament188', 'Mirror Park Blvd', '{\"x\":1204.8846435547,\"y\":-557.87286376953,\"z\":69.618438720703}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1204.8846435547,\"y\":-557.87286376953,\"z\":69.618438720703}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(262, 'Mirror Park BlvdApartment189', 'Mirror Park Blvd', '{\"x\":1200.9927978516,\"y\":-575.65765380859,\"z\":69.136810302734}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1200.9927978516,\"y\":-575.65765380859,\"z\":69.136810302734}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(263, 'Mirror Park BlvdApartment190', 'Mirror Park Blvd', '{\"x\":1203.9920654297,\"y\":-598.47552490234,\"z\":68.056823730469}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1203.9920654297,\"y\":-598.47552490234,\"z\":68.056823730469}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(264, 'Mirror Park BlvdApartment191', 'Mirror Park Blvd', '{\"x\":1207.3195800781,\"y\":-620.10437011719,\"z\":66.427070617676}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1207.3195800781,\"y\":-620.10437011719,\"z\":66.427070617676}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(265, 'Mirror Park BlvdApartment192', 'Mirror Park Blvd', '{\"x\":1221.6619873047,\"y\":-669.24731445313,\"z\":63.522682189941}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1221.6619873047,\"y\":-669.24731445313,\"z\":63.522682189941}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(266, 'Mirror Park BlvdApartment193', 'Mirror Park Blvd', '{\"x\":1220.4093017578,\"y\":-689.24365234375,\"z\":61.146011352539}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1220.4093017578,\"y\":-689.24365234375,\"z\":61.146011352539}', '[\"]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(267, 'Wsch. Mirror DrApartment194', 'Wsch. Mirror Dr', '{\"x\":1229.2222900391,\"y\":-725.52770996094,\"z\":60.740779876709}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1229.2222900391,\"y\":-725.52770996094,\"z\":60.740779876709}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(268, 'Wsch. Mirror DrLowApartament195', 'Wsch. Mirror Dr', '{\"x\":1259.3474121094,\"y\":-710.96612548828,\"z\":64.506614685059}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1259.3474121094,\"y\":-710.96612548828,\"z\":64.506614685059}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(269, 'Wsch. Mirror DrApartment196', 'Wsch. Mirror Dr', '{\"x\":1270.9147949219,\"y\":-683.53118896484,\"z\":66.004867553711}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1270.9147949219,\"y\":-683.53118896484,\"z\":66.004867553711}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(270, 'Wsch. Mirror DrApartment197', 'Wsch. Mirror Dr', '{\"x\":1265.8558349609,\"y\":-648.12823486328,\"z\":67.896949768066}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1265.8558349609,\"y\":-648.12823486328,\"z\":67.896949768066}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(271, 'Wsch. Mirror DrApartment198', 'Wsch. Mirror Dr', '{\"x\":1250.8070068359,\"y\":-621.07000732422,\"z\":69.459182739258}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1250.8070068359,\"y\":-621.07000732422,\"z\":69.459182739258}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(272, 'Wsch. Mirror DrApartment199', 'Wsch. Mirror Dr', '{\"x\":1240.5028076172,\"y\":-601.45324707031,\"z\":69.781898498535}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1240.5028076172,\"y\":-601.45324707031,\"z\":69.781898498535}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(273, 'Wsch. Mirror DrApartment200', 'Wsch. Mirror Dr', '{\"x\":1241.4038085938,\"y\":-566.17437744141,\"z\":69.654945373535}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1241.4038085938,\"y\":-566.17437744141,\"z\":69.654945373535}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(274, 'Nikola PlApartment201', 'Nikola Pl', '{\"x\":1303.1495361328,\"y\":-527.42425537109,\"z\":71.457893371582}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1303.1495361328,\"y\":-527.42425537109,\"z\":71.457893371582}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(275, 'Nikola PlApartment202', 'Nikola Pl', '{\"x\":1301.1040039063,\"y\":-574.20275878906,\"z\":71.724517822266}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1301.1040039063,\"y\":-574.20275878906,\"z\":71.724517822266}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(276, 'Nikola PlApartment203', 'Nikola Pl', '{\"x\":1328.8011474609,\"y\":-535.61761474609,\"z\":72.437088012695}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1328.8011474609,\"y\":-535.61761474609,\"z\":72.437088012695}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(277, 'Nikola PlApartment204', 'Nikola Pl', '{\"x\":1323.2828369141,\"y\":-583.00360107422,\"z\":73.237968444824}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1323.2828369141,\"y\":-583.00360107422,\"z\":73.237968444824}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(278, 'Nikola PlApartment205', 'Nikola Pl', '{\"x\":1348.3032226563,\"y\":-546.85980224609,\"z\":73.886695861816}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1348.3032226563,\"y\":-546.85980224609,\"z\":73.886695861816}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(279, 'Nikola PlApartment206', 'Nikola Pl', '{\"x\":1341.2927246094,\"y\":-597.34722900391,\"z\":74.700912475586}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1341.2927246094,\"y\":-597.34722900391,\"z\":74.700912475586}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(280, 'Nikola PlApartment207', 'Nikola Pl', '{\"x\":1373.3422851563,\"y\":-555.5927734375,\"z\":74.678009033203}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1373.3422851563,\"y\":-555.5927734375,\"z\":74.678009033203}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(281, 'Nikola PlApartment208', 'Nikola Pl', '{\"x\":1388.4561767578,\"y\":-569.48370361328,\"z\":74.488273620605}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1388.4561767578,\"y\":-569.48370361328,\"z\":74.488273620605}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(282, 'Nikola PlApartment209', 'Nikola Pl', '{\"x\":1386.2890625,\"y\":-593.39416503906,\"z\":74.484268188477}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1386.2890625,\"y\":-593.39416503906,\"z\":74.484268188477}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(283, 'Nikola PlApartment210', 'Nikola Pl', '{\"x\":1367.5096435547,\"y\":-606.52087402344,\"z\":74.707092285156}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":1367.5096435547,\"y\":-606.52087402344,\"z\":74.707092285156}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(296, 'Gentry LaneApartment223', 'Gentry Lane', '{\"x\":-0.93527561426163,\"y\":301.61825561523,\"z\":110.96363067627}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-0.93527561426163,\"y\":301.61825561523,\"z\":110.96363067627}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(297, 'Gentry LaneApartment224', 'Gentry Lane', '{\"x\":8.3503379821777,\"y\":297.82403564453,\"z\":110.92953491211}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":8.3503379821777,\"y\":297.82403564453,\"z\":110.92953491211}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(298, 'Las Lagunas BlvdApartment225', 'Las Lagunas Blvd', '{\"x\":18.348657608032,\"y\":319.07189941406,\"z\":111.05419921875}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":18.348657608032,\"y\":319.07189941406,\"z\":111.05419921875}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(303, 'San Vitus BlvdLuxApartment230', 'San Vitus Blvd', '{\"x\":-197.73942565918,\"y\":86.266098022461,\"z\":69.756774902344}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-197.73942565918,\"y\":86.266098022461,\"z\":69.756774902344}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(304, 'Spanish AveLuxApartment231', 'Spanish Ave', '{\"x\":-154.1383972168,\"y\":68.662422180176,\"z\":70.772178649902}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-154.1383972168,\"y\":68.662422180176,\"z\":70.772178649902}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(305, 'Spanish AveLuxApartment232', 'Spanish Ave', '{\"x\":-165.41844177246,\"y\":75.251914978027,\"z\":70.701850891113}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-165.41844177246,\"y\":75.251914978027,\"z\":70.701850891113}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(306, 'Spanish AveLuxApartment233', 'Spanish Ave', '{\"x\":-142.90879821777,\"y\":62.414569854736,\"z\":70.84098815918}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-142.90879821777,\"y\":62.414569854736,\"z\":70.84098815918}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(307, 'Las Lagunas BlvdApartment234', 'Las Lagunas Blvd', '{\"x\":-102.27494049072,\"y\":-31.667770385742,\"z\":66.444046020508}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-102.27494049072,\"y\":-31.667770385742,\"z\":66.444046020508}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(308, 'Las Lagunas BlvdLowApartament235', 'Las Lagunas Blvd', '{\"x\":-102.26653289795,\"y\":-31.611782073975,\"z\":70.44766998291}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-102.26653289795,\"y\":-31.611782073975,\"z\":70.44766998291}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(309, 'Las Lagunas BlvdApartment236', 'Las Lagunas Blvd', '{\"x\":-37.804767608643,\"y\":-59.705665588379,\"z\":64.057670593262}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-37.804767608643,\"y\":-59.705665588379,\"z\":64.057670593262}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(310, 'Las Lagunas BlvdApartment237', 'Las Lagunas Blvd', '{\"x\":-17.944694519043,\"y\":-68.814056396484,\"z\":61.791320800781}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-17.944694519043,\"y\":-68.814056396484,\"z\":61.791320800781}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(311, 'Las Lagunas BlvdLowApartament238', 'Las Lagunas Blvd', '{\"x\":-15.901127815247,\"y\":-61.568153381348,\"z\":61.699893951416}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-15.901127815247,\"y\":-61.568153381348,\"z\":61.699893951416}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(312, 'Las Lagunas BlvdApartment239', 'Las Lagunas Blvd', '{\"x\":-9.2824945449829,\"y\":-49.140361785889,\"z\":67.170433044434}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-9.2824945449829,\"y\":-49.140361785889,\"z\":67.170433044434}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(313, 'Las Lagunas BlvdLowApartament240', 'Las Lagunas Blvd', '{\"x\":-25.40393447876,\"y\":-52.708240509033,\"z\":67.592247009277}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-25.40393447876,\"y\":-52.708240509033,\"z\":67.592247009277}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(314, 'Las Lagunas BlvdLowApartament241', 'Las Lagunas Blvd', '{\"x\":-27.785688400269,\"y\":-60.501205444336,\"z\":67.592247009277}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":-27.785688400269,\"y\":-60.501205444336,\"z\":67.592247009277}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(315, 'Meteor StMotel242', 'Meteor St', '{\"x\":346.88110351563,\"y\":-199.28630065918,\"z\":54.221813201904}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":346.88110351563,\"y\":-199.28630065918,\"z\":54.221813201904}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(316, 'Meteor StMotel243', 'Meteor St', '{\"x\":344.73278808594,\"y\":-204.86650085449,\"z\":54.221817016602}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":344.73278808594,\"y\":-204.86650085449,\"z\":54.221817016602}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, '');
INSERT INTO `properties` (`id`, `name`, `label`, `entering`, `exit`, `inside`, `outside`, `ipls`, `gateway`, `is_single`, `is_room`, `is_gateway`, `room_menu`, `price`, `owned`, `free`, `garage`) VALUES
(317, 'Meteor StMotel244', 'Meteor St', '{\"x\":342.8017578125,\"y\":-209.85485839844,\"z\":54.221897125244}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":342.8017578125,\"y\":-209.85485839844,\"z\":54.221897125244}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(318, 'Meteor StMotel245', 'Meteor St', '{\"x\":341.05242919922,\"y\":-214.46926879883,\"z\":54.22180557251}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":341.05242919922,\"y\":-214.46926879883,\"z\":54.22180557251}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(319, 'Meteor StMotel246', 'Meteor St', '{\"x\":339.1513671875,\"y\":-219.34135437012,\"z\":54.221767425537}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":339.1513671875,\"y\":-219.34135437012,\"z\":54.221767425537}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(320, 'Meteor StMotel247', 'Meteor St', '{\"x\":337.05200195313,\"y\":-224.87626647949,\"z\":54.221775054932}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":337.05200195313,\"y\":-224.87626647949,\"z\":54.221775054932}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(321, 'Meteor StMotel248', 'Meteor St', '{\"x\":335.06512451172,\"y\":-227.34535217285,\"z\":54.221782684326}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":335.06512451172,\"y\":-227.34535217285,\"z\":54.221782684326}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(322, 'Meteor StLowApartament249', 'Meteor St', '{\"x\":331.67849731445,\"y\":-226.03994750977,\"z\":54.221782684326}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":331.67849731445,\"y\":-226.03994750977,\"z\":54.221782684326}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(323, 'Hawick AveLowApartament250', 'Hawick Ave', '{\"x\":329.54116821289,\"y\":-225.22193908691,\"z\":54.221782684326}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":329.54116821289,\"y\":-225.22193908691,\"z\":54.221782684326}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 1, 0, ''),
(324, 'Hawick AveMotel251', 'Hawick Ave', '{\"x\":329.61010742188,\"y\":-225.17398071289,\"z\":58.0192527771}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":329.61010742188,\"y\":-225.17398071289,\"z\":58.0192527771}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(325, 'Meteor StMotel252', 'Meteor St', '{\"x\":331.41720581055,\"y\":-225.86833190918,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":331.41720581055,\"y\":-225.86833190918,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 1, 0, ''),
(326, 'Meteor StLowApartament253', 'Meteor St', '{\"x\":334.77328491211,\"y\":-227.15292358398,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":334.77328491211,\"y\":-227.15292358398,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(327, 'Meteor StLowApartament254', 'Meteor St', '{\"x\":336.97604370117,\"y\":-225.0908203125,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":336.97604370117,\"y\":-225.0908203125,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(328, 'Meteor StMotel255', 'Meteor St', '{\"x\":338.90625,\"y\":-219.82518005371,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":338.90625,\"y\":-219.82518005371,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(329, 'Meteor StMotel256', 'Meteor St', '{\"x\":340.82836914063,\"y\":-215.03907775879,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":340.82836914063,\"y\":-215.03907775879,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(330, 'Meteor StMotel257', 'Meteor St', '{\"x\":342.85113525391,\"y\":-209.78007507324,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":342.85113525391,\"y\":-209.78007507324,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(331, 'Meteor StMotel258', 'Meteor St', '{\"x\":344.5944519043,\"y\":-205.24488830566,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":344.5944519043,\"y\":-205.24488830566,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(332, 'Meteor StMotel259', 'Meteor St', '{\"x\":346.59124755859,\"y\":-200.04196166992,\"z\":58.019237518311}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":346.59124755859,\"y\":-200.04196166992,\"z\":58.019237518311}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(333, 'Meteor StLuxApartment260', 'Meteor St', '{\"x\":321.50765991211,\"y\":-197.11494445801,\"z\":54.226448059082}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":321.50765991211,\"y\":-197.11494445801,\"z\":54.226448059082}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(334, 'Meteor StMotel261', 'Meteor St', '{\"x\":319.46166992188,\"y\":-196.3282623291,\"z\":54.226451873779}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":319.46166992188,\"y\":-196.3282623291,\"z\":54.226451873779}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(335, 'Meteor StMotel262', 'Meteor St', '{\"x\":316.21572875977,\"y\":-195.08331298828,\"z\":54.226451873779}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":316.21572875977,\"y\":-195.08331298828,\"z\":54.226451873779}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(336, 'Hawick AveMotel263', 'Hawick Ave', '{\"x\":313.29223632813,\"y\":-198.25207519531,\"z\":54.22180557251}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":313.29223632813,\"y\":-198.25207519531,\"z\":54.22180557251}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(337, 'Hawick AveMotel264', 'Hawick Ave', '{\"x\":311.48568725586,\"y\":-203.00175476074,\"z\":54.22180557251}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":311.48568725586,\"y\":-203.00175476074,\"z\":54.22180557251}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(338, 'Hawick AveMotel265', 'Hawick Ave', '{\"x\":309.44021606445,\"y\":-208.36047363281,\"z\":54.221801757813}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":309.44021606445,\"y\":-208.36047363281,\"z\":54.221801757813}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(339, 'Hawick AveMotel266', 'Hawick Ave', '{\"x\":307.32528686523,\"y\":-216.56387329102,\"z\":54.221801757813}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":307.32528686523,\"y\":-216.56387329102,\"z\":54.221801757813}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(340, 'Hawick AveLowApartament267', 'Hawick Ave', '{\"x\":307.57000732422,\"y\":-213.28730773926,\"z\":54.221801757813}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":307.57000732422,\"y\":-213.28730773926,\"z\":54.221801757813}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(341, 'Hawick AveMotel268', 'Hawick Ave', '{\"x\":310.87033081055,\"y\":-217.98715209961,\"z\":54.221801757813}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":310.87033081055,\"y\":-217.98715209961,\"z\":54.221801757813}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, ''),
(342, 'Hawick AveMotel269', 'Hawick Ave', '{\"x\":312.68374633789,\"y\":-218.68338012695,\"z\":54.221801757813}', '{\"x\":151.39,\"y\":-1007.96,\"z\":-99.0}', '{\"x\":151.34,\"y\":-1006.36,\"z\":-99.0}', '{\"x\":312.68374633789,\"y\":-218.68338012695,\"z\":54.221801757813}', '[]', NULL, 1, 0, NULL, '{\"x\":151.29,\"y\":-1003.23,\"z\":-99.0}', 650000, 0, 0, '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `radiocar`
--

CREATE TABLE `radiocar` (
  `id` int(11) NOT NULL,
  `label` varchar(64) NOT NULL,
  `url` varchar(256) NOT NULL,
  `spz` varchar(32) NOT NULL,
  `index_music` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `radiocar`
--

INSERT INTO `radiocar` (`id`, `label`, `url`, `spz`, `index_music`) VALUES
(1, 'pierdolsieniger', 'https://www.youtube.com/watch?v=DqUd72pK15Y', '80DQO947', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `radiocar_owned`
--

CREATE TABLE `radiocar_owned` (
  `id` int(11) NOT NULL,
  `spz` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rented_vehicles`
--

CREATE TABLE `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Zrzut danych tabeli `shops`
--

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES
(1, 'TwentyFourSeven', 'water', 20),
(2, 'RobsLiquor', 'water', 20),
(3, 'TwentyFourSeven', 'bread', 20),
(4, 'RobsLiquor', 'bread', 20),
(5, 'Automaty', 'water', 20),
(6, 'Multimedialny', 'phone', 1000),
(7, 'Multimedialny', 'sim', 1550),
(8, 'TwentyFourSeven', 'chipsy', 25),
(9, 'TwentyFourSeven', 'cigarette', 100),
(10, 'TwentyFourSeven', 'cupcake', 30),
(11, 'TwentyFourSeven', 'redbull', 200),
(12, 'TwentyFourSeven', 'icetea', 25),
(13, 'RobsLiquor', 'chipsy', 25),
(14, 'RobsLiquor', 'cigarette', 100),
(15, 'RobsLiquor', 'redbull', 350),
(16, 'RobsLiquor', 'zapalniczka', 200),
(17, 'TwentyFourSeven', 'zapalniczka', 150),
(18, 'TwentyFourSeven', 'sandwich', 35),
(19, 'Automaty', 'chipsy', 25),
(20, 'Automaty', 'bread', 15),
(21, 'Kasyno', 'scratchcard', 5000),
(22, 'Kasyno', 'scratchcardpremium', 20000),
(23, 'Alko', 'water', 50),
(24, 'Alko', 'whisky', 400),
(25, 'Alko', 'wino', 250),
(26, 'Alko', 'sok', 60),
(27, 'Alko', 'wodka', 500),
(28, 'Alko', 'cola', 100),
(29, 'Alko', 'gin', 650),
(30, 'Weed', 'weed', 500),
(31, 'Weed', 'vape', 2000),
(32, 'Weed', 'cigarette', 100),
(33, 'Technik', 'handcuffs', 150000),
(34, 'Technik', 'radio', 15000),
(35, 'Technik', 'hifi', 5000),
(36, 'Technik', 'headbag', 12000),
(37, 'Technik', 'drill', 10000),
(38, 'Technik', 'repairkit', 4000),
(39, 'Technik', 'lockpick', 6000),
(40, 'Weed', 'liquid', 250),
(41, 'Stragan', 'jablko', 10),
(42, 'Stragan', 'mandarynka', 15),
(43, 'Stragan', 'winogrono', 5),
(44, 'Stragan', 'cytryna', 18),
(45, 'Stragan', 'brzoskwinia', 25);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `identifier` varchar(70) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `hiddenjob` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'unemployed',
  `hiddenjob_grade` int(11) NOT NULL DEFAULT 0,
  `job_id` varchar(255) DEFAULT '{"name":"nojob", "id":0}',
  `jednostka` varchar(255) DEFAULT NULL,
  `loadout` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `animacje` longtext DEFAULT NULL,
  `tattoos` longtext DEFAULT '{}',
  `skin` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `fake_firstname` varchar(50) DEFAULT NULL,
  `fake_lastname` varchar(50) DEFAULT NULL,
  `dateofbirth` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `last_property` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `job_callsing` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `backTicket` int(11) NOT NULL DEFAULT 0,
  `account_number` varchar(10) DEFAULT NULL,
  `kawa` varchar(255) DEFAULT NULL,
  `slots` varchar(255) NOT NULL DEFAULT '{"first":"Brak","second":"Brak","third":"Brak","identifier":"Brak","fifth":"Brak","fourth":"Brak"}',
  `character` varchar(1) DEFAULT NULL,
  `odebranesiano` int(11) NOT NULL DEFAULT 0,
  `kursy` int(11) NOT NULL DEFAULT 0,
  `rybakkursy` int(11) NOT NULL DEFAULT 0,
  `kawiarniakursy` int(11) NOT NULL DEFAULT 0,
  `milkmankursy` int(11) NOT NULL DEFAULT 0,
  `odznakakurwa` int(11) NOT NULL DEFAULT 0,
  `chuj` int(11) DEFAULT 0,
  `odbierz` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`identifier`, `accounts`, `group`, `inventory`, `job`, `job_grade`, `hiddenjob`, `hiddenjob_grade`, `job_id`, `jednostka`, `loadout`, `position`, `animacje`, `tattoos`, `skin`, `description`, `firstname`, `lastname`, `fake_firstname`, `fake_lastname`, `dateofbirth`, `sex`, `height`, `last_property`, `phone_number`, `is_dead`, `status`, `job_callsing`, `backTicket`, `account_number`, `kawa`, `slots`, `character`, `odebranesiano`, `kursy`, `rybakkursy`, `kawiarniakursy`, `milkmankursy`, `odznakakurwa`, `chuj`, `odbierz`) VALUES
('steam:110000106271c89', '{\"black_money\":0,\"money\":5000,\"bank\":500300}', 'superadmin', '{\"radio\":{\"count\":3},\"pistol_ammo\":{\"count\":201},\"bandage\":{\"count\":20},\"medikit\":{\"count\":20},\"gps\":{\"count\":1},\"bodycam\":{\"count\":5},\"snspistol_mk2\":{\"slot\":1,\"count\":1}}', 'police', 2, 'org1', 4, '{\"name\":\"nojob\", \"id\":0}', NULL, '{\"WEAPON_SNSPISTOL_MK2\":{\"ammo\":201}}', '{\"heading\":270.7,\"x\":550.2,\"y\":-3163.4,\"z\":6.1}', NULL, '{}', '{\"helmet_1\":-1,\"age_2\":0,\"bags_2\":0,\"lipstick_1\":0,\"face\":0,\"chest_1\":0,\"nose_2\":10,\"sun_2\":0,\"shoes_1\":0,\"complexion_2\":0,\"hair_color_1\":0,\"blush_3\":0,\"eyebrow_2\":10,\"cheeks_3\":10,\"sun_1\":0,\"complexion_1\":0,\"skin\":0,\"shoes_2\":0,\"jaw_1\":10,\"nose_5\":10,\"bproof_1\":0,\"skin_3\":0,\"ears_2\":0,\"blend_skin\":0,\"helmet_2\":0,\"cheeks_1\":10,\"blemishes_1\":0,\"watches_1\":-1,\"bracelets_1\":-1,\"pants_2\":0,\"beard_4\":0,\"glasses_2\":0,\"chain_2\":0,\"mask_2\":0,\"hair_color_2\":0,\"watches_2\":0,\"nose_4\":10,\"blush_1\":0,\"beard_2\":0,\"chimp_3\":10,\"face_3\":0,\"chest_2\":0,\"face_2\":0,\"blend\":0,\"skin_2\":0,\"nose_1\":10,\"blemishes_2\":0,\"makeup_3\":0,\"sex\":0,\"torso_2\":0,\"lipstick_3\":0,\"moles_1\":0,\"torso_1\":0,\"chimp_2\":10,\"lips\":10,\"beard_1\":0,\"jaw_2\":10,\"chimp_4\":10,\"eyebrows_3\":0,\"hair_2\":0,\"chest_3\":0,\"chimp_1\":10,\"eyebrows_4\":0,\"moles_2\":0,\"tshirt_1\":0,\"nose_3\":10,\"nose_6\":10,\"cheeks_2\":10,\"makeup_1\":0,\"bags_1\":0,\"decals_1\":0,\"ears_1\":-1,\"blush_2\":0,\"eye_color\":0,\"neck\":10,\"lipstick_4\":0,\"tshirt_2\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"decals_2\":0,\"eyebrows_1\":0,\"pants_1\":0,\"makeup_2\":0,\"hair_1\":0,\"makeup_4\":0,\"hair_3\":0,\"chain_1\":0,\"bodyb_2\":0,\"blend_face\":0,\"eyebrow_1\":10,\"glasses_1\":0,\"bodyb_1\":0,\"mask_1\":0,\"arms_2\":0,\"bracelets_2\":0,\"lipstick_2\":0,\"arms\":0,\"bproof_2\":0}', NULL, 'Chujcidodupy', 'Chujcidodupy', NULL, NULL, '3331-03-31', 'm', '190', NULL, NULL, 0, '[]', NULL, 0, '5179545', NULL, '{\"first\":\"Brak\",\"second\":\"Brak\",\"third\":\"Brak\",\"identifier\":\"Brak\",\"fifth\":\"Brak\",\"fourth\":\"Brak\"}', NULL, 0, 0, 0, 0, 0, 0, 0, 0),
('steam:11000014c3cf3e2', '{\"black_money\":0,\"bank\":501200,\"money\":5000}', 'superadmin', '{\"smg\":{\"count\":1},\"vintagepistol\":{\"slot\":1,\"count\":1},\"combatpdw\":{\"count\":1},\"redbull\":{\"count\":4}}', 'unemployed', 0, 'unemployed', 0, '{\"name\":\"nojob\", \"id\":0}', NULL, '{\"WEAPON_VINTAGEPISTOL\":{\"ammo\":0},\"WEAPON_SMG\":{\"ammo\":0},\"WEAPON_COMBATPDW\":{\"ammo\":0}}', '{\"x\":604.9,\"y\":-311.2,\"z\":38.1,\"heading\":302.7}', NULL, '{}', '{\"eyebrows_3\":0,\"chest_3\":0,\"bags_2\":0,\"decals_1\":0,\"bags_1\":0,\"arms\":0,\"hair_2\":0,\"eyebrows_2\":0,\"skin\":0,\"glasses_1\":0,\"chimp_1\":10,\"chimp_3\":10,\"nose_3\":10,\"bproof_2\":0,\"nose_1\":10,\"chain_2\":0,\"blend_skin\":0,\"tshirt_1\":0,\"age_1\":0,\"watches_2\":0,\"nose_5\":10,\"decals_2\":0,\"jaw_1\":10,\"hair_color_2\":0,\"hair_1\":0,\"eyebrows_1\":0,\"shoes_2\":0,\"neck\":10,\"chimp_2\":10,\"ears_1\":-1,\"beard_3\":0,\"bodyb_2\":0,\"face_2\":0,\"lipstick_3\":0,\"makeup_2\":0,\"helmet_1\":-1,\"glasses_2\":0,\"face\":0,\"lips\":10,\"blush_3\":0,\"bproof_1\":0,\"beard_4\":0,\"lipstick_2\":0,\"watches_1\":-1,\"chain_1\":0,\"makeup_3\":0,\"sun_2\":0,\"beard_2\":0,\"chest_1\":0,\"lipstick_1\":0,\"makeup_1\":0,\"age_2\":0,\"pants_1\":0,\"cheeks_3\":10,\"blush_1\":0,\"chimp_4\":10,\"nose_2\":10,\"face_3\":0,\"blemishes_1\":0,\"beard_1\":0,\"eyebrows_4\":0,\"mask_1\":0,\"hair_3\":0,\"moles_1\":0,\"skin_3\":0,\"nose_4\":10,\"blush_2\":0,\"pants_2\":0,\"helmet_2\":0,\"jaw_2\":10,\"bracelets_1\":-1,\"chest_2\":0,\"torso_1\":0,\"sex\":0,\"nose_6\":10,\"complexion_1\":0,\"blemishes_2\":0,\"sun_1\":0,\"eyebrow_1\":10,\"blend_face\":0,\"moles_2\":0,\"bracelets_2\":0,\"complexion_2\":0,\"makeup_4\":0,\"hair_color_1\":0,\"cheeks_2\":10,\"tshirt_2\":0,\"blend\":0,\"bodyb_1\":0,\"eye_color\":0,\"skin_2\":0,\"torso_2\":0,\"lipstick_4\":0,\"shoes_1\":0,\"mask_2\":0,\"cheeks_1\":10,\"ears_2\":0,\"eyebrow_2\":10,\"arms_2\":0}', NULL, 'Niger niger', 'Niger niger', NULL, NULL, NULL, 'm', NULL, NULL, NULL, 0, '[]', NULL, 0, '7067498', NULL, '{\"first\":\"Brak\",\"second\":\"Brak\",\"third\":\"Brak\",\"identifier\":\"Brak\",\"fifth\":\"Brak\",\"fourth\":\"Brak\"}', NULL, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_lastcharacter`
--

CREATE TABLE `user_lastcharacter` (
  `license` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `bypass` tinyint(1) DEFAULT 0,
  `blockmessages` varchar(2) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Zrzut danych tabeli `user_lastcharacter`
--

INSERT INTO `user_lastcharacter` (`license`, `charid`, `limit`, `bypass`, `blockmessages`) VALUES
('steam:110000106271c89', 1, 1, 0, '0'),
('steam:11000014c3cf3e2', 1, 1, 0, '0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL,
  `time` int(11) NOT NULL DEFAULT -1,
  `label` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_properties`
--

CREATE TABLE `user_properties` (
  `userId` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_sim`
--

CREATE TABLE `user_sim` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user` varchar(50) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `userdigit` int(11) DEFAULT NULL,
  `number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `house` varchar(50) COLLATE utf8mb4_polish_ci NOT NULL DEFAULT 'Brak',
  `active` int(11) NOT NULL DEFAULT 0,
  `blocked` int(11) DEFAULT 0,
  `admin1` varchar(100) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `admin2` varchar(100) COLLATE utf8mb4_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `user_sim`
--

INSERT INTO `user_sim` (`id`, `identifier`, `user`, `userdigit`, `number`, `label`, `house`, `active`, `blocked`, `admin1`, `admin2`) VALUES
(1, 'steam:110000147973fd2', 'steam:110000147973fd2', NULL, '34572', 'SIM #34572', 'Brak', 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vehicles`
--

CREATE TABLE `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `limited` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`, `limited`) VALUES
('Akuma', 'AKUMA', 75000, 'motorcycles', 0),
('Alpha', 'alpha', 60000, 'sports', 0),
('Asea', 'asea', 5500, 'sedans', 0),
('Aston Martin Vulcan', 'AstonMartinVulcan', 7000000, 'compacts', 1),
('Audi A8', 'AudiA8', 3000000, 'sedans', 0),
('Audi RS5 ABT', 'AudiRS5ABT', 5000000, 'super', 0),
('Audi RS6 C7', 'AudiRS6C7', 2500000, 'sedans', 0),
('Audi RS6 C8', 'AudiRS6C8', 5000000, 'sports', 0),
('Audi RS7 C8', 'AudiRS7C8', 6000000, 'sports', 0),
('Avarus', 'avarus', 30000, 'motorcycles', 0),
('Bagger', 'bagger', 30000, 'motorcycles', 0),
('Banshee', 'banshee', 70000, 'sports', 0),
('Bati 801', 'bati', 120000, 'motorcycles', 0),
('Bati 801RR', 'bati2', 190000, 'motorcycles', 0),
('Bentley Bentayga', 'BentleyBentayga', 4000000, 'compacts', 1),
('Bestia GTS', 'bestiagts', 55000, 'sports', 0),
('BF400', 'bf400', 36500, 'motorcycles', 0),
('Blade', 'blade', 35000, 'muscle', 0),
('BMW I8', 'BmwI8', 8000000, 'compacts', 1),
('BMW M2 Manhart', 'BMWM2Manhart', 5000000, 'sports', 0),
('BMW M3 E92 Hamman', 'BMWM3E92Hamman', 4000000, 'coupes', 0),
('BMW M3 F80', 'BmwM3F80', 350000, 'sports', 0),
('BMW M4 GTS', 'BMWM4GTS', 7000000, 'sports', 0),
('BMW M5 E34', 'BmwM5E34', 600000, 'coupes', 0),
('BMW M5 E39', 'BmwM5E39', 800000, 'coupes', 0),
('BMW M5 F90', 'BmwM5F90', 5200000, 'coupes', 0),
('BMW M6', 'BMWM6', 6500000, 'suvs', 0),
('BMW X5 MG05', 'BmwX5MG05', 3500000, 'compacts', 1),
('BMW X6M F16', 'BmwX6MF16', 4600000, 'compacts', 1),
('BMX (velo)', 'bmx', 1600, 'motorcycles', 0),
('Brabus G500', 'BrabusG500Hi', 5200000, 'offroad', 0),
('Brabus G550', 'BrabusG550A', 6000000, 'offroad', 0),
('Brabus S900', 'BrabusS900', 4500000, 'compacts', 1),
('Buccaneer', 'buccaneer', 30000, 'muscle', 0),
('Buccaneer Rider', 'buccaneer2', 30000, 'muscle', 0),
('Buffalo', 'buffalo', 12000, 'sports', 0),
('Buffalo S', 'buffalo2', 20000, 'sports', 0),
('Bugatti Chiron', 'BugattiChiron', 9000000, 'super', 0),
('Bugatti Divo', 'BugattiDivo', 10000000, 'super', 0),
('Bugatti Veyron', 'BugattiVeyron', 8000000, 'compacts', 1),
('Carbonizzare', 'carbonizzare', 75000, 'sports', 0),
('Carbon RS', 'carbonrs', 30000, 'motorcycles', 0),
('Chevrolet Camaro SS', 'ChevroletCamaroSS', 6000000, 'compacts', 1),
('Chevrolet Silverado', 'ChevroletSilverado', 4000000, 'offroad', 0),
('Chimera', 'chimera', 38000, 'motorcycles', 0),
('Chino', 'chino', 30000, 'muscle', 0),
('Chino Luxe', 'chino2', 30000, 'muscle', 0),
('Cliffhanger', 'cliffhanger', 30000, 'motorcycles', 0),
('Cognoscenti Cabrio', 'cogcabrio', 55000, 'coupes', 0),
('Cognoscenti', 'cognoscenti', 55000, 'sedans', 0),
('Comet', 'comet2', 65000, 'sports', 0),
('Comet 5', 'comet5', 1145000, 'sports', 0),
('Contender', 'contender', 300000, 'suvs', 0),
('Coquette', 'coquette', 65000, 'sports', 0),
('Coquette BlackFin', 'coquette3', 55000, 'muscle', 0),
('Cruiser (velo)', 'cruiser', 5100, 'motorcycles', 0),
('Daemon', 'daemon', 30000, 'motorcycles', 0),
('Daemon High', 'daemon2', 30000, 'motorcycles', 0),
('Defiler', 'defiler', 30000, 'motorcycles', 0),
('Dodge Challenger', 'DodgeChallenger', 5000000, 'compacts', 1),
('Dodge Charger', 'DodgeCharger', 4500000, 'compacts', 1),
('Dodge Durango SRT', 'DodgeDurangoSRT', 3000000, 'compacts', 1),
('Dominator', 'dominator', 35000, 'muscle', 0),
('Double T', 'double', 30000, 'motorcycles', 0),
('Dubsta', 'dubsta', 250000, 'suvs', 0),
('Dubsta Luxuary', 'dubsta2', 225000, 'suvs', 0),
('Dukes', 'dukes', 30000, 'muscle', 0),
('Elegy', 'elegy2', 38500, 'sports', 0),
('Emperor', 'emperor', 8500, 'sedans', 0),
('Enduro', 'enduro', 55000, 'motorcycles', 0),
('Esskey', 'esskey', 42000, 'motorcycles', 0),
('Exemplar', 'exemplar', 32000, 'coupes', 0),
('F620', 'f620', 40000, 'coupes', 0),
('Faction', 'faction', 30000, 'muscle', 0),
('Faction Rider', 'faction2', 30000, 'muscle', 0),
('Faction XL', 'faction3', 40000, 'muscle', 0),
('Faggio', 'faggio', 30000, 'motorcycles', 0),
('Vespa', 'faggio2', 30000, 'motorcycles', 0),
('Felon', 'felon', 42000, 'coupes', 0),
('Felon GT', 'felon2', 55000, 'coupes', 0),
('Feltzer', 'feltzer2', 55000, 'sports', 0),
('Ferrari 488X', 'Ferrari488x', 11000000, 'super', 0),
('Ferrari 812', 'Ferrari812', 9000000, 'super', 0),
('Ferrari SF90', 'FerrariSF90', 10000000, 'super', 0),
('Fixter (velo)', 'fixter', 2250, 'motorcycles', 0),
('Ford Raptor', 'FordRaptor', 3000000, 'compacts', 1),
('Fugitive', 'fugitive', 12000, 'sedans', 0),
('Furore GT', 'furoregt', 45000, 'sports', 0),
('Fusilade', 'fusilade', 40000, 'sports', 0),
('Ferrari FXX', 'fxxk', 12000000, 'compacts', 1),
('Gargoyle', 'gargoyle', 30000, 'motorcycles', 0),
('Gauntlet', 'gauntlet', 30000, 'muscle', 0),
('Alfa Romeo Giulia', 'giuliagtam', 4500000, 'coupes', 0),
('Glendale', 'glendale', 6500, 'sedans', 0),
('Guardian', 'guardian', 250000, 'offroad', 0),
('Hakuchou', 'hakuchou', 31000, 'motorcycles', 0),
('Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles', 0),
('Hexer', 'hexer', 30000, 'motorcycles', 0),
('Hotknife', 'hotknife', 125000, 'muscle', 0),
('HummerH1', 'HummerH1', 14000000, 'offroad', 0),
('Hummer H2', 'HummerH2', 3800000, 'offroad', 0),
('Hummer H6', 'HummerH6', 4800000, 'compacts', 1),
('Humvee', 'Humvee', 17000000, 'offroad', 0),
('Hustler', 'hustler', 1625000, 'muscle', 0),
('hvrod', 'hvrod', 1500000, 'motorcycles', 0),
('InfinitiQ60B', 'InfinitiQ60B', 2100000, 'coupes', 0),
('Innovation', 'innovation', 30000, 'motorcycles', 0),
('Intruder', 'intruder', 7500, 'sedans', 0),
('Jackal', 'jackal', 38000, 'coupes', 0),
('JeepCherokeeSRT', 'JeepCherokeeSRT', 5500000, 'offroad', 0),
('Jeep Gladiator', 'JeepGladiator', 8500000, 'offroad', 0),
('Jester', 'jester', 65000, 'sports', 0),
('Jester(Racecar)', 'jester2', 135000, 'sports', 0),
('Khamelion', 'khamelion', 38000, 'sports', 0),
('Koenigsegg Agera', 'KoenigseggAgera', 17000000, 'super', 0),
('Koenigsegg Jesko', 'KoenigseggJesko', 17000000, 'compacts', 1),
('Kuruma', 'kuruma', 30000, 'sports', 0),
('kx450f', 'kx450f', 2100000, 'motorcycles', 0),
('LamboHuracan', 'LamboHuracan', 11000000, 'super', 0),
('Lambo LP750', 'LamboLP750sv', 13000000, 'super', 0),
('Lamborghini Urus', 'LamborghiniUrus', 7000000, 'compacts', 1),
('Lambo Sesto Elemento', 'LamboSestoElemento', 14000000, 'compacts', 1),
('Lambo Veneno', 'LamboVeneno', 15000000, 'super', 0),
('LexusGS350', 'LexusGS350', 1200000, 'coupes', 0),
('Lynx', 'lynx', 40000, 'sports', 0),
('Mamba', 'mamba', 70000, 'sports', 0),
('Manchez', 'manchez', 53000, 'motorcycles', 0),
('Massacro', 'massacro', 65000, 'sports', 0),
('Massacro(Racecar)', 'massacro2', 130000, 'sports', 0),
('McLaren 600lt', 'McLaren600lt', 5800000, 'super', 0),
('McLaren P1', 'McLarenP1', 14000000, 'super', 0),
('MercedesC63SW205', 'MercedesC63SW205', 4200000, 'sports', 0),
('Mercedes E53 Coupe', 'MercedesE53Coupe', 4000000, 'compacts', 1),
('MercedesE55W210', 'MercedesE55W210', 600000, 'coupes', 0),
('Mercedes G63', 'MercedesG63', 4800000, 'offroad', 0),
('MercedesGLE', 'MercedesGLE', 3400000, 'suvs', 0),
('Mercedes GT63', 'MercedesGT63', 4200000, 'compacts', 1),
('Mesa', 'mesa', 30000, 'suvs', 0),
('Mesa Trail', 'mesa3', 100000, 'suvs', 0),
('Mitsubishi Lancer EvoX', 'MitsubishiLancerEvoX', 2300000, 'compacts', 1),
('Nemesis', 'nemesis', 58000, 'motorcycles', 0),
('Neon', 'neon', 1500000, 'sports', 0),
('Nightblade', 'nightblade', 35000, 'motorcycles', 0),
('Nightshade', 'nightshade', 65000, 'muscle', 0),
('9F', 'ninef', 65000, 'sports', 0),
('9F Cabrio', 'ninef2', 80000, 'sports', 0),
('Kawasaki Ninja H2', 'ninjah2', 3500000, 'motorcycles', 0),
('Nissan 180SX', 'Nissan180SX', 410000, 'compacts', 1),
('Omnis', 'omnis', 35000, 'sports', 0),
('Oracle XS', 'oracle2', 35000, 'coupes', 0),
('Pagani Huayra', 'PaganiHuayraImola', 7500000, 'compacts', 1),
('Pariah', 'pariah', 1420000, 'sports', 0),
('Patriot', 'patriot', 150000, 'suvs', 0),
('PCJ-600', 'pcj', 62000, 'motorcycles', 0),
('Penumbra', 'penumbra', 28000, 'sports', 0),
('Phoenix', 'phoenix', 30000, 'muscle', 0),
('Picador', 'picador', 30000, 'muscle', 0),
('Porsche 911', 'Porsche911Venom', 7000000, 'super', 0),
('Premier', 'premier', 8000, 'sedans', 0),
('Primo Custom', 'primo2', 14000, 'sedans', 0),
('prius', 'prius', 170000, 'coupes', 0),
('raiden', 'raiden', 1375000, 'sports', 0),
('Rapid GT', 'rapidgt', 35000, 'sports', 0),
('Rapid GT Convertible', 'rapidgt2', 45000, 'sports', 0),
('Regina', 'regina', 5000, 'sedans', 0),
('Revolter', 'revolter', 1610000, 'sports', 0),
('BMW M8 Cabrio', 'rmodm8c', 3500000, 'compacts', 1),
('Ruffian', 'ruffian', 68000, 'motorcycles', 0),
('Sabre Turbo', 'sabregt', 30000, 'muscle', 0),
('Sabre GT', 'sabregt2', 30000, 'muscle', 0),
('Sanchez', 'sanchez', 53000, 'motorcycles', 0),
('Sanchez Sport', 'sanchez2', 53000, 'motorcycles', 0),
('Sanctus', 'sanctus', 30000, 'motorcycles', 0),
('Schafter', 'schafter2', 25000, 'sedans', 0),
('Schafter V12', 'schafter3', 50000, 'sports', 0),
('Scorcher (velo)', 'scorcher', 2800, 'motorcycles', 0),
('Sentinel', 'sentinel', 32000, 'coupes', 0),
('Sentinel XS', 'sentinel2', 40000, 'coupes', 0),
('Sentinel', 'sentinel3', 650000, 'sports', 0),
('Seven 70', 'seven70', 39500, 'sports', 0),
('Shotaro Concept', 'shotaro', 320000, 'motorcycles', 0),
('Slam Van', 'slamvan3', 30000, 'muscle', 0),
('Sovereign', 'sovereign', 30000, 'motorcycles', 0),
('Streiter', 'streiter', 500000, 'sports', 0),
('Stretch', 'stretch', 90000, 'sedans', 0),
('SubaruImpreza18', 'SubaruImpreza18', 1200000, 'coupes', 0),
('Sultan', 'sultan', 15000, 'sports', 0),
('Super Diamond', 'superd', 130000, 'sedans', 0),
('Surano', 'surano', 50000, 'sports', 0),
('sxf450sm', 'sxf450sm', 900000, 'motorcycles', 0),
('Tailgater', 'tailgater', 30000, 'sedans', 0),
('Tampa', 'tampa', 30000, 'muscle', 0),
('Drift Tampa', 'tampa2', 80000, 'sports', 0),
('Thrust', 'thrust', 30000, 'motorcycles', 0),
('Tmax', 'tmax', 250000, 'motorcycles', 0),
('Toyota Supra', 'ToyotaSupra20', 4200000, 'sports', 0),
('Tri bike (velo)', 'tribike3', 5200, 'motorcycles', 0),
('Tropos', 'tropos', 40000, 'sports', 0),
('Vader', 'vader', 72000, 'motorcycles', 0),
('Verlierer', 'verlierer2', 70000, 'sports', 0),
('Vigero', 'vigero', 30000, 'muscle', 0),
('Virgo', 'virgo', 30000, 'muscle', 0),
('Voodoo', 'voodoo', 72000, 'muscle', 0),
('Vortex', 'vortex', 30000, 'motorcycles', 0),
('Warrener', 'warrener', 4000, 'sedans', 0),
('Washington', 'washington', 9000, 'sedans', 0),
('Windsor', 'windsor', 95000, 'coupes', 0),
('Windsor Drop', 'windsor2', 125000, 'coupes', 0),
('Woflsbane', 'wolfsbane', 30000, 'motorcycles', 0),
('yz450f', 'yz450f', 2300000, 'motorcycles', 0),
('z1000', 'z1000', 3100000, 'motorcycles', 0),
('Zion', 'zion', 36000, 'coupes', 0),
('Zion Cabrio', 'zion2', 45000, 'coupes', 0),
('Zombie', 'zombiea', 30000, 'motorcycles', 0),
('Zombie Luxuary', 'zombieb', 30000, 'motorcycles', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `kind` int(11) NOT NULL DEFAULT 1,
  `limited` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Zrzut danych tabeli `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`, `type`, `kind`, `limited`) VALUES
('compacts', 'Limitowane', 2, 1, 1),
('coupes', 'Coupe', 1, 1, 0),
('motorcycles', 'Motocykle', 1, 1, 0),
('muscle', 'Muscle', 1, 1, 0),
('offroad', 'Off Road', 1, 1, 0),
('sedans', 'Sedan', 1, 1, 0),
('sports', 'Sportowe', 1, 1, 0),
('super', 'Super-Samochod', 1, 1, 0),
('suvs', 'SUVy', 1, 1, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vehicle_properties`
--

CREATE TABLE `vehicle_properties` (
  `vehicleId` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `vehicle_tunings`
--

CREATE TABLE `vehicle_tunings` (
  `id` int(11) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `mods` text NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Indeksy dla tabeli `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Indeksy dla tabeli `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Indeksy dla tabeli `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Indeksy dla tabeli `baninfo`
--
ALTER TABLE `baninfo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `license` (`license`),
  ADD KEY `identifier` (`identifier`);

--
-- Indeksy dla tabeli `banlist`
--
ALTER TABLE `banlist`
  ADD PRIMARY KEY (`license`),
  ADD KEY `identifier` (`identifier`),
  ADD KEY `license` (`license`);

--
-- Indeksy dla tabeli `banlisthistory`
--
ALTER TABLE `banlisthistory`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`);

--
-- Indeksy dla tabeli `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Indeksy dla tabeli `exile_org`
--
ALTER TABLE `exile_org`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `exile_transfers`
--
ALTER TABLE `exile_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `exile_zones`
--
ALTER TABLE `exile_zones`
  ADD PRIMARY KEY (`name`),
  ADD KEY `date` (`taken`),
  ADD KEY `owner` (`owner`),
  ADD KEY `name` (`name`),
  ADD KEY `label` (`label`);

--
-- Indeksy dla tabeli `fine_types`
--
ALTER TABLE `fine_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`),
  ADD KEY `name` (`name`);

--
-- Indeksy dla tabeli `jail`
--
ALTER TABLE `jail`
  ADD PRIMARY KEY (`identifier`),
  ADD KEY `identifier` (`identifier`);

--
-- Indeksy dla tabeli `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`),
  ADD KEY `name` (`name`);

--
-- Indeksy dla tabeli `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_name` (`job_name`);

--
-- Indeksy dla tabeli `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`);

--
-- Indeksy dla tabeli `lspd_mdc_judgments_suggestion`
--
ALTER TABLE `lspd_mdc_judgments_suggestion`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `lspd_mdc_judgments_suggestion_category`
--
ALTER TABLE `lspd_mdc_judgments_suggestion_category`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `lspd_mdc_tag_suggestion`
--
ALTER TABLE `lspd_mdc_tag_suggestion`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `lspd_mdc_user_notes`
--
ALTER TABLE `lspd_mdc_user_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `lspd_mdc_vehicle_notes`
--
ALTER TABLE `lspd_mdc_vehicle_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `lspd_odznaki`
--
ALTER TABLE `lspd_odznaki`
  ADD PRIMARY KEY (`identifier`);

--
-- Indeksy dla tabeli `lspd_user_judgments`
--
ALTER TABLE `lspd_user_judgments`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `owned_properties`
--
ALTER TABLE `owned_properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `owner` (`owner`),
  ADD KEY `owner_2` (`owner`),
  ADD KEY `co_owner1` (`co_owner1`),
  ADD KEY `co_owner2` (`co_owner2`);

--
-- Indeksy dla tabeli `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `owner_type` (`owner_type`),
  ADD KEY `plate` (`plate`);

--
-- Indeksy dla tabeli `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `channel` (`channel`);

--
-- Indeksy dla tabeli `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `num` (`num`);

--
-- Indeksy dla tabeli `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `receiver` (`receiver`);

--
-- Indeksy dla tabeli `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ownernumber` (`ownernumber`),
  ADD KEY `number` (`number`);

--
-- Indeksy dla tabeli `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `radiocar`
--
ALTER TABLE `radiocar`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `radiocar_owned`
--
ALTER TABLE `radiocar_owned`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Indeksy dla tabeli `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store` (`store`),
  ADD KEY `item` (`item`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Indeksy dla tabeli `user_lastcharacter`
--
ALTER TABLE `user_lastcharacter`
  ADD PRIMARY KEY (`license`),
  ADD KEY `charid` (`charid`),
  ADD KEY `limit` (`limit`),
  ADD KEY `bypass` (`bypass`);

--
-- Indeksy dla tabeli `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `owner_2` (`owner`);

--
-- Indeksy dla tabeli `user_sim`
--
ALTER TABLE `user_sim`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `userdigit` (`userdigit`),
  ADD KEY `identifier` (`identifier`),
  ADD KEY `number` (`number`),
  ADD KEY `admin1` (`admin1`),
  ADD KEY `admin2` (`admin2`),
  ADD KEY `house` (`house`);

--
-- Indeksy dla tabeli `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`),
  ADD KEY `name` (`name`);

--
-- Indeksy dla tabeli `vehicle_tunings`
--
ALTER TABLE `vehicle_tunings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate` (`plate`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6942;

--
-- AUTO_INCREMENT dla tabeli `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `baninfo`
--
ALTER TABLE `baninfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `banlisthistory`
--
ALTER TABLE `banlisthistory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32730;

--
-- AUTO_INCREMENT dla tabeli `exile_org`
--
ALTER TABLE `exile_org`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1012;

--
-- AUTO_INCREMENT dla tabeli `exile_transfers`
--
ALTER TABLE `exile_transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `fine_types`
--
ALTER TABLE `fine_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=367;

--
-- AUTO_INCREMENT dla tabeli `lspd_mdc_judgments_suggestion`
--
ALTER TABLE `lspd_mdc_judgments_suggestion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT dla tabeli `lspd_mdc_judgments_suggestion_category`
--
ALTER TABLE `lspd_mdc_judgments_suggestion_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `lspd_mdc_tag_suggestion`
--
ALTER TABLE `lspd_mdc_tag_suggestion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `lspd_mdc_user_notes`
--
ALTER TABLE `lspd_mdc_user_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `lspd_mdc_vehicle_notes`
--
ALTER TABLE `lspd_mdc_vehicle_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `lspd_user_judgments`
--
ALTER TABLE `lspd_user_judgments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `owned_properties`
--
ALTER TABLE `owned_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `radiocar`
--
ALTER TABLE `radiocar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `radiocar_owned`
--
ALTER TABLE `radiocar_owned`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT dla tabeli `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `user_sim`
--
ALTER TABLE `user_sim`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `vehicle_tunings`
--
ALTER TABLE `vehicle_tunings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
