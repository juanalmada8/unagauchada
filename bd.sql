-- MySQL Script generated by MySQL Workbench
-- Fri 19 May 2017 12:59:19 ART
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- ---------------------calificacioncategoria--------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idUsuario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido'` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `foto` BLOB NULL,
  `contraseña` VARCHAR(64) NULL,
  `telefono` VARCHAR(45) NULL,
  `nacimiento` VARCHAR(45) NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `nivelUsuario` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`zona` (
  `idZona` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Zona` VARCHAR(45) NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idZona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `idCategoria` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`calificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`calificacion` (
  `idcalificacion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `calificacion` VARCHAR(45) NULL,
  `gauchadaid` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idcalificacion`),
  INDEX `fk_Ca_G_idx` (`gauchadaid` ASC),
  CONSTRAINT `fk_Ca_G`
    FOREIGN KEY (`gauchadaid`)
    REFERENCES `mydb`.`gauchada` (`idGauchada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gauchada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gauchada` (
  `idGauchada` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `autor_usuarioid` INT UNSIGNED NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `titulo` VARCHAR(45) NULL,
  `foto` BLOB NULL,
  `fecha` VARCHAR(45) NULL,
  `zonaid` INT UNSIGNED NOT NULL,
  `categoriaid` INT UNSIGNED NOT NULL,
  `calificacionid` INT UNSIGNED NOT NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idGauchada`),
  INDEX `fk_G_U_idx` (`autor_usuarioid` ASC),
  INDEX `fk_G_C_idx` (`categoriaid` ASC),
  INDEX `fk_G_Z_idx` (`zonaid` ASC),
  INDEX `fk_G_Cf_idx` (`calificacionid` ASC),
  CONSTRAINT `fk_G_U`
    FOREIGN KEY (`autor_usuarioid`)
    REFERENCES `mydb`.`usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_G_Z`
    FOREIGN KEY (`zonaid`)
    REFERENCES `mydb`.`zona` (`idZona`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_G_C`
    FOREIGN KEY (`categoriaid`)
    REFERENCES `mydb`.`categoria` (`idCategoria`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_G_Cf`
    FOREIGN KEY (`calificacionid`)
    REFERENCES `mydb`.`calificacion` (`idcalificacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comentario` (
  `idComentario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuarioid` INT UNSIGNED NOT NULL,
  `comentario` VARCHAR(45) NULL,
  `gauchadaid` INT UNSIGNED NOT NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComentario`),
  INDEX `fk_C_U_idx` (`usuarioid` ASC),
  INDEX `fk_C_G_idx` (`gauchadaid` ASC),
  CONSTRAINT `fk_C_U`
    FOREIGN KEY (`usuarioid`)
    REFERENCES `mydb`.`usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_C_G`
    FOREIGN KEY (`gauchadaid`)
    REFERENCES `mydb`.`gauchada` (`idGauchada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`postulante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`postulante` (
  `idPostulante` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuarioid` INT UNSIGNED NOT NULL,
  `gauchadaid` INT UNSIGNED NOT NULL,
  `estado` TINYINT(1) NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPostulante`),
  INDEX `fk_P_U_idx` (`usuarioid` ASC),
  INDEX `fk_P_G_idx` (`gauchadaid` ASC),
  CONSTRAINT `fk_P_U`
    FOREIGN KEY (`usuarioid`)
    REFERENCES `mydb`.`usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_P_G`
    FOREIGN KEY (`gauchadaid`)
    REFERENCES `mydb`.`gauchada` (`idGauchada`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`precioCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`precioCredito` (
  `idPrecioCredito` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `creditos` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `habilitado` TINYINT(1) NULL,
  PRIMARY KEY (`idPrecioCredito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reputacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reputacion` (
  `idReputacion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `reputacion` VARCHAR(45) NULL,
  `hasta` VARCHAR(45) NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idReputacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compraCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compraCredito` (
  `idCompraCredito` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuarioid` INT UNSIGNED NOT NULL,
  `preciocreditoid` INT UNSIGNED NOT NULL,
  `editado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCompraCredito`),
  INDEX `fk_CC_U_idx` (`usuarioid` ASC),
  INDEX `fk_CC_PC_idx` (`preciocreditoid` ASC),
  CONSTRAINT `fk_CC_U`
    FOREIGN KEY (`usuarioid`)
    REFERENCES `mydb`.`usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CC_PC`
    FOREIGN KEY (`preciocreditoid`)
    REFERENCES `mydb`.`precioCredito` (`idPrecioCredito`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`respuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`respuesta` (
  `idrespuesta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuarioId` INT UNSIGNED NOT NULL,
  `comentarioid` INT UNSIGNED NOT NULL,
  `respuesta` VARCHAR(45) NULL,
  `creado` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idrespuesta`),
  INDEX `fk_R_U_idx` (`usuarioId` ASC),
  INDEX `fk_R_C_idx` (`comentarioid` ASC),
  CONSTRAINT `fk_R_U`
    FOREIGN KEY (`usuarioId`)
    REFERENCES `mydb`.`usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_R_C`
    FOREIGN KEY (`comentarioid`)
    REFERENCES `mydb`.`comentario` (`idComentario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;