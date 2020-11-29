-- CREATE SCHEMA
DROP DATABASE IF EXISTS whr_huy ;
CREATE DATABASE /*!32312 IF NOT EXISTS*/whr_huy /*!40100 DEFAULT CHARACTER SET latin1 */;

USE whr_huy;

/*Table structure for table customers */

DROP TABLE IF EXISTS whr;

CREATE TABLE whr
Years YEAR(4), -- pk clé composite 
Country VARCHAR(40) NOT NULL, 
HappinessRank TINYINT UNSIGNED NOT NULL,
HappinessScore DECIMAL(18,2) NOT NULL, 
Economy DECIMAL(20,2), 
Family DECIMAL(20,2), 
Health DECIMAL(20,2), 
Freedom DECIMAL(20,2), 
Generosity DECIMAL(20,2), 
Trust DECIMAL(21,2), 
DystopiaResidual DECIMAL(20,2), 
CountryCode CHAR(3), -- pk clé composite fk countries
ADD PRIMARY KEY (Years, CountryCode)
;

DROP TABLE IF EXISTS countries;
CREATE TABLE countries
CountryCode CHAR(3), -- pk 
Country VARCHAR(40) UNIQUE, 
Region ENUM('Europe & Central Asia','Sub-Saharan Africa','Latin America & Caribbean',
'East Asia & Pacific','Middle East & North Africa','South Asia','North America'),
IncomeGroup ENUM('High income', 'Upper middle income', 'Lower middle income', 'Low income'),
OECD TINYINT(1)
ADD PRIMARY KEY (CountryCode),
ADD INDEX IX_Region (Region),
ADD INDEX IX_OECD (OECD)
;

DROP TABLE IF EXISTS indicators;
CREATE TABLE indicators
CountryName VARCHAR(30),  
CountryCode CHAR(3), -- fk pour countries
IndicatorName VARCHAR(100),
IndicatorCode VARCHAR(20), -- pk clé composite
Years YEAR(4), -- pk clé composite 
Val DECIMAL(21,2), 
ADD PRIMARY KEY (CountryCode, IndicatorCode, Years)
;
