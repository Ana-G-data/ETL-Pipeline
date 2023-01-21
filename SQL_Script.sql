-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ETL-1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ETL-1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ETL-1` ;
-- -----------------------------------------------------
-- Schema etl-1
-- -----------------------------------------------------
USE `ETL-1` ;

-- -----------------------------------------------------
-- Table `ETL-1`.`voluntarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ETL-1`.`voluntarios` (
  `idVoluntarios` INT NOT NULL AUTO_INCREMENT,
  `Age` INT NOT NULL,
  `Veteran` VARCHAR(45) NULL,
  `Gender` VARCHAR(45) NULL,
  `Nationality` VARCHAR(45) NULL,
  `Name` VARCHAR(45) NULL,
  `Year` INT NULL,
  PRIMARY KEY (`idVoluntarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ETL-1`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ETL-1`.`paises` (
  `idpaises` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(45) NOT NULL,
  `ISO_Code` VARCHAR(45) NOT NULL,
  `M49_Code` INT NOT NULL,
  `Region1` VARCHAR(45) NULL,
  `Region2` VARCHAR(45) NULL,
  `Continent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpaises`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ETL-1`.`continentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ETL-1`.`continentes` (
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
    REFERENCES `ETL-1`.`paises` (`idpaises`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_continentes_voluntarios1`
    FOREIGN KEY (`voluntarios_idVoluntarios`)
    REFERENCES `ETL-1`.`voluntarios` (`idVoluntarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ETL-1`.`aplicaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ETL-1`.`aplicaciones` (
  `idaplicaciones` INT NOT NULL AUTO_INCREMENT,
  `Anglo_Status` VARCHAR(45) NOT NULL,
  `Date_Modified` DATETIME NOT NULL,
  `Age` INT NOT NULL,
  `Veteran` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `Nationality` VARCHAR(45) NOT NULL,
  `Request_Status` VARCHAR(45) NOT NULL,
  `Date_Modified1` DATETIME NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Year` INT NOT NULL,
  `voluntarios_idVoluntarios` INT NOT NULL,
  PRIMARY KEY (`idaplicaciones`),
  INDEX `fk_aplicaciones_voluntarios_idx` (`voluntarios_idVoluntarios` ASC) VISIBLE,
  CONSTRAINT `fk_aplicaciones_voluntarios`
    FOREIGN KEY (`voluntarios_idVoluntarios`)
    REFERENCES `ETL-1`.`voluntarios` (`idVoluntarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ETL-1`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ETL-1`.`cursos` (
  `idcursos` INT NOT NULL AUTO_INCREMENT,
  `Destino` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Duración` VARCHAR(45) NOT NULL,
  `Comienzo` DATETIME NOT NULL,
  `Final` DATETIME NOT NULL,
  `Nombre_completo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcursos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ETL-1`.`arrivals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ETL-1`.`arrivals` (
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
  CONSTRAINT `fk_arrivals_voluntarios1`
    FOREIGN KEY (`voluntarios_idVoluntarios`)
    REFERENCES `ETL-1`.`voluntarios` (`idVoluntarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_arrivals_cursos1`
    FOREIGN KEY (`cursos_idcursos`)
    REFERENCES `ETL-1`.`cursos` (`idcursos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
