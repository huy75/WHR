USE whr_huy ;

ALTER TABLE whr
ADD CONSTRAINT fk_whr_countries
  FOREIGN KEY (CountryCode)
  REFERENCES countries (CountryCode)
  ON UPDATE CASCADE 
  ;

ALTER TABLE indicators
ADD CONSTRAINT fk_indicators_countries
  FOREIGN KEY (CountryCode)
  REFERENCES countries (CountryCode)
  ON UPDATE CASCADE 
  ;

  