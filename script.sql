/* Napraviti skriptove u kojima se nalaze upiti kojima se kreira baza, kreiraju tabele i
popunjavaju tabele podacima. */
 
DROP DATABASE IF EXISTS crossfit;

CREATE DATABASE crossfit;

USE `crossfit`;

-- -----------------------------------------------------
-- Table `crossfit`.`Klijent`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Klijent` (
  `id` INT NOT NULL,
  `Ime` VARCHAR(45) NOT NULL,
  `Prezime` VARCHAR(45) NOT NULL,
  `BrojOdradjenihTreninga` INT NULL DEFAULT 0,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `crossfit`.`Trener`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Trener` (
  `id` INT NOT NULL,
  `Ime` VARCHAR(45) NOT NULL,
  `Prezime` VARCHAR(45) NOT NULL,
  `Plata` INT NOT NULL,
  `DatumRodjenja` DATE NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `crossfit`.`Trening`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Trening` (
  `id` INT NOT NULL,
  `Datum` DATE NOT NULL,
  `Opis` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `crossfit`.`Oprema`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Oprema` (
  `sifra` INT NOT NULL,
  `Proizvodjac` VARCHAR(45) NOT NULL,
  `Naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sifra`));


-- -----------------------------------------------------
-- Table `crossfit`.`Medicinke`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Medicinke` (
  `Oprema_sifra` INT NOT NULL,
  `Tezina` INT NOT NULL,
  `Kolicina` INT NOT NULL,
  PRIMARY KEY (`Oprema_sifra`),
  CONSTRAINT `fk_Medicinke_Oprema1`
    FOREIGN KEY (`Oprema_sifra`)
    REFERENCES `crossfit`.`Oprema` (`sifra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `crossfit`.`Prijava`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Prijava` (
  `Trening_id` INT NOT NULL,
  `Klijent_id` INT NOT NULL,
  PRIMARY KEY (`Trening_id`, `Klijent_id`),
  CONSTRAINT `fk_Trening_has_Klijent_Trening1`
    FOREIGN KEY (`Trening_id`)
    REFERENCES `crossfit`.`Trening` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trening_has_Klijent_Klijent1`
    FOREIGN KEY (`Klijent_id`)
    REFERENCES `crossfit`.`Klijent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `crossfit`.`Strunjace`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Strunjace` (
  `Oprema_sifra` INT NOT NULL,
  `Kolicina` INT NOT NULL,
  PRIMARY KEY (`Oprema_sifra`),
  CONSTRAINT `fk_Strunjace_Oprema1`
    FOREIGN KEY (`Oprema_sifra`)
    REFERENCES `crossfit`.`Oprema` (`sifra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `crossfit`.`Tegovi`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Tegovi` (
  `Oprema_sifra` INT NOT NULL,
  `Tezina` INT NOT NULL,
  `Kolicina` INT NOT NULL,
  `Opis` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Oprema_sifra`),
  CONSTRAINT `fk_Tegovi_Oprema1`
    FOREIGN KEY (`Oprema_sifra`)
    REFERENCES `crossfit`.`Oprema` (`sifra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `crossfit`.`Obucavanje`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Obucavanje` (
  `Trener_id` INT NOT NULL,
  `Trener_id1` INT NOT NULL,
  PRIMARY KEY (`Trener_id`, `Trener_id1`),  
  CONSTRAINT `fk_Trener_has_Trener_Trener1`
    FOREIGN KEY (`Trener_id`)
    REFERENCES `crossfit`.`Trener` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trener_has_Trener_Trener2`
    FOREIGN KEY (`Trener_id1`)
    REFERENCES `crossfit`.`Trener` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
-- -----------------------------------------------------
-- Table `crossfit`.`Vodi`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Vodi` (
  `Trener_id` INT NOT NULL,
  `Trening_id` INT NOT NULL,
  PRIMARY KEY (`Trener_id`, `Trening_id`),
  CONSTRAINT `fk_Trener_has_Trening_Trener1`
    FOREIGN KEY (`Trener_id`)
    REFERENCES `crossfit`.`Trener` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trener_has_Trening_Trening1`
    FOREIGN KEY (`Trening_id`)
    REFERENCES `crossfit`.`Trening` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
-- -----------------------------------------------------
-- Table `crossfit`.`Upotreba`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `crossfit`.`Upotreba` (
  `Vodi_Trener_id` INT NOT NULL,
  `Vodi_Trening_id` INT NOT NULL,
  `Oprema_sifra` INT NOT NULL,
  PRIMARY KEY (`Vodi_Trener_id`, `Vodi_Trening_id`, `Oprema_sifra`),
  CONSTRAINT `fk_Vodi_has_Oprema_Vodi1`
    FOREIGN KEY (`Vodi_Trener_id` , `Vodi_Trening_id`)
    REFERENCES `crossfit`.`Vodi` (`Trener_id` , `Trening_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vodi_has_Oprema_Oprema1`
    FOREIGN KEY (`Oprema_sifra`)
    REFERENCES `crossfit`.`Oprema` (`sifra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
-- -----------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------   
    
DELIMITER $

CREATE TRIGGER `Prijava_AFTER_INSERT` AFTER INSERT ON `Prijava`
FOR EACH ROW
BEGIN
    UPDATE `Klijent` SET `BrojOdradjenihTreninga` = `BrojOdradjenihTreninga` + 1
    WHERE new.`Klijent_id`=`id`;
END;
$

DELIMITER ;


DELIMITER $

CREATE TRIGGER `Vodi_BEFORE_INSERT` BEFORE INSERT ON `Vodi`
FOR EACH ROW
BEGIN
    DECLARE brojPrijavljenih INTEGER;
    SET brojPrijavljenih = (select count(*) from `Prijava` where `Trening_id` = new.`Trening_id`);         
    UPDATE `Trener` SET `Plata` = `Plata` + 150 * brojPrijavljenih
    WHERE `id` = new.`Trener_id`;
END;
$

DELIMITER ;