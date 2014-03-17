-- Problem 1
INSERT INTO `Application` VALUES
    (NULL, 'Keynote', NULL, 'PRODUCTIVITY'),
    (NULL, 'Pages', NULL, 'PRODUCTIVITY'),
    (NULL, 'Outlook', NULL, 'PRODUCTIVITY'),
    (NULL, 'Word', NULL, 'PRODUCTIVITY'),
    (NULL, 'PowerPoint', NULL, 'PRODUCTIVITY'),
    (NULL, 'Numbers', NULL, 'PRODUCTIVITY');

INSERT INTO `WebApplication` VALUES
    ((SELECT Id FROM Application WHERE name = 'Keynote'), 'http://apple.com/keynote', 2.00, 1000, 'Safari'),
    ((SELECT Id FROM Application WHERE name = 'Pages'), 'http://apple.com/pages', 3.00, 1000, 'Safari'),
    ((SELECT Id FROM Application WHERE name = 'Outlook'), 'http://microsoft.com/outlook', 10.00, 1000, 'IE'),
    ((SELECT Id FROM Application WHERE name = 'Word'), 'http://microsoft.com/word', 10.00, 1000, 'IE'),
    ((SELECT Id FROM Application WHERE name = 'PowerPoint'), 'http://microsoft.com/power_point', 20.00, 1000, 'IE'),
    ((SELECT Id FROM Application WHERE name = 'Numbers'), 'http://apple.com/numbers', 3.00, 1000, 'Safari');

-- Problem 2
INSERT INTO `Application` VALUES
    (NULL, 'Minecraft', NULL, 'GAMES'),
    (NULL, 'Asteroids', NULL, 'GAMES'),
    (NULL, 'Space Invaders', NULL, 'GAMES'),
    (NULL, 'Galaga', NULL, 'GAMES'),
    (NULL, 'Centipide', NULL, 'GAMES');

INSERT INTO `WebApplication` VALUES
    ((SELECT Id FROM Application WHERE name = 'Minecraft'), 'http://minecraft.net', 20.00, 1000, 'Google Chrome'),
    ((SELECT Id FROM Application WHERE name = 'Asteroids'), 'http://asteroids.com', 1.00, 1000, 'Mosaic'),
    ((SELECT Id FROM Application WHERE name = 'Space Invaders'), 'http://space-invaders.com', 0.25, 1000, 'Mozilla'),
    ((SELECT Id FROM Application WHERE name = 'Galaga'), 'http://galaga.com', 0.50, 1000, 'Netscape Navigator'),
    ((SELECT Id FROM Application WHERE name = 'Centipide'), 'http://centipide.com', 0.75, 1000, 'Lynx');

-- Problem 3

INSERT INTO `Developer` VALUES
    (NULL, 'Alice', 'Wonderland'),
    (NULL, 'Bob', 'Marley'),
    (NULL, 'Charly', 'Garcia'),
    (NULL, 'Frank', 'Herbert'),
    (NULL, 'Gregory', 'Peck'),
    (NULL, 'Edward', 'Norton');

INSERT INTO `Role` (application, developer, role)
    SELECT a.Id, d.Id, 'ARCHITECT'
    FROM Application a, Developer d
    WHERE d.firstName = "Alice" AND d.lastName = "Wonderland" AND a.category = "GAMES";

INSERT INTO `Role` (application, developer, role)
    SELECT a.Id, d.Id, 'USER EXPERIENCE'
    FROM Application a, Developer d
    WHERE d.firstName = "Bob" AND d.lastName = "Marley" AND a.category = "GAMES";

INSERT INTO `Role` (application, developer, role)
    SELECT a.Id, d.Id, 'DEVELOPER'
    FROM Application a, Developer d
    WHERE d.firstName = "Charly" AND d.lastName = "Garcia" AND a.category = "GAMES";

INSERT INTO `Role` (application, developer, role)
    SELECT a.Id, d.Id, 'PROJECT MANAGER'
    FROM Application a, Developer d
    WHERE d.firstName = "Frank" AND d.lastName = "Herbert" AND a.category = "PRODUCTIVITY";

INSERT INTO `Role` (application, developer, role)
    SELECT a.Id, d.Id, 'PRODUCT MANAGER'
    FROM Application a, Developer d
    WHERE d.firstName = "Gregory" AND d.lastName = "Peck" AND a.category = "GAMES";

INSERT INTO `Role` (application, developer, role)
    SELECT a.Id, d.Id, 'USER EXPERIENCE'
    FROM Application a, Developer d
    WHERE d.firstName = "Edward" AND d.lastName = "Norton" AND a.category = "PRODUCTIVITY";

-- Problem 4

INSERT INTO `Privilege` (applicationId, developerId, privilege, assetType)
    SELECT a.Id, d.Id, 'ALL', 'VIEW'
    FROM Application a, Developer d
    WHERE a.name = 'Centipide' AND d.firstName = 'Charly' AND d.lastName = 'Garcia';

