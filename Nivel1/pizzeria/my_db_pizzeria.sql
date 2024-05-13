-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;
-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `c_postal` INT NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Ejemplos clientes
-- -----------------------------------------------------
INSERT INTO Categoria (nombre) 
VALUES('Pizzas'),
('Hamburguesas'),
('Bebidas'),
('Otros');
-- -----------------------------------------------------
-- Table `mydb`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(110) NOT NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `categoria_id_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `categoria_id`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `mydb`.`Categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tienda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `c_postal` VARCHAR(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `tienda_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `modoEntrega` ENUM('Delivery', 'Recogida') NOT NULL,
  `productosQty` INT NOT NULL,
  `productos` VARCHAR(45) NOT NULL,
  `precio_total` INT NOT NULL,
  `tienda_id` INT NOT NULL,
  `empleado_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `empleado_id_idx` (`empleado_id` ASC) VISIBLE,
  INDEX `tienda_id_idx` (`tienda_id` ASC) VISIBLE,
  INDEX `cliente_id_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `tienda_id`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `mydb`.`Tienda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `empleado_id`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `mydb`.`Empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `mydb`.`Cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Pedido_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido_Producto` (
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`pedido_id`, `producto_id`),
  CONSTRAINT `fk_pedido_producto_pedido`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `mydb`.`Pedidos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_producto_producto`
    FOREIGN KEY (`producto_id`)
    REFERENCES `mydb`.`Productos` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Ejemplos clientes
-- -----------------------------------------------------
INSERT INTO Cliente (nombre, apellidos, direccion, c_postal, localidad, provincia, telefono) 
VALUES ('María', 'García López', 'Calle Mayor 123', '28001', 'Madrid', 'Madrid', '912345678'),
('Juan', 'Martínez Rodríguez', 'Avenida Principal 45', '41001', 'Sevilla', 'Sevilla', '955678901'),
('Ana', 'Fernández Pérez', 'Plaza del Sol 8', '28013', 'Madrid', 'Madrid', '910987654'),
('Pedro', 'López Sánchez', 'Calle Gran Vía 50', '28013', 'Madrid', 'Madrid', '915432109'),
('Carmen', 'González Martínez', 'Paseo de Gracia 100', '08008', 'Barcelona', 'Barcelona', '932345678'),
('José', 'Ruiz Jiménez', 'Calle Real 12', '41002', 'Sevilla', 'Sevilla', '954321098'),
('Sara', 'Díaz García', 'Avenida Diagonal 200', '08028', 'Barcelona', 'Barcelona', '936789012'),
('Manuel', 'Martín Pérez', 'Calle Mayor 3', '46001', 'Valencia', 'Valencia', '963456789'),
('Laura', 'Hernández Rodríguez', 'Plaza España 15', '28008', 'Madrid', 'Madrid', '917890123'),
('Miguel', 'Sánchez Gómez', 'Calle Granada 30', '18001', 'Granada', 'Granada', '958765432');

-- Productos de la categoría Pizzas
INSERT INTO Productos (nombre, descripcion, imagen, precio, categoria_id) 
VALUES ('Pizza Margarita', 'Pizza con salsa de tomate y queso mozzarella', 'pizza_margarita.jpg', 10, 1),
('Pizza Pepperoni', 'Pizza con salsa de tomate, queso mozzarella y pepperoni', 'pizza_pepperoni.jpg', 12, 1),

-- Productos de la categoría Hamburguesas
('Hamburguesa Clásica', 'Hamburguesa con carne de res, lechuga, tomate y queso', 'hamburguesa_clasica.jpg', 8, 2),
('Hamburguesa BBQ', 'Hamburguesa con carne de res, salsa BBQ, cebolla y queso cheddar', 'hamburguesa_bbq.jpg', 10, 2),

-- Productos de la categoría Bebidas
('Coca-Cola', 'Refresco de cola', 'cocacola.jpg', 2, 3),
('Agua Mineral', 'Agua mineral sin gas', 'agua_mineral.jpg', 1, 3),

-- Otros productos
('Ensalada César', 'Ensalada con lechuga, pollo, crutones y aderezo César', 'ensalada_cesar.jpg', 6, 4),
('Papas Fritas', 'Papas fritas crujientes y doradas', 'papas_fritas.jpg', 3, 4),
('Helado de Chocolate', 'Helado cremoso sabor chocolate', 'helado_chocolate.jpg', 4, 4),
('Tarta de Queso', 'Deliciosa tarta de queso casera', 'tarta_queso.jpg', 7, 4),
('Sándwich de Pollo', 'Sándwich con pechuga de pollo, lechuga, tomate y mayonesa', 'sandwich_pollo.jpg', 5, 4);

INSERT INTO Tienda (direccion, c_postal, localidad, provincia) 
VALUES ('Calle Mayor 10', '28001', 'Madrid', 'Madrid'),
('Avenida Principal 20', '41001', 'Sevilla', 'Sevilla'),
('Plaza España 5', '08001', 'Barcelona', 'Barcelona'),
('Calle Real 15', '29001', 'Málaga', 'Málaga'),
('Paseo del Prado 25', '28014', 'Madrid', 'Madrid');

INSERT INTO Empleados (nombre, apellidos, NIF, telefono, tienda_id) 
VALUES ('Juan', 'Martínez López', '12345678A', '912345678', '1'),
('María', 'García Fernández', '23456789B', '955678901', '2'),
('Pedro', 'López Rodríguez', '34567890C', '910987654', '3'),
('Ana', 'Fernández Pérez', '45678901D', '915432109', '4'),
('Laura', 'Hernández Martínez', '56789012E', '932345678', '5'),
('David', 'Gómez Sánchez', '67890123F', '954321098', '1'),
('Sara', 'Martín González', '78901234G', '936789012', '2'),
('Pablo', 'Díaz Jiménez', '89012345H', '963456789', '3'),
('Elena', 'Ruiz Gómez', '90123456I', '917890123', '4'),
('Carlos', 'García Pérez', '01234567J', '958765432', '5');

INSERT INTO Pedidos (fecha_hora, modoEntrega, productosQty, productos, precio_total, tienda_id, empleado_id, cliente_id)
VALUES('2024-04-20', 'Delivery', 4, 'Pizza', 23, 1, 3, 2),
('2024-04-15', 'Delivery', 4, 'Pizza', 23, 1, 4, 9),
('2024-03-12', 'Recogida', 4, 'Hamburguesa', 34, 4, 3, 7),
('2024-03-14', 'Delivery', 1, 'Bebidas', 7, 5, 4, 3),
('2024-02-25', 'Recogida', 1, 'Bebidas', 12, 2, 5, 4),
('2024-02-28', 'Recogida', 4, 'Bebidas', 45, 2, 8, 6),
('2024-02-15', 'Delivery', 4, 'Pizza', 10, 5, 10, 8);


-- Ejemplo 1
INSERT INTO Pedido_Producto (pedido_id, producto_id, cantidad) 
VALUES 
      (1, 1, 2),
      (1, 2, 1),
      (2, 3, 3),
      (2, 1, 1),
      (3, 2, 2),
      (3, 3, 1),
      (4, 4, 1),
      (4, 5, 2),
      (5, 1, 3),
      (5, 3, 2);

SET SQL_MODE=@OLD_SQL_MODE;
  SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


/*Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.*/
SELECT 
  SUM(p.productosQty) as cantidad_productos,
  c.localidad
FROM pedidos p 
INNER JOIN cliente c 
  ON c.id = p.cliente_id
INNER JOIN pedido_producto o 
  ON p.id = o.pedido_id
INNER JOIN productos r
  ON r.id = o.producto_id
INNER JOIN categoria t 
  ON t.id = r.categoria_id
WHERE t.nombre = 'Bebidas'
GROUP BY c.localidad;

/*Llista quantes comandes ha efectuat un determinat empleat/da.*/
SELECT COUNT(id) AS pedidos_efectuado FROM pedidos
WHERE empleado_id = 3;