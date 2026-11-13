
USE DBGimnasio;
GO

CREATE OR ALTER VIEW operaciones.vw_RankingSocios
AS
SELECT
    s.id_socio,
    s.nombre,
    s.apellido,
    m.nombre_plan,
    SUM(p.monto) AS total_invertido,
    RANK() OVER (
        ORDER BY SUM(p.monto) DESC
    ) AS ranking_gasto
FROM operaciones.Socio AS s
INNER JOIN operaciones.Pago AS p
    ON s.id_socio = p.id_socio
INNER JOIN catalogos.Membresia AS m
    ON s.id_membresia = m.id_membresia
GROUP BY
    s.id_socio,
    s.nombre,
    s.apellido,
    m.nombre_plan;
GO


CREATE OR ALTER VIEW operaciones.vw_OcupacionClases
AS
SELECT DISTINCT
    c.id_clase,
    c.nombre_clase,
    e.nombre AS entrenador,
    c.capacidad_maxima,

    COUNT(
        CASE
            WHEN r.estado = 'Confirmada'
            THEN 1
        END
    ) OVER (
        PARTITION BY c.id_clase
    ) AS reservas_actuales,

    CAST(
        100.0 *
        COUNT(
            CASE
                WHEN r.estado = 'Confirmada'
                THEN 1
            END
        ) OVER (
            PARTITION BY c.id_clase
        )
        / c.capacidad_maxima
        AS DECIMAL(10,2)
    ) AS porcentaje_ocupacion

FROM operaciones.Clase AS c
LEFT JOIN catalogos.Entrenador AS e
    ON c.id_entrenador = e.id_entrenador
LEFT JOIN operaciones.ReservaClase AS r
    ON c.id_clase = r.id_clase;
GO



CREATE OR ALTER VIEW operaciones.vw_CrecimientoIngresos
AS
WITH IngresosPorMes AS (
    SELECT
        YEAR(fecha_pago) AS anio,
        MONTH(fecha_pago) AS mes,
        SUM(monto) AS ingresos_totales
    FROM operaciones.Pago
    GROUP BY
        YEAR(fecha_pago),
        MONTH(fecha_pago)
)
SELECT
    anio,
    mes,
    ingresos_totales,

    LAG(ingresos_totales) OVER (
        ORDER BY anio, mes
    ) AS ingresos_mes_anterior,

    ingresos_totales -
    LAG(ingresos_totales) OVER (
        ORDER BY anio, mes
    ) AS diferencia_crecimiento

FROM IngresosPorMes;
GO




CREATE OR ALTER VIEW operaciones.vw_IngresosMensuales
AS
SELECT
    YEAR(fecha_pago) AS anio,
    MONTH(fecha_pago) AS mes,
    SUM(monto) AS ingresos_totales,
    COUNT(id_pago) AS cantidad_pagos
FROM operaciones.Pago
GROUP BY
    YEAR(fecha_pago),
    MONTH(fecha_pago);
GO

CREATE OR ALTER VIEW operaciones.vw_SociosPorMembresia
AS
SELECT
    m.id_membresia,
    m.nombre_plan,
    m.costo,
    m.duracion_dias,
    COUNT(s.id_socio) AS total_socios
FROM catalogos.Membresia AS m
LEFT JOIN operaciones.Socio AS s
    ON m.id_membresia = s.id_membresia
GROUP BY
    m.id_membresia,
    m.nombre_plan,
    m.costo,
    m.duracion_dias;
GO

CREATE OR ALTER VIEW operaciones.vw_ReservasPorClase
AS
SELECT
    c.id_clase,
    c.nombre_clase,
    e.nombre AS entrenador,
    c.capacidad_maxima,
    c.horario,
    COUNT(r.id_reserva) AS total_reservas,
    COUNT(CASE
        WHEN r.estado = 'Confirmada' THEN 1
    END) AS reservas_confirmadas,
    COUNT(CASE
        WHEN r.estado = 'Cancelada' THEN 1
    END) AS reservas_canceladas,
    COUNT(CASE
        WHEN r.estado = 'Asistió' THEN 1
    END) AS asistencias
FROM operaciones.Clase AS c
INNER JOIN catalogos.Entrenador AS e
    ON c.id_entrenador = e.id_entrenador
LEFT JOIN operaciones.ReservaClase AS r
    ON c.id_clase = r.id_clase
GROUP BY
    c.id_clase,
    c.nombre_clase,
    e.nombre,
    c.capacidad_maxima,
    c.horario;
GO



