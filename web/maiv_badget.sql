-- phpMyAdmin SQL Dump
-- version 4.2.10
-- http://www.phpmyadmin.net
--
-- Machine: localhost:8889
-- Gegenereerd op: 13 jun 2015 om 22:26
-- Serverversie: 5.5.38
-- PHP-versie: 5.6.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databank: `maiv_badget`
--
CREATE DATABASE IF NOT EXISTS `maiv_badget` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `maiv_badget`;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bg_badges`
--

CREATE TABLE `bg_badges` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `goal` varchar(255) NOT NULL,
  `photo_url` text NOT NULL,
  `date_achieved` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bg_barman`
--

CREATE TABLE `bg_barman` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `day` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `angle` float NOT NULL,
  `seconds` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bg_coordinator`
--

CREATE TABLE `bg_coordinator` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `day` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time` time NOT NULL,
  `distance` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bg_organisator`
--

CREATE TABLE `bg_organisator` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `day` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `friends` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bg_users`
--

CREATE TABLE `bg_users` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(60) NOT NULL,
  `gender` enum('m','f') NOT NULL,
  `photo_url` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `bg_badges`
--
ALTER TABLE `bg_badges`
 ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `bg_barman`
--
ALTER TABLE `bg_barman`
 ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `bg_coordinator`
--
ALTER TABLE `bg_coordinator`
 ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `bg_organisator`
--
ALTER TABLE `bg_organisator`
 ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `bg_users`
--
ALTER TABLE `bg_users`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `bg_badges`
--
ALTER TABLE `bg_badges`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `bg_barman`
--
ALTER TABLE `bg_barman`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `bg_coordinator`
--
ALTER TABLE `bg_coordinator`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `bg_organisator`
--
ALTER TABLE `bg_organisator`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT voor een tabel `bg_users`
--
ALTER TABLE `bg_users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
