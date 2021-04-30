USE ORIGEN
GO

/*SELECT TOP(10) * FROM [tblProceso]*/

BEGIN TRAN

INSERT INTO tblProceso
           (intIdProceso
           ,vchDescripcion
           ,bitActivo
           ,dtmFechaUltMod
           ,vchCodUsuarioUltMod
           ,dtmFechaAlta
           ,vchCodUsuarioAlta
           ,dtmFechaBaja
           ,vchCodUsuarioBaja)
     VALUES
           (46,
           'AUT Alta Carteira',
           1,
           GETDATE(),
           'sistemas',
           GETDATE(),
           'phoracio',
           NULL,
           NULL)
GO

COMMIT