-- This project uses the following licenses:
-- MIT License
-- Copyright (c) 2024 Ricardo Alfredo Mendoza Cortes 
-- Montréal Québec Canada

-- Repository : MVC_winapp_NationalBank_SqlServer > https://github.com/RicardoAMendoza/MVC_winapp_NationalBank_SqlServer.git
-- Project : prjWeb_MVC_LaBanquenationale_Rm
-- Instruction :
-- Copy and paste on SqlServer script and run it. That will create de data base

USE bdLaBanqueduQuebec
GO

--DROP DATABASE bdLaBanqueduQuebec

-- -----------------------------------------------------
-- Drop Tables 
-- -----------------------------------------------------
USE bdLaBanqueduQuebec
GO

-- 1.
DROP TABLE tconseil
-- 2.
DROP TABLE temploye_area
-- 3.
DROP TABLE tarea
-- 4.
DROP TABLE ttransaction
-- 5.
DROP TABLE tclient_compte
-- 6.
DROP TABLE tcompte
-- 7.
DROP TABLE ttypeCompte
-- 8.
DROP TABLE tclient
-- 9.
DROP TABLE temploye
-- 10.
DROP TABLE tadmin
-- 11.
DROP TABLE [dbo].[tdirecteur_agence]
-- 12.
DROP TABLE tdirecteur
-- 13.
DROP TABLE tagences
-- 14.
DROP TABLE tlabanqueduQuebec

-- -----------------------------------------------------
-- DROP PROCEDURE 
-- -----------------------------------------------------
USE bdLaBanqueduQuebec
GO
-- =====================================================
-- Stored Procedures for Data
-- =====================================================
-- 1.
DROP PROCEDURE sp_save_tlabanqueduQuebec
-- 2.
DROP PROCEDURE sp_save_tconseil
-- 3.
DROP PROCEDURE sp_save_tdirecteur
-- 4.
DROP PROCEDURE sp_save_tagences
-- 5.
DROP PROCEDURE sp_save_tdirecteur_agences
-- 6.
DROP PROCEDURE sp_save_tarea
-- 7.
DROP PROCEDURE sp_save_temploye
-- 8.
DROP PROCEDURE sp_save_temploye_area
-- 9.
DROP PROCEDURE sp_save_tclient
-- 10.
DROP PROCEDURE sp_save_tcompte
-- 11.
DROP PROCEDURE sp_save_ttypeCompte
-- 12.
DROP PROCEDURE sp_save_tclient_compte
-- 13.
DROP PROCEDURE[dbo].[sp_save_tadmin]
-- =====================================================
-- Special Stored Procedures
-- =====================================================
-- 1.
DROP PROCEDURE [dbo].[selectAdmin]
-- 2.
DROP PROCEDURE [dbo].[selectConseil]
-- 3.
DROP PROCEDURE [dbo].[selectDirecteur]
-- 4.
DROP PROCEDURE [dbo].[selectEmploye]
-- 5.
DROP PROCEDURE [dbo].[selectClient]
-- 6.
DROP PROCEDURE [dbo].[selectClientByCondition]
-- 7.
DROP PROCEDURE [dbo].[selectClientbyNameandAccountType]
-- 8.
DROP PROCEDURE [dbo].[selectClientbyNumber]
-- 9.
DROP PROCEDURE findAgenceByNumberClientNumberAndCompte
-- 10.
DROP PROCEDURE [dbo].[selectqClientByNumber]
-- 11.
DROP PROCEDURE [dbo].[sp_AccountTransaction]
-- 12.
DROP PROCEDURE [dbo].[sp_transaction_fpadepotdArgent]
-- 13.
DROP PROCEDURE [dbo].[sp_transaction_fparetraitsdArgent]
-- 14.
DROP PROCEDURE [dbo].[sp_transaction_fuadepotdArgent]
-- 15.
DROP PROCEDURE [dbo].[sp_transaction_fuaretraitsdArgent]
-- =====================================================
-- Transaction Stored Procedures
-- =====================================================
USE bdLaBanqueduQuebec
GO
DROP PROCEDURE sp_AccountTransaction

-- -----------------------------------------------------
-- Drop Views 
-- -----------------------------------------------------
USE bdLaBanqueduQuebec
GO
-- 1.
drop view [dbo].[viewClient]
-- 2.
drop view [dbo].[viewClientComptes]
-- 3.
drop view [dbo].[viewAgences]
-- 4.
drop view [dbo].[viewCompte]
-- 5.
drop VIEW viewAgences_employee_Client
-- 6.
drop view viewLaBanqueduQuebec
-- 7.
drop view [dbo].[viewACCOUNT]

-- -----------------------------------------------------
-- Drop Types 
-- -----------------------------------------------------
USE bdLaBanqueduQuebec
GO
-- 1.
DROP TYPE tv100
-- 2.
DROP TYPE tv3
-- 3.
DROP TYPE tv1
-- 4.
DROP TYPE tmoney

-- -----------------------------------------------------
-- Drop Functions 
-- -----------------------------------------------------

-- 1.
DROP FUNCTION [dbo].[fpadepotdArgent]
-- 2.
DROP FUNCTION [dbo].[fparetraitsdArgent]
-- 3.
DROP FUNCTION [dbo].[fuadepotdArgent]
-- 4.
DROP FUNCTION [dbo].[fuaretraitsdArgent]
