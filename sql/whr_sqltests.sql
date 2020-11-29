-- tests sur l'intégrité des tables en ajoutant une FK qui n'a pas de PK correspondante

-- whr
-- tests qui fonctionnent
INSERT  INTO `whr`(`Years`,`Country`,`HappinessRank`,`HappinessScore`,`Economy`,`Family`,`Health`,`Freedom`,`Generosity`,`Trust`,`DystopiaResidual`,`CountryCode`) VALUES
(2018,'norway',1,8,1.61646318435669,1.1269,0.88521,0.635422587394714,0.37895,0.36503,2.99202423,'NOR')
;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM whr 
WHERE Years = 2018 AND Country = 'norway'
;

-- test qui viole la contrainte
INSERT  INTO `whr`(`Years`,`Country`,`HappinessRank`,`HappinessScore`,`Economy`,`Family`,`Health`,`Freedom`,`Generosity`,`Trust`,`DystopiaResidual`,`CountryCode`) VALUES
(2018,'norway',1,8,1.61646318435669,1.1269,0.88521,0.635422587394714,0.37895,0.36503,2.99202423,'AAA')
;

-- indicators
-- test qui fonctionne
INSERT  INTO `indicators`(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`Years`,`Value`) VALUES
('Norway','NOR','Fixed broadband subscriptions (per 100 people)','IT.NET.BBND.P2',2018,40.01)
;

-- test qui viole la contrainte
INSERT  INTO `indicators`(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`Years`,`Value`) VALUES
('Norway','AAA','Fixed broadband subscriptions (per 100 people)','IT.NET.BBND.P2',2018,40.01)
;

-- countries
-- test qui fonctionne
INSERT  INTO `countries`(`CountryCode`,`Country`,`Region`,`IncomeGroup`,`OECD`) VALUES
('AAA','Alpha','Latin America & Caribbean','Upper middle income',False)
;

-- test sur l'intégrité des tables avec l'ajout d'une FK qui n'a pas de PK dans la table mère (countries)
INSERT  INTO `indicators`(`CountryName`,`CountryCode`,`IndicatorName`,`IndicatorCode`,`Years`,`Value`) VALUES
('Barbades','BBB','Latin America & Caribbean','High low income',False)
;

-- Quelques requêtes pour vérifier le bon fonctionnement des contraintes

-- Qry 1 : vérifier qu'on peut bien insérer une nouvelle entrée dans la table staffs
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, actif, store_id, manager_id) VALUES(11,'Michael','Jackson','michael.jackson@bikes.shop','(831) 555-5554',1,1,NULL);

-- Qry 2 : vérifier que si une nouvelle entrée indique un manager_id (FK) qui n'a pas d'équivalent staff_id (PK), l'entrée est rejetée ==> respecter l'intégrité des tables
INSERT INTO staffs(staff_id, first_name, last_name, email, phone, actif, store_id, manager_id) VALUES(13,'Tito','Jackson','tito.jackson@bikes.shop','(831) 555-5554',1,1,15);

-- Qry 3 : supprimer le brand_id = 5 dans la table brands
DELETE FROM brands WHERE brand_id = 5;

-- Qry 4 : vérifier dans la table products que les entrées qui ont brand_id = 5 comme foreign key n'y sont plus ==> vérifier le bon fonctionnement de "on delete cascade" 
 SELECT * FROM products WHERE brand_id = 5;

-- Qry 5 : modifier la table brands 
UPDATE brands SET brand_id = 5 WHERE brand_id = 4;

-- Qry 6 : s'assurer que les entrées qui ont eu le nrand_id = 4 ont bien eu le brand_id modifié à 5 ==> vérifier le bon fonctionnement de "on update cascade" 
 SELECT * FROM products WHERE brand_id = 5;