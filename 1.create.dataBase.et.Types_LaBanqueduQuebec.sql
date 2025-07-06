-- This project uses the following licenses:
-- MIT License
-- Copyright (c) 2024 Ricardo Alfredo Mendoza Cortes 
-- Montréal Québec Canada

-- Repository : MVC_winapp_NationalBank_SqlServer > https://github.com/RicardoAMendoza/MVC_winapp_NationalBank_SqlServer.git
-- Project : prjWeb_MVC_LaBanquenationale_Rm
-- Instruction :
-- Copy and paste on SqlServer script and run it. That will create de data base

use master
go
  -- BUG HAS BENN FIXED ALONG WITH ANOTHER BUG
-- -----------------------------------------------------
-- Data base 
-- -----------------------------------------------------
--create database bdLaBanqueduQuebec
--go

-- -----------------------------------------------------
-- Create Types 
-- -----------------------------------------------------
use bdLaBanqueduQuebec
go

create type tv100 from VARCHAR(100) NULL
create type tmoney from money NULL
create type tv3 from VARCHAR(3) NULL
create type tv1 from VARCHAR(1) NULL


