--job de respaldo full

USE msdb;
GO

EXEC dbo.sp_add_job
    @job_name = N'Backup_Full_DBGimnasio',
    @enabled = 1,
    @description = N'Respaldo completo semanal de DBGimnasio';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'Backup_Full_DBGimnasio',
    @step_name = N'Respaldo Full',
    @subsystem = N'TSQL',
    @database_name = N'master',
    @command = N'
DECLARE @Archivo NVARCHAR(400);

SET @Archivo = ''/var/opt/mssql/data/DBGimnasio_Full_''
    + CONVERT(VARCHAR(8), GETDATE(), 112) + ''_''
    + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), '':'', '''')
    + ''.bak'';

BACKUP DATABASE DBGimnasio
TO DISK = @Archivo
WITH COMPRESSION, STATS = 10;';
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'Horario_Full_DBGimnasio',
    @freq_type = 8,
    @freq_interval = 1,
    @active_start_time = 000000;
GO

EXEC dbo.sp_attach_schedule
    @job_name = N'Backup_Full_DBGimnasio',
    @schedule_name = N'Horario_Full_DBGimnasio';
GO

EXEC dbo.sp_add_jobserver
    @job_name = N'Backup_Full_DBGimnasio';
GO


--job de respaldo diferencial

USE msdb;
GO

EXEC dbo.sp_add_job
    @job_name = N'Backup_Differential_DBGimnasio',
    @enabled = 1,
    @description = N'Respaldo diferencial diario de DBGimnasio';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'Backup_Differential_DBGimnasio',
    @step_name = N'Respaldo Differential',
    @subsystem = N'TSQL',
    @database_name = N'master',
    @command = N'
DECLARE @Archivo NVARCHAR(400);

SET @Archivo = ''/var/opt/mssql/data/DBGimnasio_Differential_''
    + CONVERT(VARCHAR(8), GETDATE(), 112) + ''_''
    + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), '':'', '''')
    + ''.bak'';

BACKUP DATABASE DBGimnasio
TO DISK = @Archivo
WITH DIFFERENTIAL, COMPRESSION, STATS = 10;';
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'Horario_Differential_DBGimnasio',
    @freq_type = 4,
    @freq_interval = 1,
    @active_start_time = 120000;
GO

EXEC dbo.sp_attach_schedule
    @job_name = N'Backup_Differential_DBGimnasio',
    @schedule_name = N'Horario_Differential_DBGimnasio';
GO

EXEC dbo.sp_add_jobserver
    @job_name = N'Backup_Differential_DBGimnasio';
GO

--job de respaldo de registro

USE msdb;
GO

EXEC dbo.sp_add_job
    @job_name = N'Backup_Log_DBGimnasio',
    @enabled = 1,
    @description = N'Respaldo del registro de transacciones cada 6 horas';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'Backup_Log_DBGimnasio',
    @step_name = N'Respaldo Transaction Log',
    @subsystem = N'TSQL',
    @database_name = N'master',
    @command = N'
DECLARE @Archivo NVARCHAR(400);

SET @Archivo = ''/var/opt/mssql/data/DBGimnasio_Log_''
    + CONVERT(VARCHAR(8), GETDATE(), 112) + ''_''
    + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), '':'', '''')
    + ''.trn'';

BACKUP LOG DBGimnasio
TO DISK = @Archivo
WITH COMPRESSION, STATS = 10;';
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'Horario_Log_DBGimnasio',
    @freq_type = 4,
    @freq_interval = 1,
    @freq_subday_type = 8,
    @freq_subday_interval = 6,
    @active_start_time = 000000;
GO

EXEC dbo.sp_attach_schedule
    @job_name = N'Backup_Log_DBGimnasio',
    @schedule_name = N'Horario_Log_DBGimnasio';
GO

EXEC dbo.sp_add_jobserver
    @job_name = N'Backup_Log_DBGimnasio';
GO