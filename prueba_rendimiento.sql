USE DBGimnasio;
GO

-- Activar medición exacta de lecturas en disco y tiempos de CPU/ejecución
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- ============================================================================
-- PARTE A: MEDICIÓN ANTES DE LOS ÍNDICES (Deshabilitando los 3 índices)
-- ============================================================================
ALTER INDEX IX_Pago_Socio_IncludeMonto ON operaciones.Pago DISABLE;
ALTER INDEX IX_ReservaClase_Clase_IncludeEstado ON operaciones.ReservaClase DISABLE;
ALTER INDEX IX_Socio_Membresia ON operaciones.Socio DISABLE;
GO

-- -> Ejecuta aquí tus 3 consultas de funciones_ventana.sql y anota los resultados
-- -> de la pestaña "Messages" y captura el "Execution Plan".


-- ============================================================================
-- PARTE B: MEDICIÓN DESPUÉS DE LOS ÍNDICES (Rehabilitando los 3 índices)
-- ============================================================================
ALTER INDEX IX_Pago_Socio_IncludeMonto ON operaciones.Pago REBUILD;
ALTER INDEX IX_ReservaClase_Clase_IncludeEstado ON operaciones.ReservaClase REBUILD;
ALTER INDEX IX_Socio_Membresia ON operaciones.Socio REBUILD;
GO

-- -> Vuelve a ejecutar aquí tus 3 consultas de funciones_ventana.sql, anota
-- -> las nuevas métricas en "Messages" y captura el nuevo "Execution Plan".

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO