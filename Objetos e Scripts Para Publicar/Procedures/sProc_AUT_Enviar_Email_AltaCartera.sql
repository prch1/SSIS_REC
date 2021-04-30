USE ORIGEN

go

IF OBJECT_ID('sProc_AUT_Enviar_Email_AltaCartera') IS NOT NULL DROP PROC dbo.sProc_AUT_Enviar_Email_AltaCartera 

GO

CREATE PROCEDURE dbo.sProc_AUT_Enviar_Email_AltaCartera

AS

begin 

  DECLARE         
    @vchBody NVARCHAR(MAX)   
   ,@vchBodyPlantilla NVARCHAR(MAX)
   ,@vchFila NVARCHAR(MAX) = ''         
   ,@vchSubject NVARCHAR(MAX)            
   ,@vchTo NVARCHAR(MAX) = ''            
   ,@vchCC NVARCHAR(MAX) = ''
   ,@vchFilaTabela NVARCHAR(MAX) = '' 
   ,@vchFilaTotal NVARCHAR(MAX) = ''  
   ,@bEnvia as bit = 0 

   DECLARE @intIdAutCartera INT,
           @vchPath VARCHAR(200),
		   @vchLote VARCHAR(20),
		   @intQuantidade INT,
		   @vchDestinoEmail VARCHAR(300),
		   @vchUsuario VARCHAR(20),
		   @dtmFechaUltMod DATETIME,
		   @bitEnvio BIT

       SELECT       
             @vchSubject =  qp.vchSubject,
             @vchBodyPlantilla =   qp.vchBody
        FROM Rom..tblEMailsQueuePlantilla (NOLOCK) qp
		where qp.intIdEMailsQueuePlantilla = 67

  declare @Cursor cursor 
  set @Cursor = cursor FAST_FORWARD read_only FOR
               SELECT 
			       ac.intIdAutCartera,
				   ac.vchPath,
				   ac.vchLote,
				   ac.intIdQuantidade,
				   ac.vchDestinoEmail,
				   ac.vchUsuario,
				   ac.dtmFechaUltMod ,
				   ac.bitEnvio
			   FROM origen..tblAUTCarteraEmail ac WHERE ac.bitEnvio = 0
  open @Cursor  
  fetch next from @Cursor into  @intIdAutCartera,   
								@vchPath ,
								@vchLote,  
								@intQuantidade,  
								@vchDestinoEmail, 
								@vchUsuario ,
								@dtmFechaUltMod,
								@bitEnvio
 WHILE (@@FETCH_STATUS=0)  
 BEGIN  

    SET @vchFila = '';

    SELECT   @vchFila = @vchFila + CONCAT (
		    '<tr style="text-align: center; vertical-align: middle;"><td>' 
		    ,@vchPath
		    ,'</td><td>' 
		    ,@vchLote
		    ,'</td><td>' 
		    ,@intQuantidade
	    	,'</td></tr>'
		    )    
	
	 SET @vchFilaTabela += @vchFila;  
	 SET @vchTo = @vchDestinoEmail;

	 SET @bEnvia =  1;
   			
fetch next from @Cursor into @intIdAutCartera,
							 @vchPath ,
							 @vchLote,  
 			                 @intQuantidade,  
   		                     @vchDestinoEmail,
 							 @vchUsuario ,
							 @dtmFechaUltMod,
							 @bitEnvio
							 						  
END

close @Cursor
deallocate @Cursor
       
   SET @vchFilaTotal = '<table border="1">
						 <tr style="background-color:#00b7ff">
						   <td>Caminho</td>
						   <td>Lote</td>
						   <td>Quantidade</td>
						 </tr>' 
						 +  @vchFilaTabela +
						 '</table>' 

	SET @vchBody =  @vchBodyPlantilla + '</br ></br >  
	                                     Att : </br ></br >  
										 Grupo Recovery';

	SET @vchBody = REPLACE(@vchBody, '<%Mensagem%>', @vchFilaTotal);  

	--  SELECT @vchBody   
	--  SELECT @vchTo
	--  SELECT  @vchFilaTotal 			
	--  SELECT  @vchSubject	
	--  SELECT  @vchBodyPlantilla

	--EXEC Rom..sProc_MailService_EmailQueue_Add   
 --          @vchProfile = 'no-reply'--BRASIL     
 --         ,@vchFrom = 'no-reply@gruporecovery.com'            
 --         ,@vchTo = @vchTo            
 --         ,@vchCC = @vchCC            
 --         ,@vchBCC = ''            
 --         ,@vchSubject = @vchSubject            
 --         ,@vchBody = @vchBody;   


		 if (@bEnvia = 1)
		 BEGIN
		 			   
			EXEC msdb.dbo.sp_send_dbmail
					@recipients =  @vchTo, --'phoracio@gruporecovery.com', /*  @vchTo,*/
					@copy_recipients= '',    --N'infraestrutura@gruporecovery.com;dtamaral@gruporecovery.com; dba-br@gruporecovery.com',
					@subject= @vchSubject,   -- @subject,
					@profile_name= 'no-reply',
					@body= @vchBody,        --@CORPO_EMAIL ,
					@body_format = 'HTML'
		
			  UPDATE origen..tblAUTCarteraEmail
				   SET bitEnvio = 1,
				       dtmFechaUltMod = GETDATE()
		
				--select * from msdb..sysmail_allitems
				--order by 1 desc
		END
END

/*
       SELECT * FROM  origen..tblAUTCarteraEmail 

	   UPDATE origen..tblAUTCarteraEmail
	   SET bitEnvio = 0

	   TRUNCATE TABLE origen..tblAUTCarteraEmail

*/

	