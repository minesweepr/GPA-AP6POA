-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 11, 2026 at 06:35 PM
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
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aluno`
--

INSERT INTO `aluno` (`id_aluno`, `nome`, `email`, `senha`, `escolaridade`, `CR`) VALUES
                                                                                     (1, 'João Pedro', 'joao@gmail.com', 'senha123', 'ensino superior', NULL),
                                                                                     (3, 'Vera Antônia', 'verant@gmail.com', 'senha123', 'ensino médio', NULL),
                                                                                     (4, 'Vinicius', 'vininunes@gmail.com', 'senha123', 'ensino superior', 8.65);

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
    ) ENGINE=InnoDB AUTO_INCREMENT=231 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aluno_materia`
--

INSERT INTO `aluno_materia` (`id_aluno_materia`, `id_semestre`, `id_materia`) VALUES
                                                                                  (63, 6, 41),
                                                                                  (64, 6, 42),
                                                                                  (65, 6, 43),
                                                                                  (66, 6, 44),
                                                                                  (67, 6, 45),
                                                                                  (68, 9, 46),
                                                                                  (69, 9, 47),
                                                                                  (70, 9, 48),
                                                                                  (71, 9, 49),
                                                                                  (72, 9, 50),
                                                                                  (73, 10, 51),
                                                                                  (74, 10, 52),
                                                                                  (75, 10, 53),
                                                                                  (76, 10, 54),
                                                                                  (77, 10, 55),
                                                                                  (78, 11, 56),
                                                                                  (79, 11, 57),
                                                                                  (80, 11, 58),
                                                                                  (81, 11, 59),
                                                                                  (82, 11, 60),
                                                                                  (161, 12, 61),
                                                                                  (160, 12, 62),
                                                                                  (159, 12, 63),
                                                                                  (158, 12, 64),
                                                                                  (177, 19, 70),
                                                                                  (178, 19, 71),
                                                                                  (179, 19, 72),
                                                                                  (180, 19, 73),
                                                                                  (181, 19, 74),
                                                                                  (182, 19, 75),
                                                                                  (183, 19, 76),
                                                                                  (184, 19, 77),
                                                                                  (185, 19, 78),
                                                                                  (186, 19, 79),
                                                                                  (187, 19, 80),
                                                                                  (188, 19, 81),
                                                                                  (201, 20, 70),
                                                                                  (166, 20, 71),
                                                                                  (167, 20, 72),
                                                                                  (168, 20, 73),
                                                                                  (169, 20, 74),
                                                                                  (176, 20, 75),
                                                                                  (170, 20, 76),
                                                                                  (175, 20, 77),
                                                                                  (174, 20, 78),
                                                                                  (171, 20, 79),
                                                                                  (172, 20, 80),
                                                                                  (173, 20, 81),
                                                                                  (189, 21, 70),
                                                                                  (190, 21, 71),
                                                                                  (191, 21, 72),
                                                                                  (192, 21, 73),
                                                                                  (193, 21, 74),
                                                                                  (195, 21, 75),
                                                                                  (194, 21, 76),
                                                                                  (196, 21, 77),
                                                                                  (197, 21, 78),
                                                                                  (198, 21, 79),
                                                                                  (199, 21, 80),
                                                                                  (200, 21, 81),
                                                                                  (202, 22, 1),
                                                                                  (203, 22, 2),
                                                                                  (204, 22, 3),
                                                                                  (205, 22, 4),
                                                                                  (206, 22, 5),
                                                                                  (207, 22, 6),
                                                                                  (208, 22, 7),
                                                                                  (209, 23, 8),
                                                                                  (210, 23, 9),
                                                                                  (211, 23, 10),
                                                                                  (212, 23, 11),
                                                                                  (213, 23, 12),
                                                                                  (214, 23, 13),
                                                                                  (215, 23, 14),
                                                                                  (216, 23, 15),
                                                                                  (217, 24, 16),
                                                                                  (218, 24, 17),
                                                                                  (219, 24, 18),
                                                                                  (220, 24, 19),
                                                                                  (221, 24, 20),
                                                                                  (222, 24, 21),
                                                                                  (223, 25, 22),
                                                                                  (224, 25, 23),
                                                                                  (225, 25, 24),
                                                                                  (226, 25, 25),
                                                                                  (227, 25, 26),
                                                                                  (228, 25, 27),
                                                                                  (229, 25, 28),
                                                                                  (230, 25, 29);

