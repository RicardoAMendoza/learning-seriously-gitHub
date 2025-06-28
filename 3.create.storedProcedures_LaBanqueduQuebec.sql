-- This project uses the following licenses:
-- MIT License
-- Copyright (c) 2024 Ricardo Alfredo Mendoza Cortes 
-- Montréal Québec Canada

-- Repository : MVC_winapp_NationalBank_SqlServer > https://github.com/RicardoAMendoza/MVC_winapp_NationalBank_SqlServer.git
-- Project : prjWeb_MVC_LaBanquenationale_Rm
-- Instruction :
-- Copy AND paste on SqlServer script AND run it. That will create de data base



-- INDEX
-- 1.- Procedure sp_save_tlabanqueduQuebec
-- 2.- Procedure sp_save_tconseil
-- 3.- sp_save_tdirecteur
-- 4.- sp_save_tagences
-- 5.- sp_save_tdirecteur_agences
-- 6. sp_save_tarea
-- 7.- sp_save_temploye
-- 8.- sp_save_temploye_area
-- 9.- sp__save_client
-- 10.- sp_save_tcompte
-- 11.- sp_save_ttypeCompte
-- 12.- sp_save_tclient_compte
-- 13.- sp_save_tadmin

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Description:	Save data in tlabanqueduQuebec
-- 1.- Procedure sp_save_tlabanqueduQuebec
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_tlabanqueduQuebec
	@aidbanque int= null,
	@anumber tv100=null,
	@anom tv100=null,
	@acapital tmoney = null,
	@aadresse tv100 = null
AS BEGIN 
	IF @aidbanque=0
		INSERT INTO [dbo].[tlabanqueduQuebec]
		(number,nom,capital,adresse)
		VALUES 
		(@anumber,@anom,@acapital,@aadresse)
	ELSE
		UPDATE [dbo].[tlabanqueduQuebec]
		SET number=@anumber,nom=@anom,
		capital=@acapital,adresse=@aadresse
	WHERE idbanque=@aidbanque
END
GO

 -----------------------------------------------------
 --1. EXEC  sp_save_tlabanqueduQuebec
 -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

--EXEC sp_save_tlabanqueduQuebec
--@aidbanque =0,
--@anumber = "1000LaBanqueNationale",
--@anomdeFamille = "La Banque Nationale",
--@acapital = 100000000,
--@aadresse = "1000 rue Masson, Mntreal, Canada, H4N3N1" 

--USE [bdLaBanqueduQuebec]
--GO
--SELECT * FROM [dbo].[tlabanqueduQuebec]

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Description:	Save data in tconseil
-- 2.- Procedure sp_save_tconseil
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_tconseil
	@aidconseil int = null,
	@anumber tv100 =null,
	@anomdeFamille tv100 =null,
	@anom tv100 = null,
	@acourriel tv100 = null,
	@aimg tv100 = null,
	@asalary tmoney = null,
	@asexe tv1 = null,
	@aactive tv1=null,
	@aidbanque int = null
AS BEGIN
	IF @aidconseil=0
		INSERT INTO tconseil
		(number,nomdeFamille,nom,courriel, 
		img, salary,sexe,active,idbanque)
		VALUES
		(@anumber,@anomdeFamille,@anom,@acourriel, 
		@aimg,@asalary,@aactive,@asexe,@aidbanque)
	ELSE
		UPDATE tconseil
		SET number=@anumber,nomdeFamille=@anomdeFamille,nom=@anom,courriel=@acourriel, 
		img=@aimg,salary=@asalary,active=@aactive,sexe=@asexe,idbanque=@aidbanque
	WHERE idconseil=@aidconseil
END
GO

-- -----------------------------------------------------
-- 2. EXEC  sp_save_tconseil
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

--EXEC  sp_save_tconseil
--@aidconseil = 0,
--@anumber ="dir01",
--@anomdeFamille ="Patrick",
--@anom = "Dorre",
--@acourriel = "dorre@gmail.com",
--@aimg ="dorre.png",
--@asalary = 80000,
--@asexe ="M",
--@aactive="A",
--@aidbanque = 10

--SELECT * FROM tconseil

