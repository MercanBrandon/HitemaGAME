------------------------------------------------------------
--        Script Postgre
------------------------------------------------------------



------------------------------------------------------------
-- Table: INTERVENTION
------------------------------------------------------------
CREATE TABLE public.INTERVENTION(
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
CREATE TABLE public.UTILISATEUR(
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
CREATE TABLE public.RESSOURCE(
	idRessource SERIAL NOT NULL ,
	intitule    VARCHAR (100) NOT NULL ,
	etat        VARCHAR (40) NOT NULL ,
	qteDispo    INT  NOT NULL ,
	CONSTRAINT prk_constraint_RESSOURCE PRIMARY KEY (idRessource)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: COMMANDE
------------------------------------------------------------
CREATE TABLE public.COMMANDE(
	idCommande   SERIAL NOT NULL ,
	dateCommande CHAR (25)  NOT NULL ,
	idUser       INT  NOT NULL ,
	CONSTRAINT prk_constraint_COMMANDE PRIMARY KEY (idCommande)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: SECTEUR
------------------------------------------------------------
CREATE TABLE public.SECTEUR(
	idSecteur  SERIAL NOT NULL ,
	nomSecteur CHAR (25)   ,
	idVille    INT   ,
	CONSTRAINT prk_constraint_SECTEUR PRIMARY KEY (idSecteur)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: TYPE_UTILISATEUR
------------------------------------------------------------
CREATE TABLE public.TYPE_UTILISATEUR(
	idTypeUtil SERIAL NOT NULL ,
	intitule   VARCHAR (50) NOT NULL ,
	CONSTRAINT prk_constraint_TYPE_UTILISATEUR PRIMARY KEY (idTypeUtil)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: VILLE
------------------------------------------------------------
CREATE TABLE public.VILLE(
	idVille  SERIAL NOT NULL ,
	nomVille CHAR (25)   ,
	CONSTRAINT prk_constraint_VILLE PRIMARY KEY (idVille)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: concerner
------------------------------------------------------------
CREATE TABLE public.concerner(
	qteRessource INT  NOT NULL ,
	idCommande   INT  NOT NULL ,
	idRessource  INT  NOT NULL ,
	CONSTRAINT prk_constraint_concerner PRIMARY KEY (idCommande,idRessource)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: utiliser
------------------------------------------------------------
CREATE TABLE public.utiliser(
	idRessource INT  NOT NULL ,
	idInter     INT  NOT NULL ,
	CONSTRAINT prk_constraint_utiliser PRIMARY KEY (idRessource,idInter)
)WITHOUT OIDS;



ALTER TABLE public.INTERVENTION ADD CONSTRAINT FK_INTERVENTION_idSecteur FOREIGN KEY (idSecteur) REFERENCES public.SECTEUR(idSecteur);
ALTER TABLE public.INTERVENTION ADD CONSTRAINT FK_INTERVENTION_idUser FOREIGN KEY (idUser) REFERENCES public.UTILISATEUR(idUser);
ALTER TABLE public.INTERVENTION ADD CONSTRAINT FK_INTERVENTION_idUser_UTILISATEUR FOREIGN KEY (idUser_UTILISATEUR) REFERENCES public.UTILISATEUR(idUser);
ALTER TABLE public.UTILISATEUR ADD CONSTRAINT FK_UTILISATEUR_idTypeUtil FOREIGN KEY (idTypeUtil) REFERENCES public.TYPE_UTILISATEUR(idTypeUtil);
ALTER TABLE public.COMMANDE ADD CONSTRAINT FK_COMMANDE_idUser FOREIGN KEY (idUser) REFERENCES public.UTILISATEUR(idUser);
ALTER TABLE public.SECTEUR ADD CONSTRAINT FK_SECTEUR_idVille FOREIGN KEY (idVille) REFERENCES public.VILLE(idVille);
ALTER TABLE public.concerner ADD CONSTRAINT FK_concerner_idCommande FOREIGN KEY (idCommande) REFERENCES public.COMMANDE(idCommande);
ALTER TABLE public.concerner ADD CONSTRAINT FK_concerner_idRessource FOREIGN KEY (idRessource) REFERENCES public.RESSOURCE(idRessource);
ALTER TABLE public.utiliser ADD CONSTRAINT FK_utiliser_idRessource FOREIGN KEY (idRessource) REFERENCES public.RESSOURCE(idRessource);
ALTER TABLE public.utiliser ADD CONSTRAINT FK_utiliser_idInter FOREIGN KEY (idInter) REFERENCES public.INTERVENTION(idInter);

INSERT INTO tp.TYPE_UTILISATEUR (idTypeUtil,intitule)
VALUES (1,'manager'),(2,'visiteur');

INSERT INTO tp.UTILISATEUR (idUser,nomUser,prenomUser,matricule,mdpUser,mailUser)
VALUES (1,'marivint','yvann','YM','YM090117!','marivint.yvann@gmail.com');

INSERT INTO tp.DETERMINER (idUser,idTypeUtil)
VALUES (1,1);

INSERT INTO tp.VILLE (nomVille)
VALUES ('Paris');

INSERT INTO tp.SECTEUR (nomSecteur,idVille)
VALUES ('secteur1',1),('secteur2',1),('secteur3',1);

INSERT INTO tp.COMMANDE (dateCommande,idUser)
VALUES ('2018-02-16 12:58:00',1);

INSERT INTO tp.RESSOURCE (intitule,etat,qteDispo)
VALUES ('ordinateur asus','disponible','10');

INSERT INTO tp.INTERVENTION (idInter,typeInter,etatInter,dateDebut,dateFin,idSecteur,idUser,idUser_UTILISATEUR)
VALUES (1,'interne','en cours','2018-02-16 13:30:00','2018-02-16 17:00:00',1,1,1);

INSERT INTO tp.UTILISER (idRessource,idInter)
VALUES (1,1);

INSERT INTO tp.DEPEND (qteRessource,idCommande,idRessource)
VALUES ('5',1,1);