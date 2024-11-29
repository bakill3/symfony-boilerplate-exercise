-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Tempo de geração: 29-Nov-2024 às 14:45
-- Versão do servidor: 11.1.6-MariaDB-ubu2204
-- versão do PHP: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `api`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Extraindo dados da tabela `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20231201174915', '2024-11-25 18:30:36', 20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `payment_label` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `gps_latitude` double NOT NULL,
  `gps_longitude` double NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `transaction`
--

INSERT INTO `transaction` (`id`, `amount`, `payment_label`, `date`, `gps_latitude`, `gps_longitude`, `user_id`, `location`) VALUES
(2, 49.99, 'VISA', '2024-11-21 15:00:00', 53.275041770174, -7.7783203125, 'a9411591-ab7f-11ef-9acb-0242ac120002', '76GC+2M Rath Upper, County Offaly, Irlanda'),
(3, 5, '', '2024-11-20 14:21:40', 1234, 1112, 'fce8d376-ad86-11ef-a6d3-0242ac120002', 'FBurguer'),
(4, 99, 'VISA', '2024-11-28 14:45:14', 40.87090598078, -8.6722526172851, 'a9411591-ab7f-11ef-9acb-0242ac120002', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `user`
--

CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `password` varchar(180) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `score` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `user`
--

INSERT INTO `user` (`id`, `password`, `email`, `roles`, `first_name`, `last_name`, `score`) VALUES
('a9411591-ab7f-11ef-9acb-0242ac120002', '$2y$13$q5wHKPzEa7vR5Ow7v4tTxOi0mpKdM2HZu9w8m7fl9.KTw4HdQ.9X6', 'gabriel@gmail.com', '[\"ROLE_ADMIN\"]', 'Gabriel', 'Brandao', 0),
('fce8d376-ad86-11ef-a6d3-0242ac120002', '$2y$13$q5wHKPzEa7vR5Ow7v4tTxOi0mpKdM2HZu9w8m7fl9.KTw4HdQ.9X6', 'test@gmail.com', '[\"ROLE_USER\"]', '', '', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Índices para tabela `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_transaction_user` (`user_id`);

--
-- Índices para tabela `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `FK_transaction_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
