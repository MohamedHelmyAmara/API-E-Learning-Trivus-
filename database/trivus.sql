-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2025 at 12:15 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trivus`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'تطوير الويب'),
(2, 'تطوير الالعاب'),
(3, 'تطبيقات الموبيل');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `course_title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `rating` int(11) NOT NULL,
  `Instructor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `category_id`, `course_title`, `description`, `created_at`, `updated_at`, `rating`, `Instructor`) VALUES
(1, 1, 'تعلم HTML', 'هل ترغب في تعلم كيفية إنشاء وتصميم صفحات ويب من الصفر؟ كورس HTML هو خطوتك الأولى لدخول عالم تطوير الويب!', '2025-03-08 02:33:07', '2025-03-08 02:47:27', 4, 'قناة فكرة');

-- --------------------------------------------------------

--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `enroll_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollment`
--

INSERT INTO `enrollment` (`enroll_id`, `user_id`, `course_id`) VALUES
(11, 88, 1);

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `faq_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`faq_id`, `course_id`, `question`, `answer`, `created_at`, `updated_at`) VALUES
(4, 1, 'هل يمكنني تعلم HTML دون معرفة برمجية مسبقة؟', 'نعم، HTML سهلة التعلم ولا تحتاج إلى أي خلفية برمجية سابقة.', '2025-03-08 02:54:17', '2025-03-08 02:54:17'),
(5, 1, 'كم من الوقت يستغرق تعلم الأساسيات؟', 'عادةً ما يستغرق تعلم أساسيات HTML بضعة أيام إلى أسبوع، حسب وتيرة تعلمك.', '2025-03-08 02:54:17', '2025-03-08 02:54:17'),
(6, 1, 'هل أحتاج إلى برنامج معين لكتابة كود HTML؟', 'لا، يمكنك كتابة كود HTML باستخدام أي محرر نصوص مثل Notepad أو VS Code، ثم عرضه باستخدام متصفح الويب.', '2025-03-08 02:54:17', '2025-03-08 02:54:17');

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `lesson_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `lesson_title` varchar(255) NOT NULL,
  `video_url` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`lesson_id`, `course_id`, `lesson_title`, `video_url`, `created_at`, `updated_at`) VALUES
(1, 1, '00 Learn HTML تعلم', 'JCSrne6is2A', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(2, 1, '01 Head & Body in HTML', 'vVRTyfi3QkE', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(3, 1, '02 Head Line Tags & Paragraph Tag', '6M5nNsENsbg', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(4, 1, '03 Anchor Tag | Link Tag', '5-Km2FfiVqw', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(5, 1, '04 Image Tag', 'fKNYiYGEdq4', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(6, 1, '06 Table in HTML', 'DD25X8_WIWk', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(7, 1, '05 List Tags | ol tag | ul tag | dl tag', 'n_tRYEJdD6o', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(8, 1, '07 HTML Attributes | Attributes in HTML Elements', 'rBW9VMmWVJI', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(9, 1, '08 Form In HTML | How To Create Form In HTML', '0IuIsJnWWJE', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(10, 1, '09 Button in HTML بالعربي', '1Feppv2iYeA', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(11, 1, '10 Section & Div in HTML بالعربي', 'Z8afX8h2fk0', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(12, 1, '11 Style in HTML Element || HTML بالعربي', '7o2E_ZWd1Ls', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(13, 1, '12 Formatting Element in HTML || learn HTML بالعربي', 'svxLKW9Y07g', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(14, 1, '13 Quotations Element In Html || learn HTML بالعربي', 'n6XQ80VDrO0', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(15, 1, '14 Head Tag In HTML || HTML بالعربي', 'joEFN4C37M4', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(16, 1, '15 Style Tag In HTML || HTML بالعربي', '8-WifcZM094', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(17, 1, '16 Meta Tag In HTML || HTML بالعربي', '-d3yyNqQ4AU', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(18, 1, '17 Power Of Link tag in HTML | HTML بالعربي', 'mEdz5dB3vm4', '2025-03-08 02:38:58', '2025-03-08 02:38:58'),
(19, 1, '18 link file tag in head tag in HTML | HTML بالعربي', 'aDKJnVuuWkg', '2025-03-08 02:38:58', '2025-03-08 02:38:58');

-- --------------------------------------------------------

--
-- Table structure for table `progress`
--

CREATE TABLE `progress` (
  `progress_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `watched_items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`watched_items`)),
  `completed_tests` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`completed_tests`)),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `unlocked_lessons` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `progress`
--

INSERT INTO `progress` (`progress_id`, `user_id`, `course_id`, `watched_items`, `completed_tests`, `updated_at`, `created_at`, `unlocked_lessons`) VALUES
(30, 95, 1, '[0, 0, 0, 1, 0, 1, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5]', '[\"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\"]', '2025-03-19 14:56:23', '2025-03-19 14:46:12', '[0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3, 0, 0, 0, 0, 1, 2, 3, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]'),
(31, 96, 1, '[0, 0, 0, 1, 0, 1, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6]', '[\"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\", \"test_1_1\", \"test_1_2\"]', '2025-03-19 14:56:02', '2025-03-19 14:53:07', '[0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7, 8]'),
(32, 97, 1, '[0, 0, 0, 1, 0, 1, 0, 1, 2, 0, 1, 2]', '[]', '2025-03-19 17:09:31', '2025-03-19 17:09:11', '[0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 2, 0, 1, 2, 0, 1, 2, 3, 0, 1, 2, 3]');

-- --------------------------------------------------------

--
-- Table structure for table `requirements`
--

CREATE TABLE `requirements` (
  `requirement_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `requirement_text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requirements`
