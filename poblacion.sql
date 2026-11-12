USE DBGimnasio;
GO


INSERT INTO catalogos.Membresia (nombre_plan, costo, duracion_dias)
VALUES 
    ('Básico Mensual', 25.00, 30),
    ('Premium Mensual', 45.00, 30),
    ('VIP Anual', 400.00, 365);
GO


INSERT INTO operaciones.Socio (nombre, apellido, correo, id_membresia, fecha_registro)
VALUES
    ('Carlos', 'Martinez', 'cmartinez.01@email.com', 1, '2026-08-15'),
    ('Ana', 'Hernandez', 'ana.hernandez88@email.com', 2, '2026-08-16'),
    ('Luis', 'Perez', 'luis.perez.gym@email.com', 3, '2026-08-18'),
    ('Maria', 'Gomez', 'mgomez_fit@email.com', 1, '2026-08-20'),
    ('Jose', 'Lopez', 'jose.lopez99@email.com', 2, '2026-08-22'),
    ('Marta', 'Gonzalez', 'marta.gonzalez@email.com', 1, '2026-08-23'),
    ('Jorge', 'Rodriguez', 'jorge.rod@email.com', 3, '2026-08-25'),
    ('Elena', 'Sanchez', 'elena.sanch@email.com', 2, '2026-08-28'),
    ('Diego', 'Ramirez', 'diego.ramirez.fit@email.com', 1, '2026-09-01'),
    ('Laura', 'Cruz', 'lcruz.02@email.com', 2, '2026-09-02'),
    ('Miguel', 'Flores', 'miguel.flores@email.com', 1, '2026-09-03'),
    ('Lucia', 'Gomez', 'lucia.gomez12@email.com', 3, '2026-09-05'),
    ('Fernando', 'Reyes', 'fer.reyes@email.com', 2, '2026-09-06'),
    ('Carmen', 'Morales', 'carmen.morales.99@email.com', 1, '2026-09-07'),
    ('Ricardo', 'Ortiz', 'ricardo.ortiz@email.com', 1, '2026-09-09'),
    ('Patricia', 'Gutierrez', 'paty.gutierrez@email.com', 2, '2026-09-10'),
    ('Eduardo', 'Chavez', 'eduardo.chavez@email.com', 3, '2026-09-11'),
    ('Rosa', 'Ramos', 'rosa.ramos.fit@email.com', 1, '2026-09-12'),
    ('Javier', 'Rivera', 'javier.rivera88@email.com', 2, '2026-09-14'),
    ('Teresa', 'Aguilar', 'teresa.aguilar@email.com', 1, '2026-09-15'),
    ('Alejandro', 'Mendez', 'alejandro.mendez@email.com', 3, '2026-09-16'),
    ('Gloria', 'Castillo', 'gloria.castillo@email.com', 2, '2026-09-18'),
    ('Roberto', 'Jimenez', 'roberto.jimenez@email.com', 1, '2026-09-19'),
    ('Silvia', 'Romero', 'silvia.romero@email.com', 2, '2026-09-20'),
    ('Andres', 'Herrera', 'andres.herrera@email.com', 1, '2026-09-21'),
    ('Isabel', 'Diaz', 'isabel.diaz.fit@email.com', 3, '2026-09-22'),
    ('Oscar', 'Vargas', 'oscar.vargas@email.com', 2, '2026-09-23'),
    ('Diana', 'Rojas', 'diana.rojas@email.com', 1, '2026-09-25'),
    ('Victor', 'Navarro', 'victor.navarro@email.com', 2, '2026-09-26'),
    ('Sonia', 'Juarez', 'sonia.juarez@email.com', 1, '2026-09-27'),
    ('Mario', 'Valle', 'mario.valle@email.com', 3, '2026-09-28'),
    ('Beatriz', 'Pineda', 'beatriz.pineda@email.com', 2, '2026-09-29'),
    ('Rafael', 'Mejia', 'rafael.mejia@email.com', 1, '2026-09-30'),
    ('Alicia', 'Campos', 'alicia.campos@email.com', 2, '2026-10-01'),
    ('Manuel', 'Bautista', 'manuel.bautista@email.com', 1, '2026-10-02'),
    ('Veronica', 'Cabrera', 'veronica.cabrera@email.com', 3, '2026-10-03'),
    ('Julio', 'Fuentes', 'julio.fuentes@email.com', 2, '2026-10-04'),
    ('Claudia', 'Miranda', 'claudia.miranda@email.com', 1, '2026-10-05'),
    ('Hector', 'Cortes', 'hector.cortes@email.com', 2, '2026-10-06'),
    ('Natalia', 'Salazar', 'natalia.salazar@email.com', 1, '2026-10-08'),
    ('Daniel', 'Guerrero', 'daniel.guerrero@email.com', 3, '2026-10-09'),
    ('Adriana', 'Molina', 'adriana.molina@email.com', 2, '2026-10-10'),
    ('Ruben', 'Sosa', 'ruben.sosa@email.com', 1, '2026-10-11'),
    ('Daniela', 'Acosta', 'daniela.acosta@email.com', 2, '2026-10-12'),
    ('Cesar', 'Alvarado', 'cesar.alvarado@email.com', 1, '2026-10-13'),
    ('Paola', 'Orellana', 'paola.orellana@email.com', 3, '2026-10-14'),
    ('Hugo', 'Escobar', 'hugo.escobar@email.com', 2, '2026-10-15'),
    ('Lorena', 'Rivas', 'lorena.rivas@email.com', 1, '2026-10-16'),
    ('Ivan', 'Paz', 'ivan.paz@email.com', 2, '2026-10-17'),
    ('Gabriela', 'Ramos', 'gabriela.ramos@email.com', 1, '2026-10-18'),
    ('Arturo', 'Velasquez', 'arturo.velasquez@email.com', 3, '2026-10-19'),
    ('Karla', 'Portillo', 'karla.portillo@email.com', 2, '2026-10-20'),
    ('Raul', 'Zelaya', 'raul.zelaya@email.com', 1, '2026-10-21'),
    ('Monica', 'Blanco', 'monica.blanco@email.com', 2, '2026-10-22'),
    ('Joaquin', 'Arias', 'joaquin.arias@email.com', 1, '2026-10-23'),
    ('Valeria', 'Montoya', 'valeria.montoya@email.com', 3, '2026-10-24'),
    ('Ernesto', 'Franco', 'ernesto.franco@email.com', 2, '2026-10-25'),
    ('Andrea', 'Guzman', 'andrea.guzman@email.com', 1, '2026-10-26'),
    ('Felix', 'Rosales', 'felix.rosales@email.com', 2, '2026-10-27'),
    ('Sofia', 'Ayala', 'sofia.ayala@email.com', 1, '2026-10-28'),
    ('Mauricio', 'Caceres', 'mauricio.caceres@email.com', 3, '2026-10-29'),
    ('Ximena', 'Cardenas', 'ximena.cardenas@email.com', 2, '2026-10-30'),
    ('Gonzalo', 'Mendoza', 'gonzalo.mendoza@email.com', 1, '2026-11-01'),
    ('Fernanda', 'Soto', 'fernanda.soto@email.com', 2, '2026-11-02'),
    ('Gerardo', 'Ponce', 'gerardo.ponce@email.com', 1, '2026-11-03'),
    ('Cecilia', 'Arce', 'cecilia.arce@email.com', 3, '2026-11-04'),
    ('Rodrigo', 'Benitez', 'rodrigo.benitez@email.com', 2, '2026-11-05'),
    ('Julia', 'Cordova', 'julia.cordova@email.com', 1, '2026-11-06'),
    ('Nelson', 'Delgado', 'nelson.delgado@email.com', 2, '2026-11-07'),
    ('Fabiola', 'Espinosa', 'fabiola.espinosa@email.com', 1, '2026-11-08'),
    ('Marcos', 'Figueroa', 'marcos.figueroa@email.com', 3, '2026-11-09'),
    ('Angela', 'Gallo', 'angela.gallo@email.com', 2, '2026-11-10'),
    ('Tomas', 'Ibarra', 'tomas.ibarra@email.com', 1, '2026-11-11'),
    ('Evelyn', 'Lara', 'evelyn.lara@email.com', 2, '2026-11-12'),
    ('Enrique', 'Macias', 'enrique.macias@email.com', 1, '2026-11-13'),
    ('Rocio', 'Nunez', 'rocio.nunez@email.com', 3, '2026-11-14'),
    ('Salvador', 'Pacheco', 'salvador.pacheco@email.com', 2, '2026-11-15'),
    ('Leticia', 'Quintana', 'leticia.quintana@email.com', 1, '2026-11-16'),
    ('Martin', 'Salgado', 'martin.salgado@email.com', 2, '2026-11-17'),
    ('Silvana', 'Vera', 'silvana.vera@email.com', 1, '2026-11-18');
