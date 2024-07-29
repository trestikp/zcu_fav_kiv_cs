-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Stř 18. pro 2019, 13:05
-- Verze serveru: 10.1.37-MariaDB
-- Verze PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `web_semestral`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `author` int(11) NOT NULL,
  `published` tinyint(2) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `title` varchar(128) COLLATE utf8_czech_ci NOT NULL,
  `text` varchar(2048) COLLATE utf8_czech_ci NOT NULL,
  `file` varchar(256) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `posts`
--

INSERT INTO `posts` (`id`, `author`, `published`, `state`, `title`, `text`, `file`) VALUES
(1, 7, 1, 3, 'Toto je prvnÃ­ pÅ™Ã­spÄ›vek', 'Toto je prvnÃ­ pÅ™Ã­spÄ›vek po vymazÃ¡nÃ­ testovacÃ­ch dat.\r\nTento pÅ™Ã­spÄ›vek je bez filu.\r\nTento pÅ™Ã­spÄ›vek by mÄ›l dojÃ­t do fÃ¡ze zveÅ™ejnÄ›n.', ''),
(2, 7, 0, 0, 'DruhÃ½ pÅ™Ã­spÄ›vek', 'Toto je druhÃ½ pÅ™Ã­spÄ›vek.\r\nJe tu jednoduÅ¡e proto, aby nÄ›jakÃ½ autor mÄ›l vÃ­ce pÅ™Ã­spÄ›vkÅ¯.\r\nBude jeÅ¡tÄ› bez filu.\r\nNevÃ­m jestli ho zveÅ™ejnit.', ''),
(3, 7, 1, 3, 'TÅ™etÃ­ pÅ™Ã­spÄ›vek autora1', 'TÅ™etÃ­ pÅ™Ã­spÄ›vek.\r\nMÃ¡ file.\r\nBude zveÅ™ejnÄ›n.', '1-uvod.pdf'),
(4, 8, 2, 3, 'PÅ™Ã­spÄ›vek autora2', 'File.\r\nZamÃ­tnut', '3-css.pdf'),
(5, 8, 0, 1, 'DalÅ¡Ã­ pÅ™Ã­spÄ›vek', 'Tento pÅ™Ã­spÄ›vek by mÄ›l zÅ¯stat ve fÃ¡zi kdy je hodnocen.\r\nBez filu.', ''),
(6, 9, 0, 0, 'NÄ›jÃ¡kÃ½ pÅ™Ã­spÄ›vek autora3', 'Tento pÅ™Ã­spÄ›vek by nemÄ›l bÃ½t zveÅ™ejnÄ›n.\r\nAni ohodnocen.\r\nNechat ho ve fÃ¡zi vÃ½bÄ›ru recenzentÅ¯.', ''),
(7, 9, 0, 1, 'PrÅ¯chod hrou miny', 'Kliknete na nÃ¡hodnÃ© polÃ­Äko. Pokud nemÃ¡te smÅ¯lu a netrefÃ­te bombu prvnÃ­m kliknutÃ­m, odhalÃ­ se vÃ¡m oblast ohraniÄenÃ¡ bloky s ÄÃ­sly. Tyto ÄÃ­sla naznaÄujÃ­ kolik bomb je v okolÃ­ danÃ©ho polÃ­Äka. Pokud mÅ¯Å¾ete oznaÄit nÄ›kterÃ© objevenÃ© polÃ­Äko jako minu, oznaÄte ho. Pokud vÃ­te, Å¾e polÃ­Äko urÄitÄ› nenÃ­ bomba kliknÄ›te na nÄ›j. HodnÄ› Å¡tÄ›stÃ­!', '');

-- --------------------------------------------------------

