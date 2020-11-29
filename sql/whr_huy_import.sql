CREATE TABLE `whr` 
  `Years` bigint(20) DEFAULT NULL,
  `Country` text,
  `HappinessRank` bigint(20) DEFAULT NULL,
  `HappinessScore` double DEFAULT NULL,
  `Economy` double DEFAULT NULL,
  `Family` double DEFAULT NULL,
  `Health` double DEFAULT NULL,
  `Freedom` double DEFAULT NULL,
  `Generosity` double DEFAULT NULL,
  `Trust` double DEFAULT NULL,
  `DystopiaResidual` double DEFAULT NULL,
  `CountryCode` text
  ;

CREATE TABLE `countries` 
  `CountryCode` text,
  `Country` text,
  `Region` text,
  `IncomeGroup` text,
  `OECD` tinyint(1) DEFAULT NULL,
  CONSTRAINT `countries_chk_1` CHECK ((`OECD` in (0,1)))
  ;

  CREATE TABLE `indicators` 
  `CountryName` text,
  `CountryCode` text,
  `IndicatorName` text,
  `IndicatorCode` text,
  `Years` text,
  `Val` double DEFAULT NULL
  ;

  