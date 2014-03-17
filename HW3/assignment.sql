DROP TABLE IF EXISTS Asset;
DROP TABLE IF EXISTS Privilege;
DROP TABLE IF EXISTS AssetType;
DROP TABLE IF EXISTS Role;
DROP TABLE IF EXISTS RoleType;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS MobileApplication;
DROP TABLE IF EXISTS WebApplication;
DROP TABLE IF EXISTS DesktopApplication;
DROP TABLE IF EXISTS Developer;
DROP TABLE IF EXISTS Application;
DROP TABLE IF EXISTS ApplicationCategory;
DROP TABLE IF EXISTS PrivilegeEnum;

CREATE TABLE Developer (
    Id        INT          AUTO_INCREMENT NOT NULL,
    firstName VARCHAR (50) NULL,
    lastName  VARCHAR (50) NULL,
    PRIMARY KEY (Id ASC)
);

CREATE TABLE ApplicationCategory (
    category VARCHAR (25) NOT NULL,
    PRIMARY KEY (category ASC)
);

INSERT INTO ApplicationCategory (category) VALUES ('GAMES');
INSERT INTO ApplicationCategory (category) VALUES ('PRODUCTIVITY');

CREATE TABLE Application (
    Id       INT          AUTO_INCREMENT NOT NULL,
    name     VARCHAR (50) DEFAULT 'Application' NULL,
    created  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NULL,
    category VARCHAR (25) NULL,
    PRIMARY KEY (Id ASC),
    FOREIGN KEY (category) REFERENCES ApplicationCategory (category)
);

CREATE TABLE Sales (
    applicationId  INT,
    developerId    INT,
    sold           DATE NULL,
    quantity       INT,
    FOREIGN KEY (applicationId) REFERENCES Application (Id),
    FOREIGN KEY (developerId)   REFERENCES Developer   (Id)
);

CREATE TABLE DesktopApplication (
    Id               INT          NOT NULL,
    downloads   INT NULL,
    os               VARCHAR (50) NULL,
    pricePerDownload FLOAT (53)   NULL,
    PRIMARY KEY (Id ASC),
    FOREIGN KEY (Id) REFERENCES Application (Id) ON DELETE CASCADE
);

CREATE TABLE WebApplication (
    Id      INT           NOT NULL,
    url     VARCHAR (100) DEFAULT 'http://cnn.com' NULL,
    price   FLOAT (53)    DEFAULT 0.99 NULL,
    subscribers INT NULL,
    browser VARCHAR (50)  NULL,
    PRIMARY KEY (Id ASC),
    FOREIGN KEY (Id) REFERENCES Application (Id) ON DELETE CASCADE
);

CREATE TABLE MobileApplication (
    Id           INT          NOT NULL,
    os           VARCHAR (50) NULL,
    installCount INT          NULL,
    price        FLOAT (53)   NULL,
    PRIMARY KEY (Id ASC),
    FOREIGN KEY (Id) REFERENCES Application (Id) ON DELETE CASCADE
);

CREATE TABLE RoleType (
    type VARCHAR (50) NOT NULL,
    PRIMARY KEY (type ASC)
);

INSERT INTO RoleType (type) VALUES ('ARCHITECT');
INSERT INTO RoleType (type) VALUES ('BUSINESS ANALYST');
INSERT INTO RoleType (type) VALUES ('DEVELOPER');
INSERT INTO RoleType (type) VALUES ('PROJECT MANAGER');
INSERT INTO RoleType (type) VALUES ('PRODUCT MANAGER');
INSERT INTO RoleType (type) VALUES ('USER EXPERIENCE');
INSERT INTO RoleType (type) VALUES ('DIRECTOR');

CREATE TABLE Role (
    Id          INT          AUTO_INCREMENT NOT NULL,
    application INT          NULL,
    developer   INT          NULL,
    role        VARCHAR (50) NULL,
    PRIMARY KEY (Id ASC),
    UNIQUE (developer ASC, application ASC, role ASC),
    FOREIGN KEY (application) REFERENCES Application (Id),
    FOREIGN KEY (developer) REFERENCES Developer (Id),
    FOREIGN KEY (role) REFERENCES RoleType (type)
);

CREATE TABLE PrivilegeEnum (
    privilege VARCHAR (20) NOT NULL,
    PRIMARY KEY (privilege ASC)
);

INSERT INTO PrivilegeEnum (privilege) VALUES ('ALL');
INSERT INTO PrivilegeEnum (privilege) VALUES ('CREATE');
INSERT INTO PrivilegeEnum (privilege) VALUES ('DELETE');
INSERT INTO PrivilegeEnum (privilege) VALUES ('READ');
INSERT INTO PrivilegeEnum (privilege) VALUES ('UPDATE');

CREATE TABLE AssetType (
    type VARCHAR (20) NOT NULL,
    PRIMARY KEY (type ASC)
);

INSERT INTO AssetType (type) VALUES ('APPLICATION');
INSERT INTO AssetType (type) VALUES ('DATA');
INSERT INTO AssetType (type) VALUES ('MODEL');
INSERT INTO AssetType (type) VALUES ('LOGIC');
INSERT INTO AssetType (type) VALUES ('PAGE');
INSERT INTO AssetType (type) VALUES ('PRESENTATION');
INSERT INTO AssetType (type) VALUES ('SCRIPT');
INSERT INTO AssetType (type) VALUES ('CONTROLLER');
INSERT INTO AssetType (type) VALUES ('VIEW');

CREATE TABLE Privilege (
    applicationId INT          NULL,
    developerId  INT          NULL,
    privilege     VARCHAR (20) NULL,
    assetType     VARCHAR (20) NULL,
    FOREIGN KEY (applicationId) REFERENCES Application (Id),
    FOREIGN KEY (developerId) REFERENCES Developer (Id),
    FOREIGN KEY (privilege) REFERENCES PrivilegeEnum (privilege),
    FOREIGN KEY (assetType) REFERENCES AssetType (type)
);

CREATE TABLE Asset (
    Id              INT         AUTO_INCREMENT NOT NULL,
    name            VARCHAR(50) NOT NULL,
    type            VARCHAR(20) NOT NULL,
    applicationId   INT         NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (type) REFERENCES AssetType (type),
    FOREIGN KEY (applicationId) REFERENCES Application (Id)
);
