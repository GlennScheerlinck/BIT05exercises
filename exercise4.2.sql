-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema exercise4
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `exercise4` ;
USE `exercise4` ;

-- -----------------------------------------------------
-- Table `exercise4`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Doctor` (
  `doctorID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(45) NULL,
  `Phone nr` INT NULL,
  `salary` INT NULL,
  PRIMARY KEY (`doctorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Medical` (
  `idmedical` INT NOT NULL,
  `doctorID` INT NOT NULL,
  `Overtime_rate` INT NULL,
  PRIMARY KEY (`idmedical`),
  INDEX `doctorID_idx` (`doctorID` ASC) VISIBLE,
  CONSTRAINT `doctorID`
    FOREIGN KEY (`doctorID`)
    REFERENCES `exercise4`.`Doctor` (`doctorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Specialist` (
  `idspecialist` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`idspecialist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone nr` INT NULL,
  `Date_of_birth` VARCHAR(45) NULL,
  PRIMARY KEY (`idPatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Date` DATE NULL,
  `Time` TIME NULL,
  `doctorID` INT NOT NULL,
  `idPatient` INT NOT NULL,
  PRIMARY KEY (`idAppointment`),
  INDEX `doctorID_idx` (`doctorID` ASC) VISIBLE,
  INDEX `patientID_idx` (`idPatient` ASC) VISIBLE,
  CONSTRAINT `doctorID`
    FOREIGN KEY (`doctorID`)
    REFERENCES `exercise4`.`Doctor` (`doctorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `patientID`
    FOREIGN KEY (`idPatient`)
    REFERENCES `exercise4`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Payment` (
  `idPayment` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `Method` VARCHAR(45) NULL,
  `idPatient` INT NOT NULL,
  PRIMARY KEY (`idPayment`),
  INDEX `fk_Payment_1_idx` (`idPatient` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_1`
    FOREIGN KEY (`idPatient`)
    REFERENCES `exercise4`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Bill` (
  `idBill` INT NOT NULL,
  `Total` INT NULL,
  `doctorID` INT NOT NULL,
  PRIMARY KEY (`idBill`),
  INDEX `doctorID_idx` (`doctorID` ASC) VISIBLE,
  CONSTRAINT `doctorID`
    FOREIGN KEY (`doctorID`)
    REFERENCES `exercise4`.`Doctor` (`doctorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Payment_to_bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Payment_to_bill` (
  `idPayment_to_bill` INT NOT NULL,
  `idBill` INT NOT NULL,
  `idPayment` INT NOT NULL,
  PRIMARY KEY (`idPayment_to_bill`),
  INDEX `fk_Payment_to_bill_1_idx` (`idBill` ASC) VISIBLE,
  INDEX `fk_Payment_to_bill_2_idx` (`idPayment` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_to_bill_1`
    FOREIGN KEY (`idBill`)
    REFERENCES `exercise4`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_to_bill_2`
    FOREIGN KEY (`idPayment`)
    REFERENCES `exercise4`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `exercise4`.`Doctor_has_Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exercise4`.`Doctor_has_Specialist` (
  `dummy` INT NOT NULL,
  `Doctor_doctorID` INT NOT NULL,
  `Specialist_idspecialist` INT NOT NULL,
  PRIMARY KEY (`dummy`),
  INDEX `fk_Doctor_has_Specialist_Specialist1_idx` (`Specialist_idspecialist` ASC) VISIBLE,
  INDEX `fk_Doctor_has_Specialist_Doctor1_idx` (`Doctor_doctorID` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_has_Specialist_Doctor1`
    FOREIGN KEY (`Doctor_doctorID`)
    REFERENCES `exercise4`.`Doctor` (`doctorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_has_Specialist_Specialist1`
    FOREIGN KEY (`Specialist_idspecialist`)
    REFERENCES `exercise4`.`Specialist` (`idspecialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
