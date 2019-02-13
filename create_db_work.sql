SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS
, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS
, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE
, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bicycles
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bicycles`
;

-- -----------------------------------------------------
-- Schema bicycles
-- -----------------------------------------------------
CREATE SCHEMA
IF NOT EXISTS `bicycles` DEFAULT CHARACTER
SET utf8 ;
USE `bicycles`
;

-- -----------------------------------------------------
-- Table `bicycles`.`Members`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Members` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Members`
(
  `Member_ID` INT NOT NULL AUTO_INCREMENT,
  `Member_Type` VARCHAR
(50) NOT NULL,
  `Member_LastName` VARCHAR
(50) NOT NULL,
  `Member_FirstName` VARCHAR
(50) NOT NULL,
  `Member_Email` VARCHAR
(50) NOT NULL,
  `Member_Telephone` VARCHAR
(15) NOT NULL,
  `Member_Address` VARCHAR
(150) NOT NULL,
  `Member_Status` TINYINT
(1) NOT NULL,
  `Member_Payment_Method_ID` VARCHAR
(50) NOT NULL,
  `Age` INT NOT NULL,
  CONSTRAINT CheckAge
CHECK
(`Age` BETWEEN 14 and 70),
  PRIMARY KEY
(`Member_ID`),
  UNIQUE INDEX `Member_ID_UNIQUE`
(`Member_ID` ASC));


-- -----------------------------------------------------
-- Table `bicycles`.`Bicycles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Bicycles` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Bicycles`
(
  `Bicycle_ID` INT NOT NULL AUTO_INCREMENT,
  `Member_Type` VARCHAR
(50) NOT NULL,
  `Bicycle_Make` VARCHAR
(50) NOT NULL,
  `Bicycle_Color` VARCHAR
(50) NOT NULL,
  `Bicycle_Size` VARCHAR
(50) NOT NULL,
  PRIMARY KEY
(`Bicycle_ID`),
  UNIQUE INDEX `Bicycle_ID_UNIQUE`
(`Bicycle_ID` ASC));


-- -----------------------------------------------------
-- Table `bicycles`.`Sponsors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Sponsors` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Sponsors`
(
  `Sponsor_Name` VARCHAR
(50) NOT NULL,
  `Sponsor_Company` VARCHAR
(50) NOT NULL,
  `Sponsor_Contact_Person` VARCHAR
(100) NOT NULL,
  `Sponsor_Telephone` VARCHAR
(15) NOT NULL,
  `Sponsor_Address` VARCHAR
(150) NOT NULL,
  `Sponsor_Period` DATE NOT NULL,
  `Sponsor_Fees` INT NOT NULL,
  `Sponsor_Comments` VARCHAR
(255) NULL DEFAULT NULL,
  PRIMARY KEY
(`Sponsor_Name`),
  UNIQUE INDEX `Sponsor_Name_UNIQUE`
(`Sponsor_Name` ASC));


-- -----------------------------------------------------
-- Table `bicycles`.`Payment_Methods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Payment_Methods` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Payment_Methods`
(
  `Payment_Method_Code` VARCHAR
(50) NOT NULL,
  PRIMARY KEY
(`Payment_Method_Code`),
  UNIQUE INDEX `Payment_Method_Code_UNIQUE`
(`Payment_Method_Code` ASC));


