DROP TABLE IF EXISTS `cast`;
DROP TABLE IF EXISTS `comment`;
DROP TABLE IF EXISTS `actor`;
DROP TABLE IF EXISTS `movie`;
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    dateOfBirth DATE NOT NULL,
    PRIMARY KEY (`username`)
);

CREATE TABLE `movie` (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    posterImage VARCHAR(255) NOT NULL,
    releaseDate DATE NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `actor` (
    id INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    dateOfBirth DATE NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `comment` (
    id INT NOT NULL AUTO_INCREMENT,
    comment VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    userUsername VARCHAR(255) NOT NULL,
    movieId INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`userUsername`) REFERENCES `user` (`username`),
    FOREIGN KEY (`movieId`) REFERENCES `movie` (`id`)
);

CREATE TABLE `cast` (
    id INT NOT NULL AUTO_INCREMENT,
    characterName VARCHAR(255) NOT NULL,
    actorId INT NOT NULL,
    movieId INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`actorId`) REFERENCES `actor` (`id`),
    FOREIGN KEY (`movieId`) REFERENCES `movie` (`id`)
);
