USE whr_huy ;
ALTER TABLE whr
MODIFY Years YEAR, -- pk clé composite 
MODIFY Country VARCHAR(40) NOT NULL, 
MODIFY HappinessRank TINYINT UNSIGNED NOT NULL,
MODIFY HappinessScore DECIMAL(18,2) NOT NULL, 
MODIFY Economy DECIMAL(20,2), 
MODIFY Family DECIMAL(20,2), 
MODIFY Health DECIMAL(20,2), 
MODIFY Freedom DECIMAL(20,2), 
MODIFY Generosity DECIMAL(20,2), 
MODIFY Trust DECIMAL(21,2), 
MODIFY DystopiaResidual DECIMAL(20,2), 
-- pk clé composite fk countries
MODIFY CountryCode CHAR(3), 
ADD PRIMARY KEY (Years, CountryCode)
;

ALTER TABLE countries
MODIFY CountryCode CHAR(3), -- pk 
MODIFY Country VARCHAR(40) UNIQUE, 
MODIFY Region 
ENUM ('Europe & Central Asia'
,'Sub-Saharan Africa'
,'Latin America & Caribbean'
,'East Asia & Pacific'
,'Middle East & North Africa'
,'South Asia'
,'North America'), 
MODIFY IncomeGroup 
ENUM ('High income', 'Upper middle income',
'Lower middle income', 'Low income'),
ADD PRIMARY KEY (CountryCode),
ADD INDEX IX_cRegion (Region),
ADD INDEX IX_cOECD (OECD),
ADD INDEX IX_cCountry (Country)
;

ALTER TABLE indicators
MODIFY CountryName VARCHAR(30), -- pk clé composite 
MODIFY CountryCode CHAR(3), -- fk pour countries
MODIFY IndicatorName VARCHAR(100),
MODIFY IndicatorCode VARCHAR(20), -- pk clé composite
MODIFY Years YEAR(4), -- pk clé composite 
MODIFY Val DECIMAL(21,2), 
ADD PRIMARY KEY (CountryCode, IndicatorCode, Years)
;