-- -----------------------------------------------------
-- 3.- sp_save_tdirecteur
-- -----------------------------------------------------
CREATE PROCEDURE sp_save_tdirecteur
	@aiddirecteur int = null,
	@anumber tv100 =null,
	@anomdeFamille tv100= null,
	@anom tv100 = null,
	@acourriel tv100 = null,
	@aimg tv100 = null,
	@asalary tmoney = null,
	@asexe tv100 = null,
	@aactive tv100 =null
AS BEGIN
	IF @aiddirecteur =0
		INSERT INTO tdirecteur 
		(number,nomdeFamille,nom,courriel,
		img,salary,sexe,active)
		VALUES 
		(@anumber,@anomdeFamille,@anom,@acourriel,
		@aimg,@asalary,@asexe,@aactive)
	ELSE
		UPDATE tdirecteur
		SET number=@anumber,nomdeFamille=@anomdeFamille,nom=@anom,courriel=@acourriel,
		img=@aimg,salary=@asalary,sexe=@asexe,active=@aactive
	WHERE iddirecteur=@aiddirecteur
END
GO

-- -----------------------------------------------------
-- 3. EXEC  sp_save_tdirecteur
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

--EXEC  sp_save_tdirecteur
--@aiddirecteur = 0,
--@anumber ="dir01",
--@anomdeFamille ="Patrick",
--@anom = "Dorre",
--@acourriel = "dorre@gmail.com",
--@aimg ="dorre.png",
--@asalary = 80000,
--@asexe ="M",
--@aactive="A"

--SELECT * FROM tdirecteur

-- -----------------------------------------------------
-- 4.- sp_save_tagences
-- -----------------------------------------------------
USE [bdLaBanqueduQuebec]
GO
--DROP PROCEDURE sp_save_tagences
CREATE PROCEDURE sp_save_tagences
	@aidagences int = null,
	@anumber tv100 = null,
	@anom tv100 = null,
	@aadresse tv100 = null,
	@aidbanque int = null
	--@aiddirecteur int = null
AS BEGIN
	IF @aidagences = 0
		INSERT INTO tagences
		(number,nom,adresse,idbanque)--,iddirecteur)
		VALUES 
		(@anumber,@anom,@aadresse,@aidbanque)--,@aiddirecteur)
	ELSE
		UPDATE tagences
		SET number=@anumber,nom=@anom,adresse=@aadresse,
		idbanque=@aidbanque--,iddirecteur=@aiddirecteur
	WHERE idagences=@aidagences
END
GO



-- -----------------------------------------------------
-- 4.- EXEC sp_save_tagences
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO
--EXEC sp_save_tagences
--@aidagences=0,
--@anumber ="A1A1",
--@anom ="Rosemont NB",
--@aadresse ="3540 rue Msson, Rosemont, Montrela, 3H1N4L",
--@aidbanque =10,
--@aiddirecteur = 10

--SELECT * FROM tlabanqueduQuebec
--SELECT * FROM tdirecteur
--SELECT * FROM tagences



-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-09
-- Description:	Save data in tdirecteur_agences
-- 5.- sp_save_tdirecteur_agences
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_tdirecteur_agences
	@aiddirecteur int =0,
	@aidagences int =0
AS BEGIN
		DECLARE @valid int;
			SET @valid=(SELECT COUNT(*) 
						FROM tdirecteur_agence
						WHERE iddirecteur =@aiddirecteur);
	IF @valid = 0
		INSERT INTO tdirecteur_agence
		(iddirecteur,idagences)
		VALUES(@aiddirecteur, @aidagences)
	ELSE
		UPDATE tdirecteur_agence
		SET iddirecteur=@aiddirecteur, idagences=@aidagences
	WHERE iddirecteur=@aiddirecteur
END
GO

-- -----------------------------------------------------
-- 5.- sp_save_tdirecteur_agences
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO
--select * from tdirecteur
--select * from tdirecteur_agence
--select * from tagences

--USE [bdLaBanqueduQuebec]
--GO

--EXEC [dbo].[sp_save_tdirecteur_agences]
--@aiddirecteur = 40,
--@aidagences = 10

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-09
-- Description:	sp_save_tarea
-- 6. sp_save_tarea
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_tarea
	@acodearea tv3 = null,
	@adescription tv100 = null
