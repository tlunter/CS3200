-- Database creation
DROP DATABASE IF EXISTS `cs3200_hw2`;
CREATE DATABASE `cs3200_hw2`;
USE `cs3200_hw2`;

-- Table creation

DROP TABLE IF EXISTS `developer`;
CREATE TABLE `developer` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
    `name` varchar(32) NOT NULL,
    PRIMARY KEY (`name`)
);

DROP TABLE IF EXISTS `application_type`;
CREATE TABLE `application_type` (
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`name`)
);

-- DROP TABLE IF EXISTS `application`;
-- CREATE TABLE `application` (
--     `id` int(11) NOT NULL AUTO_INCREMENT,
--     `date_created` date NOT NULL,
--     `name` varchar(255) NOT NULL,
--     `type` varchar(255) NOT NULL,
--     -- Desktop
--     `target_desktop_os` varchar(255),
--     -- Mobile
--     `target_mobile_os` varchar(255),
--     `times_installed` int(11),
--     -- Web
--     `url` varchar(255),
--     `target_browser` varchar(255),
--     -- Desktop/Web
--     `price` decimal(10, 2),
--     PRIMARY KEY (`id`),
--     CONSTRAINT `fk_application_application_type_name` FOREIGN KEY (`type`) REFERENCES `application_type` (`name`),
--     CONSTRAINT `fk_application_desktop_os_name` FOREIGN KEY (`target_desktop_os`) REFERENCES `desktop_os` (`name`),
--     CONSTRAINT `fk_application_mobile_os_name` FOREIGN KEY (`target_mobile_os`) REFERENCES `mobile_os` (`name`),
--     CONSTRAINT `fk_application_web_browser_name` FOREIGN KEY (`target_browser`) REFERENCES `web_browser` (`name`)
-- );

DROP TABLE IF EXISTS `application`;
CREATE TABLE `application` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `date_created` date NOT NULL,
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `developer_id` int(11) NOT NULL,
    `application_id` int(11) NOT NULL,
    `position` varchar(32) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_role_developer_id` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_role_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_role_position_name` FOREIGN KEY (`position`) REFERENCES `position` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `unique_role_dev_id_app_id_position` UNIQUE (`developer_id`,`application_id`,`position`)
);

DROP TABLE IF EXISTS `desktop_os`;
CREATE TABLE `desktop_os` (
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`name`)
);

DROP TABLE IF EXISTS `desktop_application`;
CREATE TABLE `desktop_application` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `application_id` int(11) NOT NULL,
    `target_os` varchar(255) NOT NULL,
    `price` decimal(10, 2) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_desktop_application_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_desktop_application_desktop_os_name` FOREIGN KEY (`target_os`) REFERENCES `desktop_os` (`name`)
);

DROP TABLE IF EXISTS `mobile_os`;
CREATE TABLE `mobile_os` (
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`name`)
);

DROP TABLE IF EXISTS `mobile_application`;
CREATE TABLE `mobile_application` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `application_id` int(11) NOT NULL,
    `target_os` varchar(255) NOT NULL,
    `times_installed` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_mobile_application_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_mobile_application_mobile_os_name` FOREIGN KEY (`target_os`) REFERENCES `mobile_os` (`name`)
);

DROP TABLE IF EXISTS `web_browser`;
CREATE TABLE `web_browser` (
    `name` varchar(255) NOT NULL,
    PRIMARY KEY (`name`)
);

DROP TABLE IF EXISTS `web_application`;
CREATE TABLE `web_application` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `application_id` int(11) NOT NULL,
    `url` varchar(255) NOT NULL,
    `target_browser` varchar(255) NOT NULL,
    `price` decimal(10, 2) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_web_application_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_web_application_web_browser_name` FOREIGN KEY (`target_browser`) REFERENCES `web_browser` (`name`)
);

DROP TABLE IF EXISTS `model`;
CREATE TABLE `model` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `application_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `unique_model_application_id` UNIQUE (`name`, `application_id`),
    CONSTRAINT `fk_model_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`)
);

DROP TABLE IF EXISTS `data_type`;
CREATE TABLE `data_type` (
    `type` varchar(255) NOT NULL,
    PRIMARY KEY (`type`)
);

DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `model_id` int(11) NOT NULL,
    `name` varchar(255) NOT NULL,
    `type` varchar(255) NOT NULL,
    `string_value` varchar(255),
    `number_value` decimal(65, 30),
    `date_value` date,
    `parent_attribute` int(11),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_attribute_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_attribute_data_type_type` FOREIGN KEY (`type`) REFERENCES `data_type` (`type`),
    CONSTRAINT `fk_attribute_attribute_id` FOREIGN KEY (`parent_attribute`) REFERENCES `attribute` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `view`;
CREATE TABLE `view` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `application_id` int(11) NOT NULL,
    `parent_view` int(11),
    `model_id` int(11),
    PRIMARY KEY (`id`),
    CONSTRAINT `unique_view_application_id` UNIQUE (`name`, `application_id`),
    CONSTRAINT `fk_view_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_view_view_id` FOREIGN KEY (`parent_view`) REFERENCES `view` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_view_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `event_handler`;
CREATE TABLE `event_handler` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `view_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_event_handler_view_id` FOREIGN KEY (`view_id`) REFERENCES `view` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `controller`;
CREATE TABLE `controller` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `application_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `unique_controller_application_id` UNIQUE (`name`, `application_id`),
    CONSTRAINT `fk_controller_application_id` FOREIGN KEY (`application_id`) REFERENCES `application` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `script`;
