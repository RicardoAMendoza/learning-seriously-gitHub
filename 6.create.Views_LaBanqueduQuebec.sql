+-- This project uses the following licenses:
-- MIT License
-- Copyright (c) 2024 Ricardo Alfredo Mendoza Cortes 
-- Montréal Québec Canada

-- Repository : MVC_winapp_NationalBank_SqlServer > https://github.com/RicardoAMendoza/MVC_winapp_NationalBank_SqlServer.git
-- Project : prjWeb_MVC_LaBanquenationale_Rm
-- Instruction :
-- Copy and paste on SqlServer script and run it. That will create de data base


--In SQL Server, a "view" is a virtual table that displays the result of a single query,
--essentially acting like a customized snapshot of data FROM other tables,
--while a "procedure" (also called a stored procedure) is a set of pre-compiled SQL statements
--that can perform multiple operations like inserting, updating, deleting,
--or selecting data, allowing for more complex logic and reusable functionality;
--in simpler terms, a view is just a way to present data in a specific format, 
--while a procedure can actively manipulate data within the database. 

-- =====================================================
-- VIEWS
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Name : viewClients
-- Description:	View clients et agences FROM bdLaBanqueduQuebec
-- 1.- viewClient
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE VIEW viewClient
AS
SELECT
	CONCAT(CASE
			WHEN a.sexe ='M' THEN 'Mr'
			WHEN a.sexe ='F' THEN 'Mrs'
			END
			,'   ',a.nomdeFamille,'   ',a.nom) AS CLIENT,
	a.adresse AS 'CLIENT ADDRESS',	
	a.courriel AS [E-MAIL],
	a.number AS [CLIENT NUMBER],
	a.numerodeCarte AS 'CARD NUMBER',	
	a.nip AS NIP,
	a.active AS ACTIVE,
	CONCAT('Agence :','   ',b.nom) AS 'AGENCE FILIAL',
	b.idagences AS [AGENCE CODE],
	b.adresse AS [AGENCE ADDRESS]
	FROM tclient a 
	left join tagences b
	on a.idagences=b.idagences
	--ORDER BY [CODE] DESC, a.nom  DESC
	--The ORDER BY clause is invalid in views

--use bdLaBanqueduQuebec
--go
--SELECT * FROM viewClient
--SELECT * FROM tagences

-- =====================================================
-- VIEWS
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Name : viewClientAccounts
-- Description:	View clients accounts FROM bdLaBanqueduQuebec
-- 2.- viewClientComptes
-- =====================================================
USE [bdLaBanqueduQuebec]
GO
CREATE VIEW viewClentComptes
AS 
SELECT
	-- tclient a -------------------------------
	CONCAT(CASE
			WHEN a.sexe ='M' THEN 'Mr'
			WHEN a.sexe ='F' THEN 'Mrs'
			END
			,'   ',a.nomdeFamille,'   ',a.nom) as CLIENT,
		a.adresse AS 'CLIENT ADDRESS',
		a.courriel AS [E-MAIL],
		a.number AS [CLIENT NUMBER],
		a.numerodeCarte AS [CARD NUMBER],
		a.nip AS NIP,
	-- tagences b -------------------------------
		CONCAT('Agence :','   ',b.nom) AS 'FILIAL AGENCE',
		b.idagences AS [AGENCE CODE],
		b.adresse AS [AGENCE ADDRESS],
	-- tcompte e -------------------------------
		e.number AS [COMPTE NUMBER],
		e.balance AS BALANCE,
		e.dateOuverture AS [OPEN DATE],
		e.dateCloture AS [CLOSE DATE],
	-- ttypeCompte d -------------------------------
		d.accountType AS [ACCOUNT TYPE],
		d.commission AS COMISSION,
		d.decouvert AS OVERDRAFT,
		d.interetImmediat AS [INTEREST RATE]
	FROM tclient a 
	left join tagences b
	on a.idagences=b.idagences
	left join tclient_compte c
	on c.idclient=a.idclient
	left join ttypeCompte d
	on d.idtypeCompte= c.idtypeCompte
	left join tcompte e
	on e.idcompte=c.idcompte

--SELECT * FROM viewClentComptes
-- =====================================================
-- VIEWS
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Name : viewAgences
-- Description:	View agence FROM bdLaBanqueduQuebec
-- 3.- viewAgences
-- =====================================================
USE bdLaBanqueduQuebec
GO