AS BEGIN
	 DECLARE @valid int;
	 --SELECT COUNT(*) into @valid FROM tarea WHERE codearea=@acodearea
	 SET @valid=(SELECT COUNT(*) FROM tarea WHERE codearea=@acodearea);
	IF @valid =0
		INSERT INTO tarea
		(codearea,description)
		VALUES
		(@acodearea,@adescription)
	ELSE 
		UPDATE tarea 
		SET description =@adescription 
	WHERE codearea=@acodearea
END
GO
--SELECT COUNT(*) FROM tarea WHERE codearea='CAE';
-- -----------------------------------------------------
-- 6. EXEC sp_save_tarea
-- -----------------------------------------------------

--USE [bdLaBanqueduQuebec]
--GO

--EXEC sp_save_tarea
--@acodearea = [FIN],
--@adescription = 'Finances'

--EXEC sp_save_tarea
--@acodearea = [CON],
--@adescription = 'Contable'

--SELECT * FROM tarea

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-19
-- Description:	sp_save_temploye
-- 7.- sp_save_temploye
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_temploye
	@aidemploye int = null,
	@anumber tv100 = null,
	@anomdeFamille tv100 = null,
	@anom tv100 = null,
	@acourriel varchar (45) = null,
	@aimg varchar (45) = null,
	@ahiringDate date = null,
	@asalary tmoney = null,
	@asexe tv1 = null,
	@aactive tv1 = null,
	@aidagences int = null
AS BEGIN
	IF @aidemploye=0
		INSERT INTO temploye 
		(number,nomdeFamille,nom,courriel,
		img,hiringDate,salary,sexe,active,idagences)
		VALUES
		(@anumber,@anomdeFamille,@anom,@acourriel,
		@aimg,@ahiringDate,@asalary,@asexe,@aactive,@aidagences)
	ELSE  
		UPDATE temploye
		SET number=@anumber,nomdeFamille=@anomdeFamille,nom=@anom,
		courriel=@acourriel,img=@aimg,hiringDate=@ahiringDate,
		salary=@asalary,sexe=@asexe,active=@aactive,idagences=@aidagences
	WHERE idemploye=@aidemploye
END
GO

-- -----------------------------------------------------
-- 7. EXEC sp_save_temploye
-- -----------------------------------------------------

--USE [bdLaBanqueduQuebec]
--GO

--EXEC sp_save_temploye 
--@aidemploye  = 0,
--@anumber  = 'E1E1',
--@anomdeFamille  = 'Juan',
--@anom = 'Zamanego',
--@acourriel  = 'zamanego@gamil.com',
--@aimg  = 'zamanego.png',
--@ahiringDate  = '2017-02-23',
--@asalary = 150000.99,
--@asexe = 'M',
--@aactive = 'A',
--@aidagences  = 10

--SELECT * FROM tagences
--SELECT * FROM temploye

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-19
-- Description:	sp_save_temploye_area
-- 8.- sp_save_temploye_area
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_temploye_area
	@aidemploye int =0,
	@acodearea tv3
AS BEGIN
		DECLARE @valid int;
			SET @valid=(SELECT COUNT(*) 
						FROM temploye_area
						WHERE idemploye =@aidemploye);
	IF @valid = 0
		INSERT INTO temploye_area 
		(idemploye,codearea)
		VALUES(@aidemploye, @acodearea)
	ELSE
		UPDATE temploye_area
		SET idemploye=@aidemploye, codearea=@acodearea
	WHERE idemploye=@aidemploye
END
GO

-- -----------------------------------------------------
-- 8. EXEC sp_save_temploye_area
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

--EXEC sp_save_temploye_area
--@aidemploye = 10,
--@acodearea = 'FIN'

--SELECT * FROM temploye_area
-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-19
-- Description:	sp__save_client
-- 9.- sp__save_client
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_tclient
	@aidclient int =null,
	@anumber tv100 = null,
	@anomdeFamille tv100 = null,
	@anom tv100 =null,
	@acourriel tv100 = null,
	@aimg tv100 = null,
	@aadresse tv100 = null,
	@anumerodeCarte tv100 = null,
	@anip tv100 = null,
	@asexe tv1 = null,
	@aage int = null,
	@aactive tv1 = null,
	@aidagences int = null,
	@aidemploye int = null