CREATE TABLE `script` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `controller_id` int(11) NOT NULL,
    `model_id` int(11),
    `file_path` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `unique_name_controller_id` UNIQUE (`name`, `controller_id`),
    CONSTRAINT `fk_script_controller_id` FOREIGN KEY (`controller_id`) REFERENCES `controller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_script_model_id` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `event_handler_id` int(11) NOT NULL,
    `script_id` int(11) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_event_event_handler_id` FOREIGN KEY (`event_handler_id`) REFERENCES `event_handler` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_event_script_id` FOREIGN KEY (`script_id`) REFERENCES `script` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Data insert

INSERT INTO `developer` VALUES
    (NULL, 'Todd Lunter'),
    (NULL, 'Daniel Nordness'),
    (NULL, 'Rob Shore'),
    (NULL, 'Dan Osborne'),
    (NULL, 'Tom Hulihan'),
    (NULL, 'Keith Barrette');

INSERT INTO `position` VALUES
    ('Product Manager'),
    ('Business Analyst'),
    ('Architect'),
    ('Database Admin'),
    ('Backend Developer'),
    ('Frontend Developer');

INSERT INTO `application_type` VALUES
    ('Desktop Application'), ('Mobile Application'), ('Web Application');

INSERT INTO `application` VALUES
    (NULL, '2004-02-04', 'Facebook'),
    (NULL, '2008-07-04', 'TweetDeck'),
    (NULL, '2005-06-01', 'reddit'),
    (NULL, '2008-04-01', 'GitHub'),
    (NULL, '2007-02-19', 'Hacker News');

INSERT INTO `role` VALUES
    (NULL, 1, 2, 'Backend Developer'),
    (NULL, 1, 2, 'Frontend Developer'),
    (NULL, 2, 1, 'Product Manager'),
    (NULL, 5, 3, 'Database Admin'),
    (NULL, 3, 5, 'Business Analyst');

INSERT INTO `desktop_os` VALUES
    ('Windows'), ('Mac OS X'), ('Linux');

INSERT INTO `desktop_application` VALUES
    (NULL, 2, 'Windows', 40.00),
    (NULL, 4, 'Mac OS X', 1.00);

INSERT INTO `mobile_os` VALUES
    ('Android'), ('iOS'), ('Windows Phone'), ('Symbian');

INSERT INTO `mobile_application` VALUES
    (NULL, 1, 'Android', 1000000000);

INSERT INTO `web_browser` VALUES
    ('Google Chrome'), ('Mozilla Firefox'), ('Internet Explorer'), ('Opera');

INSERT INTO `web_application` VALUES
    (NULL, 3, 'http://www.reddit.com', 'Google Chrome', 10.00),
    (NULL, 5, 'http://news.ycombinator.com', 'Mozilla Firefox', 90000000.00);

INSERT INTO `model` VALUES
    (NULL, 'user', 1),
    (NULL, 'user', 2),
    (NULL, 'tweet', 2),
    (NULL, 'user', 3),
    (NULL, 'user', 4),
    (NULL, 'repository', 4),
    (NULL, 'user', 5);

INSERT INTO `data_type` VALUES
    ('String'), ('Number'), ('Date'), ('Set');

INSERT INTO `attribute` VALUES
    (NULL, 1, 'email', 'String', 'tlunter@gmail.com', NULL, NULL, NULL),
    (NULL, 1, 'password', 'String', 'bbb2c5e63d2ef893106fdd0d797aa97a', NULL, NULL, NULL),
    (NULL, 2, 'email', 'String', 'tlunter@gmail.com', NULL, NULL, NULL),
    (NULL, 2, 'join_date', 'Date', NULL, NULL, '2009-01-01', NULL),
    (NULL, 3, 'favorites', 'Number', NULL, 10, NULL, NULL),
    (NULL, 6, 'permissions', 'Set', NULL, NULL, NULL, NULL),
    (NULL, 6, 'create', 'String', 'tlunter', NULL, NULL, 6),
    (NULL, 6, 'delete', 'String', 'tlunter', NULL, NULL, 6);

INSERT INTO `view` VALUES
    (NULL, 'tweets.html.erb', 2, NULL, 3),
    (NULL, 'users.html.erb', 1, NULL, 1),
    (NULL, 'users.html.erb', 2, NULL, 2),
    (NULL, 'repositories.html.erb', 4, NULL, 6),
    (NULL, 'contributors.html.erb', 4, 4, 6);

