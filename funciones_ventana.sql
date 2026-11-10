-- ============================================================================
-- CONSULTA 1: Ranking de clientes VIP (Socios que más dinero han pagado)
-- Uso de función ventana: RANK() y SUM() OVER()
-- ============================================================================
SELECT 
    s.id_socio,
    s.nombre,
    s.apellido,
    m.nombre_plan,
    SUM(p.monto) AS total_invertido,
    RANK() OVER (ORDER BY SUM(p.monto) DESC) AS ranking_gasto
FROM operaciones.Socio s
JOIN operaciones.Pago p ON s.id_socio = p.id_socio
JOIN catalogos.Membresia m ON s.id_membresia = m.id_membresia
GROUP BY s.id_socio, s.nombre, s.apellido, m.nombre_plan;


-- ============================================================================
-- CONSULTA 2: Análisis de Ocupación de Clases
-- Uso de función ventana: COUNT() OVER(PARTITION BY ...)
-- ============================================================================
-- Esta consulta calcula el porcentaje de ocupación de cada clase en tiempo real.
SELECT DISTINCT
    c.id_clase,
    c.nombre_clase,
    e.nombre AS entrenador,
    c.capacidad_maxima,
    -- Contamos solo las reservas confirmadas por clase
    COUNT(CASE WHEN r.estado = 'Confirmada' THEN 1 END) 
        OVER (PARTITION BY c.id_clase) AS reservas_actuales,
    -- Calculamos el porcentaje de ocupación
    (CAST(COUNT(CASE WHEN r.estado = 'Confirmada' THEN 1 END) 
        OVER (PARTITION BY c.id_clase) AS DECIMAL(5,2)) / c.capacidad_maxima) * 100 AS porcentaje_ocupacion
FROM operaciones.Clase c
LEFT JOIN catalogos.Entrenador e ON c.id_entrenador = e.id_entrenador
LEFT JOIN operaciones.ReservaClase r ON c.id_clase = r.id_clase;


-- ============================================================================
-- CONSULTA 3: Comparativa de Ingresos Mensuales (Crecimiento del Gimnasio)
-- Uso de función ventana: LAG() OVER()
-- ============================================================================
-- Genera un reporte financiero que compara lo ganado un mes frente al mes anterior.
WITH IngresosPorMes AS (
    SELECT 
        YEAR(fecha_pago) AS Anio,
        MONTH(fecha_pago) AS Mes,
        SUM(monto) AS ingresos_totales
    FROM operaciones.Pago
    GROUP BY YEAR(fecha_pago), MONTH(fecha_pago)
)
SELECT 
    Anio,
    Mes,
    ingresos_totales,
    -- Obtenemos el ingreso del mes anterior para comparar
    LAG(ingresos_totales) OVER (ORDER BY Anio, Mes) AS ingresos_mes_anterior,
    -- Calculamos la diferencia monetaria
    ingresos_totales - LAG(ingresos_totales) OVER (ORDER BY Anio, Mes) AS diferencia_crecimiento
FROM IngresosPorMes;