--

INSERT INTO `requirements` (`requirement_id`, `course_id`, `requirement_text`, `created_at`, `updated_at`) VALUES
(1, 1, 'توفر جهاز كمبيوتر أو لابتوب يعمل بشكل جيد.', '2025-03-08 02:58:21', '2025-03-08 02:58:21'),
(2, 1, 'تثبيت محرر أكواد مثل Visual Studio Code أو Notepad++.', '2025-03-08 02:58:21', '2025-03-08 02:58:21'),
(3, 1, 'اتصال مستقر بالإنترنت لتحميل الموارد ومشاهدة الشروحات.', '2025-03-08 02:58:21', '2025-03-08 02:58:21'),
(4, 1, 'معرفة أساسية باستخدام الكمبيوتر.', '2025-03-08 02:58:21', '2025-03-08 02:58:21'),
(5, 1, 'متصفح ويب مثل Google Chrome أو Firefox لتجربة الكود.', '2025-03-08 02:58:21', '2025-03-08 02:58:21'),
(6, 1, 'وقت مخصص يومياً للتعلم وممارسة الأكواد.', '2025-03-08 02:58:21', '2025-03-08 02:58:21');

-- --------------------------------------------------------

--
-- Table structure for table `roadmap`
--

CREATE TABLE `roadmap` (
  `roadmap_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `step_number` int(11) NOT NULL,
  `step_description` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roadmap`
--

INSERT INTO `roadmap` (`roadmap_id`, `course_id`, `step_number`, `step_description`, `created_at`, `updated_at`) VALUES
(1, 1, 1, ' تعلم أساسيات HTML والهيكل الأساسي للصفحة والعناوين.', '2025-03-08 03:04:49', '2025-03-08 03:04:49'),
(2, 1, 2, ' تعلم الوسوم مثل الروابط والصور والجداول والقوائم.', '2025-03-08 03:04:49', '2025-03-08 03:04:49'),
(3, 1, 3, ' فهم السمات، إنشاء النماذج، تقسيم الصفحة باستخدام Div.', '2025-03-08 03:04:49', '2025-03-08 03:04:49');

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

CREATE TABLE `scores` (
  `score_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `submitted_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scores`
--

INSERT INTO `scores` (`score_id`, `test_id`, `user_id`, `score`, `submitted_at`) VALUES
(1, 5, 88, 85, '2025-03-20 03:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `tests`
--

CREATE TABLE `tests` (
  `test_id` int(11) NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `questions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`questions`)),
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tests`
--

INSERT INTO `tests` (`test_id`, `course_id`, `title`, `questions`, `created_at`) VALUES
(1, 1, 'اختبار HTML - الجزء 1', '[\r\n  {\"question\": \"ما هو العنصر المستخدم لتحديد الفقرة في HTML؟\", \"options\": [\"<p>\", \"<div>\", \"<section>\", \"<article>\"], \"correctAnswer\": \"<p>\"},\r\n  {\"question\": \"ما هو الوسم المستخدم لتحديد العناوين الرئيسية؟\", \"options\": [\"<h1>\", \"<h2>\", \"<h3>\", \"<h4>\"], \"correctAnswer\": \"<h1>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لربط ملف CSS خارجي؟\", \"options\": [\"<style>\", \"<link>\", \"<css>\", \"<script>\"], \"correctAnswer\": \"<link>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإنشاء قائمة غير مرتبة؟\", \"options\": [\"<ul>\", \"<ol>\", \"<li>\", \"<dl>\"], \"correctAnswer\": \"<ul>\"},\r\n  {\"question\": \"أي من الوسوم التالية يستخدم لإضافة تعليق في HTML؟\", \"options\": [\"<!-- تعليق -->\", \"// تعليق\", \"/* تعليق */\", \"<comment>\"], \"correctAnswer\": \"<!-- تعليق -->\"}\r\n]', '2025-03-17 20:14:37'),
(2, 1, 'اختبار HTML - الجزء 2', '[\r\n  {\"question\": \"ما هو العنصر المستخدم لإنشاء جدول؟\", \"options\": [\"<table>\", \"<grid>\", \"<div>\", \"<section>\"], \"correctAnswer\": \"<table>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإدخال بيانات من المستخدم؟\", \"options\": [\"<form>\", \"<input>\", \"<textarea>\", \"<button>\"], \"correctAnswer\": \"<input>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإضافة صورة؟\", \"options\": [\"<img>\", \"<picture>\", \"<figure>\", \"<icon>\"], \"correctAnswer\": \"<img>\"},\r\n  {\"question\": \"ما هو الوسم الذي يحدد الرأس في HTML؟\", \"options\": [\"<head>\", \"<header>\", \"<top>\", \"<title>\"], \"correctAnswer\": \"<head>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإنشاء قائمة مرتبة؟\", \"options\": [\"<ul>\", \"<ol>\", \"<li>\", \"<menu>\"], \"correctAnswer\": \"<ol>\"}\r\n]', '2025-03-17 20:14:37'),
(3, 1, 'اختبار HTML - الجزء 3', '[\r\n  {\"question\": \"ما هو العنصر المستخدم لتقسيم الصفحة إلى أقسام؟\", \"options\": [\"<div>\", \"<section>\", \"<article>\", \"<aside>\"], \"correctAnswer\": \"<section>\"},\r\n  {\"question\": \"أي من هذه العناصر يستخدم لإدراج فيديو؟\", \"options\": [\"<video>\", \"<media>\", \"<iframe>\", \"<movie>\"], \"correctAnswer\": \"<video>\"},\r\n  {\"question\": \"ما هو الوسم المستخدم لإضافة عنوان في المتصفح؟\", \"options\": [\"<title>\", \"<h1>\", \"<meta>\", \"<head>\"], \"correctAnswer\": \"<title>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لتحديد محتوى جانبي؟\", \"options\": [\"<aside>\", \"<section>\", \"<article>\", \"<footer>\"], \"correctAnswer\": \"<aside>\"},\r\n  {\"question\": \"ما هو الوسم المستخدم لإنشاء زر؟\", \"options\": [\"<btn>\", \"<button>\", \"<click>\", \"<input type=button>\"], \"correctAnswer\": \"<button>\"}\r\n]', '2025-03-17 20:14:37'),
(4, 1, 'اختبار HTML - الجزء 4', '[\r\n  {\"question\": \"ما هو العنصر المستخدم لإدخال بريد إلكتروني؟\", \"options\": [\"<input type=email>\", \"<input type=text>\", \"<email>\", \"<textbox>\"], \"correctAnswer\": \"<input type=email>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإدخال كلمة مرور؟\", \"options\": [\"<password>\", \"<input type=password>\", \"<secure>\", \"<input type=secure>\"], \"correctAnswer\": \"<input type=password>\"},\r\n  {\"question\": \"أي من هذه العناصر يستخدم لإدراج صوت؟\", \"options\": [\"<audio>\", \"<sound>\", \"<mp3>\", \"<speaker>\"], \"correctAnswer\": \"<audio>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لتحديد جزء في النموذج (Form)؟\", \"options\": [\"<fieldset>\", \"<section>\", \"<div>\", \"<group>\"], \"correctAnswer\": \"<fieldset>\"},\r\n  {\"question\": \"ما هو العنصر الذي يتم وضعه داخل <form> لإرسال البيانات؟\", \"options\": [\"<submit>\", \"<input type=submit>\", \"<button>\", \"<send>\"], \"correctAnswer\": \"<input type=submit>\"}\r\n]', '2025-03-17 20:14:37'),
(5, 1, 'اختبار HTML - الجزء 5', '[\r\n  {\"question\": \"ما هو العنصر المستخدم لإضافة عنوان فرعي؟\", \"options\": [\"<h2>\", \"<sub-title>\", \"<small-title>\", \"<p>\"], \"correctAnswer\": \"<h2>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإضافة خط أفقي؟\", \"options\": [\"<line>\", \"<hr>\", \"<border>\", \"<divider>\"], \"correctAnswer\": \"<hr>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإضافة نص بخط عريض؟\", \"options\": [\"<strong>\", \"<bold>\", \"<b>\", \"<heavy>\"], \"correctAnswer\": \"<strong>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإضافة نص مائل؟\", \"options\": [\"<italic>\", \"<i>\", \"<em>\", \"<slant>\"], \"correctAnswer\": \"<i>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإضافة فقرة تحتوي على اقتباس؟\", \"options\": [\"<quote>\", \"<blockquote>\", \"<cite>\", \"<p>\"], \"correctAnswer\": \"<blockquote>\"}\r\n]', '2025-03-17 20:14:37'),
(6, 1, 'اختبار HTML - الجزء 6', '[\r\n  {\"question\": \"ما هو العنصر المستخدم لتعريف بيانات التعريف (Metadata)؟\", \"options\": [\"<meta>\", \"<data>\", \"<info>\", \"<head>\"], \"correctAnswer\": \"<meta>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإنشاء ارتباط داخلي؟\", \"options\": [\"<a href=#section>\", \"<link>\", \"<goto>\", \"<internal-link>\"], \"correctAnswer\": \"<a href=#section>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإنشاء زر تشغيل في الفيديو؟\", \"options\": [\"<play>\", \"<button>\", \"<control>\", \"<video controls>\"], \"correctAnswer\": \"<video controls>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لإنشاء نافذة منبثقة؟\", \"options\": [\"<popup>\", \"<modal>\", \"<dialog>\", \"<window>\"], \"correctAnswer\": \"<dialog>\"},\r\n  {\"question\": \"ما هو العنصر المستخدم لعرض محتوى من موقع آخر داخل الصفحة؟\", \"options\": [\"<iframe>\", \"<embed>\", \"<object>\", \"<external>\"], \"correctAnswer\": \"<iframe>\"}\r\n]', '2025-03-17 20:14:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `reset_code` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `created_at`, `reset_code`) VALUES
(88, 'hanzo', 'zhanzoov3@gmail.com', '$2y$10$1ZndUi.Ons3BCsI/zXQiG.B/x71UT.kVA4f1jAqHhj0MHc7weXfDu', '2025-03-13 01:22:55', NULL),
(95, 'mo1', 'mo@gmail.com', '$2y$10$WdmPNh8E.XxGuvg.EC2QCOmfCiW92Q1gXLaF2LOiNLJIShgCf290C', '2025-03-19 13:45:37', NULL),
(96, 'ali', 'ali@gmail.com', '$2y$10$FMYMrefdH8YYITeRSZ3b5eVPYZPRSrwG/WhN3Skr7zY5UWVAGbDfG', '2025-03-19 13:52:23', NULL),
(97, 'mohamed', 'mohamed@gmail.com', '$2y$10$h.6fNpOYZFEnR2BIxMD5vuYI0RrNBMNRTVkcf0mDoQVoJlXPQUL6i', '2025-03-19 16:08:16', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `courses_category_id_fk` (`category_id`);

--
-- Indexes for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD PRIMARY KEY (`enroll_id`),
  ADD KEY `enrollment_user_id_fk` (`user_id`),
  ADD KEY `enrollment_course_id_fk` (`course_id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`faq_id`),
  ADD KEY `faqs_course_id_fk` (`course_id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`lesson_id`),
  ADD KEY `lessons_course_id_fk` (`course_id`);

--
-- Indexes for table `progress`
--
ALTER TABLE `progress`
  ADD PRIMARY KEY (`progress_id`);

--
-- Indexes for table `requirements`
--
ALTER TABLE `requirements`
  ADD PRIMARY KEY (`requirement_id`),
  ADD KEY `requirements_course_id_fk` (`course_id`);

--
-- Indexes for table `roadmap`
--
ALTER TABLE `roadmap`
  ADD PRIMARY KEY (`roadmap_id`),
  ADD KEY `roadmap_course_id_fk` (`course_id`);

--
-- Indexes for table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`score_id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tests`
--
ALTER TABLE `tests`
  ADD PRIMARY KEY (`test_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `enrollment`
--
ALTER TABLE `enrollment`
  MODIFY `enroll_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `faq_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `lesson_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `progress`
--
ALTER TABLE `progress`
  MODIFY `progress_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `requirements`
--
ALTER TABLE `requirements`
  MODIFY `requirement_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `roadmap`
--
ALTER TABLE `roadmap`
  MODIFY `roadmap_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `score_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tests`
--
ALTER TABLE `tests`
  MODIFY `test_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `enrollment`
--
ALTER TABLE `enrollment`
  ADD CONSTRAINT `enrollment_course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `enrollment_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Constraints for table `requirements`
--
ALTER TABLE `requirements`
  ADD CONSTRAINT `requirements_course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Constraints for table `roadmap`
--
ALTER TABLE `roadmap`
  ADD CONSTRAINT `roadmap_course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Constraints for table `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `tests` (`test_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `scores_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `tests`
--
ALTER TABLE `tests`
  ADD CONSTRAINT `tests_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
