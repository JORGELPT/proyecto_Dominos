-- ============================================================
-- BACKUP / SCRIPT SQL — dominospizza_RA5
-- Proyecto Final 5to DAAI — Sistema Domino's Pizza
-- Generado: 2026-05-12
-- ============================================================

USE master;
GO

-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'dominospizza_RA5')
BEGIN
    CREATE DATABASE dominospizza_RA5;
END
GO

USE dominospizza_RA5;
GO

-- ============================================================
-- TABLAS BASE (sin dependencias)
-- ============================================================

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_persona')
CREATE TABLE tbl_persona (
    id_persona INT IDENTITY(1,1) PRIMARY KEY,
    nombre     VARCHAR(100) NOT NULL,
    cedula     VARCHAR(20)  UNIQUE,
    tel        VARCHAR(20),
    correo     VARCHAR(100),
    direccion  VARCHAR(200)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_usuario')
CREATE TABLE tbl_usuario (
    id_usuario         INT IDENTITY(1,1) PRIMARY KEY,
    codigo_usuario     VARCHAR(50)  NOT NULL UNIQUE,
    contrasena         VARCHAR(255) NOT NULL,
    id_persona         INT REFERENCES tbl_persona(id_persona),
    rol                VARCHAR(30)  DEFAULT 'empleado',
    ultimo_acceso      DATETIME,
    intentos_fallidos  INT DEFAULT 0
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_departamento')
CREATE TABLE tbl_departamento (
    id_departamento      INT IDENTITY(1,1) PRIMARY KEY,
    nombre_departamento  VARCHAR(100) NOT NULL
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_cargo')
CREATE TABLE tbl_cargo (
    id_cargo        INT IDENTITY(1,1) PRIMARY KEY,
    nombre_cargo    VARCHAR(100) NOT NULL,
    id_departamento INT REFERENCES tbl_departamento(id_departamento)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_sucursal')
CREATE TABLE tbl_sucursal (
    id_sucursal     INT IDENTITY(1,1) PRIMARY KEY,
    nombre_sucursal VARCHAR(100) NOT NULL,
    direccion       VARCHAR(200),
    tel             VARCHAR(20)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_empleado')
CREATE TABLE tbl_empleado (
    id_empleado INT IDENTITY(1,1) PRIMARY KEY,
    id_persona  INT REFERENCES tbl_persona(id_persona),
    id_cargo    INT REFERENCES tbl_cargo(id_cargo),
    id_sucursal INT REFERENCES tbl_sucursal(id_sucursal),
    horario     VARCHAR(50),
    salario     DECIMAL(10,2)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_tecnico')
CREATE TABLE tbl_tecnico (
    id_tecnico     INT IDENTITY(1,1) PRIMARY KEY,
    id_persona     INT REFERENCES tbl_persona(id_persona),
    especialidad   VARCHAR(100),
    disponibilidad VARCHAR(50)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_maquina')
CREATE TABLE tbl_maquina (
    id_maquina     INT IDENTITY(1,1) PRIMARY KEY,
    nombre_maquina VARCHAR(100) NOT NULL,
    modelo         VARCHAR(100),
    estado         VARCHAR(30) DEFAULT 'Activa',
    id_sucursal    INT REFERENCES tbl_sucursal(id_sucursal)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_mantenimiento')
CREATE TABLE tbl_mantenimiento (
    id_mantenimiento INT IDENTITY(1,1) PRIMARY KEY,
    id_maquina       INT REFERENCES tbl_maquina(id_maquina),
    id_tecnico       INT REFERENCES tbl_tecnico(id_tecnico),
    fecha            DATE,
    descripcion      VARCHAR(300),
    costo            DECIMAL(10,2)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_fallos_maquina')
CREATE TABLE tbl_fallos_maquina (
    id_fallo    INT IDENTITY(1,1) PRIMARY KEY,
    id_maquina  INT REFERENCES tbl_maquina(id_maquina),
    fecha       DATE,
    descripcion VARCHAR(300),
    gravedad    VARCHAR(30)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_proveedor')
CREATE TABLE tbl_proveedor (
    id_proveedor    INT IDENTITY(1,1) PRIMARY KEY,
    nombre_proveedor VARCHAR(100) NOT NULL,
    tel             VARCHAR(20),
    correo          VARCHAR(100),
    direccion       VARCHAR(200)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_ingrediente')
CREATE TABLE tbl_ingrediente (
    id_ingrediente   INT IDENTITY(1,1) PRIMARY KEY,
    nombre_ingrediente VARCHAR(100) NOT NULL,
    unidad_medida    VARCHAR(30),
    stock            DECIMAL(10,2) DEFAULT 0
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_producto')
CREATE TABLE tbl_producto (
    id_producto    INT IDENTITY(1,1) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio         DECIMAL(10,2) NOT NULL,
    categoria      VARCHAR(50),
    descripcion    VARCHAR(200)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_cliente')
CREATE TABLE tbl_cliente (
    id_cliente  INT IDENTITY(1,1) PRIMARY KEY,
    id_persona  INT REFERENCES tbl_persona(id_persona),
    fecha_reg   DATE DEFAULT GETDATE()
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_pedido')
CREATE TABLE tbl_pedido (
    id_pedido   INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente  INT REFERENCES tbl_persona(id_persona),
    fecha       DATE DEFAULT GETDATE(),
    total       DECIMAL(10,2),
    estado      VARCHAR(30) DEFAULT 'Pendiente'
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_detalle_pedido')
CREATE TABLE tbl_detalle_pedido (
    id_detalle  INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido   INT REFERENCES tbl_pedido(id_pedido),
    id_producto INT REFERENCES tbl_producto(id_producto),
    cantidad    INT NOT NULL,
    precio_unit DECIMAL(10,2)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_comprobante')
CREATE TABLE tbl_comprobante (
    id_comprobante INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido      INT REFERENCES tbl_pedido(id_pedido),
    fecha          DATE DEFAULT GETDATE(),
    monto          DECIMAL(10,2),
    tipo           VARCHAR(30)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_devolucion')
CREATE TABLE tbl_devolucion (
    id_devolucion INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido     INT REFERENCES tbl_pedido(id_pedido),
    motivo        VARCHAR(100),
    monto         DECIMAL(10,2),
    fecha         DATE DEFAULT GETDATE(),
    descripcion   VARCHAR(300)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_compra')
CREATE TABLE tbl_compra (
    id_compra       INT IDENTITY(1,1) PRIMARY KEY,
    id_proveedor    INT REFERENCES tbl_proveedor(id_proveedor),
    monto           DECIMAL(10,2),
    monto_pendiente DECIMAL(10,2) DEFAULT 0,
    fecha           DATE,
    cantidad        INT,
    id_sucursal     INT REFERENCES tbl_sucursal(id_sucursal),
    precio          DECIMAL(10,2),
    observacion     VARCHAR(300),
    estado          VARCHAR(30) DEFAULT 'Pendiente'
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_metodo_envio')
CREATE TABLE tbl_metodo_envio (
    id_metodo_envio INT IDENTITY(1,1) PRIMARY KEY,
    descripcion     VARCHAR(100)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_envio')
CREATE TABLE tbl_envio (
    id_envio        INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido       INT REFERENCES tbl_pedido(id_pedido),
    costo_servicio  DECIMAL(10,2),
    id_metodo_envio INT REFERENCES tbl_metodo_envio(id_metodo_envio),
    observacion     VARCHAR(300),
    direccion       VARCHAR(200)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_apertura_caja')
CREATE TABLE tbl_apertura_caja (
    id_apertura_caja INT IDENTITY(1,1) PRIMARY KEY,
    fecha_apertura   DATETIME DEFAULT GETDATE(),
    monto_inicial    DECIMAL(10,2),
    id_empleado      INT REFERENCES tbl_empleado(id_empleado)
);
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tbl_reclamacion')
CREATE TABLE tbl_reclamacion (
    id_reclamacion INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente     INT REFERENCES tbl_persona(id_persona),
    descripcion    VARCHAR(500),
    fecha          DATE DEFAULT GETDATE(),
    estado         VARCHAR(30) DEFAULT 'Abierta'
);
GO

-- ============================================================
-- DATOS DE EJEMPLO
-- ============================================================

-- Departamentos base
IF NOT EXISTS (SELECT 1 FROM tbl_departamento)
BEGIN
    INSERT INTO tbl_departamento (nombre_departamento) VALUES
        ('Cocina'), ('Entrega'), ('Administración'), ('Mantenimiento'), ('Atención al Cliente');
END
GO

-- Cargos base
IF NOT EXISTS (SELECT 1 FROM tbl_cargo)
BEGIN
    INSERT INTO tbl_cargo (nombre_cargo, id_departamento) VALUES
        ('Chef Principal', 1), ('Cocinero', 1),
        ('Repartidor', 2), ('Supervisor de Entrega', 2),
        ('Gerente', 3), ('Contador', 3),
        ('Técnico de Equipos', 4),
        ('Cajero', 5), ('Atención al Cliente', 5);
END
GO

-- Métodos de envío base
IF NOT EXISTS (SELECT 1 FROM tbl_metodo_envio)
BEGIN
    INSERT INTO tbl_metodo_envio (descripcion) VALUES
        ('Propio'), ('Externo'), ('Recogida en tienda');
END
GO

PRINT 'Script ejecutado correctamente — dominospizza_RA5';
GO
