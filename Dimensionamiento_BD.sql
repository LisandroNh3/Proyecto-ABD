USE DBGimnasio;
GO

--Consulta para saber el tamaño de la BD
EXEC sp_spaceused;

--consulta para saber cuanto espacio utilizan cada tabla y sus respectivos indices
EXEC sp_MSforeachtable 
'EXEC sp_spaceused ''?''';

--consulta para obtener el espacio asignado de la BD
SELECT
    name AS Archivo,
    type_desc AS Tipo,
    size * 8 / 1024 AS Tamano_MB,
    physical_name AS Ubicacion
FROM sys.database_files;


--para verificar cuanto espacio ocupa realmente cada tabla
SELECT
    t.name AS Tabla,
    SUM(CASE WHEN ps.index_id IN (0,1)
        THEN ps.row_count ELSE 0 END) AS Registros,
    SUM(ps.reserved_page_count) * 8 AS Reservado_KB,
    SUM(ps.used_page_count) * 8 AS Utilizado_KB
FROM sys.dm_db_partition_stats ps
INNER JOIN sys.tables t
    ON ps.object_id = t.object_id
GROUP BY t.name
ORDER BY t.name;