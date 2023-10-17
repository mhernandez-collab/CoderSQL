-- ********************************************************CREACION DE ESQUEMA******************************************************************

-- Schema
CREATE SCHEMA `masterData` ;

-- ********************************************************CREACION DE TABLAS******************************************************************

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

-- ********************************************************INSERCION DE DATOS******************************************************************


-- INSERCION DE DATOS
-- Insert clientes erp

INSERT INTO `masterData`.`clientes_erp`
(`client_id`,
`name`,
`organizacion`,
`channel`,
`centro`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`)
VALUES
(00000000001, 'Martin', 'VK00', '00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE'),
(00000000002, 'Diego', 'VK01', '01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE'),
(00000000003, 'Juan', 'VK02', '02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE'),
(00000000004, 'Federico', 'DH00', '00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN'),
(00000000005, 'Lucía', 'DH01', '01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN'),
(00000000006, 'Eugenia', 'DH02', '02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN'),
(00000000007, 'Tomas', 'EH00', '00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC'),
(00000000008, 'Berenice', 'EH01', '01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC'),
(00000000009, 'Lauro', 'EH02', '02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC'),
(00000000010, 'Ernesto', 'AV00', '00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO'),
(00000000011, 'Alejandro', 'AV01', '01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO'),
(00000000012, 'José', 'AV02', '02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO');
select * from masterData.clientes_erp;


-- ********************************************************MODIFICACION DE TABLAS******************************************************************

-- Modificacion tabla facturacion, se añaden 3 campos para uso de vista

ALTER TABLE `masterData`.`facturacion` 
ADD COLUMN `status` VARCHAR(2) NOT NULL AFTER `total`,
ADD COLUMN `status_doc` VARCHAR(15) NOT NULL AFTER `status`,
ADD COLUMN `mat_id` VARCHAR(45) NOT NULL AFTER `status_doc`;

-- Insert facturacion
select * from masterData.facturacion;
INSERT INTO `masterData`.`facturacion`
(`order_id`,
`client_id`,
`invoice_id`,
`total`,
`status`,
`status_doc`,
`mat_id`,
`softdeleteflag`,
`dtlastmodifieddate`)
VALUES
('PEUAT0000001', 1000000001, 1629000000, 50.25,'01','No Pagado','1000000001', 0, CURRENT_TIMESTAMP),
('PEUAT0000002', 1000000001, 1629000001, 75.50,'01','No Pagado','1000000002', 0, CURRENT_TIMESTAMP),
('PEUAT0000003', 1000000001, 1629000002, 60.75,'01','No Pagado','1000000003', 0, CURRENT_TIMESTAMP),
('PEUAT0000004', 1000000001, 1629000003, 50.25,'01','No Pagado','1000000003', 0, CURRENT_TIMESTAMP),
('PEUAT0000005', 1000000001, 1629000004, 50.25,'01','No Pagado','1000000004', 0, CURRENT_TIMESTAMP),
('PEUAT0000006', 1000000003, 1629000005, 50.25,'01','No Pagado','1000000005', 0, CURRENT_TIMESTAMP),
('HNUAT0000001', 1000000005, 1629000006, 45.00,'01','No Pagado','1000000001', 0, CURRENT_TIMESTAMP),
('HNUAT0000002', 1000000005, 1629000007, 90.25,'01','No Pagado','1000000005', 0, CURRENT_TIMESTAMP),
('ECUAT0000001', 1000000007, 1629000008, 35.50,'01','No Pagado','1000000001', 0, CURRENT_TIMESTAMP),
('ECUAT0000002', 1000000007, 1629000009, 70.75,'01','No Pagado','1000000002', 0, CURRENT_TIMESTAMP),
('ECUAT0000003', 1000000007, 1629000010, 55.00,'01','No Pagado','1000000003', 0, CURRENT_TIMESTAMP),
('ECUAT0000004', 1000000009, 1629000011, 80.25,'01','No Pagado','1000000001', 0, CURRENT_TIMESTAMP),
('ECUAT0000005', 1000000009, 1629000012, 80.25,'01','No Pagado','1000000004', 0, CURRENT_TIMESTAMP),
('ECUAT0000006', 1000000009, 1629000013, 80.25,'01','No Pagado','1000000005', 0, CURRENT_TIMESTAMP),
('COUAT0000001', 1000000012, 1629000014, 65.50,'01','No Pagado','1000000001', 0, CURRENT_TIMESTAMP),
('COUAT0000002', 1000000012, 1629000015, 40.75,'01','No Pagado','1000000005', 0, CURRENT_TIMESTAMP),
('COUAT0000003', 1000000012, 1629000016, 95.00,'01','No Pagado','1000000007', 0, CURRENT_TIMESTAMP),
('COUAT0000004', 1000000012, 1629000017, 30.25,'01','No Pagado','1000000010', 0, CURRENT_TIMESTAMP),
('COUAT0000005', 1000000011, 1629000018, 75.50,'01','No Pagado','1000000001', 0, CURRENT_TIMESTAMP),
('COUAT0000006', 1000000011, 1629000019, 75.50,'01','No Pagado','1000000002', 0, CURRENT_TIMESTAMP),
('COUAT0000007', 1000000011, 1629000020, 75.50,'01','No Pagado','1000000003', 0, CURRENT_TIMESTAMP),
('COUAT0000008', 1000000011, 1629000021, 50.75,'01','No Pagado','1000000005', 0, CURRENT_TIMESTAMP);


-- ********************************************************UPDATE DE REGISTROS******************************************************************


-- Se modifican registros para efectos de prueba con vista
UPDATE `masterData`.`facturacion` SET `status` = '02', `status_doc` = 'Pagado' WHERE (`order_id` = 'COUAT0000008') and (`client_id` = '1000000011') and (`invoice_id` = '1629000021');
UPDATE `masterData`.`facturacion` SET `status` = '02', `status_doc` = 'Pagado' WHERE (`order_id` = 'COUAT0000007') and (`client_id` = '1000000011') and (`invoice_id` = '1629000020');
UPDATE `masterData`.`facturacion` SET `status` = '02', `status_doc` = 'Pagado' WHERE (`order_id` = 'COUAT0000002') and (`client_id` = '1000000012') and (`invoice_id` = '1629000015');
UPDATE `masterData`.`facturacion` SET `status` = '02', `status_doc` = 'Pagado' WHERE (`order_id` = 'ECUAT0000006') and (`client_id` = '1000000009') and (`invoice_id` = '1629000013');
UPDATE `masterData`.`facturacion` SET `status` = '02', `status_doc` = 'Pagado' WHERE (`order_id` = 'PEUAT0000003') and (`client_id` = '1000000001') and (`invoice_id` = '1629000002');

-- Insert material_erp
SELECT * FROM masterData.material_erp;

INSERT INTO `masterData`.`material_erp`
(`mat_id`,
`descripcion`,
`organizacion`,
`centro`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
VALUES
(1000000001, 'Material 1', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000002, 'Material 2', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000003, 'Material 3', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000004, 'Material 4', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000005, 'Material 5', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000006, 'Material 6', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000007, 'Material 7', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000008, 'Material 8', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000009, 'Material 9', 'VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000010, 'Material 10','VK00', 'PE00', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000001, 'Material 1', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000002, 'Material 2', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000003, 'Material 3', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000004, 'Material 4', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000005, 'Material 5', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000006, 'Material 6', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000007, 'Material 7', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000008, 'Material 8', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000009, 'Material 9', 'VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000010, 'Material 10','VK01', 'PE01', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000001, 'Material 1', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000002, 'Material 2', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000003, 'Material 3', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000004, 'Material 4', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000005, 'Material 5', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000006, 'Material 6', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000007, 'Material 7', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000008, 'Material 8', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000009, 'Material 9', 'VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000010, 'Material 10','VK02', 'PE02', 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000001, 'Material 1', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000002, 'Material 2', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000003, 'Material 3', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000004, 'Material 4', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000005, 'Material 5', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000006, 'Material 6', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000007, 'Material 7', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000008, 'Material 8', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000009, 'Material 9', 'DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000010, 'Material 10','DH00', 'HN00', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000001, 'Material 1', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000002, 'Material 2', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000003, 'Material 3', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000004, 'Material 4', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000005, 'Material 5', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000006, 'Material 6', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000007, 'Material 7', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000008, 'Material 8', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000009, 'Material 9', 'DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000010, 'Material 10','DH01', 'HN01', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000001, 'Material 1', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000002, 'Material 2', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000003, 'Material 3', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000004, 'Material 4', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000005, 'Material 5', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000006, 'Material 6', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000007, 'Material 7', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000008, 'Material 8', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000009, 'Material 9', 'DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000010, 'Material 10','DH02', 'HN02', 0, CURRENT_TIMESTAMP, 'HN', 'CJ'),
(1000000001, 'Material 1', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000002, 'Material 2', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000003, 'Material 3', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000004, 'Material 4', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000005, 'Material 5', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000006, 'Material 6', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000007, 'Material 7', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000008, 'Material 8', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000009, 'Material 9', 'EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000010, 'Material 10','EH00', 'EC00', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000001, 'Material 1', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000002, 'Material 2', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000003, 'Material 3', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000004, 'Material 4', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000005, 'Material 5', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000006, 'Material 6', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000007, 'Material 7', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000008, 'Material 8', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000009, 'Material 9', 'EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000010, 'Material 10','EH01', 'EC01', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000001, 'Material 1', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000002, 'Material 2', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000003, 'Material 3', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000004, 'Material 4', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000005, 'Material 5', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000006, 'Material 6', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000007, 'Material 7', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000008, 'Material 8', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000009, 'Material 9', 'EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000010, 'Material 10','EH02', 'EC02', 0, CURRENT_TIMESTAMP, 'EC', 'CJ'),
(1000000001, 'Material 1', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000002, 'Material 2', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000003, 'Material 3', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000004, 'Material 4', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000005, 'Material 5', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000006, 'Material 6', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000007, 'Material 7', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000008, 'Material 8', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000009, 'Material 9', 'AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000010, 'Material 10','AV00', 'CO00', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000001, 'Material 1', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000002, 'Material 2', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000003, 'Material 3', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000004, 'Material 4', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000005, 'Material 5', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000006, 'Material 6', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000007, 'Material 7', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000008, 'Material 8', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000009, 'Material 9', 'AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000010, 'Material 10','AV01', 'CO01', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000001, 'Material 1', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000002, 'Material 2', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000003, 'Material 3', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000004, 'Material 4', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000005, 'Material 5', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000006, 'Material 6', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000007, 'Material 7', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000008, 'Material 8', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000009, 'Material 9', 'AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ'),
(1000000010, 'Material 10','AV02', 'CO02', 0, CURRENT_TIMESTAMP, 'CO', 'CJ');

-- Insert inventory
select * from masterData.inventory;

INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
VALUES
(1000000001, 'Material 1', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000002, 'Material 2', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000003, 'Material 3', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000004, 'Material 4', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000005, 'Material 5', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000006, 'Material 6', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000007, 'Material 7', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000008, 'Material 8', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000009, 'Material 9', 'PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ'),
(1000000010, 'Material 10','PE00', 10000, 0, CURRENT_TIMESTAMP, 'PE', 'CJ');

-- Insert con importacion: 

INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'PE01' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';
  
INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'PE02' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';

-- Insert inventario Honduras

INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'HN00' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'HN' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';
  
INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'HN01' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'HN' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';

INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'HN02' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'HN' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';
  
-- Insert inventario ecuador  

INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'EC00' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'EC' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';
  
INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'EC01' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'EC' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';
  
INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'EC02' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'EC' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';

-- Insert inventario colombia

INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'CO00' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'CO' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';
  
INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'CO01' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'CO' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';
  
INSERT INTO `masterData`.`inventory`
(`mat_id`,
`descripcion`,
`centro`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`,
`country`,
`unidad_medida`)
SELECT
  `mat_id`,
  `descripcion`,
  'CO02' AS `centro`,
  `quantity`,
  `softdeleteflag`,
  CURRENT_TIMESTAMP AS `dtlastmodifieddate`,
  'CO' AS `country`,
  `unidad_medida`
