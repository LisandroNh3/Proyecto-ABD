
--Comprobamos que la configuracion  de la BD es en modelo FULL
SELECT
    name AS Base_Datos,
    recovery_model_desc AS Modelo_Recuperacion
FROM sys.databases
WHERE name = 'DBGimnasio';

--En caso que no lo este
ALTER DATABASE DBGimnasio
SET RECOVERY FULL;

--Creacion del respaldo de BD
BACKUP DATABASE DBGimnasio
TO DISK = '/var/opt/mssql/data/DBGimnasio_Full.bak'
WITH
    INIT,
    COMPRESSION,
    STATS = 10;



--Respaldo diferencial
BACKUP DATABASE DBGimnasio
TO DISK = '/var/opt/mssql/data/DBGimnasio_Differential.bak'
WITH
    DIFFERENTIAL,
    INIT,
    COMPRESSION,
    STATS = 10;

--transaction log
BACKUP LOG DBGimnasio
TO DISK = '/var/opt/mssql/data/DBGimnasio_Log.trn'
WITH
    INIT,
    COMPRESSION,
    STATS = 10;