CREATE VIEW viewAgences
AS
SELECT
		-- tagence  a ------------------------------
		a.number AS 'AGENCE CODE',
		CONCAT('Agence :','   ',a.nom) AS 'FILIAL AGENCE',
		a.adresse AS 'AGENCE ADDRESS',
		-- temploye b ------------------------------
		b.number AS [EMPLOYEE NUMBER],
		CONCAT(CASE
				WHEN b.sexe ='M' THEN 'Mr'
				WHEN b.sexe ='F' THEN 'Mrs'
				END,'   ',b.nomdeFamille, '   ', b.nom) AS EMPLOYEE,
		-- tarea c  ------------------------------
		c.codearea AS 'AREA CODE',
		c.description AS AREA,
		-- tclient d  ------------------------------
		d.number AS [CLIENT NUMBER],
		CONCAT(CASE
				WHEN d.sexe ='M' THEN 'Mr'
				WHEN d.sexe ='F' THEN 'Mrs'
				END,'   ',d.nomdeFamille, '   ', d.nom)  AS CLIENT,
		-- ttypeCompte e --------------------------
		e.accountType AS 'ACCOUNT TYPE',
		e.interetImmediat AS 'INTEREST', -- PaidAccount
		e.commission AS 'COMISSION',   -- UnPaidAccount
		e.decouvert AS 'OVERDRAFT',    -- UnPaidAccount
		-- tcompte f ------------------------------
		f.number AS 'COMPTE CODE',
		f.balance AS 'BALANCE',
		f.dateOuverture AS 'OPENDATE'
FROM tclient d  
		left join tclient_compte P1 
		   on d.idclient=P1.idclient
		left join tcompte f 
		   on P1.idcompte =f.idcompte
		left join ttypeCompte e 
		   on e.idtypeCompte=P1.idtypeCompte
		left join tagences a 
		   on a.idagences=d.idagences
		left join temploye b
		   on b.idagences=a.idagences
		left join temploye_area P2
		   on P2.idemploye=b.idemploye
		left join tarea c on c.codearea= P2.codearea


--SELECT * FROM viewAgences

-- =====================================================
-- Author:		Ricardo Mendoza
-- Create date: 24-03-2024
-- Description:	selectCompte
-- Décrit la notion de compte bancaire : 
-- elle contient le numéro du compte, 
-- le nom du titulaire et le solde du compte. 
-- Elle permet d'effectuer les opérations minimales sur un compte bancaire : 
		-- 1. consultation du solde, 
		-- 2. retirer une somme du compte, 
		-- 3. déposer une somme sur le compte.
-- 4.- viewCompte
-- =====================================================
USE [bdLaBanqueduQuebec]
GO
CREATE VIEW viewCompte
AS
SELECT 
	-- tclient b  ------------------------------
	CONCAT(CASE
			WHEN b.sexe ='M' THEN 'Mr'
			WHEN b.sexe ='F' THEN 'Mrs'
			END
			,'   ',b.nomdeFamille,'   ',b.nom) as TITULAIRE,	
	b.numerodeCarte AS 'CARTE NUMBER',
	-- tcompte a ------------------------------
	a.number AS 'COMPTE CODE', 
	a.balance AS 'BALANCE',
	-- ttypeCompte d --------------------------
	d.accountType AS 'ACCOUNT TYPE',
	d.interetImmediat AS 'INTEREST', -- PaidAccount
	d.commission AS 'COMISSION',   -- UnPaidAccount 
	d.decouvert AS 'OVERDRAFT'     -- UnPaidAccount 
	FROM tcompte a 
	left join tclient_compte c 
	on a.idcompte= c.idcompte
	left join tclient b
	on b.idclient = c.idclient
	left join ttypeCompte d
	on d.idtypeCompte=c.idtypeCompte

-- SELECT * FROM  [dbo].[viewCompte]

-- =====================================================
-- VIEWS
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Name : viewAgences
-- Description:	View agence FROM bdLaBanqueduQuebec
-- 5.- viewAgences_employee_Client
-- =====================================================
USE bdLaBanqueduQuebec
GO

CREATE VIEW viewAgences_employee_Client
AS
SELECT
		-- tagence  a ------------------------------
		a.number AS 'AGENCE CODE',
		CONCAT('Agence :','   ',a.nom) AS 'FILIAL AGENCE',
		a.adresse AS 'AGENCE ADDRESS',
		-- temploye b ------------------------------
		b.number AS [EMPLOYEE NUMBER],
		CONCAT(CASE
				WHEN b.sexe ='M' THEN 'Mr'
				WHEN b.sexe ='F' THEN 'Mrs'
				END,'   ',b.nomdeFamille, '   ', b.nom) AS EMPLOYEE,
		-- tarea c  ------------------------------
		c.codearea AS 'AREA CODE',
		c.description AS AREA,
		-- tclient d  ------------------------------
		d.number AS [CLIENT NUMBER],
		CONCAT(CASE
				WHEN d.sexe ='M' THEN 'Mr'
				WHEN d.sexe ='F' THEN 'Mrs'
				END,'   ',d.nomdeFamille, '   ', d.nom)  AS CLIENT  
