USE ROM

GO

IF OBJECT_ID('sProc_Aut_CadastroModificarSucursal','P') IS NOT NULL DROP PROC sProc_Aut_CadastroModificarSucursal
GO 

CREATE PROCEDURE [dbo].[sProc_Aut_CadastroModificarSucursal]  
AS 

BEGIN  

DECLARE  @intIdSucursal INT ,  
		 @sinCodCarteraCompra smallint,  
		 @vchNombre varchar(50),  
		 @vchCuit varchar(30),  
		 @vchLocalidad varchar(80),  
		 @vchProvincia varchar(80),  
		 @intCodProvincia INTEGER,  
		 @sinCodOrigen smallint,  
		 @vchIdEnOrigen varchar(50),  
		 @vchDireccion varchar(150),  
		 @vchTelefono varchar(50),
		 @bitActivo BIT
		
 declare @Cursor cursor 
 set @Cursor = cursor FAST_FORWARD read_only FOR
               SELECT 
			       TS.intIdSucursal,
				   TS.sinCodCarteraCompra,
				   TS.vchNombre,
				   TS.vchCuit, 
				   TS.vchLocalidad,
				   TS.vchProvincia,
				   TS.intCodProvincia, 
				   TS.sinCodOrigen,
				   TS.vchIdEnOrigen,
				   TS.vchDireccion,
				   TS.vchTelefono,   
				   TS.bitActivo		   
			   FROM tblTMP_Sucursal TS
  open @Cursor  
  fetch next from @Cursor into  @intIdSucursal,   
								@sinCodCarteraCompra ,
								@vchNombre,  
								@vchCuit,  
								@vchLocalidad,  
								@vchProvincia,  
								@intCodProvincia,  
								@sinCodOrigen,  
								@vchIdEnOrigen,  
								@vchDireccion,  
								@vchTelefono,
								@bitActivo  
  
 while (@@FETCH_STATUS=0)  
 begin  

        IF @sinCodOrigen = 0 BEGIN
		    SELECT top(1)
		       @sinCodOrigen = sinCodOrigenDato
		    from tblOrigenDato 
		     WHERE 
		        sincodcarteracompra = @sinCodCarteraCompra and
		        bitActivo = 1
		END

IF (@intIdSucursal = 0 OR @intIdSucursal IS NULL) BEGIN  

 --SELECT * FROM #tblSucursal
   INSERT INTO tblSucursal  
      (sinCodCarteraCompra  
      ,vchNombre  
      ,vchLocalidad  
      ,vchProvincia  
      ,intCodProvincia  
      ,sinCodOrigen  
      ,vchIdEnOrigen  
      ,vchDireccion  
      ,vchTelefono  
      ,vchCuit  
      ,dtmFechaUltMod  
      ,bitActivo)  
   VALUES  
      (@sinCodCarteraCompra  
      ,@vchNombre  
      ,@vchLocalidad  
      ,@vchProvincia  
      ,@intCodProvincia  
      ,@sinCodOrigen  
      ,@vchIdEnOrigen  
      ,@vchDireccion  
      ,@vchTelefono  
      ,@vchCuit  
      ,GETDATE()  
      ,1)  
        
  --SET @intIdSucursal = SCOPE_IDENTITY()      
             
END ELSE BEGIN  
           
 UPDATE tblSucursal  
    SET sinCodCarteraCompra = @sinCodCarteraCompra  
    ,vchNombre = @vchNombre  
    ,vchLocalidad = @vchLocalidad  
    ,vchProvincia = @vchProvincia  
    ,sinCodOrigen = @sinCodOrigen  
    ,vchIdEnOrigen = @vchIdEnOrigen  
    ,vchDireccion = @vchDireccion  
    ,vchTelefono = @vchTelefono  
    ,vchCuit = @vchCuit  
    ,dtmFechaUltMod = GETDATE()  
    ,intCodProvincia = @intCodProvincia  
  WHERE   
  intIdSucursal = @intIdSucursal  

 END  

  fetch next from @Cursor into @intIdSucursal,   
							   @sinCodCarteraCompra ,
							   @vchNombre,  
  							   @vchCuit,  
 			                   @vchLocalidad,  
   		                       @vchProvincia,  
 							   @intCodProvincia,  
							   @sinCodOrigen,  
							   @vchIdEnOrigen,  
							   @vchDireccion,  
							   @vchTelefono,
  							   @bitActivo  
end
close @Cursor
deallocate @Cursor

end

 