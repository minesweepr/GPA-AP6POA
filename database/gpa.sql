-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01/05/2026 às 02:41
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `gpa`
--

DELIMITER $$
--
-- Funções
--
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
-- Estrutura para tabela `aluno`
--

CREATE TABLE `aluno` (
  `id_aluno` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `escolaridade` varchar(50) DEFAULT NULL,
  `CR` decimal(4,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `aluno_materia`
--

CREATE TABLE `aluno_materia` (
  `id_aluno_materia` int(11) NOT NULL,
  `id_semestre` int(11) NOT NULL,
  `id_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `materia`
--

CREATE TABLE `materia` (
  `id_materia` int(11) NOT NULL,
  `sigla` varchar(5) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `creditos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Estrutura para tabela `notas`
--

CREATE TABLE `notas` (
  `id_nota` int(11) NOT NULL,
  `id_aluno_materia` int(11) NOT NULL,
  `av1` decimal(4,2) DEFAULT NULL,
  `av2` decimal(4,2) DEFAULT NULL,
  `avf` decimal(4,2) DEFAULT NULL,
  `mf` decimal(4,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `notas`
--
DELIMITER $$
CREATE TRIGGER `trg_calcular_mf` BEFORE INSERT ON `notas` FOR EACH ROW BEGIN
    SET NEW.mf = f_media_final(NEW.av1, NEW.av2, NEW.avf);
END
$$
DELIMITER ;
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
DELIMITER $$
CREATE TRIGGER `trg_update_mf` BEFORE UPDATE ON `notas` FOR EACH ROW BEGIN
    SET NEW.mf = f_media_final(NEW.av1, NEW.av2, NEW.avf);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `semestre`
--

CREATE TABLE `semestre` (
  `id_semestre` int(11) NOT NULL,
  `id_aluno` int(11) NOT NULL,
  `titulo` varchar(6) NOT NULL,
  `desempenho` decimal(4,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `semestre`
--

--
-- Acionadores `semestre`
--
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
-- Estrutura para tabela `trabalhos`
--

CREATE TABLE `trabalhos` (
  `id_trabalho` int(11) NOT NULL,
  `id_aluno_materia` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `data_entrega_prevista` date DEFAULT NULL,
  `data_entrega_aluno` date DEFAULT NULL,
  `situacao` enum('atribuida','pendente','entregue') DEFAULT 'atribuida'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Acionadores `trabalhos`
--
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
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `aluno`
--
ALTER TABLE `aluno`
  ADD PRIMARY KEY (`id_aluno`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `aluno_materia`
--
ALTER TABLE `aluno_materia`
  ADD PRIMARY KEY (`id_aluno_materia`),
  ADD UNIQUE KEY `id_semestre` (`id_semestre`,`id_materia`),
  ADD KEY `fk_am_materia` (`id_materia`);

--
-- Índices de tabela `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`id_materia`);

--
-- Índices de tabela `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`id_nota`),
  ADD UNIQUE KEY `id_aluno_materia` (`id_aluno_materia`);

--
-- Índices de tabela `semestre`
--
ALTER TABLE `semestre`
  ADD PRIMARY KEY (`id_semestre`),
  ADD UNIQUE KEY `id_aluno` (`id_aluno`,`titulo`);

--
-- Índices de tabela `trabalhos`
--
ALTER TABLE `trabalhos`
  ADD PRIMARY KEY (`id_trabalho`),
  ADD KEY `fk_trabalhos_am` (`id_aluno_materia`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `aluno`
--
ALTER TABLE `aluno`
  MODIFY `id_aluno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `aluno_materia`
--
ALTER TABLE `aluno_materia`
  MODIFY `id_aluno_materia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `materia`
--
ALTER TABLE `materia`
  MODIFY `id_materia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `notas`
--
ALTER TABLE `notas`
  MODIFY `id_nota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `semestre`
--
ALTER TABLE `semestre`
  MODIFY `id_semestre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `trabalhos`
--
ALTER TABLE `trabalhos`
  MODIFY `id_trabalho` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `aluno_materia`
--
ALTER TABLE `aluno_materia`
  ADD CONSTRAINT `fk_am_materia` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`),
  ADD CONSTRAINT `fk_am_semestre` FOREIGN KEY (`id_semestre`) REFERENCES `semestre` (`id_semestre`) ON DELETE CASCADE;

--
-- Restrições para tabelas `notas`
--
ALTER TABLE `notas`
  ADD CONSTRAINT `fk_notas_am` FOREIGN KEY (`id_aluno_materia`) REFERENCES `aluno_materia` (`id_aluno_materia`) ON DELETE CASCADE;

--
-- Restrições para tabelas `semestre`
--
ALTER TABLE `semestre`
  ADD CONSTRAINT `fk_semestre_aluno` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id_aluno`) ON DELETE CASCADE;

--
-- Restrições para tabelas `trabalhos`
--
ALTER TABLE `trabalhos`
  ADD CONSTRAINT `fk_trabalhos_am` FOREIGN KEY (`id_aluno_materia`) REFERENCES `aluno_materia` (`id_aluno_materia`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
