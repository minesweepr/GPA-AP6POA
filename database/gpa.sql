-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 24, 2026 at 06:39 PM
-- Server version: 12.2.2-MariaDB
-- PHP Version: 8.4.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gpa`
--

-- --------------------------------------------------------

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
CREATE TABLE IF NOT EXISTS `aluno` (
  `id_aluno` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `escolaridade` varchar(50) DEFAULT NULL,
  `CR` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id_aluno`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aluno_materia`
--

DROP TABLE IF EXISTS `aluno_materia`;
CREATE TABLE IF NOT EXISTS `aluno_materia` (
  `id_aluno_materia` int(11) NOT NULL AUTO_INCREMENT,
  `id_semestre` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL,
  PRIMARY KEY (`id_aluno_materia`),
  UNIQUE KEY `id_semestre` (`id_semestre`,`id_materia`),
  KEY `id_materia` (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `materia`
--

DROP TABLE IF EXISTS `materia`;
CREATE TABLE IF NOT EXISTS `materia` (
  `id_materia` int(11) NOT NULL AUTO_INCREMENT,
  `sigla` varchar(5) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `creditos` int(11) NOT NULL,
  PRIMARY KEY (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
CREATE TABLE IF NOT EXISTS `notas` (
  `id_nota` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno_materia` int(11) NOT NULL,
  `av1` decimal(4,2) DEFAULT NULL,
  `av2` decimal(4,2) DEFAULT NULL,
  `avf` decimal(4,2) DEFAULT NULL,
  `mf` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id_nota`),
  UNIQUE KEY `id_aluno_materia` (`id_aluno_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `semestre`
--

DROP TABLE IF EXISTS `semestre`;
CREATE TABLE IF NOT EXISTS `semestre` (
  `id_semestre` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) NOT NULL,
  `titulo` varchar(6) NOT NULL,
  `desempenho` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id_semestre`),
  UNIQUE KEY `id_aluno` (`id_aluno`,`titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trabalhos`
--

DROP TABLE IF EXISTS `trabalhos`;
CREATE TABLE IF NOT EXISTS `trabalhos` (
  `id_trabalho` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno_materia` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `data_entrega_prevista` date DEFAULT NULL,
  `data_entrega_aluno` date DEFAULT NULL,
  `situacao` enum('atribuida','pendente','entregue') DEFAULT 'atribuida',
  PRIMARY KEY (`id_trabalho`),
  KEY `id_aluno_materia` (`id_aluno_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Triggers `trabalhos`
--
DROP TRIGGER IF EXISTS `atualizar_situacao_trabalho`;
DELIMITER $$
CREATE TRIGGER `atualizar_situacao_trabalho` BEFORE UPDATE ON `trabalhos` FOR EACH ROW BEGIN
    IF NEW.data_entrega_aluno IS NULL AND NEW.data_entrega_prevista<CURDATE() THEN
        SET NEW.situacao='pendente';
    END IF;

    IF NEW.data_entrega_aluno IS NOT NULL THEN
        SET NEW.situacao='entregue';
    END IF;
END
$$
DELIMITER ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aluno_materia`
--
ALTER TABLE `aluno_materia`
  ADD CONSTRAINT `1` FOREIGN KEY (`id_semestre`) REFERENCES `semestre` (`id_semestre`) ON DELETE CASCADE,
  ADD CONSTRAINT `2` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`);

--
-- Constraints for table `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `1` FOREIGN KEY (`id_aluno_materia`) REFERENCES `aluno_materia` (`id_aluno_materia`) ON DELETE CASCADE;

--
-- Constraints for table `semestre`
--
ALTER TABLE `semestre`
  ADD CONSTRAINT `1` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id_aluno`) ON DELETE CASCADE;

--
-- Constraints for table `trabalhos`
--
ALTER TABLE `trabalhos`
  ADD CONSTRAINT `1` FOREIGN KEY (`id_aluno_materia`) REFERENCES `aluno_materia` (`id_aluno_materia`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