--
-- Triggers `aluno_materia`
--
DROP TRIGGER IF EXISTS `trg_insert_nota_aluno_materia`;
DELIMITER $$
CREATE TRIGGER `trg_insert_nota_aluno_materia` AFTER INSERT ON `aluno_materia` FOR EACH ROW BEGIN
    INSERT INTO notas (
        id_aluno_materia,
        av1,
        av2,
        avf,
        mf
    )
    VALUES (
               NEW.id_aluno_materia,
               NULL,
               NULL,
               NULL,
               NULL
           );
END
    $$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `materia`
--

DROP TABLE IF EXISTS `materia`;
CREATE TABLE IF NOT EXISTS `materia` (
                                         `id_materia` int(11) NOT NULL AUTO_INCREMENT,
    `sigla` varchar(10) NOT NULL,
    `nome` varchar(100) NOT NULL,
    `creditos` int(11) NOT NULL,
    `id_aluno` int(11) DEFAULT NULL,
    PRIMARY KEY (`id_materia`),
    KEY `fk_materia_aluno` (`id_aluno`)
    ) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `materia`
--

INSERT INTO `materia` (`id_materia`, `sigla`, `nome`, `creditos`, `id_aluno`) VALUES
                                                                                  (1, '1FAC', 'Fundamentos de Algoritmos de Computação', 4, 1),
                                                                                  (2, '1IAS', 'Introdução à Análise de Sistemas', 4, 1),
                                                                                  (3, '1IHM', 'Interface Homem-Máquina', 2, 1),
                                                                                  (4, '1LPO', 'Língua Portuguesa', 4, 1),
                                                                                  (5, '1MAB', 'Matemática Básica', 4, 1),
                                                                                  (6, '1MAC', 'Matemática para Computação', 4, 1),
                                                                                  (7, '1ORG', 'Organização de Computadores', 4, 1),
                                                                                  (8, '2CAL', 'Cálculo', 4, 1),
                                                                                  (9, '2CAW', 'Construção de Aplicações WEB', 4, 1),
                                                                                  (10, '2FPR', 'Fundamentos de Programação', 4, 1),
                                                                                  (11, '2LES', 'Língua Estrangeira', 2, 1),
                                                                                  (12, '2MPA', 'Métodos e Processos Administrativos', 2, 1),
                                                                                  (13, '2REQ', 'Engenharia de Requisitos', 4, 1),
                                                                                  (14, '2SOP', 'Fundamentos de Sistemas Operacionais', 4, 1),
                                                                                  (15, '2TPH', 'Técnicas e Paradigmas Humanos', 4, 1),
                                                                                  (16, '3ALG', 'Álgebra', 4, 1),
                                                                                  (17, '3DAW', 'Desenvolvimento de Tecnologias WEB', 4, 1),
                                                                                  (18, '3ESD', 'Estrutura de Dados', 4, 1),
                                                                                  (19, '3PBD', 'Projeto de Banco de Dados', 4, 1),
                                                                                  (20, '3POB', 'Programação Orientada a Objetos Básica', 4, 1),
                                                                                  (21, '3RSD', 'Fundamentos de Redes e Sistemas Distribuídos', 4, 1),
                                                                                  (22, '4ADS', 'Tópicos em ADS', 4, 1),
                                                                                  (23, '4EMP', 'Empreendedorismo e Inovação', 2, 1),
                                                                                  (24, '4EST', 'Estatística e Probabilidade', 4, 1),
                                                                                  (25, '4MET', 'Metodologia da Pesquisa', 2, 1),
                                                                                  (26, '4MOD', 'Modelagem de Sistemas', 4, 1),
                                                                                  (27, '4POA', 'Programação Orientada a Objetos Avançada', 4, 1),
                                                                                  (28, '4SEG', 'Segurança da Informação', 4, 1),
                                                                                  (29, '4UBD', 'Utilização de Banco de Dados e SQL', 4, 1),
                                                                                  (30, '5GPS', 'Gerência e Projeto de Sistemas', 2, 1),
                                                                                  (31, '5PDM', 'Programação de Dispositivos Móveis', 4, 1),
                                                                                  (32, '5PJS', 'Projeto de Sistemas', 4, 1),
                                                                                  (33, '5SBD', 'Programação de Scripts de Banco de Dados', 4, 1),
                                                                                  (34, '5TAV', 'Tópicos Avançados', 4, 1),
                                                                                  (41, 'ALG', 'ALGORITMOS E LÓGICA DE PROGRAMAÇÃO', 6, 4),
                                                                                  (42, 'CSO', 'COMPUTADORES E SOCIEDADE ', 4, 4),
                                                                                  (43, 'CSI', 'CONSTRUÇÃO DE SITES', 4, 4),
                                                                                  (44, 'FCO', 'FUNDAMENTOS DA COMPUTAÇÃO', 4, 4),
                                                                                  (45, 'LOG', 'LÓGICA MATEMÁTICA', 4, 4),
                                                                                  (46, 'BD1', 'BANCO DE DADOS I', 4, 4),
                                                                                  (47, 'ESD', 'ESTRUTURAS DE DADOS', 6, 4),
                                                                                  (48, 'OAC', 'ORGANIZAÇÃO E ARQUITETURA DE COMPUTADORES', 4, 4),
                                                                                  (49, 'POO', 'PROGRAMAÇÃO ORIENTADA A OBJETOS', 4, 4),
                                                                                  (50, 'PWB', 'PROGRAMAÇÃO WEB', 4, 4),
                                                                                  (51, 'BD2', 'BANCO DE DADOS II', 4, 4),
                                                                                  (52, 'DEI', 'DESIGN DE INTERAÇÃO', 4, 4),
                                                                                  (53, 'ES1', 'ENGENHARIA DE SOFTWARE I', 4, 4),
                                                                                  (54, 'PW1', 'PROGRAMAÇÃO ORIENTADA A OBJETOS PARA WEB I', 4, 4),
                                                                                  (55, 'SOP', 'SISTEMAS OPERACIONAIS', 4, 4),
                                                                                  (56, 'EMP', 'EMPREENDEDORISMO E INOVAÇÃO', 4, 4),
                                                                                  (57, 'ES2', 'ENGENHARIA DE SOFTWARE II', 4, 4),
                                                                                  (58, 'EST', 'ESTATÍSTICA', 4, 4),
                                                                                  (59, 'PW2', 'PROGRAMAÇÃO ORIENTADA A OBJETOS PARA WEB II', 4, 4),
                                                                                  (60, 'REC', 'REDES DE COMPUTADORES', 4, 4),
                                                                                  (61, 'PDP', 'PADRÕES DE PROJETO', 4, 4),
                                                                                  (62, 'PDM', 'PROGRAMAÇÃO PARA DISPOSITIVOS MÓVEIS', 4, 4),
                                                                                  (63, 'PRI', 'PROJETO INTEGRADOR', 12, 4),
                                                                                  (64, 'TC1', 'TRABALHO DE CONCLUSÃO DE CURSO I', 4, 4),
                                                                                  (70, 'ART', 'Artes', 2, 3),
                                                                                  (71, 'EDF', 'Educação Física', 2, 3),
                                                                                  (72, 'FILO', 'Filosofia', 2, 3),
                                                                                  (73, 'SOC', 'Sociologia', 2, 3),
                                                                                  (74, 'ING', 'Inglês', 2, 3),
                                                                                  (75, 'FIS', 'Física', 4, 3),
                                                                                  (76, 'QUI', 'Química', 4, 3),
                                                                                  (77, 'BIO', 'Biologia', 4, 3),
                                                                                  (78, 'GEO', 'Geografia', 4, 3),
                                                                                  (79, 'HST', 'História', 4, 3),
                                                                                  (80, 'MAT', 'Matemática', 4, 3),
                                                                                  (81, 'PRT', 'Língua Portuguesa', 4, 3);

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
    ) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notas`
--

INSERT INTO `notas` (`id_nota`, `id_aluno_materia`, `av1`, `av2`, `avf`, `mf`) VALUES
                                                                                   (18, 63, 6.40, 7.30, 9.00, 6.85),
                                                                                   (19, 64, 9.00, 10.00, NULL, 9.50),
                                                                                   (20, 65, 9.06, 10.00, NULL, 9.53),
                                                                                   (21, 66, 7.20, 9.60, NULL, 8.40),
                                                                                   (22, 67, 6.90, 9.30, NULL, 8.10),
                                                                                   (23, 68, 9.80, 8.75, NULL, 9.28),
                                                                                   (24, 69, 8.60, 9.00, NULL, 8.80),
                                                                                   (25, 70, 9.70, 9.40, NULL, 9.55),
                                                                                   (26, 71, 5.90, 8.80, NULL, 7.35),
                                                                                   (27, 72, 10.00, 9.20, NULL, 9.60),
                                                                                   (28, 73, 8.20, 9.48, NULL, 8.84),
                                                                                   (29, 74, 7.95, 8.80, NULL, 8.38),
                                                                                   (30, 75, 10.00, 10.00, NULL, 10.00),
                                                                                   (31, 76, 8.50, 10.00, NULL, 9.25),
                                                                                   (32, 77, 8.38, 9.80, NULL, 9.09),
                                                                                   (33, 78, 10.00, 10.00, NULL, 10.00),
                                                                                   (34, 79, 6.00, 8.18, NULL, 7.09),
                                                                                   (35, 80, 9.00, 10.00, NULL, 9.50),
                                                                                   (36, 81, 8.00, 9.00, NULL, 8.50),
                                                                                   (37, 82, 8.35, 9.00, NULL, 8.68),
                                                                                   (38, 158, 6.00, 7.00, NULL, 6.50),
                                                                                   (39, 159, 8.00, NULL, NULL, NULL),
                                                                                   (40, 160, NULL, NULL, NULL, NULL),
                                                                                   (41, 161, NULL, NULL, NULL, NULL),
                                                                                   (46, 166, NULL, NULL, NULL, NULL),
                                                                                   (47, 167, NULL, NULL, NULL, NULL),
                                                                                   (48, 168, NULL, NULL, NULL, NULL),
                                                                                   (49, 169, NULL, NULL, NULL, NULL),
                                                                                   (50, 170, NULL, NULL, NULL, NULL),
                                                                                   (51, 171, NULL, NULL, NULL, NULL),
                                                                                   (52, 172, NULL, NULL, NULL, NULL),
                                                                                   (53, 173, NULL, NULL, NULL, NULL),
                                                                                   (54, 174, NULL, NULL, NULL, NULL),
                                                                                   (55, 175, NULL, NULL, NULL, NULL),
                                                                                   (56, 176, NULL, NULL, NULL, NULL),
                                                                                   (57, 177, NULL, NULL, NULL, NULL),
                                                                                   (58, 178, NULL, NULL, NULL, NULL),
                                                                                   (59, 179, NULL, NULL, NULL, NULL),
                                                                                   (60, 180, NULL, NULL, NULL, NULL),
                                                                                   (61, 181, NULL, NULL, NULL, NULL),
                                                                                   (62, 182, NULL, NULL, NULL, NULL),
                                                                                   (63, 183, NULL, NULL, NULL, NULL),
                                                                                   (64, 184, NULL, NULL, NULL, NULL),
                                                                                   (65, 185, NULL, NULL, NULL, NULL),
                                                                                   (66, 186, NULL, NULL, NULL, NULL),
                                                                                   (67, 187, NULL, NULL, NULL, NULL),
                                                                                   (68, 188, NULL, NULL, NULL, NULL),
                                                                                   (69, 189, NULL, NULL, NULL, NULL),
                                                                                   (70, 190, NULL, NULL, NULL, NULL),
                                                                                   (71, 191, NULL, NULL, NULL, NULL),
                                                                                   (72, 192, NULL, NULL, NULL, NULL),
                                                                                   (73, 193, NULL, NULL, NULL, NULL),
                                                                                   (74, 194, NULL, NULL, NULL, NULL),
                                                                                   (75, 195, NULL, NULL, NULL, NULL),
                                                                                   (76, 196, NULL, NULL, NULL, NULL),
                                                                                   (77, 197, NULL, NULL, NULL, NULL),
                                                                                   (78, 198, NULL, NULL, NULL, NULL),
                                                                                   (79, 199, NULL, NULL, NULL, NULL),
                                                                                   (80, 200, NULL, NULL, NULL, NULL),
                                                                                   (81, 201, NULL, NULL, NULL, NULL),
                                                                                   (82, 202, NULL, NULL, NULL, NULL),
                                                                                   (83, 203, NULL, NULL, NULL, NULL),
                                                                                   (84, 204, NULL, NULL, NULL, NULL),
                                                                                   (85, 205, NULL, NULL, NULL, NULL),
                                                                                   (86, 206, NULL, NULL, NULL, NULL),
                                                                                   (87, 207, NULL, NULL, NULL, NULL),
                                                                                   (88, 208, NULL, NULL, NULL, NULL),
                                                                                   (89, 209, NULL, NULL, NULL, NULL),
                                                                                   (90, 210, NULL, NULL, NULL, NULL),
                                                                                   (91, 211, NULL, NULL, NULL, NULL),
                                                                                   (92, 212, NULL, NULL, NULL, NULL),
                                                                                   (93, 213, NULL, NULL, NULL, NULL),
                                                                                   (94, 214, NULL, NULL, NULL, NULL),
                                                                                   (95, 215, NULL, NULL, NULL, NULL),
                                                                                   (96, 216, NULL, NULL, NULL, NULL),
                                                                                   (97, 217, NULL, NULL, NULL, NULL),
                                                                                   (98, 218, NULL, NULL, NULL, NULL),
                                                                                   (99, 219, NULL, NULL, NULL, NULL),
                                                                                   (100, 220, NULL, NULL, NULL, NULL),
                                                                                   (101, 221, NULL, NULL, NULL, NULL),
                                                                                   (102, 222, NULL, NULL, NULL, NULL),
                                                                                   (103, 223, NULL, NULL, NULL, NULL),
                                                                                   (104, 224, NULL, NULL, NULL, NULL),
                                                                                   (105, 225, NULL, NULL, NULL, NULL),
                                                                                   (106, 226, NULL, NULL, NULL, NULL),
                                                                                   (107, 227, NULL, NULL, NULL, NULL),
                                                                                   (108, 228, NULL, NULL, NULL, NULL),
                                                                                   (109, 229, NULL, NULL, NULL, NULL),
                                                                                   (110, 230, NULL, NULL, NULL, NULL);

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
    ) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semestre`
--

INSERT INTO `semestre` (`id_semestre`, `id_aluno`, `titulo`, `desempenho`) VALUES
                                                                               (6, 4, '2024.1', 8.48),
                                                                               (9, 4, '2024.2', 8.92),
                                                                               (10, 4, '2025.1', 9.11),
                                                                               (11, 4, '2025.2', 8.75),
                                                                               (12, 4, '2026.1', 6.50),
                                                                               (19, 3, '2025.2', NULL),
                                                                               (20, 3, '2025.1', NULL),
                                                                               (21, 3, '2026.1', NULL),
                                                                               (22, 1, '2024.2', NULL),
                                                                               (23, 1, '2025.1', NULL),
                                                                               (24, 1, '2025.2', NULL),
                                                                               (25, 1, '2026.1', NULL);

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
    `id_google_calendar` varchar(255) DEFAULT NULL,
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
-- Constraints for table `materia`
--
ALTER TABLE `materia`
    ADD CONSTRAINT `fk_materia_aluno` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id_aluno`);

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