USE [ORIGEN]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE IF EXISTS dbo.tblAUTCarteraEmail

CREATE TABLE dbo.tblAUTCarteraEmail
(
	intIdAutCartera INT IDENTITY(1,1) NOT NULL,
	vchPath VARCHAR(500),
	vchLote varchar(100), 
	intIdQuantidade INT,
	vchDestinoEmail varchar(300),
	vchUsuario varchar(50),
	dtmFechaUltMod datetime,
	bitEnvio bit
)    

WITH (DATA_COMPRESSION = PAGE)
