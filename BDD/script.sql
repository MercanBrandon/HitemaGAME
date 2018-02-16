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
-- Table: determiner
------------------------------------------------------------
CREATE TABLE public.determiner(
	idUser     INT  NOT NULL ,
	idTypeUtil INT  NOT NULL ,
	CONSTRAINT prk_constraint_determiner PRIMARY KEY (idUser,idTypeUtil)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: depend
------------------------------------------------------------
CREATE TABLE public.depend(
	qteRessource INT  NOT NULL ,
	idCommande   INT  NOT NULL ,
	idRessource  INT  NOT NULL ,
	CONSTRAINT prk_constraint_depend PRIMARY KEY (idCommande,idRessource)
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
ALTER TABLE public.COMMANDE ADD CONSTRAINT FK_COMMANDE_idUser FOREIGN KEY (idUser) REFERENCES public.UTILISATEUR(idUser);
ALTER TABLE public.SECTEUR ADD CONSTRAINT FK_SECTEUR_idVille FOREIGN KEY (idVille) REFERENCES public.VILLE(idVille);
ALTER TABLE public.determiner ADD CONSTRAINT FK_determiner_idUser FOREIGN KEY (idUser) REFERENCES public.UTILISATEUR(idUser);
ALTER TABLE public.determiner ADD CONSTRAINT FK_determiner_idTypeUtil FOREIGN KEY (idTypeUtil) REFERENCES public.TYPE_UTILISATEUR(idTypeUtil);
ALTER TABLE public.depend ADD CONSTRAINT FK_depend_idCommande FOREIGN KEY (idCommande) REFERENCES public.COMMANDE(idCommande);
ALTER TABLE public.depend ADD CONSTRAINT FK_depend_idRessource FOREIGN KEY (idRessource) REFERENCES public.RESSOURCE(idRessource);
ALTER TABLE public.utiliser ADD CONSTRAINT FK_utiliser_idRessource FOREIGN KEY (idRessource) REFERENCES public.RESSOURCE(idRessource);
ALTER TABLE public.utiliser ADD CONSTRAINT FK_utiliser_idInter FOREIGN KEY (idInter) REFERENCES public.INTERVENTION(idInter);
