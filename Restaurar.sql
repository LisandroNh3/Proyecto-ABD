
USE master;
GO

-- 1. Preparar la base de datos para la restauración
ALTER DATABASE DBGimnasio
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- 2. Restaurar respaldo completo (FULL)
RESTORE DATABASE DBGimnasio
FROM DISK = '/var/opt/mssql/data/DBGimnasio_Full_20261113_013943.bak'
WITH
    REPLACE,
    NORECOVERY,
    STATS = 10;
GO

-- 3. Restaurar respaldo diferencial
RESTORE DATABASE DBGimnasio
FROM DISK = '/var/opt/mssql/data/DBGimnasio_Differential_20261113_014026.bak'
WITH
    NORECOVERY,
    STATS = 10;
GO

-- 4. Restaurar respaldo del registro de transacciones (LOG)
RESTORE LOG DBGimnasio
FROM DISK = '/var/opt/mssql/data/DBGimnasio_Log_20261113_014053.trn'
WITH
    RECOVERY,
    STATS = 10;
GO

-- 5. Habilitar nuevamente el acceso a la base de datos
ALTER DATABASE DBGimnasio
SET MULTI_USER;
GO

-- 6. Verificar el estado de la base de datos
SELECT
    name,
    state_desc
FROM sys.databases
WHERE name = 'DBGimnasio';
GO