INSERT INTO `event_handler` VALUES
    (NULL, 1), (NULL, 1), (NULL, 2);

INSERT INTO `controller` VALUES
    (NULL, 'tweets', 2),
    (NULL, 'users', 1),
    (NULL, 'users', 2),
    (NULL, 'repositories', 4);

INSERT INTO `script` VALUES
    (NULL, 'favorite', 1, 3, 'favorite_tweet.pl'),
    (NULL, 'refresh', 1, NULL, 'refresh_tweets.pl'),
    (NULL, 'add friend', 2, 1, 'add_friend.pl');

INSERT INTO `event` VALUES
    (NULL, 1, 1),
    (NULL, 2, 2),
    (NULL, 3, 3);

-- Show tables
SHOW TABLES;

-- Select statements
SELECT "Developer" as "";
SELECT * FROM `developer` LIMIT 5;

SELECT "Position" as "";
SELECT * FROM `position` LIMIT 5;

SELECT "Application Type" as "";
SELECT * FROM `application_type` LIMIT 5;

SELECT "Application" as "";
SELECT * FROM `application` LIMIT 5;

SELECT "Role" as "";
SELECT * FROM `role` LIMIT 5;

SELECT "Desktop OS" as "";
SELECT * FROM `desktop_os` LIMIT 5;

SELECT "Mobile OS" as "";
SELECT * FROM `mobile_os` LIMIT 5;

SELECT "Web Browser" as "";
SELECT * FROM `web_browser` LIMIT 5;

SELECT "Desktop Application" as "";
SELECT * FROM `desktop_application` LIMIT 5;

SELECT "Mobile Application" as "";
SELECT * FROM `mobile_application` LIMIT 5;

SELECT "Web Application" as "";
SELECT * FROM `web_application` LIMIT 5;

SELECT "Model" as "";
SELECT * FROM `model` LIMIT 5;

SELECT "Data Type" as "";
SELECT * FROM `data_type` LIMIT 5;

SELECT "Attribute" as "";
SELECT * FROM `attribute` LIMIT 5;

SELECT "View" as "";
SELECT * FROM `view` LIMIT 5;

SELECT "Event Handler" as "";
SELECT * FROM `event_handler` LIMIT 5;

SELECT "Controller" as "";
SELECT * FROM `controller` LIMIT 5;

SELECT "Script" as "";
SELECT * FROM `script` LIMIT 5;

SELECT "Event" as "";
SELECT * FROM `event` LIMIT 5;

SELECT "Application - Desktop Application Join" as "";
SELECT * FROM `application` `a` INNER JOIN `desktop_application` `w` ON (w.application_id = a.id);

SELECT "Application - Mobile Application Join" as "";
SELECT * FROM `application` `a` INNER JOIN `mobile_application` `w` ON (w.application_id = a.id);

SELECT "Application - Web Application Join" as "";
SELECT * FROM `application` `a` INNER JOIN `web_application` `w` ON (w.application_id = a.id);

SELECT "Developer - Application - Position Join" as "";
SELECT d.name as "Developer", a.name as "Application", p.name as "Position" FROM `role` `r` JOIN `developer` `d` JOIN `application` `a` JOIN `position` `p` ON (r.developer_id = d.id AND r.application_id = a.id AND r.position = p.name);

SELECT "Model - Application Join" as "";
SELECT m.*, a.name as "application" FROM `model` `m` JOIN `application` `a` ON (a.id = m.application_id);

SELECT "View - Application Join" as "";
SELECT v.*, a.name as "application" FROM `view` `v` JOIN `application` `a` ON (a.id = v.application_id);

SELECT "Controller - Application Join" as "";
SELECT c.*, a.name as "application" FROM `controller` `c` JOIN `application` `a` ON (a.id = c.application_id);

SELECT "Attribute - Model Join" as "";
SELECT a.*, m.name as "model" FROM `attribute` `a` JOIN `model` `m` ON (m.id = a.model_id);

SELECT "Attribute - Attribute Join" as "";
SELECT a1.*, a2.name as "parent attribute" FROM `attribute` `a1` INNER JOIN `attribute` `a2` ON (a1.parent_attribute = a2.id);

SELECT "View - View Join" as "";
SELECT v1.*, v2.name as "parent view" FROM `view` `v1` INNER JOIN `view` `v2` ON (v1.parent_view = v2.id);

SELECT "View - Event Handler - Event - Script Join" as "";
SELECT v.name as "view", ev.id as "event_handler", s.name as "script" FROM `event` `e` JOIN `view` `v` JOIN `event_handler` `ev` JOIN `script` `s` ON (e.script_id = s.id AND e.event_handler_id = ev.id AND ev.view_id = v.id);

SELECT "Script - Controller - Model Join" as "";
SELECT s.*, c.name as "controller", m.name as "model" FROM `script` `s` LEFT JOIN `model` `m`ON m.id = s.model_id LEFT JOIN `controller` `c` ON c.id = s.controller_id;
