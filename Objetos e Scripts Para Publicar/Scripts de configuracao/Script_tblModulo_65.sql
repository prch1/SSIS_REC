USE ROM
GO

--SELECT 
--                *
--FROM ROM.dbo.tblModulo WITH (NOLOCK)
--ORDER BY sinIdModulo ASC

BEGIN TRANSACTION

INSERT INTO dbo.tblModulo
           (vchDescripcion
           ,bitActivo
           ,dtmFechaUltMod
           ,vchMailBody
           ,vchPathFisico
           ,vchPathVirtual
           ,intCantMinParaEncolar
           ,vchPath2)
     VALUES
           ('TakeOver_AltaCarteira',
             1,
            GETDATE(),
            ' ',
            '\\dev-sir.gruporecovery.com\upload\Aquisicoes\hml',
            '',
            0,
            '\\dev-sir.gruporecovery.com\upload\Aquisicoes\hml')
GO

COMMIT

--UPDATE tblModulo
-- SET vchPathFisico ='\\RECSP-SRV-DSQL1.fcrecovery.com.ar\DADOS\TKO-AltaCarteira',
--     vchPathVirtual ='\\RECSP-SRV-DSQL1.fcrecovery.com.ar\DADOS\TKO-AltaCarteira',
--	 vchPath2 ='\\RECSP-SRV-DSQL1.fcrecovery.com.ar\DADOS\TKO-AltaCarteira'
--WHERE
--   sinIdModulo = 65


--ROLLBACK
--DBCC CHECKIDENT ('tblModulo', RESEED, 64);  
