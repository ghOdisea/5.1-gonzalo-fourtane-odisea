DROP database IF EXISTS my_sql_structure_optica;
CREATE database my_sql_structure_optica;
USE my_sql_structure_optica;

CREATE TABLE proveedores(
	id int NOT NULL AUTO_INCREMENT,
    nombre varchar(60) NOT NULL,
    direccion varchar(60) NOT NULL,
    telefono int NOT NULL,
    fax int,
    NIF varchar(11),
    PRIMARY KEY (id)
    );

CREATE TABLE clientes(
	id int NOT NULL AUTO_INCREMENT,
    nombre varchar(55) NOT NULL,
    direccion varchar(55) NOT NULL,
    telefono int NOT NULL,
    email varchar(35) NOT NULL,
    fechaRegistro varchar(25) NOT NULL,
    recomended boolean,
    idRecommend int,
    PRIMARY KEY (id),
    FOREIGN KEY (idRecommend) REFERENCES clientes(id)
    );
        
CREATE TABLE empleados(
	id int NOT NULL AUTO_INCREMENT,
    nombre varchar(55) NOT NULL,
    PRIMARY KEY (id)
    );

CREATE TABLE gafas(
	id int NOT NULL AUTO_INCREMENT,
    marca varchar(60) NOT NULL,
    graduacionI varchar(11) NOT NULL,
    graduacionD varchar(11) NOT NULL,
    tipoMontura varchar(25) NOT NULL,
    colorMontura varchar(25),
    colorCristales varchar(25),
    precio float NOT NULL,
    idProveedor int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idProveedor) REFERENCES proveedores(id)    
    );
        
CREATE TABLE ventas (
	id int primary key not null auto_increment,
    idGafas int not null,
    idEmpleado int not null,
    idCliente int not null,
    fechaVenta date not null,
    foreign key (idGafas) references gafas(id),
    foreign key (idEmpleado) references empleados(id),
    foreign key (idCliente) references clientes(id)
    );

INSERT INTO proveedores (nombre, direccion, telefono, NIF)
VALUES('Opticas Barcelona', 'Gran via de les corts catalanes 203', 93845617, '85479632Y'),
	('Opticas Barcelona', "Avda. del Portal de l'Angel, 23", 97535617, '78979632Y'),
	('Barcelona Eyewear', 'C. de Sant Carles, 3', 94565617, '85479603P'),
	('Optica Universitaria', "Av. d'Icària, 162-164, Local 58", 90985617, '88779632Y'),
	('Multiopticas', 'Gran via de les corts catalanes 506', 91255617, '85479632G'),
	('gafas.es', 'Gran via de les corts catalanes 203', 93876617, '45979632Y'),
	('Barna Gafas', 'Av. Sarria 75', 8457621, '3456981L');

INSERT INTO clientes (nombre, direccion, telefono, email, fechaRegistro) 
VALUES ("María García", "Calle de la Luna 123", 555123456, "maria.garcia@example.com", "2024-04-16"),
	("Juan Martínez", "Avenida del Sol 456", 555789012, "juan.martinez@example.com", "2016-04-16"),
	("Ana Rodríguez", "Plaza Mayor 789", 555234567, "ana.rodriguez@example.com", "2018-04-16"),
	("Pedro Sánchez", "Paseo de la Libertad 234", 555890123, "pedro.sanchez@example.com", "2024-04-16"),
	("Laura López", "Calle de la Rosa 567", 555345678, "laura.lopez@example.com", "2014-04-16"),
	("Carlos Fernández", "Avenida de la Paz 890", 555901234, "carlos.fernandez@example.com", "2020-04-16"),
	("Sofía Pérez", "Carrer de la Plaça 345", 555456789, "sofia.perez@example.com", "2023-04-16"),
	("David Ruiz", "Calle del Sol 678", 555567890, "david.ruiz@example.com", "2022-04-16"),
	("Elena González", "Rua da Praia 901", 555678901, "elena.gonzalez@example.com", "2021-04-16"),
	("Miguel Martínez", "Paseo del Parque 123", 555789012, "miguel.martinez@example.com", "2019-04-16");