-- -----------------------------------------------------
-- Table `bicycles`.`Rates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Rates` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Rates`
(
  `Daily` INT NOT NULL,
  `Monthly` INT NOT NULL,
  `Yearly` INT NOT NULL,
  `Rental_Rates` INT NOT NULL,
  INDEX `Rates`
(`Rental_Rates` ASC));


-- -----------------------------------------------------
-- Table `bicycles`.`Visitors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Visitors` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Visitors`
(
  `Visitor_ID` INT NOT NULL AUTO_INCREMENT,
  `Visitor_LastName` VARCHAR
(50) NOT NULL,
  `Visitor_FirstName` VARCHAR
(50) NOT NULL,
  `Visitor_Email` VARCHAR
(50) NOT NULL,
  `Visitor_Telephone` VARCHAR
(15) NOT NULL,
  `Visitor_Address` VARCHAR
(150) NULL DEFAULT NULL,
  `Visitor_Payment_Method_ID` VARCHAR
(50) NOT NULL,
  `Age` INT NOT NULL,
  CONSTRAINT CheckAge
CHECK
(`Age` BETWEEN 14 and 70),
  PRIMARY KEY
(`Visitor_ID`),
  UNIQUE INDEX `Visitor_ID_UNIQUE`
(`Visitor_ID` ASC),
  INDEX `Visitor_Payment_Method_ID1_idx`
(`Visitor_Payment_Method_ID` ASC),
  CONSTRAINT `Visitor_Payment_Method_ID1`
    FOREIGN KEY
(`Visitor_Payment_Method_ID`)
    REFERENCES `bicycles`.`Visitor_Payments`
(`Visitor_Payment_Method_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Renters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Renters` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Renters`
(
  `Renter_ID` INT NOT NULL,
  `Member_ID` INT NULL DEFAULT NULL,
  `Visitor_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY
(`Renter_ID`),
  UNIQUE INDEX `Member_ID_UNIQUE`
(`Member_ID` ASC),
  UNIQUE INDEX `Visitor_ID_UNIQUE`
(`Visitor_ID` ASC),
  UNIQUE INDEX `Renter_ID_UNIQUE`
(`Renter_ID` ASC),
  CONSTRAINT `Member_ID`
    FOREIGN KEY
(`Member_ID`)
    REFERENCES `bicycles`.`Members`
(`Member_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Visitor_ID`
    FOREIGN KEY
(`Visitor_ID`)
    REFERENCES `bicycles`.`Visitors`
(`Visitor_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Cities` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Cities`
(
  `City` CHAR
(50) NOT NULL,
  PRIMARY KEY
(`City`),
  UNIQUE INDEX `City_UNIQUE`
(`City` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bicycles`.`Terminals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Terminals` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Terminals`
(
  `Terminal_Number` INT NOT NULL,
  `Terminal_Name` VARCHAR
(50) NOT NULL,
  `Terminal_Address` VARCHAR
(150) NOT NULL,
  `Terminal_Telephone` VARCHAR
(15) NOT NULL,
  `Terminal_Capacity` SMALLINT NOT NULL,
  `Terminal_City` CHAR
(50) NOT NULL,
  PRIMARY KEY
(`Terminal_Number`),
  UNIQUE INDEX `Terminal_Number_UNIQUE`
(`Terminal_Number` ASC),
  UNIQUE INDEX `Terminal_City_UNIQUE`
(`Terminal_City` ASC),
  CONSTRAINT `Terminal_City`
    FOREIGN KEY
(`Terminal_City`)
    REFERENCES `bicycles`.`Cities`
(`City`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Racks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Racks` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Racks`
(
  `Rack_Number` INT NOT NULL,
  `Rack_Name` VARCHAR
(50) NOT NULL,
  `Rack_Location` VARCHAR
(150) NOT NULL,
  `Rack_Capacity` INT NOT NULL,
  `Rack_City` CHAR
(50) NOT NULL,
  PRIMARY KEY
(`Rack_Number`),
  INDEX `Rack_City`
(`Rack_City` ASC),
  CONSTRAINT `Rack_City`
    FOREIGN KEY
(`Rack_City`)
    REFERENCES `bicycles`.`Cities`
(`City`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Rentals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Rentals` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Rentals`
(
  `Rental_ID` INT NOT NULL,
  `Bicycle_ID` INT NOT NULL,
  `Renter_ID` INT NOT NULL,
  `Renter_Payment_ID` VARCHAR
(50) NOT NULL,
  `Renter Payment_Method_Code` VARCHAR
(50) NOT NULL,
  `Rental_Rates` INT NOT NULL,
  `Booked_Start` DATE NOT NULL,
  `Booked_End` DATE NOT NULL,
  `Actual_Start` DATE NOT NULL,
  `Actual_End` DATE NOT NULL,
  `Terminal_Number` INT NOT NULL,
  `Rack_Number` INT NOT NULL,
  `Terminal_City` CHAR
(50) NOT NULL,
  `Rack_City` CHAR
(50) NOT NULL,
  UNIQUE INDEX `Bicycle_ID_UNIQUE`
(`Rental_ID` ASC),
  UNIQUE INDEX `Renter_ID_UNIQUE`
(`Renter_ID` ASC),
  UNIQUE INDEX `Renter_Payment_ID_UNIQUE`
(`Renter_Payment_ID` ASC),
  PRIMARY KEY
(`Rental_ID`, `Renter Payment_Method_Code`),
  INDEX `Terminal_Number_idx`
(`Terminal_Number` ASC),
  INDEX `Rack_Number_idx`
(`Rack_Number` ASC),
  INDEX `Rack_City_idx`
(`Rack_City` ASC),
  INDEX `Terminal_City_idx`
(`Terminal_City` ASC),
  INDEX `Renter_Payment_Method_Code_idx`
(`Renter Payment_Method_Code` ASC),
  UNIQUE INDEX `Renter Payment_Method_Code_UNIQUE`
(`Renter Payment_Method_Code` ASC),
  CONSTRAINT `Renter_IDs`
    FOREIGN KEY
(`Renter_ID`)
    REFERENCES `bicycles`.`Renters`
(`Renter_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Bicycle_IDs`
    FOREIGN KEY
(`Bicycle_ID`)
    REFERENCES `bicycles`.`Bicycles`
(`Bicycle_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Terminal_Number1`
    FOREIGN KEY
(`Terminal_Number`)
    REFERENCES `bicycles`.`Terminals`
(`Terminal_Number`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Rack_Number1`
    FOREIGN KEY
(`Rack_Number`)
    REFERENCES `bicycles`.`Racks`
(`Rack_Number`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Rack_Cities1`
    FOREIGN KEY
(`Rack_City`)
    REFERENCES `bicycles`.`Racks`
(`Rack_City`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Terminal_Cities1`
    FOREIGN KEY
(`Terminal_City`)
    REFERENCES `bicycles`.`Terminals`
(`Terminal_City`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Renter_Payment_Method_Code1`
    FOREIGN KEY
(`Renter Payment_Method_Code`)
    REFERENCES `bicycles`.`Payment_Methods`
(`Payment_Method_Code`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Member_Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Member_Payments` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Member_Payments`
(
  `Member_Payment_Method_ID` VARCHAR
(50) NOT NULL,
  `Member_Type` VARCHAR
(50) NOT NULL,
  `Purchase_Date` DATE NOT NULL,
  `Payment_Method_Code` VARCHAR
(50) NOT NULL,
  `Card_Number` INT NULL DEFAULT NULL,
  `Member_ID` INT NULL,
  PRIMARY KEY
(`Member_Payment_Method_ID`),
  UNIQUE INDEX `Member_Payment_Method_ID_UNIQUE`
(`Member_Payment_Method_ID` ASC),
  INDEX `Member_ID_idx`
(`Member_ID` ASC),
  INDEX `Payment_Method_Code_idx`
(`Payment_Method_Code` ASC),
  CONSTRAINT `Member_ID1`
    FOREIGN KEY
(`Member_ID`)
    REFERENCES `bicycles`.`Members`
(`Member_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Payment_Method_Code1`
    FOREIGN KEY
(`Payment_Method_Code`)
    REFERENCES `bicycles`.`Rentals`
(`Renter Payment_Method_Code`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Payments` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Payments`
(
  `Renter_Payment_ID` VARCHAR
(50) NOT NULL,
  `Renter_ID` INT NOT NULL,
  `Renter_Payment_Method_Code` VARCHAR
(50) NOT NULL,
  `Member_Payment_Method_ID` VARCHAR
(50) NOT NULL,
  `Visitor_Payment_Method_ID` VARCHAR
(50) NOT NULL,
  UNIQUE INDEX `Renter_Payment_ID_UNIQUE`
(`Renter_Payment_ID` ASC),
  INDEX `Member_Payment_Method_ID_idx`
(`Member_Payment_Method_ID` ASC),
  INDEX `Renter Payment_Method_Code_idx`
(`Renter_Payment_Method_Code` ASC),
  INDEX `Visitor_Payment_Method_ID_idx`
(`Visitor_Payment_Method_ID` ASC),
  INDEX `Renter_IDss_idx`
(`Renter_ID` ASC),
  CONSTRAINT `Renter_IDss`
    FOREIGN KEY
(`Renter_ID`)
    REFERENCES `bicycles`.`Renters`
(`Renter_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Renter_Payment_Method_Code`
    FOREIGN KEY
(`Renter_Payment_Method_Code`)
    REFERENCES `bicycles`.`Rentals`
(`Renter Payment_Method_Code`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Member_Payment_Method_ID`
    FOREIGN KEY
(`Member_Payment_Method_ID`)
    REFERENCES `bicycles`.`Member_Payments`
(`Member_Payment_Method_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Visitor_Payment_Method_ID`
    FOREIGN KEY
(`Visitor_Payment_Method_ID`)
    REFERENCES `bicycles`.`Visitor_Payments`
(`Visitor_Payment_Method_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Visitor_Payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Visitor_Payments` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Visitor_Payments`
(
  `Visitor_Payment_Method_ID` VARCHAR
(50) NOT NULL,
  `Visitor_ID` INT NOT NULL,
  `Purchase_Date` DATE NOT NULL,
  `Payment_Method_Code` VARCHAR
(50) NOT NULL,
  `Card_Number` INT NULL DEFAULT NULL,
  `Purchase_Rate` INT NOT NULL,
  PRIMARY KEY
(`Visitor_Payment_Method_ID`),
  UNIQUE INDEX `Visitor_Payment_Method_ID_UNIQUE`
(`Visitor_Payment_Method_ID` ASC),
  INDEX `Payment_Method_Code_idx`
(`Payment_Method_Code` ASC),
  INDEX `Visitor_ID_idx`
(`Visitor_ID` ASC),
  CONSTRAINT `Payment_Method_Code2`
    FOREIGN KEY
(`Payment_Method_Code`)
    REFERENCES `bicycles`.`Payments`
(`Renter_Payment_Method_Code`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Visitor_ID1`
    FOREIGN KEY
(`Visitor_ID`)
    REFERENCES `bicycles`.`Visitors`
(`Visitor_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Bills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Bills` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Bills`
(
  `Bill_ID` VARCHAR
(50) NOT NULL,
  `Renter_Payment_ID` VARCHAR
(50) NOT NULL,
  `Renter_Payment_Method_Code` VARCHAR
(50) NOT NULL,
  `Purchase_Date` DATE NOT NULL,
  `Purchase_City` CHAR
(50) NOT NULL,
  `Purchase_Amount` DECIMAL NOT NULL,
  PRIMARY KEY
(`Bill_ID`),
  UNIQUE INDEX `Renter_Payment_ID_UNIQUE`
(`Renter_Payment_ID` ASC),
  INDEX `Renter Payment_Method_Code_idx`
(`Renter_Payment_Method_Code` ASC),
  INDEX `Purchase_City_idx`
(`Purchase_City` ASC),
  UNIQUE INDEX `Bill_ID_UNIQUE`
(`Bill_ID` ASC),
  CONSTRAINT `Renter_Payments`
    FOREIGN KEY
(`Renter_Payment_ID`)
    REFERENCES `bicycles`.`Payments`
(`Renter_Payment_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Renter_Payment_Method_Code2`
    FOREIGN KEY
(`Renter_Payment_Method_Code`)
    REFERENCES `bicycles`.`Rentals`
(`Renter Payment_Method_Code`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Purchase_City1`
    FOREIGN KEY
(`Purchase_City`)
    REFERENCES `bicycles`.`Cities`
(`City`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `bicycles`.`Services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Services` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Services`
(
  `Service_Company_ID` INT NOT NULL AUTO_INCREMENT,
  `Service_Address` VARCHAR
(150) NOT NULL,
  `Service_Contact` VARCHAR
(50) NOT NULL,
  `Service_Email` VARCHAR
(50) NOT NULL,
  `Service_Telephone` VARCHAR
(15) NOT NULL,
  `Service_Fees` INT NOT NULL,
  PRIMARY KEY
(`Service_Company_ID`),
  UNIQUE INDEX `Service_Company_ID_UNIQUE`
(`Service_Company_ID` ASC));


-- -----------------------------------------------------
-- Table `bicycles`.`Rental_History`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bicycles`.`Rental_History` ;

CREATE TABLE
IF NOT EXISTS `bicycles`.`Rental_History`
(
  `Rental_History_ID` VARCHAR
(50) NOT NULL,
  `Bicycle_ID` INT NOT NULL,
  `Renter_ID` INT NOT NULL,
  `Renter_Payment_ID` VARCHAR
(50) NOT NULL,
  `Payment_Method_Code` VARCHAR
(50) NOT NULL,
  `Rental_Rates` INT NOT NULL,
  `Booked_Start` DATE NOT NULL,
  `Booked_End` DATE NULL DEFAULT NULL,
  `Actual_Start` DATE NULL DEFAULT NULL,
  `Actual_End` DATE NULL DEFAULT NULL,
  `Rack_City` CHAR
(50) NOT NULL,
  `Terminal_City` CHAR
(50) NOT NULL,
  UNIQUE INDEX `Rental_History_ID_UNIQUE`
(`Rental_History_ID` ASC),
  UNIQUE INDEX `Bicycle_ID_UNIQUE`
(`Bicycle_ID` ASC),
  UNIQUE INDEX `Renter_ID_UNIQUE`
(`Renter_ID` ASC),
  UNIQUE INDEX `Renter_Payment_ID_UNIQUE`
(`Renter_Payment_ID` ASC),
  INDEX `Payment_Method_Code_idx`
(`Payment_Method_Code` ASC),
  INDEX `Rental_Rates_idx`
(`Rental_Rates` ASC),
  INDEX `Rack_City_idx`
(`Rack_City` ASC),
  INDEX `Terminal_City_idx`
(`Terminal_City` ASC),
  PRIMARY KEY
(`Rental_History_ID`),
  CONSTRAINT `Bicycle_ID2`
    FOREIGN KEY
(`Bicycle_ID`)
    REFERENCES `bicycles`.`Bicycles`
(`Bicycle_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Renter_ID2`
    FOREIGN KEY
(`Renter_ID`)
    REFERENCES `bicycles`.`Renters`
(`Renter_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Renter_Payment_ID`
    FOREIGN KEY
(`Renter_Payment_ID`)
    REFERENCES `bicycles`.`Rentals`
(`Renter_Payment_ID`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Payment_Method_Code`
    FOREIGN KEY
(`Payment_Method_Code`)
    REFERENCES `bicycles`.`Payment_Methods`
(`Payment_Method_Code`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Rental_Rates`
    FOREIGN KEY
(`Rental_Rates`)
    REFERENCES `bicycles`.`Rates`
(`Rental_Rates`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Rack_City2`
    FOREIGN KEY
(`Rack_City`)
    REFERENCES `bicycles`.`Rentals`
(`Terminal_City`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION,
  CONSTRAINT `Terminal_City2`
    FOREIGN KEY
(`Terminal_City`)
    REFERENCES `bicycles`.`Rentals`
(`Terminal_City`)
    ON
DELETE NO ACTION
    ON
UPDATE NO ACTION);


SET SQL_MODE
=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS
=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS
=@OLD_UNIQUE_CHECKS;
