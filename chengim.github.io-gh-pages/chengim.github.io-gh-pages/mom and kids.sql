-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`CreditCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CreditCard` (
  `cardNumber` INT NOT NULL,
  `cardHolderName` VARCHAR(45) NULL,
  `cvv` INT NULL,
  `expiryDate` VARCHAR(45) NULL,
  PRIMARY KEY (`cardNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `customerId` INT NOT NULL,
  `userName` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `CreditCard_cardNumber` INT NOT NULL,
  `cartId` INT NULL,
  PRIMARY KEY (`customerId`),
  INDEX `fk_Customer_CreditCard1_idx` (`CreditCard_cardNumber` ASC),
  CONSTRAINT `fk_Customer_CreditCard1`
    FOREIGN KEY (`CreditCard_cardNumber`)
    REFERENCES `mydb`.`CreditCard` (`cardNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `addressId` INT NOT NULL,
  `Customer_customerId` INT NOT NULL,
  PRIMARY KEY (`addressId`, `Customer_customerId`),
  INDEX `fk_Address_CustomerAccount_idx` (`Customer_customerId` ASC),
  CONSTRAINT `fk_Address_CustomerAccount`
    FOREIGN KEY (`Customer_customerId`)
    REFERENCES `mydb`.`Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `supplierId` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  `Suppliercategory` VARCHAR(45) NULL,
  PRIMARY KEY (`supplierId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `skuCode` INT NOT NULL,
  `brand` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  `description` INT NULL,
  `category` VARCHAR(45) NULL,
  `unitPrice` VARCHAR(45) NULL,
  `rating` VARCHAR(45) NULL,
  `stock` INT NULL,
  `Supplier_supplierId` INT NOT NULL,
  PRIMARY KEY (`skuCode`, `Supplier_supplierId`),
  INDEX `fk_Product_Supplier1_idx` (`Supplier_supplierId` ASC),
  CONSTRAINT `fk_Product_Supplier1`
    FOREIGN KEY (`Supplier_supplierId`)
    REFERENCES `mydb`.`Supplier` (`supplierId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Transaction` (
  `transactionId` INT NOT NULL,
  `product` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `quantity` VARCHAR(45) NULL,
  `totalPrice` VARCHAR(45) NULL,
  `Customer_customerId` INT NOT NULL,
  `orderTrackingId` INT NULL,
  `CreditCard_cardNumber` INT NOT NULL,
  `Address_addressId` INT NOT NULL,
  `Address_Customer_customerId` INT NOT NULL,
  `Address_addressId1` INT NOT NULL,
  `Address_Customer_customerId1` INT NOT NULL,
  PRIMARY KEY (`Customer_customerId`, `transactionId`, `CreditCard_cardNumber`, `Address_addressId`, `Address_Customer_customerId`, `Address_addressId1`, `Address_Customer_customerId1`),
  INDEX `fk_Transaction_CreditCard1_idx` (`CreditCard_cardNumber` ASC),
  INDEX `fk_Transaction_Address1_idx` (`Address_addressId` ASC, `Address_Customer_customerId` ASC),
  INDEX `fk_Transaction_Address2_idx` (`Address_addressId1` ASC, `Address_Customer_customerId1` ASC),
  CONSTRAINT `fk_Transaction_Customer1`
    FOREIGN KEY (`Customer_customerId`)
    REFERENCES `mydb`.`Customer` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_CreditCard1`
    FOREIGN KEY (`CreditCard_cardNumber`)
    REFERENCES `mydb`.`CreditCard` (`cardNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Address1`
    FOREIGN KEY (`Address_addressId` , `Address_Customer_customerId`)
    REFERENCES `mydb`.`Address` (`addressId` , `Customer_customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaction_Address2`
    FOREIGN KEY (`Address_addressId1` , `Address_Customer_customerId1`)
    REFERENCES `mydb`.`Address` (`addressId` , `Customer_customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProductLineItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductLineItem` (
  `serialNumber` INT NOT NULL,
  `Transaction_transactionId` INT NOT NULL,
  `Product_skuCode` INT NOT NULL,
  `Transaction_Customer_customerId` INT NOT NULL,
  `unitPrice` INT NULL,
  `subTotal` INT NULL,
  PRIMARY KEY (`serialNumber`, `Transaction_transactionId`, `Product_skuCode`),
  INDEX `fk_ProductLineItem_Transaction1_idx` (`Transaction_Customer_customerId` ASC, `Transaction_transactionId` ASC),
  INDEX `fk_ProductLineItem_Product1_idx` (`Product_skuCode` ASC),
  CONSTRAINT `fk_ProductLineItem_Transaction1`
    FOREIGN KEY (`Transaction_Customer_customerId` , `Transaction_transactionId`)
    REFERENCES `mydb`.`Transaction` (`Customer_customerId` , `transactionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductLineItem_Product1`
    FOREIGN KEY (`Product_skuCode`)
    REFERENCES `mydb`.`Product` (`skuCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
