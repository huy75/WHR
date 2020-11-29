
-- Création
CREATE USER 'login'@'hote' [IDENTIFIED BY 'mot_de_passe'];

-- Suppression
DROP USER 'login'@'hote';

CREATE USER 'max'@'localhost' IDENTIFIED BY 'maxisthebest';
CREATE USER 'elodie'@'194.28.12.4' IDENTIFIED BY 'ginko1';
CREATE USER 'gabriel'@'arb.brab.net' IDENTIFIED BY 'chinypower';

-- thibault peut se connecter à partir de n'importe quel hôte dont l'adresse IP commence par 194.28.12.
CREATE USER 'thibault'@'194.28.12.%' IDENTIFIED BY 'basketball8';

SET PASSWORD FOR 'thibault'@'194.28.12.%' = PASSWORD('basket8');

-- joelle peut se connecter à partir de n'importe quel hôte du domaine brab.net
CREATE USER 'joelle'@'%.brab.net' IDENTIFIED BY 'singingisfun';

-- hannah peut se connecter à partir de n'importe quel hôte
CREATE USER 'hannah'@'%' IDENTIFIED BY 'looking4sun';

CREATE USER 'john'@'localhost' IDENTIFIED BY 'exemple2012';
GRANT SELECT, 
      UPDATE (nom, sexe, commentaires), 
      DELETE, 
      INSERT
ON elevage.Animal
TO 'john'@'localhost';

REVOKE DELETE
ON elevage.Animal
FROM 'john'@'localhost';

GRANT ALL 
ON elevage.Client
TO 'john'@'localhost';