--
-- Struktura tabulky `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `post` int(11) NOT NULL,
  `reviewer` int(11) NOT NULL,
  `criterium1` int(11) NOT NULL,
  `criterium2` int(11) NOT NULL,
  `criterium3` int(11) NOT NULL,
  `overall` int(11) NOT NULL,
  `text` varchar(1024) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `reviews`
--

INSERT INTO `reviews` (`id`, `post`, `reviewer`, `criterium1`, `criterium2`, `criterium3`, `overall`, `text`) VALUES
(1, 1, 2, 1, 2, 1, 1, 'VÃ½bornÃ½ prvnÃ­ pÅ™Ã­spÄ›vek.'),
(2, 3, 3, 2, 1, 3, 2, 'Nic moc obsah. DobrÃ¡ pdf pÅ™Ã­loha.'),
(3, 4, 3, 5, 4, 4, 4, 'UÅ¾ jsem vidÄ›l horÅ¡Ã­, ale nedoporuÄuji!'),
(4, 1, 3, 1, 1, 1, 1, 'ProstÄ› prvnÃ­ pÅ™Ã­spÄ›vek. Co dodat?'),
(5, 3, 4, 2, 3, 2, 2, 'Je to ok k zveÅ™ejnÄ›nÃ­.'),
(6, 4, 4, 5, 5, 5, 5, 'PobouÅ™enÃ­hodnÃ©!'),
(7, 1, 5, 1, 1, 1, 1, 'Super.'),
(8, 3, 6, 2, 1, 2, 2, 'SluÅ¡nÃ½ pÅ™Ã­spÄ›vek s pÅ™Ã­lohou.'),
(9, 4, 10, 5, 5, 5, 5, 'NedovolÃ­m, aby se tuto zveÅ™ejnilo!'),
(10, 7, 3, 1, 1, 2, 2, 'Je to sluÅ¡nÃ½, ale velmi obecnÃ½ nÃ¡vod na prÅ¯chod hry.'),
(11, 7, 4, 2, 1, 2, 2, 'NÃ¡vod na prÅ¯chod hry miny. Je pouÅ¾itelnÃ½, ale mohl by bÃ½t i lepÅ¡Ã­.'),
(12, 7, 6, 1, 2, 3, 2, 'PÅ™Ã­liÅ¡ jednoduchÃ©, ale je to jedinÃ½ nÃ¡vod, kterÃ½ nÄ›kdo napsal, takÅ¾e je to pouÅ¾itelnÃ½.');

-- --------------------------------------------------------

--
-- Struktura tabulky `review_queue`
--

CREATE TABLE `review_queue` (
  `id` int(11) NOT NULL,
  `reviewer` int(11) NOT NULL,
  `post` int(11) NOT NULL,
  `reviewed` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `review_queue`
--

INSERT INTO `review_queue` (`id`, `reviewer`, `post`, `reviewed`) VALUES
(1, 3, 3, 1),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 5, 1, 1),
(5, 6, 3, 1),
(6, 4, 3, 1),
(7, 3, 4, 1),
(8, 10, 4, 1),
(9, 4, 4, 1),
(10, 1, 5, 0),
(11, 4, 5, 0),
(12, 6, 5, 0),
(13, 2, 6, 0),
(14, 3, 7, 1),
(15, 6, 7, 1),
(16, 4, 7, 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(64) COLLATE utf8_czech_ci NOT NULL,
  `password` varchar(64) COLLATE utf8_czech_ci NOT NULL,
  `role` int(11) NOT NULL DEFAULT '1',
  `email` varchar(128) COLLATE utf8_czech_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Vypisuji data pro tabulku `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `email`) VALUES
(1, 'admin', 'admin', 3, 'admin@owners.com'),
(2, 'rec1', 'rec1', 2, 'rec1@recenzenti.com'),
(3, 'rec2', 'rec2', 2, 'rec2@recenzenti.com'),
(4, 'rec3', 'rec3', 2, 'rec3@recenzenti.com'),
(5, 'rec4', 'rec4', 2, 'rec4@recenzenti.com'),
(6, 'rec5', 'rec5', 2, 'rec5@recenzenti.com'),
(7, 'autor1', 'autor1', 1, 'autor1@autori.net'),
(8, 'autor2', 'autor2', 1, 'autor2@autori.net'),
(9, 'autor3', 'autor3', 1, 'autor3@autori.net'),
(10, 'recadm', 'recadm', 2, 'recadm@recenzenti.com'),
(11, 'later', 'later', 1, 'later@pozdeji.cz');

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author` (`author`);

--
-- Klíče pro tabulku `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviewer_fk` (`reviewer`),
  ADD KEY `post_fk` (`post`);

--
-- Klíče pro tabulku `review_queue`
--
ALTER TABLE `review_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviewer` (`reviewer`),
  ADD KEY `post` (`post`);

--
-- Klíče pro tabulku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pro tabulku `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pro tabulku `review_queue`
--
ALTER TABLE `review_queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pro tabulku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `author` FOREIGN KEY (`author`) REFERENCES `users` (`id`);

--
-- Omezení pro tabulku `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `post_fk` FOREIGN KEY (`post`) REFERENCES `posts` (`id`),
  ADD CONSTRAINT `reviewer_fk` FOREIGN KEY (`reviewer`) REFERENCES `users` (`id`);

--
-- Omezení pro tabulku `review_queue`
--
ALTER TABLE `review_queue`
  ADD CONSTRAINT `post` FOREIGN KEY (`post`) REFERENCES `posts` (`id`),
  ADD CONSTRAINT `reviewer` FOREIGN KEY (`reviewer`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
