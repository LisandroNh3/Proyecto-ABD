USE DBGimnasio;
GO

-- Índice para optimizar el cálculo de ingresos y gastos por socio.
CREATE NONCLUSTERED INDEX IX_Pago_Socio_IncludeMonto 
ON operaciones.Pago(id_socio) 
INCLUDE (monto, fecha_pago);
GO

-- Índice para optimizar el conteo de reservas por clase y filtrar rápidamente por estado.
CREATE NONCLUSTERED INDEX IX_ReservaClase_Clase_IncludeEstado 
ON operaciones.ReservaClase(id_clase) 
INCLUDE (id_socio, estado);
GO

-- Índice para acelerar los cruces entre Socios y sus Membresías.
CREATE NONCLUSTERED INDEX IX_Socio_Membresia 
ON operaciones.Socio(id_membresia) 
INCLUDE (nombre, apellido, correo);
GO