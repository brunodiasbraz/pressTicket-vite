-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 31/10/2024 às 16:48
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "-03:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `press-ticket`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `ContactCustomFields`
--

CREATE TABLE `ContactCustomFields` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `contactId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Contacts`
--

CREATE TABLE `Contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `profilePicUrl` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `email` varchar(255) DEFAULT '',
  `isGroup` tinyint(1) NOT NULL DEFAULT 0,
  `messengerId` text DEFAULT NULL,
  `instagramId` text DEFAULT NULL,
  `telegramId` text DEFAULT NULL,
  `webchatId` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ContactTags`
--

CREATE TABLE `ContactTags` (
  `contactId` int(11) NOT NULL,
  `tagId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Integrations`
--

CREATE TABLE `Integrations` (
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `Integrations`
--

INSERT INTO `Integrations` (`key`, `value`, `createdAt`, `updatedAt`) VALUES
('apikey', '', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('apiMaps', '', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('hubToken', '', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('organization', '', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('urlApiN8N', '', '2024-10-31 10:18:57', '2024-10-31 10:18:57');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Messages`
--

CREATE TABLE `Messages` (
  `id` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `ack` int(11) NOT NULL DEFAULT 0,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `mediaType` varchar(255) DEFAULT NULL,
  `mediaUrl` varchar(255) DEFAULT NULL,
  `ticketId` int(11) NOT NULL,
  `createdAt` datetime(6) NOT NULL,
  `updatedAt` datetime(6) NOT NULL,
  `fromMe` tinyint(1) NOT NULL DEFAULT 0,
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `contactId` int(11) DEFAULT NULL,
  `quotedMsgId` varchar(255) DEFAULT NULL,
  `isEdited` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `OldMessages`
--

CREATE TABLE `OldMessages` (
  `id` int(11) NOT NULL,
  `body` text NOT NULL,
  `messageId` varchar(255) DEFAULT NULL,
  `createdAt` datetime(6) NOT NULL,
  `updatedAt` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Queues`
--

CREATE TABLE `Queues` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `greetingMessage` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `startWork` varchar(255) DEFAULT NULL,
  `endWork` varchar(255) DEFAULT NULL,
  `absenceMessage` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `QuickAnswers`
--

CREATE TABLE `QuickAnswers` (
  `id` int(11) NOT NULL,
  `shortcut` text NOT NULL,
  `message` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `SequelizeMeta`
--

CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Despejando dados para a tabela `SequelizeMeta`
--

INSERT INTO `SequelizeMeta` (`name`) VALUES
('20200717133438-create-users.js'),
('20200717144403-create-contacts.js'),
('20200717145643-create-tickets.js'),
('20200717151645-create-messages.js'),
('20200717170223-create-whatsapps.js'),
('20200723200315-create-contacts-custom-fields.js'),
('20200723202116-add-email-field-to-contacts.js'),
('20200730153237-remove-user-association-from-messages.js'),
('20200730153545-add-fromMe-to-messages.js'),
('20200813114236-change-ticket-lastMessage-column-type.js'),
('20200901235509-add-profile-column-to-users.js'),
('20200903215941-create-settings.js'),
('20200904220257-add-name-to-whatsapp.js'),
('20200906122228-add-name-default-field-to-whatsapp.js'),
('20200906155658-add-whatsapp-field-to-tickets.js'),
('20200919124112-update-default-column-name-on-whatsappp.js'),
('20200927220708-add-isDeleted-column-to-messages.js'),
('20200929145451-add-user-tokenVersion-column.js'),
('20200930162323-add-isGroup-column-to-tickets.js'),
('20200930194808-add-isGroup-column-to-contacts.js'),
('20201004150008-add-contactId-column-to-messages.js'),
('20201004155719-add-vcardContactId-column-to-messages.js'),
('20201004955719-remove-vcardContactId-column-to-messages.js'),
('20201026215410-add-retries-to-whatsapps.js'),
('20201028124427-add-quoted-msg-to-messages.js'),
('20210108001431-add-unreadMessages-to-tickets.js'),
('20210108164404-create-queues.js'),
('20210108164504-add-queueId-to-tickets.js'),
('20210108174594-associate-whatsapp-queue.js'),
('20210108204708-associate-users-queue.js'),
('20210109192513-add-greetingMessage-to-whatsapp.js'),
('20210818102605-create-quickAnswers.js'),
('20211016014719-add-farewellMessage-to-whatsapp.js'),
('20220223095932-add-whatsapp-to-user.js'),
('20220619203200-add-startwork-queues.js'),
('20220619203500-add-endwork-queues.js'),
('20220619203900-add-absencemessage-queues.js'),
('20220906150400-create-tags.js'),
('20220906150600-create-associate-contacttags.js'),
('20221012212600-add-startwork-users.js'),
('20221012212700-add-endwork-users.js'),
('20221023085500-add-isdisplay-to-whatsapp.js'),
('20221128234000-add-number-to-whatsapp.js'),
('20230503231400-create-integrations.js'),
('20230505232700-add-istricked-to-users.js'),
('20230527010200-remove-isTricked-column-to-users.js'),
('20230527010400-add-istricked-column-to-users.js'),
('20240921112934-alter-userId-foreign-key-on-tickets.js'),
('20240921153422-alter-queueId-foreign-key-on-tickets.js'),
('20240924160957-add-hub-to-contacts.js'),
('20240924161020-add-type-to-whatsapp.js'),
('20240924161124-change-column-number-to-allownull.js'),
('20240926143622-alter-contact-email-nullable.js'),
('20241026162841-add-isEdited-column-to-messages.js'),
('20241026164855-create-oldmessages.js'),
('20241028230052-add-color-whatsapp.js');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Settings`
--

CREATE TABLE `Settings` (
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `Settings`
--

INSERT INTO `Settings` (`key`, `value`, `createdAt`, `updatedAt`) VALUES
('allTicket', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('ASC', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('call', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('CheckMsgIsGroup', 'enabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('closeTicketApi', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('created', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('darkMode', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:31:14'),
('quickAnswer', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('sideMenu', 'disabled', '2024-10-31 10:18:57', '2024-10-31 10:31:45'),
('timeCreateNewTicket', '10', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('userApiToken', 'bc899a63-30c6-4d6f-94d2-5dde1cced897', '2024-10-31 10:18:57', '2024-10-31 10:18:57'),
('userCreation', 'enabled', '2024-10-31 10:18:57', '2024-10-31 10:18:57');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Tags`
--

CREATE TABLE `Tags` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Tickets`
--

CREATE TABLE `Tickets` (
  `id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `lastMessage` text DEFAULT NULL,
  `contactId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdAt` datetime(6) NOT NULL,
  `updatedAt` datetime(6) NOT NULL,
  `whatsappId` int(11) DEFAULT NULL,
  `isGroup` tinyint(1) NOT NULL DEFAULT 0,
  `unreadMessages` int(11) DEFAULT NULL,
  `queueId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `UserQueues`
--

CREATE TABLE `UserQueues` (
  `userId` int(11) NOT NULL,
  `queueId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Users`
--

CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `passwordHash` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `profile` varchar(255) NOT NULL DEFAULT 'admin',
  `tokenVersion` int(11) NOT NULL DEFAULT 0,
  `whatsappId` int(11) DEFAULT NULL,
  `startWork` varchar(255) DEFAULT '00:00',
  `endWork` varchar(255) DEFAULT '23:59',
  `isTricked` varchar(255) NOT NULL DEFAULT 'enabled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `Users`
--

INSERT INTO `Users` (`id`, `name`, `email`, `passwordHash`, `createdAt`, `updatedAt`, `profile`, `tokenVersion`, `whatsappId`, `startWork`, `endWork`, `isTricked`) VALUES
(3, 'Administrador', 'admin@admin.com', '$2a$08$JPjQUmbIammgyqvUnhKECu7SjKwC4/NThXImzQhfztS92g6soQXlq', '2023-06-07 10:14:13', '2024-10-04 09:34:21', 'admin', 0, NULL, '00:00', '23:59', 'enabled'),
(4, 'teste', 'teste@teste.com', '$2a$08$UmKAdsmzdVEZYl9yPNgSruYhfbsnB6Ub8CtsMd9uOqd7RPXXIH.va', '2023-06-07 11:12:28', '2024-10-04 11:00:46', 'user', 0, NULL, '00:00', '23:59', 'enabled'),
(5, 'Canal Digital', 'canaldigital@cercred.com.br', '$2a$08$TsKJwtCIq3/cpFuiabMRQu.8AAyn.K/e6cWQIxqf.wHRUBlL0WMTC', '2023-06-07 12:21:05', '2024-09-10 14:13:07', 'admin', 0, NULL, '00:00', '23:59', 'enabled');

-- --------------------------------------------------------

--
-- Estrutura para tabela `WhatsappQueues`
--

CREATE TABLE `WhatsappQueues` (
  `whatsappId` int(11) NOT NULL,
  `queueId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `Whatsapps`
--

CREATE TABLE `Whatsapps` (
  `id` int(11) NOT NULL,
  `session` text DEFAULT NULL,
  `qrcode` text DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `battery` varchar(255) DEFAULT NULL,
  `plugged` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  `isDefault` tinyint(1) NOT NULL DEFAULT 0,
  `retries` int(11) NOT NULL DEFAULT 0,
  `greetingMessage` text DEFAULT NULL,
  `farewellMessage` text DEFAULT NULL,
  `isDisplay` tinyint(1) NOT NULL DEFAULT 0,
  `number` varchar(255) DEFAULT NULL,
  `type` text DEFAULT NULL,
  `color` varchar(255) DEFAULT '#5C59A0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `ContactCustomFields`
--
ALTER TABLE `ContactCustomFields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contactId` (`contactId`);

--
-- Índices de tabela `Contacts`
--
ALTER TABLE `Contacts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `number` (`number`),
  ADD UNIQUE KEY `number_2` (`number`);

--
-- Índices de tabela `ContactTags`
--
ALTER TABLE `ContactTags`
  ADD KEY `contactId` (`contactId`),
  ADD KEY `tagId` (`tagId`);

--
-- Índices de tabela `Integrations`
--
ALTER TABLE `Integrations`
  ADD PRIMARY KEY (`key`);

--
-- Índices de tabela `Messages`
--
ALTER TABLE `Messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticketId` (`ticketId`),
  ADD KEY `Messages_contactId_foreign_idx` (`contactId`),
  ADD KEY `Messages_quotedMsgId_foreign_idx` (`quotedMsgId`);

--
-- Índices de tabela `OldMessages`
--
ALTER TABLE `OldMessages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messageId` (`messageId`);

--
-- Índices de tabela `Queues`
--
ALTER TABLE `Queues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `color` (`color`);

--
-- Índices de tabela `QuickAnswers`
--
ALTER TABLE `QuickAnswers`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `SequelizeMeta`
--
ALTER TABLE `SequelizeMeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices de tabela `Settings`
--
ALTER TABLE `Settings`
  ADD PRIMARY KEY (`key`);

--
-- Índices de tabela `Tags`
--
ALTER TABLE `Tags`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `Tickets`
--
ALTER TABLE `Tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contactId` (`contactId`),
  ADD KEY `Tickets_whatsappId_foreign_idx` (`whatsappId`),
  ADD KEY `Tickets_ibfk_2` (`userId`),
  ADD KEY `Tickets_queueId_custom_foreign` (`queueId`);

--
-- Índices de tabela `UserQueues`
--
ALTER TABLE `UserQueues`
  ADD PRIMARY KEY (`userId`,`queueId`);

--
-- Índices de tabela `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `Users_whatsappId_foreign_idx` (`whatsappId`);

--
-- Índices de tabela `WhatsappQueues`
--
ALTER TABLE `WhatsappQueues`
  ADD PRIMARY KEY (`whatsappId`,`queueId`);

--
-- Índices de tabela `Whatsapps`
--
ALTER TABLE `Whatsapps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `ContactCustomFields`
--
ALTER TABLE `ContactCustomFields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Contacts`
--
ALTER TABLE `Contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `OldMessages`
--
ALTER TABLE `OldMessages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Queues`
--
ALTER TABLE `Queues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `QuickAnswers`
--
ALTER TABLE `QuickAnswers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Tags`
--
ALTER TABLE `Tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Tickets`
--
ALTER TABLE `Tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `Whatsapps`
--
ALTER TABLE `Whatsapps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `ContactCustomFields`
--
ALTER TABLE `ContactCustomFields`
  ADD CONSTRAINT `contactcustomfields_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `Contacts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `ContactTags`
--
ALTER TABLE `ContactTags`
  ADD CONSTRAINT `contacttags_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `Contacts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contacttags_ibfk_2` FOREIGN KEY (`tagId`) REFERENCES `Tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `Messages`
--
ALTER TABLE `Messages`
  ADD CONSTRAINT `Messages_contactId_foreign_idx` FOREIGN KEY (`contactId`) REFERENCES `Contacts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Messages_quotedMsgId_foreign_idx` FOREIGN KEY (`quotedMsgId`) REFERENCES `Messages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`ticketId`) REFERENCES `Tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `OldMessages`
--
ALTER TABLE `OldMessages`
  ADD CONSTRAINT `oldmessages_ibfk_1` FOREIGN KEY (`messageId`) REFERENCES `Messages` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `Tickets`
--
ALTER TABLE `Tickets`
  ADD CONSTRAINT `Tickets_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Tickets_queueId_custom_foreign` FOREIGN KEY (`queueId`) REFERENCES `Queues` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Tickets_whatsappId_foreign_idx` FOREIGN KEY (`whatsappId`) REFERENCES `Whatsapps` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `Contacts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `Users`
--
ALTER TABLE `Users`
  ADD CONSTRAINT `Users_whatsappId_foreign_idx` FOREIGN KEY (`whatsappId`) REFERENCES `Whatsapps` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
