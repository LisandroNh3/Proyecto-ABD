
USE master;
GO

--Restaurar respaldo FULL
ALTER DATABASE DBGimnasio
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

RESTORE DATABASE DBGimnasio
FROM DISK = '/var/opt/mssql/data/DBGimnasio_Full_20261113_013943.bak'
WITH
    REPLACE,
    NORECOVERY,
    STATS = 10;
GO

--Restaurar respaldo diferencial
RESTORE DATABASE DBGimnasio
FROM DISK = '/var/opt/mssql/data/DBGimnasio_Differential_20261113_014026.bak'
WITH
    NORECOVERY,
    STATS = 10;
GO

--Restaurar respaldo del LOG
RESTORE LOG DBGimnasio
FROM DISK = '/var/opt/mssql/data/DBGimnasio_Log_20261113_014053.trn'
WITH
    RECOVERY,
    STATS = 10;
GO

--Habilitar nuevamente el acceso
ALTER DATABASE DBGimnasio
SET MULTI_USER;
GO

--Verificar estado
SELECT
    name,
    state_desc
FROM sys.databases
WHERE name = 'DBGimnasio';
GO
