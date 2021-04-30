USE ROM
GO
/*

SELECT * FROM tblEMailsQueuePlantillaTIPO ORDER BY intIdEMailsQueuePlantillaTipo ASC
-- 33	Transferencia automatica de archivos

SELECT * FROM .tblEMailsQueuePlantilla
*/
BEGIN TRANSACTION

INSERT INTO dbo.tblEMailsQueuePlantilla
           (vchDescripcion
           ,intIdEMailsQueuePlantillaTipo
           ,vchSubject
           ,vchBody
           ,bitActivo
           ,dtmFechaUltMod
           ,vchCodUsuario)
     VALUES
           ('AUT - CargaCartera',
           33, 
           'Aviso Processamento AUT Alta Cartera', 
           '<p>          Prezados,
            <br />         
            <br />            
            </p> 
            Segue Resultado do Processamento .   
            <br />         
            <br />          
            <%Mensagem%> ',
           1, 
           GETDATE(), 
           'prhoracio')
GO

COMMIT
