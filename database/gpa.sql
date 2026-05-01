-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 01, 2026 at 09:09 PM
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
CREATE DATABASE IF NOT EXISTS `gpa` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gpa`;

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `f_media_final`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `f_media_final` (`av1` DECIMAL(4,2), `av2` DECIMAL(4,2), `avf` DECIMAL(4,2)) RETURNS DECIMAL(4,2) DETERMINISTIC BEGIN
    DECLARE media_parcial DECIMAL(4,2);

    IF av1 IS NULL OR av2 IS NULL THEN
        RETURN NULL;
END IF;

    SET media_parcial = (av1 + av2) / 2;

    IF media_parcial >= 6 THEN
        RETURN media_parcial;
    ELSEIF avf IS NOT NULL THEN
        RETURN (media_parcial + avf) / 2;
ELSE
        RETURN media_parcial;
END IF;
END$$

DELIMITER ;

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
    ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aluno`
--

INSERT INTO `aluno` (`id_aluno`, `nome`, `email`, `senha`, `escolaridade`, `CR`) VALUES
                                                                                     (1, 'João Pedro', 'joao@gmail.com', 'senha123', 'ensino superior', 10.00),
                                                                                     (3, 'teste', 'teste', 'teste', 'ensino médio', NULL);

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
    KEY `fk_am_materia` (`id_materia`)
    ) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aluno_materia`
--

INSERT INTO `aluno_materia` (`id_aluno_materia`, `id_semestre`, `id_materia`) VALUES
                                                                                  (45, 1, 22),
                                                                                  (46, 1, 23),
                                                                                  (47, 1, 24),
                                                                                  (48, 1, 25),
                                                                                  (49, 1, 26),
                                                                                  (50, 1, 27),
                                                                                  (51, 1, 28),
                                                                                  (52, 1, 29),
                                                                                  (32, 2, 8),
                                                                                  (33, 2, 9),
                                                                                  (34, 2, 10),
                                                                                  (35, 2, 11),
                                                                                  (31, 2, 12),
                                                                                  (36, 2, 13),
                                                                                  (37, 2, 14),
                                                                                  (38, 2, 15),
                                                                                  (39, 4, 16),
                                                                                  (40, 4, 17),
                                                                                  (41, 4, 18),
                                                                                  (42, 4, 19),
                                                                                  (43, 4, 20),
                                                                                  (44, 4, 21);

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
    ) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `materia`
--

INSERT INTO `materia` (`id_materia`, `sigla`, `nome`, `creditos`) VALUES
                                                                      (1, '1FAC', 'Fundamentos de Algoritmos de Computação', 4),
                                                                      (2, '1IAS', 'Introdução à Análise de Sistemas', 4),
                                                                      (3, '1IHM', 'Interface Homem-Máquina', 2),
                                                                      (4, '1LPO', 'Língua Portuguesa', 4),
                                                                      (5, '1MAB', 'Matemática Básica', 4),
                                                                      (6, '1MAC', 'Matemática para Computação', 4),
                                                                      (7, '1ORG', 'Organização de Computadores', 4),
                                                                      (8, '2CAL', 'Cálculo', 4),
                                                                      (9, '2CAW', 'Construção de Aplicações WEB', 4),
                                                                      (10, '2FPR', 'Fundamentos de Programação', 4),
                                                                      (11, '2LES', 'Língua Estrangeira', 2),
                                                                      (12, '2MPA', 'Métodos e Processos Administrativos', 2),
                                                                      (13, '2REQ', 'Engenharia de Requisitos', 4),
                                                                      (14, '2SOP', 'Fundamentos de Sistemas Operacionais', 4),
                                                                      (15, '2TPH', 'Técnicas e Paradigmas Humanos', 4),
                                                                      (16, '3ALG', 'Álgebra', 4),
                                                                      (17, '3DAW', 'Desenvolvimento de Tecnologias WEB', 4),
                                                                      (18, '3ESD', 'Estrutura de Dados', 4),
                                                                      (19, '3PBD', 'Projeto de Banco de Dados', 4),
                                                                      (20, '3POB', 'Programação Orientada a Objetos Básica', 4),
                                                                      (21, '3RSD', 'Fundamentos de Redes e Sistemas Distribuí­dos', 4),
                                                                      (22, '4ADS', 'Tópicos em ADS', 4),
                                                                      (23, '4EMP', 'Empreendedorismo e Inovação', 2),
                                                                      (24, '4EST', 'Estatística e Probabilidade', 4),
                                                                      (25, '4MET', 'Metodologia da Pesquisa', 2),
                                                                      (26, '4MOD', 'Modelagem de Sistemas', 4),
                                                                      (27, '4POA', 'Programação Orientada a Objetos Avançada', 4),
                                                                      (28, '4SEG', 'Segurança da Informação', 4),
                                                                      (29, '4UBD', 'Utilização de Banco de Dados e SQL', 4),
                                                                      (30, '5GPS', 'Gerência e Projeto de Sistemas', 2),
                                                                      (31, '5PDM', 'Programação de Dispositivos Móveis', 4),
                                                                      (32, '5PJS', 'Projeto de Sistemas', 4),
                                                                      (33, '5SBD', 'Programação de Scripts de Banco de Dados', 4),
                                                                      (34, '5TAV', 'Tópicos Avançados', 4);

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
    ) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `notas`
--
DROP TRIGGER IF EXISTS `trg_calcular_mf`;
DELIMITER $$
CREATE TRIGGER `trg_calcular_mf` BEFORE INSERT ON `notas` FOR EACH ROW BEGIN
    SET NEW.mf = f_media_final(NEW.av1, NEW.av2, NEW.avf);
END
    $$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_insert_desempenho`;
