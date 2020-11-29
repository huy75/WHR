-- Interrogation de la base de données 2016
SELECT * FROM whr
WHERE Years = 2016
ORDER BY HappinessRank
;

-- Nombre de pays dans le classement pour chaque année
SELECT Years, MAX(HappinessRank) 
FROM whr w
GROUP BY 1
ORDER BY 1
;
-- Résultats 2015 : 158, 2016 157: , 2017 : 155

-- Classement 2016 avec jointure
SELECT w.Years, w.Country, w.HappinessRank, w.HappinessScore, c.Region, c.IncomeGroup, c.OECD FROM whr w
INNER JOIN countries c ON w.CountryCode = c.CountryCode
WHERE Years = 2016
ORDER BY HappinessRank
;

-- Moyenne de tous les pays par année 
CREATE VIEW whr_huy.Tous_pays AS
	SELECT Years, AVG(HappinessScore) Moyenne
	FROM whr 
	GROUP BY 1
	ORDER BY 1 
;

-- Moyenne de tous les pays OCDE par année 
CREATE VIEW whr_huy.OCDE AS
    SELECT Years, AVG(HappinessScore) Moyenne
    FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 1
    GROUP BY Years
;

-- Moyenne de tous les pays hors OCDE par année 
CREATE VIEW whr_huy.N_OCDE AS
    SELECT Years, AVG(HappinessScore) Moyenne
    FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 0
    GROUP BY Years
;

-- Requête de synthèse 
SELECT tous.Years, tous.Moyenne Tous, ocde.Moyenne OECD, nocde.Moyenne N_OECD
FROM whr_huy.Tous_pays tous
JOIN whr_huy.OCDE ocde
ON tous.Years = ocde.Years
JOIN whr_huy.N_OCDE nocde
ON tous.Years = nocde.Years
;


-- créer une sous requête qui retourne les 5 meilleurs pays sur les 3 années 
CREATE VIEW whr_huy.top5 AS
	SELECT Country, count(Country), AVG(HappinessScore) Moyenne
	FROM whr 
	GROUP BY 1
	ORDER BY 2 DESC, 3 DESC 
    LIMIT 5
;

-- Top 5 sur les trois années
CREATE VIEW whr_huy.agg_top5 AS
    SELECT w.Years, AVG(w.HappinessScore) Moyenne
    FROM whr_huy.top5 t
    LEFT JOIN whr w
    ON t.Country = w.Country
    GROUP BY w.Years
;

-- créer une sous requête qui retourne les 5 pires pays sur les 3 années 
CREATE VIEW whr_huy.bottom5 AS
	SELECT Country, count(Country), AVG(HappinessScore) Moyenne
	FROM whr 
	GROUP BY 1
	ORDER BY 2 DESC, 3 
    LIMIT 5
;

-- Bottom 5 sur les trois années
CREATE VIEW whr_huy.agg_b5 AS
    SELECT w.Years, AVG(w.HappinessScore) Moyenne
    FROM whr_huy.bottom5 t
    LEFT JOIN whr w
    ON t.Country = w.Country
    GROUP BY w.Years
;

-- TOP 5 qui font parti de l'OCDE
CREATE VIEW whr_huy.t5_OECD AS
	SELECT w.Country, count(w.Country), AVG(w.HappinessScore) Moyenne
	FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 1
	GROUP BY 1
	ORDER BY 2 DESC, 3 DESC 
    LIMIT 5
;

CREATE VIEW whr_huy.agg_t5_OCDE AS
    SELECT w.Years, AVG(w.HappinessScore) Moyenne
    FROM whr_huy.t5_OECD t
    LEFT JOIN whr w
    ON t.Country = w.Country
    GROUP BY w.Years
;

-- TOP 5 qui ne font pas parti de l'OCDE
CREATE VIEW whr_huy.t5nOECD AS
	SELECT w.Country, count(w.Country), AVG(w.HappinessScore) Moyenne
	FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 0
	GROUP BY 1
	ORDER BY 2 DESC, 3 DESC 
    LIMIT 5
;

CREATE VIEW whr_huy.agg_t5nOECD AS
    SELECT w.Years, AVG(w.HappinessScore) Moyenne
    FROM whr_huy.t5nOECD t
    LEFT JOIN whr w
    ON t.Country = w.Country
    GROUP BY w.Years
;

-- BOTTOM 5 qui font parti de l'OCDE
CREATE VIEW whr_huy.b5_OECD AS
	SELECT w.Country, count(w.Country), AVG(w.HappinessScore) Moyenne
	FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 1
	GROUP BY 1
	ORDER BY 2 DESC, 3  
    LIMIT 5
;

CREATE VIEW whr_huy.agg_b5OECD AS
    SELECT w.Years, AVG(w.HappinessScore) Moyenne
    FROM whr_huy.b5_OECD t
    LEFT JOIN whr w
    ON t.Country = w.Country
    GROUP BY w.Years
;

-- BOTTOM 5 qui ne font pas parti de l'OCDE
CREATE VIEW whr_huy.b5nOECD AS
	SELECT w.Country, count(w.Country), AVG(w.HappinessScore) Moyenne
	FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 0
	GROUP BY 1
	ORDER BY 2 DESC, 3  
    LIMIT 5
