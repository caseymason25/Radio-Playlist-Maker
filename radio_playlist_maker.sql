-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2017 at 12:20 AM
-- Server version: 5.6.25
-- PHP Version: 5.6.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `radio_playlist_maker`
--

-- --------------------------------------------------------

--
-- Table structure for table `songlist`
--

CREATE TABLE IF NOT EXISTS `songlist` (
  `id` int(10) unsigned NOT NULL,
  `song` varchar(100) DEFAULT NULL,
  `artist` varchar(100) DEFAULT NULL,
  `station` varchar(100) DEFAULT NULL,
  `spotify_id` int(10) unsigned DEFAULT NULL,
  `update_dttm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_cnt` int(10) unsigned NOT NULL DEFAULT '0',
  `create_dttm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=61602 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `songlist`
--

INSERT INTO `songlist` (`id`, `song`, `artist`, `station`, `spotify_id`, `update_dttm`, `update_cnt`, `create_dttm`) VALUES
(1, 'Remember That Night', 'Grouplove', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(2, 'Little Talks', 'Of Monsters and Men', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(3, 'Feel It Still', 'Portugal. The Man', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(4, 'Thunder', 'Imagine Dragons', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(5, 'LINE OF SIGHT', 'ODESZA', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(6, 'It''s a Trip!', 'Joywave', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(7, 'Portions for Foxes', 'Rilo Kiley', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(8, 'Passion', 'AWOLNATION', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(9, 'The Night We Met', 'Lord Huron', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(10, 'Coloring Outside the Lines', 'MisterWives', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(11, 'Dance, Dance', 'Fall Out Boy', '965 The Buzz', NULL, '2017-11-03 02:56:46', 0, '2017-11-03 02:56:46'),
(12, 'Giver', 'K.Flay', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(13, 'Nobody Speak (feat. Run The Jewels)', 'DJ Shadow', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(14, 'I Want You', 'Marian Hill', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(15, 'Lay It On Me', 'Vance Joy', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(16, 'Ti Amo', 'Phoenix', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(17, 'Paul Revere', 'Beastie Boys', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(18, 'Suit and Jacket', 'Judah & The Lion', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(19, 'Creature Comfort', 'Arcade Fire', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(20, 'Walk On Water', 'Thirty Seconds to Mars', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(21, 'Over and Over Again', 'The Used', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(22, 'The System Only Dreams in Total Darkness', 'The National', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(23, 'Black Cat Heavy Metal', 'Dan Luke and the Raid', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(24, 'Be Bold Like Elijah', 'Irontom', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(25, 'You’re the Best Thing About Me', 'U2', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(26, 'Agnes', 'Glass Animals', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(27, 'Up All Night', 'Beck', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(28, 'I Miss Those Days', 'Bleachers', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(29, 'Come Together', 'Gary Clark Jr. & Junkie XL', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(30, 'The Gold', 'Manchester Orchestra', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(31, 'Weekends', 'Amy Shark', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(32, 'All My Life', 'Honors', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(33, 'Two High', 'Moon Taxi', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(34, 'The Man', 'The Killers', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(35, 'DREAM', 'BISHOP BRIGGS', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(36, 'Sober Up', 'AJR', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(37, 'Vacation', 'Dirty Heads', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(38, 'Holy Mountain', 'Noel Gallagher''s High Flying Birds', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(39, 'Can I Sit Next to You', 'Spoon', '965 The Buzz', NULL, '2017-11-03 02:56:47', 0, '2017-11-03 02:56:47'),
(40, 'We''re Going to Be Friends', 'The White Stripes', '965 The Buzz', NULL, '2017-11-03 02:59:01', 0, '2017-11-03 02:59:01'),
(41, 'Sit Next to Me', 'Foster the People', '965 The Buzz', NULL, '2017-11-03 03:01:16', 0, '2017-11-03 03:01:16'),
(42, 'Whole Wide World', 'Cage the Elephant', '965 The Buzz', NULL, '2017-11-03 03:06:01', 0, '2017-11-03 03:06:01'),
(304, 'May I Have This Dance (Remix) [feat. Chance the Rapper]', 'Francis and the Lights', '965 The Buzz', NULL, '2017-11-03 03:09:31', 0, '2017-11-03 03:09:31'),
(1642, 'I Write Sins Not Tragedies', 'Panic! At the Disco', '965 The Buzz', NULL, '2017-11-03 03:21:16', 0, '2017-11-03 03:21:16'),
(2015, 'Perfect Places', 'Lorde', '965 The Buzz', NULL, '2017-11-03 03:24:16', 0, '2017-11-03 03:24:16'),
(2481, 'Pink Chateau', 'In The Valley Below', '965 The Buzz', NULL, '2017-11-03 03:28:01', 0, '2017-11-03 03:28:01'),
(2948, 'Faded Heart', 'BØRNS', '965 The Buzz', NULL, '2017-11-03 03:31:46', 0, '2017-11-03 03:31:46'),
(4077, 'THE WANTING', 'J RODDY WASTON AND THE BUSINESS', '965 The Buzz', NULL, '2017-11-03 03:48:46', 0, '2017-11-03 03:48:46'),
(4078, 'J-Boy', 'Phoenix', '965 The Buzz', NULL, '2017-11-03 03:48:46', 0, '2017-11-03 03:48:46'),
(4588, 'Heathens', 'twenty one pilots', '965 The Buzz', NULL, '2017-11-03 03:55:46', 0, '2017-11-03 03:55:46'),
(4663, 'Day I Die', 'The National', '965 The Buzz', NULL, '2017-11-03 03:58:31', 0, '2017-11-03 03:58:31'),
(5330, 'The Adventure', 'Angels & Airwaves', '965 The Buzz', NULL, '2017-11-03 04:12:01', 0, '2017-11-03 04:12:01'),
(5631, 'One Foot', 'WALK THE MOON', '965 The Buzz', NULL, '2017-11-03 04:16:16', 0, '2017-11-03 04:16:16'),
(6415, 'G#', 'Kitten', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6416, 'Electric Love', 'BØRNS', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6417, 'American Money', 'BØRNS', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6418, '(KE) UNSTEADY', 'X AMBASSADORS', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6419, 'Renegades', 'X Ambassadors', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6420, 'SURFACE', 'YgodY', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6421, 'Lasso', 'Phoenix', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6422, 'Bourgeois', 'Phoenix', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6423, 'Down', 'Marian Hill', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6424, 'No Phone', 'Cake', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6425, 'Seein'' Red', 'Unwritten Law', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6426, 'Sic Transit Gloria ... Glory Fades', 'Brand New', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6427, 'Inhaler', 'Foals', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6428, 'Pools', 'Glass Animals', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6431, 'Work', 'Jimmy Eat World', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6435, 'Pyramid Song', 'Radiohead', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6437, 'Spirit Cold', 'Tall Heights', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6439, 'Sabotage', 'Beastie Boys', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6440, 'We Wish You a Merry Christmas', 'Weezer', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6441, 'American Idiot', 'Green Day', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6442, 'FEVAH BLOODRUNNER REMIX', 'ALICIA SOLO', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6445, 'Dead Leaves and the Dirty Ground', 'The White Stripes', '965 The Buzz', NULL, '2017-11-03 13:53:46', 0, '2017-11-03 13:53:46'),
(6718, 'ALL DAY', 'YgodY', '965 The Buzz', NULL, '2017-11-03 14:00:45', 0, '2017-11-03 14:00:45'),
(8637, 'Juicy', 'The Notorious B.I.G.', '965 The Buzz', NULL, '2017-11-03 14:25:46', 0, '2017-11-03 14:25:46'),
(9034, '10,000 Emerald Pools', 'BØRNS', '965 The Buzz', NULL, '2017-11-03 14:30:16', 0, '2017-11-03 14:30:16'),
(10027, 'Wish I Knew You', 'The Revivalists', '965 The Buzz', NULL, '2017-11-03 14:41:16', 0, '2017-11-03 14:41:16'),
(10760, 'No Roots', 'Alice Merton', '965 The Buzz', NULL, '2017-11-03 14:48:46', 0, '2017-11-03 14:48:46'),
(13123, 'Reunion', 'M83', '965 The Buzz', NULL, '2017-11-03 15:15:46', 0, '2017-11-03 15:15:46'),
(13444, 'No Good', 'Kaleo', '965 The Buzz', NULL, '2017-11-03 15:19:46', 0, '2017-11-03 15:19:46'),
(13745, 'Deadcrush', 'alt-J', '965 The Buzz', NULL, '2017-11-03 15:23:31', 0, '2017-11-03 15:23:31'),
(14727, 'Holiday in Cambodia', 'Dead Kennedys', '965 The Buzz', NULL, '2017-11-03 15:35:01', 0, '2017-11-03 15:35:01'),
(15525, 'Safe and Sound', 'Capital Cities', '965 The Buzz', NULL, '2017-11-03 15:43:31', 0, '2017-11-03 15:43:31'),
(16286, 'Existentialism On Prom Night', 'Straylight Run', '965 The Buzz', NULL, '2017-11-03 15:51:01', 0, '2017-11-03 15:51:01'),
(18052, 'Sex and Candy', 'Marcy Playground', '965 The Buzz', NULL, '2017-11-03 16:10:01', 0, '2017-11-03 16:10:01'),
(19805, 'S.O.B.', 'Nathaniel Rateliff & The Night Sweats', '965 The Buzz', NULL, '2017-11-03 16:29:31', 0, '2017-11-03 16:29:31'),
(20563, 'Self Esteem', 'The Offspring', '965 The Buzz', NULL, '2017-11-03 16:37:16', 0, '2017-11-03 16:37:16'),
(23504, 'Higher Ground', 'Red Hot Chili Peppers', '965 The Buzz', NULL, '2017-11-03 17:03:31', 0, '2017-11-03 17:03:31'),
(23841, 'Epic', 'Faith No More', '965 The Buzz', NULL, '2017-11-03 17:07:01', 0, '2017-11-03 17:07:01'),
(24322, 'My Wave', 'Soundgarden', '965 The Buzz', NULL, '2017-11-03 17:12:01', 0, '2017-11-03 17:12:01'),
(24841, 'Wrong Way', 'Sublime', '965 The Buzz', NULL, '2017-11-03 17:17:16', 0, '2017-11-03 17:17:16'),
(25232, 'Grey Cell Green', 'Ned''s Atomic Dustbin', '965 The Buzz', NULL, '2017-11-03 17:21:01', 0, '2017-11-03 17:21:01'),
(25633, 'Basket Case', 'Green Day', '965 The Buzz', NULL, '2017-11-03 17:24:46', 0, '2017-11-03 17:24:46'),
(25931, 'Standing Outside a Broken Phone Booth With Money In My Hand', 'Primitive Radio Gods', '965 The Buzz', NULL, '2017-11-03 17:27:31', 0, '2017-11-03 17:27:31'),
(26439, 'Big Me', 'Foo Fighters', '965 The Buzz', NULL, '2017-11-03 17:32:02', 0, '2017-11-03 17:32:02'),
(26759, 'Low', 'Cracker', '965 The Buzz', NULL, '2017-11-03 17:34:46', 0, '2017-11-03 17:34:46'),
(27305, 'Here In Your Bedroom', 'Goldfinger', '965 The Buzz', NULL, '2017-11-03 17:39:16', 0, '2017-11-03 17:39:16'),
(27902, 'Pepper', 'Butthole Surfers', '965 The Buzz', NULL, '2017-11-03 17:44:01', 0, '2017-11-03 17:44:01'),
(28427, 'Bitter Sweet Symphony', 'The Verve', '965 The Buzz', NULL, '2017-11-03 17:48:01', 0, '2017-11-03 17:48:01'),
(29136, 'Til I Hear It from You', 'Gin Blossoms', '965 The Buzz', NULL, '2017-11-03 17:53:16', 0, '2017-11-03 17:53:16'),
(30858, 'In Cold Blood', 'alt-J', '965 The Buzz', NULL, '2017-11-03 18:07:31', 0, '2017-11-03 18:07:31'),
(31735, 'Blister In the Sun', 'Violent Femmes', '965 The Buzz', NULL, '2017-11-03 18:15:46', 0, '2017-11-03 18:15:46'),
(33150, 'Just a Girl', 'No Doubt', '965 The Buzz', NULL, '2017-11-03 18:28:16', 0, '2017-11-03 18:28:16'),
(34420, 'My Doorbell', 'The White Stripes', '965 The Buzz', NULL, '2017-11-03 18:38:31', 0, '2017-11-03 18:38:31'),
(36231, 'High Enough', 'K.Flay', '965 The Buzz', NULL, '2017-11-03 18:52:01', 0, '2017-11-03 18:52:01'),
(36792, 'Unsteady', 'X Ambassadors', '965 The Buzz', NULL, '2017-11-03 18:56:01', 0, '2017-11-03 18:56:01'),
(38089, 'I Wanna Be Sedated', 'Ramones', '965 The Buzz', NULL, '2017-11-03 19:07:01', 0, '2017-11-03 19:07:01'),
(38697, 'Don''t Go Away', 'Oasis', '965 The Buzz', NULL, '2017-11-03 19:12:31', 0, '2017-11-03 19:12:31'),
(40417, 'Angela', 'The Lumineers', '965 The Buzz', NULL, '2017-11-03 19:27:01', 0, '2017-11-03 19:27:01'),
(41364, 'Ride', 'twenty one pilots', '965 The Buzz', NULL, '2017-11-03 19:34:31', 0, '2017-11-03 19:34:31'),
(42292, 'Lithium', 'Nirvana', '965 The Buzz', NULL, '2017-11-03 19:41:31', 0, '2017-11-03 19:41:31'),
(44415, 'I Will Wait', 'Mumford & Sons', '965 The Buzz', NULL, '2017-11-03 19:56:31', 0, '2017-11-03 19:56:31'),
(46346, 'Song 2', 'Blur', '965 The Buzz', NULL, '2017-11-03 20:13:16', 0, '2017-11-03 20:13:16'),
(52586, 'The Kids Aren''t Alright', 'The Offspring', '965 The Buzz', NULL, '2017-11-03 21:07:15', 0, '2017-11-03 21:07:15'),
(53474, 'Rehab', 'Amy Winehouse', '965 The Buzz', NULL, '2017-11-03 21:19:01', 0, '2017-11-03 21:19:01'),
(54648, 'The Boys of Summer', 'The Ataris', '965 The Buzz', NULL, '2017-11-03 21:32:31', 0, '2017-11-03 21:32:31'),
(57669, 'Live in the Moment', 'Portugal. The Man', '965 The Buzz', NULL, '2017-11-03 22:03:00', 0, '2017-11-03 22:03:00'),
(58333, 'Instant Crush', 'Cage the Elephant', '965 The Buzz', NULL, '2017-11-03 22:14:00', 0, '2017-11-03 22:14:00'),
(59557, 'Do I Wanna Know?', 'Arctic Monkeys', '965 The Buzz', NULL, '2017-11-03 22:32:01', 0, '2017-11-03 22:32:01'),
(60528, 'When I Come Around', 'Green Day', '965 The Buzz', NULL, '2017-11-03 22:44:16', 0, '2017-11-03 22:44:16'),
(61387, 'Drive', 'Incubus', '965 The Buzz', NULL, '2017-11-03 22:54:01', 0, '2017-11-03 22:54:01');

-- --------------------------------------------------------

--
-- Table structure for table `spotify`
--

CREATE TABLE IF NOT EXISTS `spotify` (
  `id` int(10) unsigned NOT NULL,
  `song` varchar(100) DEFAULT NULL,
  `create_dttm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `songlist`
--
ALTER TABLE `songlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `song` (`song`,`artist`,`station`);

--
-- Indexes for table `spotify`
--
ALTER TABLE `spotify`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `songlist`
--
ALTER TABLE `songlist`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=61602;
--
-- AUTO_INCREMENT for table `spotify`
--
ALTER TABLE `spotify`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
