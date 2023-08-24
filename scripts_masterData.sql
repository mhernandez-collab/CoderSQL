-- Schema
CREATE SCHEMA `masterData` ;
-- tables
-- Table: clientes_erp
CREATE TABLE clientes_erp (
    client_id varchar(10) NOT NULL,
    name varchar(35) NOT NULL,
    organizacion varchar(4) NOT NULL,
    channel varchar(2) NOT NULL,
    centro varchar(4) NOT NULL,
    softdeleteflag bit(1) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    country varchar(2) NOT NULL,
    CONSTRAINT pk_clientes PRIMARY KEY (client_id, organizacion, centro)
);

-- Table: material_erp
CREATE TABLE material_erp (
    mat_id varchar(18) NOT NULL,
    descripcion varchar(35) NOT NULL,
    organizacion varchar(4) NOT NULL,
    centro varchar(4) NOT NULL,
    softdeleteflag bit(1) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    country varchar(2) NOT NULL,
    unidad_medida varchar(3) NOT NULL,
    CONSTRAINT pk_material PRIMARY KEY (mat_id, organizacion, centro)
);

-- Table: inventory
CREATE TABLE inventory (
    mat_id varchar(18) NOT NULL,
    descripcion varchar(35) NOT NULL,
    centro varchar(4) NOT NULL,
    quantity int(4) NOT NULL,
    softdeleteflag bit(1) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    country varchar(2) NOT NULL,
    unidad_medida varchar(3) NOT NULL,
    CONSTRAINT pk_inventory PRIMARY KEY (mat_id, centro)
);

-- Table: t_order
CREATE TABLE t_order (
    order_id varchar(35) NOT NULL,
    client_id varchar(10) NOT NULL,
    order_type varchar(4) NOT NULL,
    status varchar(8) NOT NULL,
    order_json text(500000),
    softdeleteflag bit(1) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_t_order PRIMARY KEY (order_id, client_id)
);

-- Table: t_material
CREATE TABLE t_material (
    order_id varchar(35) NOT NULL,
    client_id varchar(10) NOT NULL,
    mat_id varchar(18) NOT NULL,
    quantity int(15) NOT NULL,
    softdeleteflag bit(1) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_t_material PRIMARY KEY (order_id, client_id,mat_id)
);

-- Table: facturacion
CREATE TABLE facturacion (
    order_id varchar(35) NOT NULL,
    client_id varchar(10) NOT NULL,
    invoice_id varchar(10) NOT NULL,
    total int(15) NOT NULL,
    softdeleteflag bit(1) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_facturacion PRIMARY KEY (order_id, client_id,invoice_id)
);








