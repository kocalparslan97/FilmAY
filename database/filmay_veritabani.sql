-- MySQL Script generated by MySQL Workbench
-- Cum 27 Eki 2017 12:38:38 +03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema FilmAY
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FilmAY
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FilmAY` DEFAULT CHARACTER SET utf8 ;
USE `FilmAY` ;

-- -----------------------------------------------------
-- Table `FilmAY`.`Yonetmenler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FilmAY`.`Yonetmenler` (
  `idYonetmenler` INT NOT NULL,
  `dogum_tarihi` VARCHAR(45) NULL,
  `aciklama` VARCHAR(45) NULL,
  `olum_tarihi` VARCHAR(45) NULL,
  PRIMARY KEY (`idYonetmenler`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FilmAY`.`Filmler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FilmAY`.`Filmler` (
  `idFilmler` INT NOT NULL AUTO_INCREMENT,
  `filmAdi` VARCHAR(45) NULL,
  `aciklama` VARCHAR(250) NULL,
  `imdb_puani` VARCHAR(45) NULL,
  `poster_url` VARCHAR(45) NULL,
  `video_url` VARCHAR(45) NULL,
  `yapim_tarihi` DATETIME NULL,
  `oyuncu_ids` INT NULL,
  `kategori_ids` VARCHAR(45) NULL,
  `Yonetmen_id` INT NOT NULL,
  PRIMARY KEY (`idFilmler`),
  INDEX `fk_Filmler_Yonetmenler1_idx` (`Yonetmen_id` ASC),
  CONSTRAINT `fk_Filmler_Yonetmenler1`
    FOREIGN KEY (`Yonetmen_id`)
    REFERENCES `FilmAY`.`Yonetmenler` (`idYonetmenler`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FilmAY`.`Kullanicilar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FilmAY`.`Kullanicilar` (
  `idKullanicilar` INT NOT NULL AUTO_INCREMENT,
  `kullanici_adi` VARCHAR(45) NULL,
  `adi` VARCHAR(45) NULL,
  `soyadi` VARCHAR(45) NULL,
  `parola` VARCHAR(45) NULL,
  `resim_url` VARCHAR(45) NULL,
  `admin_mi` INT NULL,
  PRIMARY KEY (`idKullanicilar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FilmAY`.`Satin_almalar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FilmAY`.`Satin_almalar` (
  `idSatinAlmalar` INT NOT NULL,
  `Kullanicilar_id` INT NOT NULL,
  `Filmler_id` INT NOT NULL,
  `satin_alma_tarihi` DATETIME NULL,
  `odenen_tutar` FLOAT NULL,
  PRIMARY KEY (`idSatinAlmalar`),
  INDEX `fk_SatinAlmalar_Kullanicilar_idx` (`Kullanicilar_id` ASC),
  INDEX `fk_SatinAlmalar_Filmler1_idx` (`Filmler_id` ASC),
  CONSTRAINT `fk_SatinAlmalar_Kullanicilar`
    FOREIGN KEY (`Kullanicilar_id`)
    REFERENCES `FilmAY`.`Kullanicilar` (`idKullanicilar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SatinAlmalar_Filmler1`
    FOREIGN KEY (`Filmler_id`)
    REFERENCES `FilmAY`.`Filmler` (`idFilmler`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FilmAY`.`Oyuncular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FilmAY`.`Oyuncular` (
  `idOyuncular` INT NOT NULL,
  `Adi` VARCHAR(45) NULL,
  `Soyadi` VARCHAR(45) NULL,
  `dogum_tarihi` VARCHAR(45) NULL,
  `Aciklama` VARCHAR(45) NULL,
  `resim_url` VARCHAR(45) NULL,
  PRIMARY KEY (`idOyuncular`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FilmAY`.`Oyuncular_has_Filmler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FilmAY`.`Oyuncular_has_Filmler` (
  `Oyuncular_idOyuncular` INT NOT NULL,
  `Filmler_idFilmler` INT NOT NULL,
  PRIMARY KEY (`Oyuncular_idOyuncular`, `Filmler_idFilmler`),
  INDEX `fk_Oyuncular_has_Filmler_Filmler1_idx` (`Filmler_idFilmler` ASC),
  INDEX `fk_Oyuncular_has_Filmler_Oyuncular1_idx` (`Oyuncular_idOyuncular` ASC),
  CONSTRAINT `fk_Oyuncular_has_Filmler_Oyuncular1`
    FOREIGN KEY (`Oyuncular_idOyuncular`)
    REFERENCES `FilmAY`.`Oyuncular` (`idOyuncular`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Oyuncular_has_Filmler_Filmler1`
    FOREIGN KEY (`Filmler_idFilmler`)
    REFERENCES `FilmAY`.`Filmler` (`idFilmler`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
