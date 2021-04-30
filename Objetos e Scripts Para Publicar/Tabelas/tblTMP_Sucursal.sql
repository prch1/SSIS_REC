USE [ROM]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTMP_Sucursal](
	[intIdSucursal] [int] NULL,
	[sinCodCarteraCompra] [smallint] NOT NULL,
	[vchCuit] [varchar](30) NULL,
	[vchNombre] [varchar](50) NOT NULL,
	[vchDireccion] [varchar](150) NULL,
	[vchLocalidad] [varchar](80) NULL,
	[vchProvincia] [varchar](80) NULL,
	[vchTelefono] [varchar](50) NULL,
	[sinCodOrigen] [smallint] NULL,
	[vchIdEnOrigen] [varchar](50) NULL,
	[dtmFechaUltMod] [datetime] NULL,
	[bitActivo] [bit] NULL,
	[intCodProvincia] [int] NULL)
	WITH (DATA_COMPRESSION = PAGE) 
 