;

CREATE VIEW whr_huy.agg_b5nOECD AS
    SELECT w.Years, AVG(w.HappinessScore) Moyenne
    FROM whr_huy.b5nOECD t
    LEFT JOIN whr w
    ON t.Country = w.Country
    GROUP BY w.Years
;

-- Requête de synthèse 
CREATE VIEW whr_huy.summary AS
SELECT tous.Years, tous.Moyenne Tous, ocde.Moyenne OECD, nocde.Moyenne N_OECD, tp5.Moyenne TOP5, 
bm5.Moyenne BOM5, t5OCDE.Moyenne TP5_OECD, t5nOCDE.Moyenne TP5_NOECD, b5OCDE.Moyenne BOM5_OECD, 
b5nOCDE.Moyenne BOM5_NOECD
FROM whr_huy.Tous_pays tous
JOIN whr_huy.OCDE ocde
ON tous.Years = ocde.Years
JOIN whr_huy.N_OCDE nocde
ON tous.Years = nocde.Years
JOIN whr_huy.agg_top5 tp5
ON tous.Years = tp5.Years
JOIN whr_huy.agg_b5 bm5
ON tous.Years = bm5.Years
JOIN whr_huy.agg_t5_OCDE t5OCDE
ON tous.Years = t5OCDE.Years
JOIN whr_huy.agg_t5nOECD t5nOCDE
ON tous.Years = t5nOCDE.Years
JOIN whr_huy.agg_b5OECD b5OCDE
ON tous.Years = b5OCDE.Years
JOIN whr_huy.agg_b5nOECD b5nOCDE
ON tous.Years = b5nOCDE.Years
;

-- créer une sous requête qui retourne les régions classées par arbre alphabétique 
CREATE VIEW whr_huy.Regions AS
    SELECT w.Years, c.Region, count(c.Region) AS NB_C, AVG(HappinessScore) AS Moyenne
    FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    GROUP BY 1, 2
    ORDER BY 1, 2 
;

-- créer une sous requête qui retourne les régions avec les annéees en colonnes 
CREATE VIEW whr_huy.R_ancol AS
SELECT 
   r.Region
 , r.NB_C
 , MAX(CASE WHEN r.Years = "2015" THEN r.Moyenne END) "2015"
 , MAX(CASE WHEN r.Years = "2016" THEN r.Moyenne END) "2016"
 , MAX(CASE WHEN r.Years = "2017" THEN r.Moyenne END) "2017"
 , MAX(CASE WHEN r.Years = "2018" THEN r.Moyenne END) "2018"
 , MAX(CASE WHEN r.Years = "2019" THEN r.Moyenne END) "2019"
FROM 
    whr_huy.Regions r
GROUP BY
    r.Region
ORDER BY
    r.Region 
;

-- Région  OCDE uniquement
CREATE VIEW whr_huy.Reg_OECD AS
    SELECT w.Years, c.Region, count(c.Region) AS NB_C, AVG(HappinessScore) AS Moyenne
    FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 1
    GROUP BY 1, 2
    ORDER BY 1, 2 
;

-- créer une sous requête qui retourne les régions avec les annéees en colonnes 
CREATE VIEW whr_huy.RReg_OECD AS
SELECT 
   r.Region
 , r.NB_C
 , MAX(CASE WHEN r.Years = "2015" THEN r.Moyenne END) "2015"
 , MAX(CASE WHEN r.Years = "2016" THEN r.Moyenne END) "2016"
 , MAX(CASE WHEN r.Years = "2017" THEN r.Moyenne END) "2017"
 , MAX(CASE WHEN r.Years = "2018" THEN r.Moyenne END) "2018"
 , MAX(CASE WHEN r.Years = "2019" THEN r.Moyenne END) "2019"
FROM 
    whr_huy.Reg_OECD r
GROUP BY
    r.Region
ORDER BY
    r.Region 
;

-- Région total sans OCDE 
CREATE VIEW whr_huy.RegnOECD AS
    SELECT w.Years, c.Region, count(c.Region) AS NB_C, AVG(HappinessScore) AS Moyenne
    FROM whr w
    JOIN countries c 
    ON w.CountryCode = c.CountryCode
    WHERE c.OECD = 0
    GROUP BY 1, 2
    ORDER BY 1, 2 
;

-- créer une sous requête qui retourne les régions avec les annéees en colonnes 
CREATE VIEW whr_huy.RRegnOECD AS
SELECT 
   r.Region
 , r.NB_C
 , MAX(CASE WHEN r.Years = "2015" THEN r.Moyenne END) "2015"
 , MAX(CASE WHEN r.Years = "2016" THEN r.Moyenne END) "2016"
 , MAX(CASE WHEN r.Years = "2017" THEN r.Moyenne END) "2017"
 , MAX(CASE WHEN r.Years = "2018" THEN r.Moyenne END) "2018"
 , MAX(CASE WHEN r.Years = "2019" THEN r.Moyenne END) "2019"
FROM 
    whr_huy.RegnOECD r
GROUP BY
    r.Region
ORDER BY
    r.Region 
;


-- les facteurs qui ont contribué au Happiness Score