AS BEGIN
	IF @aidclient = 0
		INSERT INTO tclient
		(number,nomdeFamille,nom,courriel,img,
		adresse,numerodeCarte,nip,sexe,age,active,
		idagences,idemploye)
		VALUES
		(@anumber,@anomdeFamille,@anom,@acourriel,@aimg,
		@aadresse,@anumerodeCarte,@anip,@asexe,@aage,
		@aactive,@aidagences,@aidemploye)
	ELSE
		UPDATE tclient
		SET
		number=@anumber,nomdeFamille=@anomdeFamille,
		nom=@anom,courriel=@acourriel,img=@aimg,
		adresse=@aadresse,numerodeCarte=@anumerodeCarte,
		nip=@anip,sexe=@asexe,age=@aage,
		active=@aactive,idagences=@aidagences,
		idemploye=@aidemploye
	WHERE idclient=@aidclient
END
GO

-- -----------------------------------------------------
-- 9. EXEC sp_save_tclient
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

--EXEC sp_save_tclient
--@aidclient = 0,
--@anumber  = 'C1C1',
--@anomdeFamille  = 'Bill',
--@anom  = 'Gates',
--@acourriel  = 'gates@microsoft.com',
--@aimg  = 'gates.png',
--@aadresse  = '3540 Masson',
--@anumerodeCarte = '123456',
--@anip  = 'windows',
--@asexe = 'M',
--@aactive = 'A',
--@aidagences  = 10,
--@aidemploye = 10

--SELECT * FROM tagences
--SELECT * FROM temploye
--SELECT * FROM tclient

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-19
-- Description:	sp_save_tcompte
-- 10.- sp_save_tcompte
-- =====================================================
USE [bdLaBanqueduQuebec]
GO
--drop procedure sp_save_tcompte
CREATE PROCEDURE sp_save_tcompte
	@aidcompte int = null,
	@anumber tv100 =null,
	@abalance tmoney =null,
-- -----------------------------------------------------
	-- @adeposer tmoney =null,
	-- @aretirer tmoney =null,
	-- @adateOperation date =null,
-- -----------------------------------------------------	
	@adateOuverture date =null,
	@adateCloture date = null,
	@aidemploye int = null,
	@aidagences int = null
AS BEGIN
	IF @aidcompte=0
		INSERT INTO tcompte
		(number,balance,dateOuverture,dateCloture,
		idemploye,idagences)
		VALUES
		(@anumber,@abalance,@adateOuverture,
		@adateCloture,@aidemploye,@aidagences)
	ELSE
		UPDATE tcompte
		SET number=@anumber,balance=@abalance,
		dateOuverture=@adateOuverture,
		dateCloture=@adateCloture,idemploye=@aidemploye,
		idagences=@aidagences
	WHERE idcompte=@aidcompte
END
GO

-- -----------------------------------------------------
-- 10. EXEC sp_save_tcompte
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

-- C1C1 ----------------------------
--EXEC sp_save_tcompte
--@aidcompte  = 0,
--@anumber = "UA1UA1",
--@abalance = 2300,
--@adateOuverture  = '2016-08-17 23:59:59',
--@adateCloture = '2016-08-17 23:59:59',
--@aidemploye  = 10,
--@aidagences  = 10

--EXEC sp_save_tcompte
--@aidcompte  = 0,
--@anumber = "PA1PA1",
--@abalance = 2999,
--@adateOuverture   = '2016-08-17 23:59:59',
--@adateCloture = '2016-08-17 23:59:59',
--@aidemploye  = 10,
--@aidagences  = 10

--SELECT * FROM temploye
--SELECT * FROM tagences
--SELECT * FROM tcompte

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-19
-- Description:	sp_save_ttypeCompte
-- 11.- sp_save_ttypeCompte
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_ttypeCompte
	@aidtypeCompte int = null,
	@aaccountType tv100 = null,
	@acommission tmoney = null,
	@adecouvert tmoney = null,
	@ainteretImmediat tmoney = null
AS BEGIN
	IF @aidtypeCompte=0
		INSERT INTO ttypeCompte
		(accountType,commission,decouvert,interetImmediat)
		VALUES
		(@aaccountType,@acommission,@adecouvert,@ainteretImmediat)
	ELSE
		UPDATE ttypeCompte
		SET accountType=@aaccountType,commission=@acommission,
		    decouvert=@adecouvert,interetImmediat=@ainteretImmediat
	WHERE idtypeCompte=@aidtypeCompte