GO


-- 3. Insertar Entrenadores
INSERT INTO catalogos.Entrenador (nombre, especialidad, telefono)
VALUES 
    ('Marcos Silva', 'Crossfit y Funcional', '7000-1111'),
    ('Valeria Castro', 'Yoga y Pilates', '7000-2222'),
    ('Jorge Ruiz', 'Levantamiento Olímpico', '7000-3333'),
    ('Camila Santos', 'Spinning', '7000-4444');
GO

-- 4. Insertar Clases (Programadas para noviembre 2026)
INSERT INTO operaciones.Clase (nombre_clase, id_entrenador, capacidad_maxima, horario)
VALUES 
    ('Crossfit Matutino', 1, 20, '2026-11-15 06:00:00'),
    ('Yoga Relax', 2, 15, '2026-11-15 18:00:00'),
    ('Fuerza Máxima', 3, 10, '2026-11-16 19:00:00'),
    ('Spinning Intense', 4, 25, '2026-11-16 07:00:00');
GO

-- 5. Insertar Reservas de Clase (Mezcla de estados para probar las consultas)
INSERT INTO operaciones.ReservaClase (id_socio, id_clase, fecha_reserva, estado)
VALUES 
    (1, 1, '2026-11-10 10:00:00', 'Confirmada'),
    (2, 1, '2026-11-10 11:30:00', 'Confirmada'),
    (3, 1, '2026-11-11 09:15:00', 'Cancelada'),
    (4, 2, '2026-11-12 14:00:00', 'Confirmada'),
    (5, 2, '2026-11-12 15:20:00', 'Asistió'),
    (6, 3, '2026-11-13 08:00:00', 'Confirmada'),
    (7, 4, '2026-11-14 16:45:00', 'Confirmada'),
    (8, 4, '2026-11-14 17:00:00', 'Cancelada'),
    (9, 4, '2026-11-14 18:10:00', 'Confirmada');
