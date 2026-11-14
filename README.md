#  Sistema de Reservas de Gimnasio (`DBGimnasio`)
**Proyecto de Cátedra — Administración de Bases de Datos con SQL Server**

Este proyecto implementa el diseño, administración, aseguramiento, optimización y explotación analítica de una base de datos relacional para la gestión integral de un gimnasio (membresías, socios, entrenadores, clases, reservas y pagos), desplegada sobre **SQL Server 2025 Developer** en contenedores Docker y conectada a **Power BI**.

---

##  Características Principales del Sistema

1. **Arquitectura Modular por Esquemas:**
   * `catalogos`: Almacena entidades maestras y de configuración (`Membresia`, `Entrenador`).
   * `operaciones`: Gestiona las tablas transaccionales de alta concurrencia (`Socio`, `Clase`, `ReservaClase`, `Pago`).
2. **Seguridad Granular y Auditoría:**
   * Implementación del principio de mínimo privilegio mediante 3 roles personalizados (`rolrecepcion`, `rolentrenador`, `roladministrador`) vinculados a usuarios dedicados.
   * Integridad financiera reforzada mediante el trigger `operaciones.trg_prohibirmodificacionpago`, que bloquea modificaciones o eliminaciones directas en el historial de pagos.
   * Auditoría nativa a nivel de servidor y base de datos (`auditoriagimnasio`) con almacenamiento de registros `.sqlaudit` en `/audit/`.
3. **Optimización y Analítica Avanzada:**
   * **3 Índices No Agrupados (*Covering Indexes*)** con cláusula `INCLUDE` (`IX_Pago_Socio_IncludeMonto`, `IX_ReservaClase_Clase_IncludeEstado`, `IX_Socio_Membresia`) para evitar *Key Lookups*.
   * **3 Consultas Analíticas con Funciones Ventana:** Ranking de clientes VIP (`RANK() OVER`), cálculo de ocupación de clases en tiempo real (`COUNT() OVER`) y comparativa de crecimiento financiero mensual (`LAG() OVER`).
4. **Continuidad del Negocio (Backup, Recuperación y Dimensionamiento):**
   * Modelo de recuperación `FULL` con automatización mediante **SQL Server Agent** (Respaldo Completo semanal, Diferencial diario y Log de transacciones cada 6 horas, garantizando un **RPO máximo de 6 horas**).
   * Procedimiento de recuperación segura sobre instancia paralela (`DBGimnasio_Restaurada` mediante `WITH MOVE`) sin afectar la base operativa.
   * Proyección matemática de almacenamiento a 1 y 3 años contemplando el factor de crecimiento de índices (+35%).
5. **Explotación en Power BI:**
   * 6 vistas analíticas optimizadas en SQL Server conectadas a un dashboard interactivo (`.pbix`) con KPIs, segmentadores y análisis de ingresos y asistencia.

---

##  Estructura de Archivos y Orden de Ejecución

Para desplegar la base de datos desde cero sin errores de dependencias (llaves foráneas o esquemas), ejecuta los scripts SQL en el siguiente orden estricto:

| Orden | Archivo | Descripción |
| :---: | :--- | :--- |
| **1** | `gimnasio.sql` | Crea la base de datos `DBGimnasio`, los esquemas (`catalogos`, `operaciones`) y las 6 tablas con sus restricciones (`PK`, `FK`, `UNIQUE`, `CHECK`). |
| **2** | `poblacion.sql` | Inserta los datos de prueba: 3 planes de membresía, 80 socios, 4 entrenadores, 4 clases, 9 reservas y 14 pagos distribuidos en varios meses. |
| **3** | `clusters.sql` | Crea los 3 índices no agrupados con columnas incluidas (`INCLUDE`) para optimizar las consultas de reporte. |
| **4** | `funciones_ventana.sql` | Contiene las 3 consultas analíticas principales utilizando `RANK()`, `COUNT() OVER()` y `LAG()`. |
| **5** | `VistasBI.sql` | Crea las 6 vistas en el esquema `operaciones` que alimentan el modelo de datos de Power BI. |
| **6** | `Roles_y_auditoria.sql` | Configura los roles, permisos, trigger de protección de pagos, auditoría del servidor, usuarios de prueba y casos de validación. |
| **7** | `Dimensionamiento_BD.sql` | Consulta el espacio actual utilizado y calcula la proyección de almacenamiento a 1 y 3 años con factor de índices. |
| **8** | `respaldos.sql` | Ejecuta respaldos manuales de prueba (`FULL`, `DIFFERENTIAL` y `LOG`) con compresión. |
| **9** | `jobs.sql` | Programa los 3 trabajos automatizados en `msdb` mediante SQL Server Agent. |
| **10** | `Restaurar.sql` | Script de contingencia para restaurar la cadena `FULL -> DIFF -> LOG` sobre una base nueva (`DBGimnasio_Restaurada`). |
| *Extra* | `prueba_rendimiento.sql` | *Script de diagnóstico (no ejecutar en producción).* Permite medir planes de ejecución, `STATISTICS IO` y `TIME` antes y después de los índices. |
| *BI* | `Dashboard_DBGimnasio.pbix` | Archivo de Power BI Desktop con las visualizaciones conectadas a SQL Server. |

---

##  Requisitos y Configuración del Entorno (Docker)

### Prerrequisitos
* **Docker Desktop** con imagen de **SQL Server 2025 Developer**.
* **SQL Server Management Studio (SSMS)** o **Azure Data Studio**.
* **Power BI Desktop**.

### Preparación del Contenedor Docker
Antes de ejecutar los scripts de auditoría y jobs automatizados, asegúrate de habilitar **SQL Server Agent** y crear el directorio `/audit/` dentro del contenedor ejecutando en tu terminal:

```bash
# 1. Crear carpeta de auditoría con permisos para SQL Server
docker exec -u 0 -it <nombre_contenedor> bash -c "mkdir -p /audit && chown mssql:mssql /audit"

# 2. Habilitar SQL Server Agent y reiniciar el contenedor
docker exec -u 0 -it <nombre_contenedor> /opt/mssql/bin/mssql-conf set sqlagent.enabled true
docker restart <nombre_contenedor>
```

### Conexión desde SSMS / Power BI
* **Servidor:** `localhost,1433` *(ajustar puerto según mapeo del contenedor)*
* **Autenticación:** SQL Server Authentication (`sa` o usuarios de rol configurados).

---

##  Equipo de Desarrollo y Distribución de Roles

| Rol en el Proyecto | Responsabilidades Principales |
| :--- | :--- |
| **Christopher Santos: Arquitectura y Documentación** | Diseño lógico/físico, diagrama Entidad-Relación (ER), diccionario de datos, organización de esquemas e integración del informe final. |
| **Andy Ochoa: Seguridad y Auditoría** | Diseño de roles por función, aplicación de mínimo privilegio, triggers de control, configuración de auditoría y validación de logs. |
| **Lisandro Villalobos: Rendimiento y Consultas** | Desarrollo de consultas analíticas con funciones ventana, estrategia de indexación (`INCLUDE`) y análisis de planes de ejecución. |
| **Elias Aguilar: Storage y Continuidad (DBA)** | Cálculos de dimensionamiento y crecimiento futuro, estrategia de backups (RPO/RTO), SQL Agent Jobs y pruebas de restauración. |
| **Victor Valencia: Explotación BI y Defensa** | Carga/población de datos, creación de vistas analíticas, desarrollo del dashboard en Power BI y coordinación de la presentación final. |
