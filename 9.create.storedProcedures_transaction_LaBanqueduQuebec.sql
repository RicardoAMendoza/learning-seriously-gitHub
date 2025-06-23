

	
-- consultation du solde,            -- consultation
-- retirer une somme du compte,      -- retirer
-- déposer une somme sur le compte.  -- deposer
--USE bdLaBanqueduQuebec
--GO
DROP PROCEDURE sp_AccountTransaction

USE bdLaBanqueduQuebec
GO
CREATE PROCEDURE sp_AccountTransaction
	 @aidcompte int= null,
	 @aidtypeCompte int =null,
	 @anumber [dbo].[tv100]= null,
	 ----------------------------------------------------------
	 @adepot money = null,
	 @aretrait money = null,
	 -- OPERATION ---------------------------------------------
	 @aoperation [dbo].[tv100]= null
AS BEGIN
    DECLARE @abalance money;
	DECLARE @aresult money;
	DECLARE @ainteretImmediat float;
		SET @abalance = (SELECT balance FROM tcompte WHERE [dbo].[tcompte].idcompte = @aidcompte)
		            -- ANALYSIS                                                  @aidcompte
		             --SELECT balance FROM tcompte WHERE [dbo].[tcompte].idcompte = 100
		SET @ainteretImmediat = (SELECT [interetImmediat] FROM [dbo].[ttypeCompte] WHERE [idtypeCompte] = @aidtypeCompte)
		            -- ANALYSIS                                                               @aidtypeCompte
		            -- SELECT [interetImmediat] FROM [dbo].[ttypeCompte] WHERE [idtypeCompte] = 10
			-- PaidAccount 
			IF @anumber like 'PA'+'%' 
			-- IF @anumber = 'PA1PA1'
				IF @aoperation = 'retirer'
					 SET @aresult = [dbo].[fparetraitsdArgent](@aretrait , @abalance)		
				IF @aoperation = 'deposer'
					 SET @aresult = [dbo].[fpadepotdArgent](@adepot , @abalance, @ainteretImmediat)
				IF @aoperation = 'consultation'	 
					SET @aresult = @abalance
            -- UnPaidAccount
			IF @anumber like 'UA'+'%'	
			-- IF @anumber ='UA1UA1'
			      -- ANALYSIS
		           --SELECT * FROM tcompte WHERE number  like 'UA'+'%'
				  -- WHERE h.number like @aclientNumber + '%'
				   --SELECT * FROM tcompte WHERE number = 'UA1UA1'
				IF @aoperation = 'retirer'
					 SET @aresult = [dbo].[fuaretraitsdArgent](@aretrait , @abalance, @aidtypeCompte)
                  -- ANALYSIS
				   --SET @aresult = [dbo].[fuaretraitsdArgent](1000 , 3500, 100)
				   --SELECT [dbo].[fuaretraitsdArgent](1000 , 3500, 100)
				IF @aoperation = 'deposer'
					 SET @aresult = [dbo].[fuadepotdArgent](@adepot , @abalance)	
				IF @aoperation = 'consultation'	
					 SET @aresult = @abalance
	IF @aidcompte=0
		INSERT INTO tcompte(balance)
		VALUES (@adepot)
	ELSE
		UPDATE tcompte SET deposer=@adepot WHERE idcompte=@aidcompte
		UPDATE tcompte SET retirer=@aretrait WHERE idcompte=@aidcompte
		UPDATE tcompte SET balance=@aresult WHERE idcompte=@aidcompte
		UPDATE tcompte SET dateOperation = CONVERT(NVARCHAR, GETDATE(), 0) WHERE idcompte=@aidcompte
	SELECT
	    -- tclient h ------------------------------------------
		h.number AS [CLIENT CODE],
		CONCAT(
				CASE
				WHEN h.sexe ='M' THEN 'Mr'
				WHEN h.sexe ='F' THEN 'Mrs'
				END,'   ',h.nomdeFamille, '   ', h.nom) AS CLIENT,
        h.nip AS NIP,
		h.numerodeCarte AS CARTE,
		-- ttypeCompte k --------------------------------------		
		k.accountType AS ACCOUNT,
		-- tcompte j ------------------------------------------
		j.number AS [ACCOUNT CODE],
		j.dateOperation AS 'DATE dOPÉRATION',
		j.deposer AS 'MONTANT DÉPOSÉ',
		j.retirer AS 'MONTANT RETIRÉ',
		j.balance AS SOLDE
	FROM 
	    tclient h
		left join tclient_compte i
		    on h.idclient=i.idclient
		left join tcompte j
            on j.idcompte = i.idcompte
        left join ttypeCompte k
            on k.idtypeCompte=i.idtypeCompte
	WHERE j.idcompte=@aidcompte and j.number=@anumber
	-- INSERT INTO ttransaction ---------------------------
	INSERT INTO ttransaction(idcompte,[CLIENT CODE],CLIENT,NIP,SEXE,AGE,CARTE,AGENCES,[ACCOUNT TYPE],NUMBER,
				-- OPERATION ----------------------------------
				deposer,retirer,BALANCE,
				COMMISSION,DECOUVERT,INTERET,DATE)
				-----------------------------------------------
		SELECT
		-- tcompte j ------------------------------------------
		j.idcompte,
		-- tclient h ------------------------------------------
		h.number AS [CLIENT CODE],
		CONCAT(
				CASE
				WHEN h.sexe ='M' THEN 'Mr'
				WHEN h.sexe ='F' THEN 'Mrs'
				END,'   ',h.nomdeFamille, '   ', h.nom) AS CLIENT,
		h.nip AS NIP,
		h.sexe AS SEXE,
		h.age AS AGE,
		h.numerodeCarte AS CARTE,
        -- tagences  b ---------------------------------------
		concat (b.number,':  ',b.nom,'  ',b.adresse) AS AGENCES,		
		-- ttypeCompte k --------------------------------------		
		k.accountType AS [ACCOUNT TYPE],
		-- tcompte j ------------------------------------------
		j.number AS NUMBER,
		j.deposer,
		j.retirer,
		j.balance AS BALANCE,
		-- ttypeCompte k --------------------------------------		
		k.commission AS COMMISSION,
		k.decouvert AS DECOUVERT,
		k.interetImmediat AS [INTERET],
	   CONVERT(NVARCHAR, GETDATE(), 0)
	FROM 
	    tagences b 
		left join tclient h
			on b.idagences=h.idagences
		left join tclient_compte i
		    on h.idclient=i.idclient
		left join tcompte j
            on j.idcompte = i.idcompte
        left join ttypeCompte k
            on k.idtypeCompte=i.idtypeCompte
	WHERE j.idcompte=@aidcompte and j.number=@anumber
	
	-- NO FUNCIONAN LOS UPDATES CAMBIAR LA FORMA DE ACTUALIZAR LOS CAMPOS Y AGREGARLOS A LA TABLA TRANSACCION
	 --UPDATE ttransaction SET deposer = @adepot WHERE [dbo].[ttransaction].idcompte=@aidcompte
	 --UPDATE ttransaction SET retirer = @aretrait WHERE [dbo].[ttransaction].idcompte=@aidcompte	
	SELECT * FROM ttransaction
