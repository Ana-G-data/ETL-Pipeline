-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paises` (
  `idPaises` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(45) NOT NULL,
  `ISO_Code` VARCHAR(45) NOT NULL,
  `M49_Code` INT NOT NULL,
  `Region1` VARCHAR(45) NULL,
  `Region2` VARCHAR(45) NULL,
  `Continent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPaises`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Voluntarios_únicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Voluntarios_únicos` (
  `idVoluntarios` INT NOT NULL AUTO_INCREMENT,
  `Identificador_numérico` INT NOT NULL,
  `Age` INT NOT NULL,
  `Birth_Date` DATE NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `Paises_idPaises` INT NOT NULL,
  PRIMARY KEY (`idVoluntarios`),
  INDEX `fk_Voluntarios_únicos_Paises1_idx` (`Paises_idPaises` ASC) VISIBLE,
  CONSTRAINT `fk_Voluntarios_únicos_Paises1`
    FOREIGN KEY (`Paises_idPaises`)
    REFERENCES `mydb`.`Paises` (`idPaises`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cursos_Teens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cursos_Teens` (
  `idCursos_Teens` INT NOT NULL AUTO_INCREMENT,
  `Destino` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Duración` VARCHAR(45) NOT NULL,
  `Comienzo` DATE NOT NULL,
  `Final` VARCHAR(45) NOT NULL,
  `Nombre_completo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCursos_Teens`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Voluntarios_Total(df)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Voluntarios_Total(df)` (
  `idVoluntarios_Total` INT NOT NULL AUTO_INCREMENT,
  `Course` VARCHAR(45) NOT NULL,
  `Anglo_Status` VARCHAR(45) NOT NULL,
  `Date_Modified` VARCHAR(45) NULL,
  `Age` VARCHAR(45) NOT NULL,
  `Voluntarios_Totalcol` INT NOT NULL,
  `Birth_Date` INT NOT NULL,
  `Veteran` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `Nationality` VARCHAR(45) NOT NULL,
  `Request_Status` VARCHAR(45) NULL,
  `Date_Modified1` VARCHAR(45) NULL,
  `Arrival Medium` VARCHAR(45) NOT NULL,
  `Arrival_Company` VARCHAR(45) NOT NULL,
  `Arrival_number` VARCHAR(45) NOT NULL,
  `Identificador` VARCHAR(45) NOT NULL,
  `Travel_Alone` VARCHAR(45) NOT NULL,
  `Voluntarios_únicos_idVoluntarios` INT NOT NULL,
  `Cursos_Teens_idCursos_Teens` INT NOT NULL,
  `Paises_idPaises` INT NOT NULL,
  PRIMARY KEY (`idVoluntarios_Total`),
  INDEX `fk_Voluntarios_Total(df)_Voluntarios_únicos_idx` (`Voluntarios_únicos_idVoluntarios` ASC) VISIBLE,
  INDEX `fk_Voluntarios_Total(df)_Cursos_Teens1_idx` (`Cursos_Teens_idCursos_Teens` ASC) VISIBLE,
  INDEX `fk_Voluntarios_Total(df)_Paises1_idx` (`Paises_idPaises` ASC) VISIBLE,
  CONSTRAINT `fk_Voluntarios_Total(df)_Voluntarios_únicos`
    FOREIGN KEY (`Voluntarios_únicos_idVoluntarios`)
    REFERENCES `mydb`.`Voluntarios_únicos` (`idVoluntarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Voluntarios_Total(df)_Cursos_Teens1`
    FOREIGN KEY (`Cursos_Teens_idCursos_Teens`)
    REFERENCES `mydb`.`Cursos_Teens` (`idCursos_Teens`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Voluntarios_Total(df)_Paises1`
    FOREIGN KEY (`Paises_idPaises`)
    REFERENCES `mydb`.`Paises` (`idPaises`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