INSERT INTO `Privilege` (applicationId, developerId, privilege, assetType)
    SELECT a.Id, d.Id, 'UPDATE', 'SCRIPT'
    FROM Application a, Developer d
    WHERE a.name = 'Outlook' AND d.firstName = 'Edward' AND d.lastName = 'Norton';

-- Problem 5

UPDATE `Role` `r`
    JOIN `Developer` `d` ON (r.developer = d.Id)
    SET r.role = 'PRODUCT MANAGER'
    WHERE r.role = 'PROJECT MANAGER' AND d.firstName = 'Frank' AND d.lastName = 'Herbert';

-- Problem 6

DELETE FROM `r`
    USING `Role` AS `r`
    JOIN `Developer` `d` ON (r.developer = d.Id)
    WHERE d.firstName = 'Gregory' AND d.lastName = 'Peck';

INSERT INTO `Role` (application, developer, role)
    SELECT w.Id, d.Id, 'DIRECTOR'
    FROM WebApplication w, Developer d
    WHERE d.firstName = 'Gregory' AND d.lastName = 'Peck';

-- Problem 7

DELETE FROM `p` USING `Privilege` AS `p`
    JOIN `Developer` `d` ON (p.developerId = d.Id)
    JOIN `Application` `a` ON (p.applicationId = a.Id)
    WHERE a.name = "Outlook" AND d.firstName = 'Edward' AND d.lastName = 'Norton' AND p.assetType = 'SCRIPT' AND p.privilege = 'UPDATE';

-- Problem 8

DELETE FROM `Asset`, `r`, `p`, `s`, `w` USING `Application` AS `a`
    LEFT JOIN `Asset` ON (Asset.applicationId = a.Id)
    LEFT JOIN `Role` `r` ON (r.application = a.Id)
    LEFT JOIN `Privilege` `p` ON (p.applicationId = a.Id)
    LEFT JOIN `Sales` `s` ON (s.applicationId = a.Id)
    LEFT JOIN `WebApplication` `w` ON (w.Id = a.Id)
    WHERE a.name = "PowerPoint";

DELETE FROM `Application` WHERE `name` = "PowerPoint";

-- Problem 9

INSERT INTO `Developer` VALUES
    (NULL, 'Edward', 'Scissorhands');

INSERT INTO `Role` (application, developer, role)
    SELECT a.Id, d.Id, 'PRODUCT MANAGER'
    FROM Application a, Developer d
    WHERE d.firstName = "Edward" AND d.lastName = "Scissorhands" AND a.category = "PRODUCTIVITY";

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-01-24", 11
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Outlook' AND d.firstName = 'Frank' AND d.lastName = 'Herbert';

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-01-25", 10
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Outlook' AND d.firstName = 'Frank' AND d.lastName = 'Herbert';

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-02-24", 8
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Outlook' AND d.firstName = 'Frank' AND d.lastName = 'Herbert';

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-02-25", 1
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Outlook' AND d.firstName = 'Frank' AND d.lastName = 'Herbert';

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-01-24", 9
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Pages' AND d.firstName = 'Edward' AND d.lastName = 'Scissorhands';

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-01-24", 40
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Outlook' AND d.firstName = 'Edward' AND d.lastName = 'Scissorhands';

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-02-24", 10
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Outlook' AND d.firstName = 'Edward' AND d.lastName = 'Scissorhands';

INSERT INTO `Asset` VALUES
    (NULL, "front page", "VIEW", (SELECT Id FROM `Application` WHERE `name` = 'Outlook')),
    (NULL, "inbox", "VIEW", (SELECT Id FROM `Application` WHERE `name` = 'Outlook')),
    (NULL, "site map", "VIEW", (SELECT Id FROM `Application` WHERE `name` = 'Pages'));

DROP VIEW IF EXISTS `WebApplicationSells`;
CREATE VIEW `WebApplicationSells` AS
    SELECT wa.Id as "waId", r.developer as "dId", MONTH(s.sold) as "month", YEAR(s.sold) as "year", SUM(s.quantity) as "quantity"
    FROM `Sales` `s`, `WebApplication` `wa`, `Role` `r`
    WHERE r.role = 'PRODUCT MANAGER' AND wa.Id = s.applicationId AND r.developer = s.developerId AND r.application = s.applicationId
    GROUP BY wa.Id, r.developer, MONTH(s.sold)
    ORDER BY wa.Id, r.developer;