END
GO 

 SELECT * FROM ttransaction
 
 SELECT * FROM tclient
 select * from ttypeCompte
 select * from tcompte
 SELECT * FROM ttransaction

 EXEC sp_AccountTransaction
 @aidcompte =100,
 @aidtypeCompte = 20,
 @anumber ='PA5PA5',
 @adepot = 100000,
 @aretrait=0,
 @aoperation ='deposer'

 EXEC sp_AccountTransaction
 @aidcompte =100,
 @aidtypeCompte = 20,
 @anumber ='PA5PA5',
 @adepot = 0,
 @aretrait=789,
 @aoperation ='retirer'

 EXEC sp_AccountTransaction
 @aidcompte =100,
 @aidtypeCompte = 20,
 @anumber ='PA5PA5',
 @adepot = 0,
 @aretrait=0,
 @aoperation ='consultation'

-----------------------------------------------------------------------------------------
-- UNPAID ACCOUNT
-----------------------------------------------------------------------------------------
 EXEC sp_AccountTransaction
 @aidcompte =70,
 @aidtypeCompte = 10,
 @anumber ='UA4UA4',
 @adepot = 100000,
 @aretrait=0,
 @aoperation ='deposer'

 EXEC sp_AccountTransaction
 @aidcompte =70,
 @aidtypeCompte = 10,
 @anumber ='UA4UA4',
 @adepot = 0,
 @aretrait=100000,
 @aoperation ='retirer'

 EXEC sp_AccountTransaction
 @aidcompte =70,
 @aidtypeCompte = 10,
 @anumber ='UA4UA4',
 @adepot = 0,
 @aretrait=0,
 @aoperation ='consultation'

--------------------------------------
 EXEC sp_AccountTransaction
 @aidcompte =80,
 @aidtypeCompte = 20,
 @anumber ='PA4PA4',
 @adepot = 0,
 @aretrait=1000,
 @aoperation ='deposer'

 EXEC sp_AccountTransaction
 @aidcompte =80,
 @aidtypeCompte = 20,
 @anumber ='PA4PA4',
 @adepot = 0,
 @aretrait=1000,
 @aoperation ='retirer'

 EXEC sp_AccountTransaction
 @aidcompte =80,
 @aidtypeCompte = 20,
 @anumber ='PA4PA4',
 @adepot = 0,
 @aretrait=0,
 @aoperation ='consultation'

  -- select * from tcompte
 -- update tcompte set balance =3500 where idcompte = 121
--------------------------------------

 EXEC sp_AccountTransaction
 @aidcompte =142,
 @aidtypeCompte = 10,
 @anumber ='UA8UA8',
 @adepot = 100000,
 @aretrait=0,
 @aoperation ='deposer'

 EXEC sp_AccountTransaction
 @aidcompte =142,
 @aidtypeCompte = 10,
 @anumber ='UA8UA8',
 @adepot = 0,
 @aretrait=100000,
 @aoperation ='retirer'

 EXEC sp_AccountTransaction
 @aidcompte =142,
 @aidtypeCompte = 10,
 @anumber ='UA8UA8',
 @adepot = 0,
 @aretrait=0,
 @aoperation ='consultation'

 -- select * from ttransaction
 -- select * from tcompte
 -- update tcompte set balance =3500 where idcompte = 121
			
	