USE ORIGEN

GO

IF OBJECT_ID('sProc_Inserir_Log_AUT_AltaCarteira','P') IS NOT NULL DROP PROC sProc_Inserir_Log_AUT_AltaCarteira

GO
 
CREATE procedure [dbo].[sProc_Inserir_Log_AUT_AltaCarteira]        
(        
 @vchEtapa VARCHAR(100),         
 @descripcion VARCHAR(200),   
 @idQuantidade int,       
 @bitError BIT       
)   
       
AS        
      
DECLARE @DESCRICAO VARCHAR(200)  

SET @bitError = 0;  
  
  IF @vchEtapa LIKE '%Inicio%'
  begin
  
    SET @DESCRICAO = @vchEtapa + ' - ' +    
                     @descripcion;
  end
  ELSE
  BEGIN
  SET @DESCRICAO = @vchEtapa + ' - ' +    
                   @descripcion  + ' - ' +   
                  'Quantidade' + ' - ' +  
                  Convert(varchar(10),@idQuantidade);  
  END
    
  EXEC origen..SProc_tblProcesoLog_Insert    
         @intIdProceso = 46,    
         @vchDescripcion = @DESCRICAO ,   
         @bitError = @bitError  
            
			
			
			    