FROM
  `masterData`.`inventory`
WHERE
  `centro` = 'PE00';

-- Insert t_order
select * from masterData.t_order;

INSERT INTO `masterData`.`t_order`
(`order_id`,
`client_id`,
`order_type`,
`status`,
`order_json`,
`softdeleteflag`,
`dtlastmodifieddate`)
VALUES
('PEUAT0000001', 1000000001, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('PEUAT0000002', 1000000001, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}',0, CURRENT_TIMESTAMP),
('PEUAT0000003', 1000000001, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}',0, CURRENT_TIMESTAMP),
('PEUAT0000004', 1000000001, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('PEUAT0000005', 1000000001, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}',0, CURRENT_TIMESTAMP),
('PEUAT0000006', 1000000003, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}',0, CURRENT_TIMESTAMP),
('HNUAT0000001', 1000000005, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('HNUAT0000002', 1000000005, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('ECUAT0000001', 1000000007, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('ECUAT0000002', 1000000007, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('ECUAT0000003', 1000000007, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}',0, CURRENT_TIMESTAMP),
('ECUAT0000004', 1000000009, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('ECUAT0000005', 1000000009, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('ECUAT0000006', 1000000009, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000001', 1000000012, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000002', 1000000012, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000003', 1000000012, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000004', 1000000012, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000005', 1000000011, 'APP','Pending', '{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000006', 1000000011, 'APP','Pending','{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000007', 1000000011, 'APP','Pending','{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP),
('COUAT0000008', 1000000011, 'APP','Pending','{"audit":{"createAt":"2023-09-01T16:21:01.641Z","updateAt":"2023-09-01T16:21:01.641Z"},"beesAccountId":"5a4c720e-491f-455e-be55-1fe35918a6c4","channel":"B2B_APP","combos":[],"delivery":{"date":"2023-09-04","windowId":"DC-0013410657-20230904","type":"FLEX","deliveryCenterId":"DH00","distributionCenters":[],"fee":{"value":20,"maximumOrderTotal":2000}},"empties":{"extraAmount":0,"discountForExtraEmpties":0,"hasEmpties":false,"minimumRequired":31,"totalAmount":31},"items":[{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013913"},"key":"f496316b-4af0-4171-83d6-b49fe466a750","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":405,"browsePriceInclDiscounts":350,"price":343.22,"total":350,"discountAmount":55,"basePrice":343.22}],"summaryItem":{"discount":1398.28,"price":350,"originalPrice":405,"subtotal":8898.33,"total":10500.03,"taxes":[{"id":"IVA","value":1601.7}],"charges":[],"discounts":[{"type":"SCALED_LINE_ITEM_DISCOUNT","externalId":"6239310","value":1398.28,"vendorDealId":"6239310","vendorPromotionId":"6239310","discountPercentage":13.58}]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013913","type":"REGULAR","quantity":30,"itemClassification":"REGULAR","name":"IMPERIAL 355ML VIDRIO RET","sku":"000000000000013913"},{"package":{"itemCount":24,"packageId":"24 Un. x Caja","unitCount":1,"pack":"CAJA","name":"24 Un. x Caja"},"dynamicAttributes":{"sku":"000000000000013917"},"key":"d298212e-e2d1-4bc2-998d-2ad308f23a25","measureUnit":"ML","typeOfUnit":"UN","uom":[{"type":"PACK","browsePrice":445.95,"browsePriceInclDiscounts":445.95,"price":377.92,"total":445.95,"discountAmount":0,"basePrice":377.92}],"summaryItem":{"discount":0,"price":445.95,"originalPrice":445.95,"subtotal":377.92,"total":445.95,"taxes":[{"id":"IVA","value":68.03}],"charges":[],"discounts":[]},"container":{"name":"Vidrio Ret","unitOfMeasurement":"ML","itemSize":355,"returnable":true,"size":355},"vendorItemId":"000000000000013917","type":"REGULAR","quantity":1,"itemClassification":"REGULAR","name":"BARENA 355ML VIDRIO RET","sku":"000000000000013917"}],"orderGenericInfo":{"dynamicAttributes":{}},"orderNumber":"UAT0029581","payment":{"dynamicAttributes":{"paymentMethodCode":"CASH","transactionReferenceId":null},"paymentMethod":"CASH","paymentMethodCode":"CASH"},"placementDate":"2023-09-01T16:21:01+00:00","previousStatus":"PENDING","status":"PENDING","summary":{"discount":1398.28,"subtotal":9276.25,"total":10945.98,"taxes":[{"id":"IVA","value":1669.73}],"charges":[],"aggregateAmount":[],"dynamicValues":{"deposit":0}},"vendor":{"id":"060ea43d-4a3d-4e47-b533-579e2f4e7b35","accountId":"13410657"},"deleted":false}', 0, CURRENT_TIMESTAMP);

-- Insert t_material
select * from masterData.t_material;

INSERT INTO `masterData`.`t_material`
(`order_id`,
`client_id`,
`mat_id`,
`quantity`,
`softdeleteflag`,
`dtlastmodifieddate`)
VALUES
('PEUAT0000001', 1000000001, '1000000001', 3 , 0, CURRENT_TIMESTAMP),
('PEUAT0000001', 1000000001, '1000000005', 2 , 0, CURRENT_TIMESTAMP),
('PEUAT0000002', 1000000001, '1000000006', 4 , 0, CURRENT_TIMESTAMP),
('PEUAT0000002', 1000000001, '1000000007', 2 , 0, CURRENT_TIMESTAMP),
('PEUAT0000003', 1000000001, '1000000007', 2 , 0, CURRENT_TIMESTAMP),
('PEUAT0000004', 1000000001, '1000000008', 5 , 0, CURRENT_TIMESTAMP),
('PEUAT0000004', 1000000001, '1000000010', 1 , 0, CURRENT_TIMESTAMP),
('PEUAT0000005', 1000000001, '1000000006', 10 , 0, CURRENT_TIMESTAMP),
('PEUAT0000006', 1000000003, '1000000010', 1 , 0, CURRENT_TIMESTAMP),
('HNUAT0000001', 1000000005, '1000000006', 20 , 0, CURRENT_TIMESTAMP),
('HNUAT0000002', 1000000005, '1000000007', 3 , 0, CURRENT_TIMESTAMP),
('ECUAT0000001', 1000000007, '1000000002', 2 , 0, CURRENT_TIMESTAMP),
('ECUAT0000002', 1000000007, '1000000004', 8 , 0, CURRENT_TIMESTAMP),
('ECUAT0000003', 1000000007, '1000000002', 3 , 0, CURRENT_TIMESTAMP),
('ECUAT0000003', 1000000007, '1000000005', 4 , 0, CURRENT_TIMESTAMP),
('ECUAT0000003', 1000000007, '1000000009', 4 , 0, CURRENT_TIMESTAMP),
('ECUAT0000004', 1000000009, '1000000001', 5 , 0, CURRENT_TIMESTAMP),
('ECUAT0000004', 1000000009, '1000000002', 5 , 0, CURRENT_TIMESTAMP),
('ECUAT0000005', 1000000009, '1000000010', 8 , 0, CURRENT_TIMESTAMP),
('ECUAT0000006', 1000000009, '1000000003', 10 , 0, CURRENT_TIMESTAMP),
('COUAT0000001', 1000000012, '1000000003', 10 , 0, CURRENT_TIMESTAMP),
('COUAT0000001', 1000000012, '1000000004', 10 , 0, CURRENT_TIMESTAMP),
('COUAT0000002', 1000000012, '1000000002', 10 , 0, CURRENT_TIMESTAMP),
('COUAT0000003', 1000000012, '1000000001', 1 , 0, CURRENT_TIMESTAMP),
('COUAT0000003', 1000000012, '1000000005', 5 , 0, CURRENT_TIMESTAMP),
('COUAT0000003', 1000000012, '1000000008', 8 , 0, CURRENT_TIMESTAMP),
('COUAT0000004', 1000000012, '1000000006', 5 , 0, CURRENT_TIMESTAMP),
('COUAT0000004', 1000000012, '1000000010', 10 , 0, CURRENT_TIMESTAMP),
('COUAT0000005', 1000000011, '1000000007', 5 , 0, CURRENT_TIMESTAMP),
('COUAT0000006', 1000000011, '1000000008', 3 , 0, CURRENT_TIMESTAMP),
('COUAT0000007', 1000000011, '1000000002', 6 , 0, CURRENT_TIMESTAMP),
('COUAT0000007', 1000000011, '1000000004', 6 , 0, CURRENT_TIMESTAMP),
('COUAT0000008', 1000000011, '1000000001', 1 , 0, CURRENT_TIMESTAMP),
('COUAT0000008', 1000000011, '1000000008', 11 , 0, CURRENT_TIMESTAMP);














-- ********************************************************CREACION DE VISTAS******************************************************************



-- VISTAS
-- masterData.delta_invoices2 source
-- obtiene las facturas que sean anteriores a una semana y que no esten pagadas
CREATE OR REPLACE VIEW masterData.delta_invoices
AS SELECT DISTINCT 
	a.order_id AS pedido,
    b.name AS nombre,
    b.channel AS canal,
    b.organizacion AS organizacion,
	a.client_id AS cliente,
    a.invoice_id AS factura,
    a.total AS total,
    a.status_doc AS estado
   FROM masterData.facturacion a
	LEFT JOIN masterData.clientes_erp b ON a.client_id = b.client_id
  WHERE a.dtlastmodifieddate <= now() -7 AND a.status = '01' ;
  
  
-- masterData.delta_accounts source
-- obtiene los clientes que no tengan marcado para borrado y campos especificos para front end
CREATE OR REPLACE VIEW masterData.delta_accounts
AS SELECT DISTINCT 
	a.client_id AS accountid,
    a.name AS nombre,
    a.country AS pais
   FROM masterData.clientes_erp a
  WHERE a.dtlastmodifieddate <= now() AND a.softdeleteflag = '0';
  
-- masterData.delta_inventory source
-- obtiene inventario de los materiales que existan en la tabla erp y no tengan marcado para borrado
CREATE OR REPLACE VIEW masterData.delta_inventory
AS SELECT DISTINCT 
	a.mat_id AS producto,
    a.descripcion AS descripcion,
    a.centro AS locacion,
    a.quantity AS cantidad,
    a.country AS pais,
    b.unidad_medida AS unidad_venta
   FROM masterData.inventory a
INNER JOIN masterData.material_erp b ON a.mat_id = b.mat_id AND a.centro = b.centro AND a.country = b.country
WHERE a.dtlastmodifieddate <= now() AND a.softdeleteflag = '0';

  
-- masterData.delta_update_orders
-- vista para la extraccion de pedidos pendientes por enviar a ERP

CREATE OR REPLACE VIEW masterData.delta_update_orders
AS SELECT 
	a.order_id as pedido,
    a.client_id as cliente,
    a.order_type as tipo,
    a.status as status, 
    a.order_json as strgorder
   FROM masterData.t_order a
WHERE a.status = 'Pending' and a.softdeleteflag = '0';

-- masterData.t_material_batch
-- obtiene los datos de los materiales de un pedido mas algunos datos maestros de la tabla erp y la factura asociada
CREATE OR REPLACE VIEW masterData.t_material_batch
AS SELECT 
	a.order_id as pedido,
    a.client_id as cliente,
    a.mat_id as tipo,
    a.quantity as cantidad,
    b.centro as centro,
    b.organizacion as organizacion,
    c.invoice_id as factura
   FROM masterData.t_material a
	  INNER JOIN masterData.material_erp b ON a.mat_id = b.mat_id 
      INNER JOIN masterData.facturacion c ON a.order_id = c.order_id and a.client_id = c.client_id
WHERE a.softdeleteflag = '0' and c.status = '01';


select * from masterData.t_material_batch







-- ********************************************************CREACION DE FUNCIONES******************************************************************






-- FUNCIONES
-- se cambia tipo de campo total a float en tabla de facturacion 
ALTER TABLE `masterData`.`facturacion` CHANGE COLUMN `total` `total` FLOAT NOT NULL ;



-- Se añaden campos para utilizacion de funcion de calculo de precios mas iva

ALTER TABLE `masterData`.`material_erp` 
ADD COLUMN `net_price` FLOAT NOT NULL DEFAULT 0 AFTER `unidad_medida`,
ADD COLUMN `tax_type` VARCHAR(10) NULL AFTER `net_price`,
ADD COLUMN `tax_amount` FLOAT NOT NULL DEFAULT 0 AFTER `tax_type`;

-- actualizacion de registros para añadir el tipo de impuesto

UPDATE `masterData`.`material_erp` SET `tax_type` = 'IVA';

-- actualizacion de registros para añadir el precio base

UPDATE `masterData`.`material_erp` SET `net_price` = 10.00 WHERE mat_id = '1000000001'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 12.00 WHERE mat_id = '1000000002'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 14.00 WHERE mat_id = '1000000003'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 15.00 WHERE mat_id = '1000000004'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 17.00 WHERE mat_id = '1000000005'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 10.00 WHERE mat_id = '1000000006'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 20.00 WHERE mat_id = '1000000007';
UPDATE `masterData`.`material_erp` SET `net_price` = 21.00 WHERE mat_id = '1000000008'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 12.00 WHERE mat_id = '1000000009'; 
UPDATE `masterData`.`material_erp` SET `net_price` = 14.00 WHERE mat_id = '1000000010';

-- actualizacion de registros para añadir el porcentaje de impuesto por pais

UPDATE `masterData`.`material_erp` SET `tax_amount` = 0.12 WHERE country = 'HN'; 
UPDATE `masterData`.`material_erp` SET `tax_amount` = 0.12 WHERE mat_id = 'EC'; 
UPDATE `masterData`.`material_erp` SET `tax_amount` = 0.19 WHERE mat_id = 'CO';
UPDATE `masterData`.`material_erp` SET `tax_amount` = 0.18 WHERE mat_id = 'PE';  
  

select * from masterData.material_erp;
select * from masterData.facturacion;
select * from masterData.t_material;
select * from masterData.t_order;


-- Funcion para actualizacion de totales en tabla de facturacion 
use masterData;
drop function if exists calculate_order_total;

DELIMITER $$

CREATE FUNCTION calculate_order_total()
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    UPDATE facturacion AS f
    INNER JOIN (
        SELECT DISTINCT tm.order_id, tm.mat_id, (me.net_price * tm.quantity) as total
        FROM t_material AS tm
        INNER JOIN t_order AS tod ON tm.order_id = tod.order_id
        INNER JOIN material_erp AS me ON me.mat_id = tm.mat_id
    ) AS subquery
    ON f.order_id = subquery.order_id
    SET f.total = subquery.total;

    RETURN 'Se actualizaron totales de facturas';
END$$

DELIMITER ;

-- funcion de eliminacion de facturas con antiguedad de 90 dias 

DELIMITER $$

CREATE FUNCTION eliminacion_facturas()
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE days INT;
    SET days = 90;

    CREATE TEMPORARY TABLE temp_invoice_ids AS
    SELECT invoice_id FROM facturacion WHERE dtlastmodifieddate < (NOW() - INTERVAL days DAY);

    DELETE FROM facturacion WHERE invoice_id IN (SELECT invoice_id FROM temp_invoice_ids);

    DROP TEMPORARY TABLE temp_invoice_ids;

    RETURN 'OK';
END$$

DELIMITER ;


SELECT calculate_order_total();
SELECT eliminacion_facturas();


    

    





-- ********************************************************CREACION DE SP******************************************************************







-- STORED PROCEDURES
-- ORDERNAR REGISTROS POR FECHA ASCENCENTE O DESCENDENTE
DELIMITER //

CREATE PROCEDURE OrdenarTablas(IN tabla VARCHAR(255), IN campoOrden VARCHAR(255), IN direccion VARCHAR(10))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tabla, ' ORDER BY ', campoOrden, ' ', direccion);
    PREPARE sentence FROM @query;
    EXECUTE sentence;
    DEALLOCATE PREPARE sentence;
END//

DELIMITER ;

call OrdenarTablas('t_order', 'dtlastmodifieddate', 'ASC');

-- STORED PROCEDURE
-- INSERT Y DELETE

DELIMITER //

CREATE PROCEDURE InsertDeleteAccounts(
    IN client_id VARCHAR(10),
    IN name VARCHAR(35),
    IN organizacion VARCHAR(4),
    IN channel VARCHAR(2),
    IN centro VARCHAR(4),
    IN softdeleteflag bit(1),
    IN dtlastmodifieddate datetime,
    IN country VARCHAR(2),
    IN idEliminar VARCHAR(10)
)
BEGIN
    -- 1. Insertar datos en la tabla "clientes_erp"
    INSERT INTO clientes_erp (`client_id`, `name`, `organizacion`, `channel`, `centro`, `softdeleteflag`, `dtlastmodifieddate`, `country`)
    VALUES (client_id, name, organizacion, channel, centro, softdeleteflag, dtlastmodifieddate, country);

    -- Mostrar información antes de la eliminación
    SELECT * FROM clientes_erp WHERE client_id = idEliminar;

    -- 2. Eliminar un registro específico de la tabla "clientes_erp"
    DELETE FROM clientes_erp WHERE client_id = idEliminar;

    -- Mostrar información después de la eliminación
    SELECT * FROM clientes_erp WHERE client_id = idEliminar;
END//

DELIMITER ;


CALL InsertDeleteAccounts('1000000123', 'INSERTSP', 'AV02', '02', 'CO02', 1, now(), 'CO', '');



















-- TRIGGERS
-- CREACION DE TABLA CLIENTES ESPEJO
CREATE TABLE clientes_nuevos (
	usuario varchar(255) NOT NULL,
    client_id varchar(10) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    country varchar(2) NOT NULL,
    CONSTRAINT pk_clientes_nuevos PRIMARY KEY (client_id, country)
);

-- Facturacion log
-- muestra usuario que creo una factura y fecha
CREATE TABLE facturacion_log (
	usuario varchar(255) NOT NULL,
    invoice_id varchar(10) NOT NULL,
    dtlastmodifieddate datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_facturacion_log PRIMARY KEY (invoice_id)
);

DROP TRIGGER IF EXISTS `masterData`.`clientes_erp_AFTER_INSERT`;

-- TRIGGER CLIENTES
-- muestra usuario que creo un cliente y fecha
DELIMITER $$
USE `masterData`$$
CREATE DEFINER = CURRENT_USER TRIGGER `masterData`.`clientes_erp_AFTER_INSERT` AFTER INSERT ON `clientes_erp` FOR EACH ROW
BEGIN
    DECLARE usuario VARCHAR(255);  -- Declara una variable para el nombre de usuario

    -- Obtiene el nombre de usuario actual de la sesión
    SET usuario = USER();

    -- Inserta los datos en la tabla clientes_nuevos, incluyendo el nombre de usuario
    INSERT INTO clientes_nuevos (usuario, client_id, dtlastmodifieddate, country)
    VALUES (usuario, NEW.client_id, NEW.dtlastmodifieddate, NEW.country);
END;$$
DELIMITER ;

-- TRIGGER FACTURAS
-- muestra usuario que creo una factura y fecha
DROP TRIGGER IF EXISTS `masterData`.`facturacion_AFTER_INSERT`;

DELIMITER $$
USE `masterData`$$
CREATE DEFINER = CURRENT_USER TRIGGER `masterData`.`facturacion_AFTER_INSERT` AFTER INSERT ON `facturacion` FOR EACH ROW
BEGIN
DECLARE usuario VARCHAR(255);  -- Declara una variable para el nombre de usuario

    -- Obtiene el nombre de usuario actual de la sesión
    SET usuario = USER();

    -- Inserta los datos en la tabla clientes_nuevos, incluyendo el nombre de usuario
    INSERT INTO facturacion_log (usuario, invoice_id, dtlastmodifieddate)
    VALUES (usuario, NEW.invoice_id, NEW.dtlastmodifieddate);
END$$
DELIMITER ;