END
GO

-- -----------------------------------------------------
-- 11. EXEC sp_save_ttypeCompte
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

-- EXEC sp_save_ttypeCompte
-- @aidtypeCompte = 0,
-- @aaccountType = UnPaidAccount,
-- @acommission = 0.12,
-- @adecouvert = 2000,
-- @ainteretImmediat = 0
 
-- EXEC sp_save_ttypeCompte
-- @aidtypeCompte = 0,
-- @aaccountType = PaidAccount,
-- @acommission = 0,
-- @adecouvert = 0,
-- @ainteretImmediat = 0.15

-- SELECT * FROM ttypeCompte
 
-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-19
-- Description:	sp_save_tclient_compte
-- 12.- sp_save_tclient_compte
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_tclient_compte
	@aidtypeCompte int = null,
	@aidclient int = null,
	@aidcompte int null
AS BEGIN
	DECLARE @valid int;
	SET @valid=(SELECT COUNT (*) FROM tclient_compte
				WHERE idtypeCompte=@aidtypeCompte 
				AND idclient=@aidclient);
	IF @valid=0
		INSERT INTO tclient_compte
		(idtypeCompte,idclient,idcompte)
		VALUES
		(@aidtypeCompte,@aidclient,@aidcompte)
	ELSE
		UPDATE tclient_compte
		SET idcompte=@aidcompte
	WHERE idtypeCompte=@aidtypeCompte 
	AND idclient=@aidclient
END 
GO

-- -----------------------------------------------------
-- 12. EXEC sp_save_tclient_compte
-- -----------------------------------------------------
--USE [bdLaBanqueduQuebec]
--GO

---- C1C1 ----------------------------
--EXEC sp_save_tclient_compte
--@aidtypeCompte = 10,
--@aidclient = 10,
--@aidcompte = 70

--EXEC sp_save_tclient_compte
--@aidtypeCompte = 20,
--@aidclient = 10,
--@aidcompte = 80

--USE [bdLaBanqueduQuebec]
--GO
--SELECT * FROM ttypeCompte
--SELECT * FROM tclient
--SELECT * FROM tcompte
--SELECT * FROM tclient_compte

-- =====================================================
-- Stored Procedures for Data
-- Author:		Ricardo Mendoza
-- Create date: 2025-02-19
-- Description: sp_save_tadmin
-- 13.- sp_save_tadmin
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE PROCEDURE sp_save_tadmin
	@aidadmin  int = null,
	@anumber tv100 = null,
	@anomdeFamille tv100 = null,
	@anom tv100 = null,
	@acourriel tv100 = null,
	@aimg  tv100 = null,
	@autilisateur tv100 = null,
	@amotdePasse tv100 = null,
	@asexe tv1 = null,
	@aactive tv1 = null
AS BEGIN
	IF @aidadmin=0
		INSERT INTO tadmin 
		(number,nomdeFamille,nom,courriel,img,
		utilisateur,motdePasse,sexe,active)
		VALUES
		(@anumber,@anomdeFamille,@anom,@acourriel,@aimg,
		@autilisateur,@amotdePasse,@asexe,@aactive)
	ELSE
		UPDATE tadmin
		SET 
		number=@anumber,nomdeFamille=@anomdeFamille,
		nom=@anom,courriel=@acourriel,img=@aimg,
		utilisateur=@autilisateur,motdePasse=@amotdePasse,
		sexe=@asexe,active=@aactive
	WHERE idadmin=@aidadmin
END
GO

-- -----------------------------------------------------
-- 13. EXEC sp_save_tadmin
-- -----------------------------------------------------

USE [bdLaBanqueduQuebec]
GO

--EXEC [dbo].[sp_save_tadmin] 
--@aidadmin  = 0,
--@anumber = 'Ad01',
--@anomdeFamille = 'Andy',
--@anom = 'Garcia',
--@acourriel = 'garcia@teccart.qc.ca',
--@aimg = 'andy.png',
--@autilisateur = 'andydelRisco',
--@amotdePasse = 'sql',
--@asexe = 'M',
--@aactive = 'A'

--USE [bdLaBanqueduQuebec]
--GO

--SELECT * FROM tadmin

