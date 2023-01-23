-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema etl-1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema etl-1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `etl-1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `etl-1` ;

-- -----------------------------------------------------
-- Table `etl-1`.`voluntarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `etl-1`.`voluntarios` (
  `idVoluntarios` INT NOT NULL AUTO_INCREMENT,
  `Age` INT NOT NULL,
  `Veteran` VARCHAR(45) NULL DEFAULT NULL,
  `Gender` VARCHAR(45) NULL DEFAULT NULL,
  `Nationality` VARCHAR(45) NULL DEFAULT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Year` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idVoluntarios`))
ENGINE = InnoDB
AUTO_INCREMENT = 26801
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl-1`.`aplicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `etl-1`.`aplicaciones` (
  `idaplicaciones` INT NOT NULL AUTO_INCREMENT,
  `Anglo_Status` VARCHAR(45) NOT NULL,
  `Date_Modified` VARCHAR(45) NULL DEFAULT NULL,
  `Age` INT NOT NULL,
  `Veteran` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `Nationality` VARCHAR(45) NOT NULL,
  `Request_Status` VARCHAR(45) NOT NULL,
  `Date_Modified1` VARCHAR(45) NULL DEFAULT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Year` INT NOT NULL,
  `voluntarios_idVoluntarios` INT NOT NULL,
  PRIMARY KEY (`idaplicaciones`),
  INDEX `fk_aplicaciones_voluntarios_idx` (`voluntarios_idVoluntarios` ASC) VISIBLE,
  CONSTRAINT `fk_aplicaciones_voluntarios`
    FOREIGN KEY (`voluntarios_idVoluntarios`)
    REFERENCES `etl-1`.`voluntarios` (`idVoluntarios`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl-1`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `etl-1`.`cursos` (
  `idcursos` INT NOT NULL AUTO_INCREMENT,
  `Destino` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Duración` VARCHAR(45) NOT NULL,
  `Comienzo` DATETIME NOT NULL,
  `Final` DATETIME NOT NULL,
  `Nombre_completo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idcursos`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl-1`.`arrivals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `etl-1`.`arrivals` (
  `idarrivals` INT NOT NULL AUTO_INCREMENT,
  `Course` VARCHAR(45) NOT NULL,
  `Birth_Date` DATETIME NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `Nationality` VARCHAR(45) NOT NULL,
  `Arrival_Medium` VARCHAR(45) NOT NULL,
  `Ariival_Company` VARCHAR(45) NOT NULL,
  `Arrival_Number` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `voluntarios_idVoluntarios` INT NOT NULL,
  `cursos_idcursos` INT NOT NULL,
  PRIMARY KEY (`idarrivals`),
  INDEX `fk_arrivals_voluntarios1_idx` (`voluntarios_idVoluntarios` ASC) VISIBLE,
  INDEX `fk_arrivals_cursos1_idx` (`cursos_idcursos` ASC) VISIBLE,
  CONSTRAINT `fk_arrivals_cursos1`
    FOREIGN KEY (`cursos_idcursos`)
    REFERENCES `etl-1`.`cursos` (`idcursos`),
  CONSTRAINT `fk_arrivals_voluntarios1`
    FOREIGN KEY (`voluntarios_idVoluntarios`)
    REFERENCES `etl-1`.`voluntarios` (`idVoluntarios`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl-1`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `etl-1`.`paises` (
  `idpaises` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(150) NULL DEFAULT NULL,
  `ISO_Code` VARCHAR(45) NOT NULL,
  `M49_Code` INT NOT NULL,
  `Region1` VARCHAR(45) NULL DEFAULT NULL,
  `Region2` VARCHAR(45) NULL DEFAULT NULL,
  `Continent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpaises`))
ENGINE = InnoDB
AUTO_INCREMENT = 48
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `etl-1`.`continentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `etl-1`.`continentes` (
  `idcontinentes` INT NOT NULL AUTO_INCREMENT,
  `Nationality` VARCHAR(45) NOT NULL,
  `Total` INT NOT NULL,
  `Porcentaje` INT NOT NULL,
  `ISO_Code` VARCHAR(45) NOT NULL,
  `Continent` VARCHAR(45) NOT NULL,
  `capital_coordinates` VARCHAR(60) NOT NULL,
  `paises_idpaises` INT NOT NULL,
  `voluntarios_idVoluntarios` INT NOT NULL,
  PRIMARY KEY (`idcontinentes`),
  INDEX `fk_continentes_paises1_idx` (`paises_idpaises` ASC) VISIBLE,
  INDEX `fk_continentes_voluntarios1_idx` (`voluntarios_idVoluntarios` ASC) VISIBLE,
  CONSTRAINT `fk_continentes_paises1`
    FOREIGN KEY (`paises_idpaises`)
    REFERENCES `etl-1`.`paises` (`idpaises`),
  CONSTRAINT `fk_continentes_voluntarios1`
    FOREIGN KEY (`voluntarios_idVoluntarios`)
    REFERENCES `etl-1`.`voluntarios` (`idVoluntarios`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
