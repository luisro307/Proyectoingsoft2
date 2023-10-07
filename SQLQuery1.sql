CREATE DATABASE parkingGO;
USE parkingGO
go

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    ID_usuario INT NOT NULL PRIMARY KEY ,
	ID_empleado INT NOT NULL,
	ID_rol INT NOT NULL,
	ID_permiso INT NOT NULL,
	ID_configuracion INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo_electrónico VARCHAR(100) NOT NULL UNIQUE,
    Contraseña VARCHAR(100) NOT NULL
	FOREIGN KEY (ID_empleado) REFERENCES Empleados5(ID_empleado),
    FOREIGN KEY (ID_rol) REFERENCES Roles(ID_rol),
	FOREIGN KEY (ID_configuracion) REFERENCES Configuracion(ID_configuracion),
    FOREIGN KEY (ID_permiso) REFERENCES Permisos(ID_permiso)
);

-- Tabla de Clientes
CREATE TABLE Clientes5 (
    ID_cliente INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo_electrónico VARCHAR(100)NOT NULL UNIQUE,
);

-- Tabla de Empleados
CREATE TABLE Empleados5 (
    ID_empleado INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo_electrónico VARCHAR(100) NOT NULL,
    Teléfono VARCHAR(20) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2) NOT NULL
);