GO

-- 6. Insertar Pagos (Simulando meses de Agosto, Septiembre y Octubre para la consulta LAG)
INSERT INTO operaciones.Pago (id_socio, monto, fecha_pago, metodo_pago)
VALUES 
    -- Pagos de Agosto
    (1, 25.00, '2026-08-15 08:00:00', 'Tarjeta de Crédito'),
    (2, 45.00, '2026-08-16 09:00:00', 'Efectivo'),
    (3, 400.00, '2026-08-18 10:00:00', 'Transferencia'),
    (4, 25.00, '2026-08-20 11:00:00', 'Efectivo'),
    -- Pagos de Septiembre (Crecimiento en ingresos)
    (5, 45.00, '2026-09-02 07:30:00', 'Tarjeta de Crédito'),
    (6, 25.00, '2026-09-05 14:00:00', 'Efectivo'),
    (7, 400.00, '2026-09-10 16:20:00', 'Transferencia'),
    (8, 45.00, '2026-09-15 09:10:00', 'Tarjeta de Crédito'),
    (9, 25.00, '2026-09-20 18:00:00', 'Efectivo'),
    -- Pagos de Octubre
    (1, 25.00, '2026-10-15 08:15:00', 'Tarjeta de Crédito'), -- Renovación mensual
    (2, 45.00, '2026-10-16 09:05:00', 'Efectivo'),         -- Renovación mensual
    (10, 45.00, '2026-10-02 10:00:00', 'Transferencia'),
    (11, 25.00, '2026-10-05 11:30:00', 'Tarjeta de Crédito'),
    (12, 400.00, '2026-10-10 15:45:00', 'Transferencia');
GO