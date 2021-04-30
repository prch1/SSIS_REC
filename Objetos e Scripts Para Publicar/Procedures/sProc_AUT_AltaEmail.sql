USE ORIGEN

GO

IF OBJECT_ID('sProc_AUT_AltaEmail','P') IS NOT NULL DROP PROC dbo.sProc_AUT_AltaEmail

GO

CREATE PROCEDURE dbo.sProc_AUT_AltaEmail  
(                
 @vchPath VARCHAR(200),   
 @vchLote varchar(20),       
 @intQtd int,
 @vchDestinoEmail varchar(300)      
)
AS  

DECLARE @vchUsuario VARCHAR(20),
        @dtmFechaUltMod DATETIME,
		@bitEnvio BIT

SET @vchUsuario = 'sistemas'
SET @dtmFechaUltMod = GETDATE()
SET @bitEnvio = 0


INSERT INTO dbo.tblAUTCarteraEmail
           (vchPath
           ,vchLote
           ,intIdQuantidade
		   ,vchDestinoEmail
           ,vchUsuario
           ,dtmFechaUltMod
		   ,bitEnvio)
     VALUES
           (@vchPath,
           @vchLote,
           @intQtd,
		   @vchDestinoEmail,
           @vchUsuario,
           @dtmFechaUltMod,
		   @bitEnvio)
GO










  
  
  
  