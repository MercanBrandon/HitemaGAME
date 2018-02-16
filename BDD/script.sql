------------------------------------------------------------
--        Script Postgre
------------------------------------------------------------



------------------------------------------------------------
-- Table: INTERVENTION
------------------------------------------------------------
CREATE TABLE tp.INTERVENTION(
	idInter            SERIAL NOT NULL ,
	typeInter          CHAR (25)  NOT NULL ,
	etatInter          CHAR (25)   ,
	dateDebut          DATE   ,
	dateFin            DATE   ,
	intitule           CHAR (50)   ,
	idSecteur          INT   ,
	idUser             INT  NOT NULL ,
	idUser_UTILISATEUR INT  NOT NULL ,
	CONSTRAINT prk_constraint_INTERVENTION PRIMARY KEY (idInter)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: UTILISATEUR
------------------------------------------------------------
CREATE TABLE tp.UTILISATEUR(
	idUser     SERIAL NOT NULL ,
	nomUser    VARCHAR (100) NOT NULL ,
	prenomUser VARCHAR (50) NOT NULL ,	
	matricule  CHAR (25)   ,
	mdpUser    CHAR (25)   ,
	mailUser   CHAR (25)   ,
	idTypeUtil INT  NOT NULL ,
	CONSTRAINT prk_constraint_UTILISATEUR PRIMARY KEY (idUser)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: RESSOURCE
------------------------------------------------------------
CREATE TABLE tp.RESSOURCE(
	idRessource SERIAL NOT NULL ,
	intitule    VARCHAR (100) NOT NULL ,
	etat        VARCHAR (40) NOT NULL ,
	qteDispo    INT  NOT NULL ,
	CONSTRAINT prk_constraint_RESSOURCE PRIMARY KEY (idRessource)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: COMMANDE
------------------------------------------------------------
CREATE TABLE tp.COMMANDE(
	idCommande   SERIAL NOT NULL ,
	dateCommande CHAR (25)  NOT NULL ,
	idUser       INT  NOT NULL ,
	CONSTRAINT prk_constraint_COMMANDE PRIMARY KEY (idCommande)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: SECTEUR
------------------------------------------------------------
CREATE TABLE tp.SECTEUR(
	idSecteur  SERIAL NOT NULL ,
	nomSecteur CHAR (25)   ,
	idVille    INT   ,
	CONSTRAINT prk_constraint_SECTEUR PRIMARY KEY (idSecteur)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: TYPE_UTILISATEUR
------------------------------------------------------------
CREATE TABLE tp.TYPE_UTILISATEUR(
	idTypeUtil SERIAL NOT NULL ,
	intitule   VARCHAR (50) NOT NULL ,
	CONSTRAINT prk_constraint_TYPE_UTILISATEUR PRIMARY KEY (idTypeUtil)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: VILLE
------------------------------------------------------------
CREATE TABLE tp.VILLE(
	idVille  SERIAL NOT NULL ,
	nomVille CHAR (25)   ,
	CONSTRAINT prk_constraint_VILLE PRIMARY KEY (idVille)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: concerner
------------------------------------------------------------
CREATE TABLE tp.concerner(
	qteRessource INT  NOT NULL ,
	idCommande   INT  NOT NULL ,
	idRessource  INT  NOT NULL ,
	CONSTRAINT prk_constraint_concerner PRIMARY KEY (idCommande,idRessource)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: utiliser
------------------------------------------------------------
CREATE TABLE tp.utiliser(
	idRessource INT  NOT NULL ,
	idInter     INT  NOT NULL ,
	CONSTRAINT prk_constraint_utiliser PRIMARY KEY (idRessource,idInter)
)WITHOUT OIDS;



ALTER TABLE tp.INTERVENTION ADD CONSTRAINT FK_INTERVENTION_idSecteur FOREIGN KEY (idSecteur) REFERENCES tp.SECTEUR(idSecteur);
ALTER TABLE tp.INTERVENTION ADD CONSTRAINT FK_INTERVENTION_idUser FOREIGN KEY (idUser) REFERENCES tp.UTILISATEUR(idUser);
ALTER TABLE tp.INTERVENTION ADD CONSTRAINT FK_INTERVENTION_idUser_UTILISATEUR FOREIGN KEY (idUser_UTILISATEUR) REFERENCES tp.UTILISATEUR(idUser);
ALTER TABLE tp.UTILISATEUR ADD CONSTRAINT FK_UTILISATEUR_idTypeUtil FOREIGN KEY (idTypeUtil) REFERENCES tp.TYPE_UTILISATEUR(idTypeUtil);
ALTER TABLE tp.COMMANDE ADD CONSTRAINT FK_COMMANDE_idUser FOREIGN KEY (idUser) REFERENCES tp.UTILISATEUR(idUser);
ALTER TABLE tp.SECTEUR ADD CONSTRAINT FK_SECTEUR_idVille FOREIGN KEY (idVille) REFERENCES tp.VILLE(idVille);
ALTER TABLE tp.concerner ADD CONSTRAINT FK_concerner_idCommande FOREIGN KEY (idCommande) REFERENCES tp.COMMANDE(idCommande);
ALTER TABLE tp.concerner ADD CONSTRAINT FK_concerner_idRessource FOREIGN KEY (idRessource) REFERENCES tp.RESSOURCE(idRessource);
ALTER TABLE tp.utiliser ADD CONSTRAINT FK_utiliser_idRessource FOREIGN KEY (idRessource) REFERENCES tp.RESSOURCE(idRessource);
ALTER TABLE tp.utiliser ADD CONSTRAINT FK_utiliser_idInter FOREIGN KEY (idInter) REFERENCES tp.INTERVENTION(idInter);

INSERT INTO tp.TYPE_UTILISATEUR (idTypeUtil,intitule)
VALUES (1,'manager'),(2,'intervenant'),(3,'visiteur');

INSERT INTO tp.UTILISATEUR (idUser,nomUser,prenomUser,matricule,mdpUser,mailUser,idTypeUtil)
VALUES (1,'marivint','yvann','YM','YM090117!','marivint.yvann@gmail.com',2),
	   (2,'mercan','brandon','BM','BM090117!','mercan.brandon@gmail.com',1);

INSERT INTO tp.VILLE (idVille,nomVille)
VALUES (1,'Paris'),(2,'Rouen');

INSERT INTO tp.SECTEUR (idSecteur,nomSecteur,idVille)
VALUES (1,'secteurRouen1',2),(2,'secteurRouen2',2),(3,'secteurParis',1);

INSERT INTO tp.COMMANDE (idCommande,dateCommande,idUser)
VALUES (1,'2018-02-16 12:58:00',1),(2,'2018-02-16 14::00:00',2),(3,'2018-02-16 14:10:00',1);

INSERT INTO tp.RESSOURCE (idRessource,intitule,etat,qteDispo)
VALUES (1,'Box wifi PK01','disponible','10'),(2,'agents','disponible','13'),(3,'téléphones','disponible','22'),(4,'cable JR45','disponible','123');

INSERT INTO tp.INTERVENTION (idInter,typeInter,etatInter,dateDebut,dateFin,intitule,idSecteur,idUser,idUser_UTILISATEUR)
VALUES 	(1,'interne','Valider','2018-02-17 19:00:00','2018-02-17 20:00:00','Reparation serveur',1,1,1),
		(2,'externe','Terminer','2018-02-15 13:30:00','2018-02-15 17:00:00','Livraison switch',1,1,1),
		(3,'externe','EnAttente','2018-02-20 14:00:00','2018-02-21 12:00:00','Installation serveurs',1,1,1),
		(4,'externe','EnCours','2018-02-16 14:20:00','2018-02-16 17:00:00','Mise en place de la BDD client Horizon',2,2,1),
		(5,'interne','EnCours','2018-02-16 09:00:00','2018-02-16 20:00:00','Audit connexion 5G',2,2,1),
		(6,'interne','EnCours','2018-02-16 16:00:00','2018-02-16 17:00:00','Reparation accès internet ligne ABD01',1,2,1);

INSERT INTO tp.UTILISER (idRessource,idInter)
VALUES (2,1),(3,1),(2,2),(2,3),(2,4),(2,5),(2,6);

INSERT INTO tp.CONCERNER (qteRessource,idCommande,idRessource)
<<<<<<< HEAD
VALUES ('5',1,1);
=======
VALUES ('40',1,3),('5',2,2),('5',3,1);
>>>>>>> origin/master