FROM tclient d  
		left join tclient_compte P1 
		   on d.idclient=P1.idclient
		left join tcompte f 
		   on P1.idcompte =f.idcompte
		left join ttypeCompte e 
		   on e.idtypeCompte=P1.idtypeCompte
		left join tagences a 
		   on a.idagences=d.idagences
		left join temploye b
		   on b.idagences=a.idagences
		left join temploye_area P2
		   on P2.idemploye=b.idemploye
		left join tarea c on c.codearea= P2.codearea
		
-- =====================================================
-- VIEWS
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Name : viewLaBanqueduQuebec
-- Description:	View agence FROM bdLaBanqueduQuebec
-- 6.- viewLaBanqueduQuebec
-- =====================================================
USE [bdLaBanqueduQuebec]
GO

CREATE VIEW viewLaBanqueduQuebec
AS
	SELECT 
		-- tlabanqueduQuebec  a ------------------------------
		concat (a.number,'  ',a.nom) AS MATRIS,
		a.adresse AS DIRECTION,
		-- tagences  b ---------------------------------------
		concat (b.number,':  ',b.nom) AS AGENCE,
		b.adresse AS ADRESSE,
		-- tdirecteur  d -------------------------------------
		concat (CASE
				WHEN d.sexe ='M' THEN 'Mr'
				WHEN d.sexe ='F' THEN 'Mrs'
				END,'  ',d.nomdeFamille,'  ',d.nom) AS DIRECTEUR,
		-- temploye e ---------------------------------------- 
		CONCAT(CASE
				WHEN e.sexe ='M' THEN 'Mr'
				WHEN e.sexe ='F' THEN 'Mrs'
				END,'   ',e.nomdeFamille, '   ', e.nom) AS EMPLOYEE,
		-- tarea g -------------------------------------------- 
		CONCAT (g.codearea,':  ',g.description) AS AREA,
		-- tclient h ------------------------------------------
		CONCAT(h.number,':   ',
				CASE
				WHEN h.sexe ='M' THEN 'Mr'
				WHEN h.sexe ='F' THEN 'Mrs'
				END,'   ',h.nomdeFamille, '   ', h.nom) AS CLIENT,
		-- tcompte j ------------------------------------------
		j.number AS [ACCOUNT CODE],
		j.balance AS BALANCE,
		j.dateOuverture AS OUVERTURE,
		-- ttypeCompte k --------------------------------------		
		k.accountType AS ACCOUNT,
		k.commission AS COMMISSION,
		K.decouvert AS DECOUVERT,
		K.interetImmediat AS INTERET
	FROM [dbo].[tlabanqueduQuebec] a
		left join [dbo].[tagences] b
			on a.idbanque= b.idbanque
		left join  [dbo].[tdirecteur_agence] c
			on c.idagences=b.idagences
		left join tdirecteur d
			on d.iddirecteur=c.iddirecteur
		left join temploye e
			on e.idagences=b.idagences
		left join temploye_area f
			on f.idemploye=e.idemploye
		left join tarea g
			on g.codearea=f.codearea
		left join tclient h
			on h.idemploye=f.idemploye
		left join tclient_compte i
		   on i.idclient=h.idclient
		left join tcompte j
			on i.idcompte=j.idcompte
		left join ttypeCompte k
			on k.idtypeCompte=i.idtypeCompte

		--SELECT * FROM viewAgences

-- =====================================================
-- VIEWS
-- Author:		Ricardo Mendoza
-- Create date: 2025-01-26
-- Name : viewACCOUNT
-- Description:	viewACCOUNT
-- 6.- viewACCOUNT
-- =====================================================		
USE [bdLaBanqueduQuebec]
GO

CREATE VIEW viewACCOUNT
AS	
	SELECT
	    -- tclient h ------------------------------------------
		CONCAT(h.number,':   ',
				CASE
				WHEN h.sexe ='M' THEN 'Mr'
				WHEN h.sexe ='F' THEN 'Mrs'
				END,'   ',h.nomdeFamille, '   ', h.nom) AS CLIENT,
		-- tcompte j ------------------------------------------
		j.number AS [ACCOUNT CODE],
		j.balance AS BALANCE,
		j.dateOuverture AS OUVERTURE,
		-- ttypeCompte k --------------------------------------		
		k.accountType AS ACCOUNT,
		k.commission AS COMMISSION,
		K.decouvert AS DECOUVERT,
		K.interetImmediat AS INTERET	
	FROM 
	    tclient h
		left join tclient_compte i
		    on h.idclient=i.idclient
		left join tcompte j
            on j.idcompte = i.idcompte
        left join ttypeCompte k
            on k.idtypeCompte=i.idtypeCompte
			
		-- SELECT * FROM viewACCOUNT
		-- SELECT * FROM ttransaction
		-- select * from tclient
		-- select * from tcompte
		-- select * from ttype