INSERT INTO empleados (nombre)
VALUES ('Juan'),('Maria'),('Pedro'),('Facundo'),('Rosa');

INSERT INTO gafas (marca, graduacionI, graduacionD, tipoMontura, colorMontura, colorCristales, precio, idProveedor) 
VALUES ("VistaClara", "+1.50", "+1.50", "Flotante", "Negro", "Transparente", 25.99, 7),
	("OjitosFelices", "+2.00", "+2.25", "Pasta", "Marrón", "Marrón Oscuro", 35.50, 5),
	("VisiónPerfecta", "+1.75", "+1.75", "Metalica", "Azul", "Azul Claro", 29.99, 3),
	("EleganciaOptica", "+2.25", "+2.00", "Pasta", "Gris", "Gris Ahumado", 42.75, 3),
	("SolucionesVisuales", "+1.00", "+1.25", "Metalica", "Rojo", "Transparente", 19.99, 4),
	("ModaVisual", "+2.50", "+2.50", "Pasta", "Negro", "Negro Ahumado", 38.99, 2),
	("OpticaFácil", "+1.75", "+2.00", "Flotante", "Verde", "Verde Claro", 27.50, 7),
	("EstiloClásico", "+2.25", "+2.25", "Pasta", "Marrón", "Marrón Claro", 33.75, 2),
	("GafasChic", "+1.50", "+1.75", "Metalica", "Azul", "Transparente", 29.99, 6),
	("TendenciaVisual", "+2.00", "+2.25", "Metalica", "Negro", "Negro Ahumado", 45.50, 5),
	("DiseñoÚnico", "+1.25", "+1.25", "Pasta", "Blanco", "Transparente", 22.99, 2),
	("EstiloModerno", "+2.00", "+2.00", "Pasta", "Plateado", "Gris Ahumado", 39.99, 3),
	("ClásicosElegantes", "+1.75", "+1.75", "Metalica", "Gris", "Transparente", 28.50, 7),
	("VistaJuvenil", "+1.50", "+1.50", "Flotante", "Rojo", "Rojo Oscuro", 31.75, 1),
	("GafasDeModa", "+2.25", "+2.25", "Metalica", "Negro", "Negro Ahumado", 37.99, 3);
    
INSERT INTO ventas (idGafas, idEmpleado, idCliente, fechaVenta)
VALUES 
(3, 1, 4, '2024-02-10'),
(1, 2, 8, '2023-03-10'),
(2, 3, 6, '2023-04-10'),
(3, 4, 5, '2023-05-10'),
(5, 5, 10,'2023-06-10'),
(3, 5, 10,'2023-07-10'),
(2, 1, 3,'2024-02-10'),
(1, 2, 10,'2024-02-10'),
(1, 5, 3,'2021-01-10'),
(7, 2, 3,'2021-07-10'),
(15, 1, 4,'2020-02-10'),
(1, 2, 9,'2020-12-02');

-- Listado de compras de un cliente --
SELECT c.nombre as Cliente, 
				g.marca as Marca, 
				g.precio as Precio, 
				v.fechaVenta as FechaDeCompra 
from ventas v 
join gafas g on v.idGafas = g.id
join clientes c on v.idCliente = c.id
where c.id = 3;

-- Listado de gafas vendidas por un empleado en un año -- 
SELECT 	count(g.id) as Cantidad,
		g.marca as MarcaGafas,
		e.nombre as Empleado,
        v.fechaVenta as FechaDeVenta,
        g.precio as Precio
from ventas v 
join empleados e on v.idEmpleado = e.id
join gafas g on v.idGafas = g.id
where e.id = 5 and year(v.fechaVenta) = '2023'
group by g.marca, g.precio, e.nombre, v.fechaVenta;

-- Listado de proveedores que hayan suministrado gafas vendidas -- 
SELECT  g.marca as Marca,
		p.nombre as Proveedor,
		count(g.id) as UnidadesVendidas
from ventas v 
join gafas g on v.idGafas = g.id
join proveedores p 
where g.idProveedor = p.id
group by p.nombre, g.marca;


