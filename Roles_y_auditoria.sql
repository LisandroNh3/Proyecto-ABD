--ROLES Y PERMISOS

use dbgimnasio;
go

--Creacion de roles

create role rolrecepcion;
create role rolentrenador;
create role roladministrador;



-- Permisos para RolRecepcion
grant select on catalogos.membresia to rolrecepcion;
grant select on catalogos.entrenador to rolrecepcion;
grant select on operaciones.clase to rolrecepcion;

grant select, insert, update on operaciones.socio to rolrecepcion;
grant select, insert, update on operaciones.reservaclase to rolrecepcion;

grant select, insert on operaciones.pago to rolrecepcion
grant select on operaciones.clase to rolrecepcion;


-- Permisos de rolEntrenador
grant select on catalogos.entrenador to rolentrenador;
grant select on operaciones.clase to rolentrenador;
grant select on operaciones.reservaclase to rolentrenador;
grant select on operaciones.socio to rolentrenador;


-- Permisos de rolAdministrador
grant control on schema::catalogos to roladministrador;
grant control on schema::operaciones to roladministrador;



--Adicional trigger de validacion
create trigger operaciones.trg_prohibirmodificacionpago
on operaciones.pago
after update, delete
as
begin
    set nocount on;
    raiserror('Por motivos de seguridad y auditoría, los pagos no pueden ser modificados ni eliminados directamente.', 16, 1);
    rollback transaction;
end;

--AUDITORIA

use master;
go

--crear auditoria en el servidor
create server audit auditoriagimnasio
to file (
    filepath = '/audit/',
    maxsize = 10 mb,
    max_rollover_files = 5,
    reserve_disk_space = off
)
with (
    queue_delay = 1000,
    on_failure = continue
);
go

--habilitar auditoria
alter server audit auditoriagimnasio
with (state = on);
go

use dbgimnasio;
go

--Creacion de las especificaciones de la auditoria
create database audit specification especificacionauditgimnasio
for server audit auditoriagimnasio
    -- 1. Grupos globales de nivel de base de datos 
    add (database_object_permission_change_group),
    add (database_object_change_group),
    
    -- 2. Acciones específicas de datos (DML) orientadas al esquema 'operaciones' para todos (public)
    add (select on schema::operaciones by public),
    add (insert on schema::operaciones by public),
    add (update on schema::operaciones by public),
    add (delete on schema::operaciones by public)
with (state = on);

--consultar auditoria
select 
    event_time,
    action_id,
    succeeded,
    session_server_principal_name as usuario,
    database_name,
    schema_name,
    object_name,
    statement
from sys.fn_get_audit_file('/audit/auditoriagimnasio*.sqlaudit', default, default);