-- Tabla de Roles
CREATE TABLE Roles (
    ID_rol INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

-- Tabla de Permisos
CREATE TABLE Permisos (
    ID_permiso INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

-- Tabla de Configuración
CREATE TABLE Configuracion (
    ID_configuracion INT NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Valor VARCHAR(100) NOT NULL
);

-- Tabla de Espacios de Estacionamiento
CREATE TABLE Espacios (
    ID_espacio_est INT NOT NULL PRIMARY KEY,
	descripcion VARCHAR(200) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Disponible INT NOT NULL,
   
);

-- Tabla de Tarifas
CREATE TABLE Tarifas5 (
    ID_tarifa INT NOT NULL PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

-- Tabla de Reservas
CREATE TABLE Reservas5 (
    ID_reserva INT NOT NULL PRIMARY KEY,
    Fecha_inicio DATE NOT NULL,
    Hora_inicio TIME NOT NULL,
    Fecha_fin DATE NOT NULL,
    Hora_fin TIME NOT NULL,
    ID_espacio_est INT NOT NULL,
    ID_cliente INT NOT NULL,
    ID_usuario INT NOT NULL,
    FOREIGN KEY (ID_espacio_est) REFERENCES Espacios(ID_espacio_est),
    FOREIGN KEY (ID_cliente) REFERENCES Clientes5(ID_cliente),
    FOREIGN KEY (ID_usuario) REFERENCES Usuarios(ID_usuario)
);

-- Tabla de Pagos
CREATE TABLE Pagos5 (
    ID_pago INT NOT NULL PRIMARY KEY,
    Fecha_inicio DATE NOT NULL,
    Hora_inicio TIME NOT NULL,
    Fecha_fin DATE NOT NULL,
    Hora_fin TIME NOT NULL,
	ID_tarifa INT NOT NULL,
	Monto DECIMAL(10,2) NOT NULL,
    ID_espacio_est INT NOT NULL,
    ID_reserva INT NOT NULL,
    ID_cliente INT NOT NULL,
    ID_usuario INT NOT NULL,
    FOREIGN KEY (ID_espacio_est) REFERENCES Espacios(ID_espacio_est),
    FOREIGN KEY (ID_reserva) REFERENCES Reservas5(ID_reserva),
    FOREIGN KEY (ID_cliente) REFERENCES Clientes5(ID_cliente),
	FOREIGN KEY (ID_tarifa) REFERENCES Tarifas5(ID_tarifa),
    FOREIGN KEY (ID_usuario) REFERENCES Usuarios(ID_usuario)
);

CREATE TABLE vehiculo (
  ID_vehiculo INT NOT NULL PRIMARY KEY,
  placa VARCHAR(20) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  color VARCHAR(20) NOT NULL,
  ID_cliente INT NOT NULL,
  FOREIGN KEY (ID_cliente) REFERENCES Clientes5(ID_cliente),
);

CREATE TABLE eventos (
  ID_e INT NOT NULL PRIMARY KEY,
  tipo VARCHAR(50) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  fecha DATE NOT NULL,
  ID_usuario INT NOT NULL,
  FOREIGN KEY (ID_usuario) REFERENCES Usuarios(ID_usuario)
);


CREATE TABLE comentarios_o_quejas (
  id INT NOT NULL PRIMARY KEY,
  descripcion VARCHAR(200) NOT NULL,
  fecha DATE NOT NULL,
  ID_usuario INT NOT NULL,
  ID_cliente INT NOT NULL,
  FOREIGN KEY (ID_cliente) REFERENCES Clientes5(ID_cliente),
  FOREIGN KEY (ID_usuario) REFERENCES Usuarios(ID_usuario)
);

CREATE TABLE mantenimiento (
  ID_mantenimiento INT NOT NULL PRIMARY KEY,
  tipo VARCHAR(50) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  costo DECIMAL(10,2) NOT NULL,
  ID_empleado INT NOT NULL,
  FOREIGN KEY (ID_empleado) REFERENCES Empleados5(ID_empleado)
);

CREATE TABLE transacciones (
  ID_trans INT NOT NULL PRIMARY KEY,
  ID_pago INT NOT NULL,
  ID_espacio_est INT NOT NULL,
  ID_vehiculo INT NOT NULL,
  id_usuario_ingreso INT NOT NULL,
  id_usuario_salida INT NOT NULL,
  FOREIGN KEY (ID_pago) REFERENCES Pagos5(ID_pago),
  FOREIGN KEY (ID_espacio_est) REFERENCES Espacios(ID_espacio_est),
  FOREIGN KEY (ID_vehiculo) REFERENCES Vehiculo(ID_vehiculo),
  FOREIGN KEY (id_usuario_ingreso) REFERENCES Usuarios(ID_usuario),
  FOREIGN KEY (id_usuario_salida) REFERENCES Usuarios(ID_usuario)
);

CREATE TABLE alertas (
  ID_alerta INT NOT NULL PRIMARY KEY,
  descripcion VARCHAR(200) NOT NULL,
  fecha DATE NOT NULL,
  ID_trans INT NOT NULL,
  FOREIGN KEY (ID_trans) REFERENCES transacciones(ID_trans)
);

--creacion de los check
--usuarios check
alter table Clientes5 add constraint CHK_Correo_electrónico check (Correo_electrónico LIKE '%@%.%');


--creacion de usuarios
CREATE USER luis_m WITHOUT LOGIN;
CREATE USER luis_p WITHOUT LOGIN;
CREATE USER samuel_p WITHOUT LOGIN;
CREATE USER jimmy_e WITHOUT LOGIN;


--insert
INSERT INTO Clientes5 (ID_cliente, Nombre, Apellido, Correo_electrónico) VALUES 
(1, 'Juan', 'Pérez', 'juan.perez@gmail.com'),
(2, 'María', 'González', 'maria.gonzalez@hotmail.com'),
(3, 'Pedro', 'López', 'pedro.lopez@yahoo.com'),
(4, 'carlos', 'peguero', 'cp@gmail.com'),
(5, 'luis', 'perdomo', 'lp@hotmail.com'),
(6, 'samuel', 'López', 'sl@yahoo.com'),
(7, 'jimmmy', 'e', 'je@gmail.com'),
(8, 'juan', 'delospalotes', 'jp@hotmail.com'),
(9, 'linett', 'serrano', 'ls@yahoo.com')

INSERT INTO Empleados5 (ID_empleado, Nombre, Apellido, Correo_electrónico, Teléfono, Cargo, Salario)
VALUES
(1, 'Juan', 'Pérez', 'juan.perez@empresa.com', '555-1234', 'Gerente', 5000.00),
(2, 'María', 'García', 'maria.garcia@empresa.com', '555-5678', 'Analista', 3000.00),
(3, 'Pedro', 'Gómez', 'pedro.gomez@empresa.com', '555-9012', 'Programador', 2500.00),
(4, 'Ana', 'López', 'ana.lopez@empresa.com', '555-3456', 'Diseñador', 2800.00),
(5, 'Carlos', 'Hernández', 'carlos.hernandez@empresa.com', '555-7890', 'Contador', 3500.00),
(6, 'J', 'P', 'j@empresa.com', '551-1234', 'cajera', 1000.00),
(7, 'M', 'G', 'm@empresa.com', '552-5678', 'cajera', 1000.00),
(8, 'P', 'G', 'p@empresa.com', '553-9012', 'cajera', 1000.00),
(9, 'A', 'L', 'a@empresa.com', '554-3456', 'cajera', 1000.00),
(10, 'Cs', 'H', 'c@empresa.com', '556-7890', 'cajera', 1000.00),
(11, 'El', 'pintor', 'ep@empresa.com', '557-1234', 'Pintor', 25000.00),
(12, 'Seña', 'lizacion', 'sl@empresa.com', '558-1234', 'Enc. señalizacion', 50000.00);

INSERT INTO Roles (ID_rol, Nombre)
VALUES (1, 'Administrador'),
       (2, 'Moderador'),
       (3, 'Usuario');

INSERT INTO Permisos (ID_permiso, Nombre)
VALUES (1, 'Crear usuarios'),
       (2, 'Eliminar usuarios'),
       (3, 'Modificar usuarios');

INSERT INTO Configuracion (ID_configuracion, Nombre, Valor)
VALUES (1, 'MaximoTiempoReserva', '120'),
       (2, 'TiempoMinimoCancelacion', '60'),
       (3, 'CostoHora', '5.50');

INSERT INTO Espacios VALUES (1, 'Espacio de estacionamiento techado', 'A1', 1);
INSERT INTO Espacios VALUES (2, 'Espacio de estacionamiento techado', 'A2', 0);
INSERT INTO Espacios VALUES (3, 'Espacio de estacionamiento al aire libre', 'B1', 1);
INSERT INTO Espacios VALUES (4, 'Espacio de estacionamiento al aire libre', 'B2', 1);
INSERT INTO Espacios VALUES (5, 'Espacio de estacionamiento techado', 'C1', 0);
INSERT INTO Espacios VALUES (6, 'Espacio de estacionamiento techado', 'C2', 1);
INSERT INTO Espacios VALUES (7, 'Espacio de estacionamiento al aire libre', 'D1', 1);
INSERT INTO Espacios VALUES (8, 'Espacio de estacionamiento al aire libre', 'D2', 0);
INSERT INTO Espacios VALUES (9, 'Espacio de estacionamiento techado', 'E1', 1);
INSERT INTO Espacios VALUES (10, 'Espacio de estacionamiento techado', 'E2', 1);

INSERT INTO Tarifas5 (ID_tarifa, Tipo, Precio)
VALUES (1, 'Por hora', 2.50),
(2, 'Por día', 15.00),
(3, 'Por semana', 50.00),
(4, 'Por mes', 150.00),
(5, 'VIP', 500.00);

INSERT INTO Usuarios (ID_usuario, ID_empleado, ID_rol, ID_permiso, ID_configuracion, Nombre, Apellido, Correo_electrónico, Contraseña)
VALUES
    (1, 1, 1, 1, 1, 'Juan', 'Pérez', 'juan.perez@empresa.com', 'password123'),
    (2, 2, 2, 2, 2, 'María', 'García', 'maria.garcia@empresa.com', 'password456'),
    (3, 3, 3, 3, 3, 'Pedro', 'Gómez', 'pedro.gomez@empresa.com', 'password789'),
	(4, 4, 1, 1, 1, 'Ana', 'López', 'ana.lopez@empresa.com', 'password123'),
    (5, 5, 2, 2, 2, 'Carlos', 'Hernández', 'carlos.hernandez@empresa.com', 'password456'),
    (6, 6, 3, 3, 3, 'J', 'P', 'j@empresa.com', 'password789'),
	(7, 7, 1, 1, 1, 'M', 'G', 'm@empresa.com', 'password123'),
    (8, 8, 2, 2, 2, 'P', 'G', 'p@empresa.com', 'password456'),
    (9, 9, 3, 3, 3, 'A', 'L', 'a@empresa.com', 'password789'),
	(10, 10, 3, 3, 3, 'Cs', 'H', 'c@empresa.com', 'password789');

INSERT INTO Reservas5(ID_reserva,
    Fecha_inicio,
    Hora_inicio,
    Fecha_fin,
    Hora_fin,
    ID_espacio_est,
    ID_cliente,
    ID_usuario)
VALUES
    (1, '2022-12-10', '16:00', '2022-12-10', '18:00', 1, 1, 1),
    (2, '2022-12-11', '16:00', '2022-12-12', '18:00', 2, 2, 2),
    (3, '2022-12-12', '16:00', '2022-12-13', '18:00', 3, 3, 3),
	(4, '2022-12-13', '16:00', '2022-12-14', '18:00', 4, 4, 4),
    (5, '2022-12-14', '16:00', '2022-12-15', '18:00', 5, 5, 5),
    (6, '2022-12-15', '16:00', '2022-12-16', '18:00', 6, 6, 6),
	(7, '2022-12-16', '16:00', '2022-12-17', '18:00', 7, 7, 7),
    (8, '2022-12-17', '16:00', '2022-12-18', '18:00', 8, 8, 8),
    (9, '2022-12-18', '16:00', '2022-12-19', '18:00', 9, 9, 9),
	(10,'2022-12-19', '16:00', '2022-12-20', '18:00', 10, 2, 10);

INSERT INTO Pagos5(ID_pago,
    Fecha_inicio,
    Hora_inicio,
    Fecha_fin,
    Hora_fin,
	ID_tarifa,
	Monto,
    ID_espacio_est,
    ID_reserva,
    ID_cliente,
    ID_usuario)
VALUES
    (1, '2022-12-10', '16:00', '2022-12-10', '18:00', 1, 5.00, 1,1,1,1),
    (2, '2022-12-11', '16:00', '2022-12-12', '18:00', 2, 20.00, 2,2,2,2),
    (3, '2022-12-12', '16:00', '2022-12-13', '18:00', 2, 20.00, 3,3,3,3),
	(4, '2022-12-13', '16:00', '2022-12-14', '18:00', 2, 20.00, 4,4,4,4),
    (5, '2022-12-14', '16:00', '2022-12-15', '18:00', 2, 20.00, 5,5,5,5),
    (6, '2022-12-15', '16:00', '2022-12-16', '18:00', 2, 20.00, 6,6,6,6),
	(7, '2022-12-16', '16:00', '2022-12-17', '18:00', 2, 20.00, 7,7,7,7),
    (8, '2022-12-17', '16:00', '2022-12-18', '18:00', 2, 20.00, 8,8,8,8),
    (9, '2022-12-18', '16:00', '2022-12-19', '18:00', 2, 20.00, 9,9,9,9),
	(10,'2022-12-19', '16:00', '2022-12-20', '18:00', 2, 20.00, 10,10,2,10);

INSERT INTO vehiculo(ID_vehiculo,
  placa,
  modelo,
  color,
  ID_cliente)
VALUES
    (1, 'a528502', 'toyota', 'negro', 1),
    (2, 'a528520', 'toyota', 'azul', 2),
    (3, 'g521578', 'honda', 'azul', 3),
	(4, 'z018545', 'nissan', 'rojo', 4),
    (5,'pp985495', 'toyota', 'dorado', 5),
    (6, 'pp852963', 'mercedesben', 'blanco', 6),
	(7, 'g741258', 'minicooper', 'plateado', 7),
    (8, 'g859785', 'bmw', 'amarrilo', 8),
    (9, 'a123456', 'honda', 'blanco', 9),
	(10,'a458741', 'honda', 'negro', 2);

INSERT INTO eventos(ID_e,
  tipo,
  descripcion,
  fecha,
  ID_usuario)
VALUES
    (1, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-01-15', 1),
    (2, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-02-15', 2),
    (3, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-03-15',5),
	(4, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-04-15', 4),
    (5, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-05-15', 5),
    (6, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-06-15', 6),
	(7, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-07-15', 7),
    (8, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-08-15', 8),
    (9, 'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-09-15', 9),
	(10,'Autoferia', 'Venta y finaciamiento de vehiculos nuevos y usados.', '2022-10-15', 10);

INSERT INTO comentarios_o_quejas(id,
  descripcion,
  fecha,
  ID_usuario,
  ID_cliente)
VALUES
    (1, 'Mal servicio', '2022-01-15', 1, 1),
    (2, 'Me robaron el retrovisor', '2022-02-15', 2, 2),
    (3, 'Deben mejorar la vijilancia', '2022-03-15',3,3),
	(4, 'Mala hijiene de los baños', '2022-04-15', 4,4),
    (5, 'Mal servicio de la cajera', '2022-05-15', 5,5),
    (6, 'Deben bajar los precios del servicio', '2022-06-15', 6,6),
	(7, 'Mal servicio', '2022-07-15', 7,7),
    (8, 'Mejorar el servicio al cliente', '2022-08-15', 8,8),
    (9, 'Mal servicio', '2022-09-15', 9,9),
	(10,'Mal servicio', '2022-10-15', 10,2);

INSERT INTO mantenimiento(ID_mantenimiento,
  tipo,
  descripcion,
  fecha_inicio,
  fecha_fin,
  costo,
  ID_empleado)
VALUES
    (1, 'Pintura 1', 'Pintura al parqueo', '2022-01-15', '2022-01-16', 30.00, 11),
    (2, 'Limpieza General 1', 'Limpieza al parqueo', '2022-02-17', '2022-02-18', 25.00, 6),
    (3, 'Mantenimiento de sistema 1', 'Mantenimiento de la base de datos', '2022-03-15', '2022-03-15', 50.00,3),
	(4, 'Limepieza General 2', 'Limpieza al parqueo', '2022-04-15', '2022-04-16', 25.00,7),
    (5, 'Pintura 2', 'Pintura al parqueo', '2022-07-15', '2022-07-16', 30.00,11),
    (6, 'Señalizacion 1', 'Colocar y cambiar las señalizaciones dentro del parqueo', '2022-08-15', '2022-08-20', 70.00,12),
	(7, 'Limpieza General 3', 'Limpieza al parqueo', '2022-06-15', '2022-06-16', 25.00,8),
    (8, 'Pintura 3','Pintura al parqueo', '2023-03-15', '2023-03-16', 30.00,11),
    (9, 'Limpeza General 4', 'Limpieza al parqueo', '2022-08-15', '2022-08-16', 25.00,9),
	(10,'Señalizacion 2', 'Colocar y cambiar las señalizaciones dentro del parqueo', '2023-08-15', '2023-08-20', 70.00,12);

INSERT INTO transacciones(ID_trans,
  ID_pago,
  ID_espacio_est,
  ID_vehiculo,
  id_usuario_ingreso,
  id_usuario_salida)
VALUES
    (1, 1, 1, 1, 10,1),
    (2, 2, 2, 2, 9,2),
    (3, 3, 3, 3, 8,3),
	(4, 4, 4, 4, 7,4),
    (5, 5, 5, 5, 6,5),
    (6, 6, 6, 6, 5,6),
	(7, 7, 7, 7, 4,7),
    (8, 8, 8, 8, 3,8),
    (9, 9, 9, 9, 2,9),
	(10,10, 10, 10,1,10);

--consultas
Select * from Clientes5;
Select * from comentarios_o_quejas;
Select * from Configuracion;
Select * from Empleados5;
Select * from Espacios;
Select * from eventos;
Select * from mantenimiento;
Select * from Pagos5;
Select * from Permisos;
Select * from Reservas5;
Select * from Roles;
Select * from Tarifas5;
Select * from transacciones;
Select * from Usuarios;
Select * from vehiculo;


--VISTAS
CREATE VIEW ReservasView AS
SELECT r.ID_reserva, r.Fecha_inicio, r.Hora_inicio, r.Fecha_fin, r.Hora_fin, e.Nombre AS espacio_nombre, e.descripcion AS espacio_descripcion, e.Disponible, 
c.Nombre AS cliente_nombre, c.Apellido AS cliente_apellido, c.Correo_electrónico AS cliente_correo, u.Nombre AS usuario_nombre, u.Apellido AS usuario_apellido, 
u.Correo_electrónico AS usuario_correo
FROM Reservas5 r
JOIN Espacios e ON r.ID_espacio_est = e.ID_espacio_est
JOIN Clientes5 c ON r.ID_cliente = c.ID_cliente
JOIN Usuarios u ON r.ID_usuario = u.ID_usuario;

CREATE VIEW PagosView AS
SELECT p.ID_pago, p.Fecha_inicio, p.Hora_inicio, p.Fecha_fin, p.Hora_fin, t.Tipo AS tarifa_tipo, t.Precio AS tarifa_precio, e.Nombre AS espacio_nombre, c.Nombre AS cliente_nombre, 
c.Apellido AS cliente_apellido, c.Correo_electrónico AS cliente_correo, u.Nombre AS usuario_nombre, u.Apellido AS usuario_apellido, u.Correo_electrónico AS usuario_correo
FROM Pagos5 p
JOIN Tarifas5 t ON p.ID_tarifa = t.ID_tarifa
JOIN Espacios e ON p.ID_espacio_est = e.ID_espacio_est
JOIN Clientes5 c ON p.ID_cliente = c.ID_cliente
JOIN Usuarios u ON p.ID_usuario = u.ID_usuario;

CREATE VIEW Available_Parking_Spaces AS
SELECT ID_espacio_est, descripcion, Nombre, Disponible
FROM Espacios
WHERE Disponible = 1;

SELECT * FROM ReservasView;
SELECT * FROM PagosView;
SELECT * FROM Available_Parking_Spaces;

--creacion de los triggers
create trigger t_cliente
on Clientes5
after insert
as
print concat('el cliente se registro el', getDate());
go

create trigger t_vehiculo
on vehiculo
after insert
as
print concat('el vehiculo se registro el', getDate());
go

create trigger t_usuario
on Usuarios
after insert
as
print concat('el usuario se registro el', getDate());
go

--creacion store procedure
--inserta un nuevo usuario
CREATE PROCEDURE SP_InsertarUsuario
    @ID_usuario INT,
    @ID_empleado INT,
    @ID_rol INT,
    @ID_permiso INT,
    @ID_configuracion INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Correo_electrónico VARCHAR(100),
    @Contraseña VARCHAR(100)
AS
BEGIN
    INSERT INTO Usuarios (ID_usuario, ID_empleado, ID_rol, ID_permiso, ID_configuracion, Nombre, Apellido, Correo_electrónico, Contraseña)
    VALUES (@ID_usuario, @ID_empleado, @ID_rol, @ID_permiso, @ID_configuracion, @Nombre, @Apellido, @Correo_electrónico, @Contraseña)
END
--actualiza un cliente
CREATE PROCEDURE SP_ActualizarCliente
    @ID_cliente INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Correo_electrónico VARCHAR(100)
AS
BEGIN
    UPDATE Clientes5
    SET Nombre = @Nombre, Apellido = @Apellido, Correo_electrónico = @Correo_electrónico
    WHERE ID_cliente = @ID_cliente
END
--elimina un espacio del estacionamiento
CREATE PROCEDURE SP_EliminarEspacioEst
    @ID_espacio_est INT
AS
BEGIN
    DELETE FROM Espacios
    WHERE ID_espacio_est = @ID_espacio_est
END