DELIMITER $$
CREATE TRIGGER `trg_insert_desempenho` AFTER INSERT ON `notas` FOR EACH ROW BEGIN
    UPDATE semestre s
        JOIN aluno_materia am ON am.id_semestre = s.id_semestre
        SET s.desempenho = (
        SELECT AVG(n2.mf)
        FROM aluno_materia am2
        JOIN notas n2 ON n2.id_aluno_materia = am2.id_aluno_materia
        WHERE am2.id_semestre = s.id_semestre
        AND n2.mf IS NOT NULL
        )
    WHERE am.id_aluno_materia = NEW.id_aluno_materia;
END
    $$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_update_desempenho`;
DELIMITER $$
CREATE TRIGGER `trg_update_desempenho` AFTER UPDATE ON `notas` FOR EACH ROW BEGIN
    IF (OLD.mf IS NULL AND NEW.mf IS NOT NULL)
       OR (OLD.mf IS NOT NULL AND NEW.mf IS NULL)
       OR (OLD.mf <> NEW.mf) THEN

    UPDATE semestre s
        JOIN aluno_materia am ON am.id_semestre = s.id_semestre
        SET s.desempenho = (
        SELECT AVG(n2.mf)
        FROM aluno_materia am2
        JOIN notas n2 ON n2.id_aluno_materia = am2.id_aluno_materia
        WHERE am2.id_semestre = s.id_semestre
        AND n2.mf IS NOT NULL
        )
    WHERE am.id_aluno_materia = NEW.id_aluno_materia;

END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_update_mf`;
DELIMITER $$
CREATE TRIGGER `trg_update_mf` BEFORE UPDATE ON `notas` FOR EACH ROW BEGIN
    SET NEW.mf = f_media_final(NEW.av1, NEW.av2, NEW.avf);
END
    $$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `semestre`
--

DROP TABLE IF EXISTS `semestre`;
CREATE TABLE IF NOT EXISTS `semestre` (
                                          `id_semestre` int(11) NOT NULL AUTO_INCREMENT,
    `id_aluno` int(11) NOT NULL,
    `titulo` varchar(6) NOT NULL,
    `desempenho` decimal(4,2) DEFAULT 0.00,
    PRIMARY KEY (`id_semestre`),
    UNIQUE KEY `id_aluno` (`id_aluno`,`titulo`)
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semestre`
--

INSERT INTO `semestre` (`id_semestre`, `id_aluno`, `titulo`, `desempenho`) VALUES
                                                                               (1, 1, '2026.1', 10.00),
                                                                               (2, 1, '2025.1', NULL),
                                                                               (4, 1, '2025.2', NULL);

--
-- Triggers `semestre`
--
DROP TRIGGER IF EXISTS `trg_update_cr`;
DELIMITER $$
CREATE TRIGGER `trg_update_cr` AFTER UPDATE ON `semestre` FOR EACH ROW BEGIN
    UPDATE aluno a
    SET a.CR = (
        SELECT
            SUM(n.mf * m.creditos) / SUM(m.creditos)
        FROM semestre s
                 JOIN aluno_materia am ON am.id_semestre = s.id_semestre
                 JOIN notas n ON n.id_aluno_materia = am.id_aluno_materia
                 JOIN materia m ON m.id_materia = am.id_materia
        WHERE s.id_aluno = a.id_aluno
          AND n.mf IS NOT NULL
    )
    WHERE a.id_aluno = NEW.id_aluno;
END
    $$
DELIMITER ;

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
    KEY `fk_trabalhos_am` (`id_aluno_materia`)
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `trabalhos`
--
DROP TRIGGER IF EXISTS `atualizar_situacao_trabalho`;
DELIMITER $$
CREATE TRIGGER `atualizar_situacao_trabalho` BEFORE UPDATE ON `trabalhos` FOR EACH ROW BEGIN
    IF NEW.data_entrega_aluno IS NULL
       AND NEW.data_entrega_prevista < CURDATE() THEN
        SET NEW.situacao = 'pendente';
END IF;

IF NEW.data_entrega_aluno IS NOT NULL THEN
        SET NEW.situacao = 'entregue';
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
    ADD CONSTRAINT `fk_am_materia` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`),
  ADD CONSTRAINT `fk_am_semestre` FOREIGN KEY (`id_semestre`) REFERENCES `semestre` (`id_semestre`) ON DELETE CASCADE;

--
-- Constraints for table `notas`
--
ALTER TABLE `notas`
    ADD CONSTRAINT `fk_notas_am` FOREIGN KEY (`id_aluno_materia`) REFERENCES `aluno_materia` (`id_aluno_materia`) ON DELETE CASCADE;

--
-- Constraints for table `semestre`
--
ALTER TABLE `semestre`
    ADD CONSTRAINT `fk_semestre_aluno` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id_aluno`) ON DELETE CASCADE;

--
-- Constraints for table `trabalhos`
--
ALTER TABLE `trabalhos`
    ADD CONSTRAINT `fk_trabalhos_am` FOREIGN KEY (`id_aluno_materia`) REFERENCES `aluno_materia` (`id_aluno_materia`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
