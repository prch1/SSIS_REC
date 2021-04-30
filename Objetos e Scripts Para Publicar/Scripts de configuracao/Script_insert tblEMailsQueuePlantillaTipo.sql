USE ROM
GO

--SELECT * FROM tblEMailsQueuePlantillaTIPO ORDER BY intIdEMailsQueuePlantillaTipo ASC
-- 2	Transferencia automatica de archivos

BEGIN TRANSACTION

INSERT INTO dbo.tblEMailsQueuePlantillaTipo
           (vchDescripcion
           ,bitActivo
           ,dtmFechaUltMod
           ,vchCodUsuario)
     VALUES
           ('Carga Alta Cartera',
           1,
           GETDATE(),
           'sistemas')
GO

COMMIT