DROP VIEW IF EXISTS `WebApplicationSellsMonthlyComparison`;
CREATE VIEW `WebApplicationSellsMonthlyComparison` AS 
    SELECT was1.waId as "waId", was1.dId, (was1.quantity / was2.quantity) AS "ratio"
    FROM `WebApplicationSells` `was1`, `WebApplicationSells` `was2`
    WHERE was1.waId = was2.waId AND was1.dId = was2.dId AND was1.month = MONTH(CURRENT_TIMESTAMP) AND was2.month  = was1.month - 1 AND was1.year = YEAR(CURRENT_TIMESTAMP) AND was1.year = was2.year
    HAVING ratio < 0.9;

SELECT wasmc.ratio as "Sales Ratio Current/Last", CONCAT(d.firstName, ' ', d.lastName) as "name", a.name
    FROM `WebApplicationSellsMonthlyComparison` `wasmc`
    JOIN `Developer` `d` ON (d.Id = wasmc.dId)
    JOIN `Asset` `a` ON (a.applicationId = wasmc.waId)
    WHERE a.type = "VIEW";

-- Problem 10

-- Specific test data for me
INSERT INTO `Asset` (name, type, applicationId)
    SELECT "Test", "CONTROLLER", a.Id
    FROM `Application` `a`
    JOIN `Role` `r` ON (a.Id = r.application)
    JOIN `Developer` `d` ON (r.developer = d.Id)
    WHERE a.name = "Centipide" AND d.firstName = "Alice" AND d.lastName = "Wonderland";

INSERT INTO `Asset` (name, type, applicationId)
    SELECT "NoTest", "CONTROLLER", a.Id
    FROM `Application` `a`
    JOIN `Role` `r` ON (a.Id = r.application)
    JOIN `Developer` `d` ON (r.developer = d.Id)
    WHERE a.name = "Outlook" AND d.firstName = "Edward" AND d.lastName = "Norton";

SELECT Asset.*
    FROM `Asset`
    JOIN `Application` `a` ON (a.Id = Asset.applicationId)
    JOIN `Role` `r` ON (r.application = a.Id)
    JOIN `Developer` `d` ON (d.Id = r.developer)
    WHERE d.firstName = "Alice" AND d.lastName = "Wonderland" AND Asset.type = "CONTROLLER";

-- Problem 11

INSERT INTO `Sales` (applicationId, developerId, sold, quantity)
    SELECT a.Id, d.Id, "2014-01-24 00:30:00", 11
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Minecraft' AND d.firstName = 'Gregory' AND d.lastName = 'Peck';

DROP VIEW IF EXISTS ApplicationCost;
CREATE VIEW ApplicationCost AS
    SELECT
    a.category, SUM(s.quantity * IFNULL(da.pricePerDownload, IFNULL(ma.price, wa.price))) as "price"
    FROM `Application` `a`
    LEFT JOIN `DesktopApplication` `da` ON (da.Id = a.Id)
    LEFT JOIN `MobileApplication` `ma` ON (ma.Id = a.Id)
    LEFT JOIN `WebApplication` `wa` ON (wa.Id = a.Id)
    JOIN `Sales` `s` ON (s.applicationId = a.Id)
    GROUP BY a.category;

SELECT category, price FROM ApplicationCost ORDER BY price DESC LIMIT 1;

-- Problem 12

INSERT INTO `Application` VALUES (NULL, 'Threes', NULL, 'GAMES');
INSERT INTO `MobileApplication` VALUES
    ((SELECT Id FROM Application WHERE name = 'Threes'), 'iOS', 10, 1.99);

INSERT INTO `Sales`
    SELECT a.Id, d.Id, "2013-01-24", 13
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Threes' AND d.firstName = 'Gregory' AND d.lastName = 'Peck';

INSERT INTO `Sales`
    SELECT a.Id, d.Id, "2014-01-24", 12
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Threes' AND d.firstName = 'Gregory' AND d.lastName = 'Peck';

INSERT INTO `Sales`
    SELECT a.Id, d.Id, "2014-02-24", 11
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Threes' AND d.firstName = 'Gregory' AND d.lastName = 'Peck';

INSERT INTO `Sales`
    SELECT a.Id, d.Id, "2014-02-24", 10
    FROM `Application` `a`, `Developer` `d`
    WHERE a.name = 'Threes' AND d.firstName = 'Charly' AND d.lastName = 'Garcia';

DROP VIEW IF EXISTS `MobileApplicationSells`;
CREATE VIEW `MobileApplicationSells` AS
    SELECT CONCAT(d.firstName, ' ', d.lastName) AS name, SUM(s.quantity) AS 'quantity'
    FROM `Developer` `d`
    JOIN `Sales` `s` ON (s.developerId = d.Id)
    JOIN `MobileApplication` `ma` ON (ma.Id = s.applicationId)
    WHERE MONTH(s.sold) = MONTH(CURRENT_TIMESTAMP) AND YEAR(s.sold) = YEAR(CURRENT_TIMESTAMP)
    GROUP BY d.Id;

SELECT * FROM `MobileApplicationSells` ORDER BY `quantity` DESC LIMIT 1;
