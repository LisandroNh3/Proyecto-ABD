CREATE DATABASE DBGimnasio;
GO

USE DBGimnasio;
GO

-- Creación de Esquemas de Base de Datos
CREATE SCHEMA catalogos;
GO
CREATE SCHEMA operaciones;
GO

-- 1. Tabla de Catálogo: Membresias
CREATE TABLE catalogos.Membresia (
    id_membresia INT IDENTITY(1,1) PRIMARY KEY,
    nombre_plan VARCHAR(50) NOT NULL UNIQUE,
    costo DECIMAL(10,2) NOT NULL CHECK (costo >= 0),
    duracion_dias INT NOT NULL CHECK (duracion_dias > 0)
);
GO

-- 2. Tabla de Catálogo: Entrenadores
CREATE TABLE catalogos.Entrenador (
    id_entrenador INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NULL
);
GO

-- 3. Tabla Transaccional: Socios
CREATE TABLE operaciones.Socio (
    id_socio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    id_membresia INT NOT NULL,
    fecha_registro DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT FK_Socio_Membresia FOREIGN KEY (id_membresia) 
        REFERENCES catalogos.Membresia(id_membresia)
);
GO

-- 4. Tabla Transaccional: Clases
CREATE TABLE operaciones.Clase (
    id_clase INT IDENTITY(1,1) PRIMARY KEY,
    nombre_clase VARCHAR(50) NOT NULL,
    id_entrenador INT NOT NULL,
    capacidad_maxima INT NOT NULL CHECK (capacidad_maxima > 0),
    horario DATETIME2 NOT NULL,
    CONSTRAINT FK_Clase_Entrenador FOREIGN KEY (id_entrenador) 
        REFERENCES catalogos.Entrenador(id_entrenador)
);
GO

-- 5. Tabla Transaccional: ReservaClase
CREATE TABLE operaciones.ReservaClase (
    id_reserva INT IDENTITY(1,1) PRIMARY KEY,
    id_socio INT NOT NULL,
    id_clase INT NOT NULL,
    fecha_reserva DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    estado VARCHAR(20) NOT NULL DEFAULT 'Confirmada' CHECK (estado IN ('Confirmada', 'Cancelada', 'Asistió')),
    CONSTRAINT FK_Reserva_Socio FOREIGN KEY (id_socio) 
        REFERENCES operaciones.Socio(id_socio),
    CONSTRAINT FK_Reserva_Clase FOREIGN KEY (id_clase) 
        REFERENCES operaciones.Clase(id_clase),
    CONSTRAINT UQ_Socio_Clase UNIQUE (id_socio, id_clase)
);
GO

-- 6. Tabla Transaccional: Pago
CREATE TABLE operaciones.Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_socio INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),
    fecha_pago DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    metodo_pago VARCHAR(30) NOT NULL CHECK (metodo_pago IN ('Efectivo', 'Tarjeta de Crédito', 'Transferencia')),
    CONSTRAINT FK_Pago_Socio FOREIGN KEY (id_socio) 
        REFERENCES operaciones.Socio(id_socio)
);
GO