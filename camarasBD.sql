--Creamos nuevo Usuario
CREATE TABLESPACE BDWS DATAFILE 
'C:\camarasBD\camarasWS.dbf' SIZE 100M EXTENT 
MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;


--error: ORA-65096: nombre de usuario o rol común no válido-- ERROR 
alter session set "_ORACLE_SCRIPT"=true;


CREATE USER DARIA
IDENTIFIED BY daria
DEFAULT TABLESPACE BDWS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON BDWS;

CREATE USER JULIANA
IDENTIFIED BY juliana
DEFAULT TABLESPACE BDWS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON BDWS;

-- ROLES
GRANT CONNECT,RESOURCE TO JULIANA;

-- SYSTEM PRIVILEGES
GRANT CREATE ANY INDEX TO JULIANA ;
GRANT CREATE ANY SEQUENCE TO JULIANA ;
GRANT CREATE ANY SYNONYM TO JULIANA ;
GRANT CREATE ANY VIEW TO JULIANA ;
GRANT CREATE ANY TABLE TO JULIANA ;
GRANT CREATE ANY TYPE TO JULIANA ;
ALTER USER JULIANA quota unlimited on BDWS;

-- ROLES
GRANT CONNECT,RESOURCE TO DARIA;

-- SYSTEM PRIVILEGES
GRANT CREATE ANY INDEX TO DARIA ;
GRANT CREATE ANY SEQUENCE TO DARIA ;
GRANT CREATE ANY SYNONYM TO DARIA ;
GRANT CREATE ANY VIEW TO DARIA ;
GRANT CREATE ANY TABLE TO DARIA ;
GRANT CREATE ANY TYPE TO DARIA ;
ALTER USER DARIA quota unlimited on BDWS;


create table producto(
	id_prod int not null,
	codigo varchar(30),
	nombre varchar(60),
	marca varchar(30),
	descripcion varchar(100),
	precio_compra real,
	precio_venta real,
	material varchar(20),
	primary key(id_prod)
);

create table camara(
	id_camara int not null,
	id_prod int not null,
	resolucion varchar(10),
	lente real,
	forma varchar(15),
	ip char(1),--s, n
	microfono char(1),
	infrarojo int,
	max_mem int,
	exterior char(1),
	inc_fuente char(1),
	alimentacion int,
	consumo real,
	angulo_vision real default 92.0,
	proteccion_ip int,
	id_especif_camara int,
	primary key(id_camara),
);

create table camara_grabadora_wifi(--100
	id_camara_grabadora_wifi int not null,
	id_camara int not null,
	wifi char(1),
	altavoz char(1),
	audio_bidireccional char(1),
	luz_estroboscopica char(1),
	sirena char(1),
	primary key(id_camara_grabadora_wifi),
	foreign key(id_camara) references camara(id_camara)
);

create table camara_ip(--200
	id_camara_ip int not null,
	id_camara int not null,
	compresion varchar(30),
	dual_stream char(1),
	compatible_software varchar(30),
	poe char(1),
	color_vu char(1),
	luz_blanca int,
	velocidad_obturador_ini varchar(10),
	velocidad_obturador_fin varchar(10),
	dnr char(1),
	primary key(id_camara_ip),
	foreign key(id_camara) references camara(id_camara)
);

create table camara_analogica(--300
	id_camara_analogica int not null,
	id_camara int not null,
	dual_stream char(1),
	compatible_software varchar(30),
	velocidad_obturador_ini varchar(10),
	velocidad_obturador_fin varchar(10),
	primary key(id_camara_analogica),
	foreign key(id_camara) references camara(id_camara)
);

create table camara_ptz_ip(--400
	id_camara_ptz_ip int not null,
	id_camara int not null,
	zoom int,
	dual_stream char(1),
	poe char(1),
	pan int,
	tilt_ini int default 0,
	tilt_fin int,
	auto_flip char(1),
	compatible_software varchar(30),
	inc_soporte char(1),
	smart_tracking char(1),
	smart_detection char(1),
	primary key(id_camara_ptz_ip),
	foreign key(id_camara) references camara(id_camara)
);

create table camara_especial(--500
	id_camara_especial int not null,
	id_camara int not null,
	funcion varchar(20),
	compresion varchar(30),
	alarma char(1),
	pan int,
	tilt_ini int default 0,
	tilt_fin int,
	smart_detection char(1),
	intrusion_detection char(1),
	angulo_vision float,
	
	primary key(id_camara_especial),
	foreign key(id_camara) references camara(id_camara)
);

create table nvr(--600
	id_nvr int not null,
	id_producto int not null,
	ch_input int,
	max_hdd int,
	max_resolucion varchar(50),
	tasa_bits int,
	alarmas int,
	onvif char(1),
	compatible_software varchar(30),
	inc_fuente char(1),
	soporte varchar(10),
	audio_in int,
	audio_out int,
	usb2 int,
	usb3 int,
	primary key(id_nvr),
	foreign key (id_producto) references producto(id_prod)
);

create table dvr(--700
	id_dvr int not null,
	id_producto int not null,
	ch_input int,
	ch_input_ip int,
	max_hdd int,
	max_resolucion varchar(50),
	alarmas int,
	compatible_software varchar(30),
	inc_fuente char(1),
	soporte varchar(10),
	audio_in int,
	audio_out int,
	video_in varchar(30),
	primary key(id_dvr),
	foreign key(id_producto) references producto(id_prod)
);

create table cliente(
	id_cliente int not null,
	nombre varchar(60),
	direccion varchar(60),
	telefono varchar(20),
	email varchar(20),
	primary key(id_cliente)
);

create table cliente_natural(
	id_cliente int not null,
	dni varchar(20) not null,
	apellido varchar(60),
	primary key(id_cliente),
	foreign key(id_cliente) references cliente(id_cliente),
	unique(dni)
);

create table cliente_empresa(
	id_cliente int not null,
	ruc varchar(20) not null,
	primary key(id_cliente),
	foreign key(id_cliente) references cliente(id_cliente),
	unique(ruc)
);

create table pedido(
	id_pedido int not null,
	id_cliente int not null,
	fecha date,
	dir_entrega varchar(60),
	primary key(id_pedido),
	foreign key (id_cliente) references cliente(id_cliente)
);

create table det_pedido(
	id_pedido int not null,
	id_producto int not null,
	cantidad int not null,
	primary key (id_pedido, id_producto),
	foreign key(id_pedido) references pedido(id_pedido),
	foreign key(id_producto) references producto(id_prod)
);

--Alter Table
ALTER TABLE camara DROP CONSTRAINT SYS_C008375;
ALTER TABLE camara
ADD CONSTRAINT fk_camara_prod
	FOREIGN KEY (id_prod)
	REFERENCES producto (id_prod)
	ON DELETE CASCADE;

ALTER TABLE dvr DROP CONSTRAINT SYS_C008403;
ALTER TABLE dvr
ADD CONSTRAINT fk_dvr_prod
	FOREIGN KEY (id_producto)
	REFERENCES producto (id_prod)
	ON DELETE CASCADE;

ALTER TABLE nvr DROP CONSTRAINT SYS_C008399;
ALTER TABLE nvr
ADD CONSTRAINT fk_nvr_prod
	FOREIGN KEY (id_producto)
	REFERENCES producto (id_prod)
	ON DELETE CASCADE;

ALTER TABLE det_pedido DROP CONSTRAINT SYS_C008425;
ALTER TABLE det_pedido
ADD CONSTRAINT fk_det_pedido_prod
	FOREIGN KEY (id_producto)
	REFERENCES producto (id_prod)
	ON DELETE CASCADE;

--Productos
/* INSERT QUERY NO: 1 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
1, 'CS-C1C-D0-1D1WFR', 'Cámara IP WIFI 720P interior', 'EZVIZ', 'Incluye fuente 220V. Con una base magnética.', 0, 0, 'plástico'
);

/* INSERT QUERY NO: 2 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
2, 'CS-C1C-D0-1D2WFR', 'Cámara IP WIFI 1080P interior', 'EZVIZ', 'Incluye fuente 220V. Con una base magnética.', 0, 0, 'plástico'
);

/* INSERT QUERY NO: 3 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
3, 'CS-C1C-D0-1D2WPFR', 'Cámara IP + PIR - WIFI 1080P', 'EZVIZ', '"Incluye fuente 220V. Con una base magnética', 0, 0 , 'plástico');

/* INSERT QUERY NO: 4 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
4, 'CS-CV310-A0-3B1WFR', 'Tubo IP WIFI 720P', 'EZVIZ', 'ICR, 0lux con IR, H.264, dual- stream', 0, 0 , 'plástico'
);

/* INSERT QUERY NO: 5 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
5, 'CS-CV310-A0-1B2WFR', 'CAMARA IP WIFI EXTERIOR', 'EZVIZ', 'Lente 2.8mm. Cámara ezGuard IP WIFI 1080P CMOS 1/2.7"" 2Mp Resolución 1920x1080 ICR', 0, 0 , 'plástico'
);

/* INSERT QUERY NO: 6 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
6, 'CS-CV246-B0-1C1WFR', 'CAMARA PT IP WIFI 720P', 'EZVIZ', '25 fps. IR 10m. Lente fijo 4 mm. H.264 / DC5V / DWDR / 3D DNR / BLC. Wi-Fi con EZVIZ smart-config.', 0, 0 , 'plástico'
);

/* INSERT QUERY NO: 7 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
7, 'CS-CV246-A0-1C2WFR', 'CAMARA PT IP WIFI 1080P', 'EZVIZ', '25 fps. IR 10m. Lente fijo 4 mm. H.264 / DC5V / DWDR / 3D DNR / BLC.' , 0, 0 , 'plástico'
);

/* INSERT QUERY NO: 8 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
8, 'CS-CV248-A3-32WMFR', 'CAMARA PT IP WIFI 2MP CON ALARMA INTERIOR', 'EZVIZ', '', 0, 0 , 'plástico'
);

/* INSERT QUERY NO: 9 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
9, 'CS-CV248-A3-32WMFR', 'CAMARA IP WIFI OJO DE PEZ (360°)', 'EZVIZ', '', 85.00, 119.00, 'plástico'
);

/* INSERT QUERY NO: 10 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
10, 'CS-CV346-A0-7A3WFR', 'Sirena', 'APEC', '', 109.00, 152.60, 'plástico'
);

/* INSERT QUERY NO: 11 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
11, 'CS-T9-A (APEC)', 'PIR', 'APEC', '', 24.25, 33.95, 'plástico'
);

/* INSERT QUERY NO: 12 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
12, 'CS-T1-C/12M (APEC)', 'MAGNETICO P/PUERTA/VENTANA INALAMBRICO', 'APEC', '', 27.11, 37.95, 'plástico'
);

/* INSERT QUERY NO: 13 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
13, 'CS-T2-A (APEC)', 'Boton de emergencia inalambrico', 'APEC', '', 15.69, 21.97, 'plástico'
);

/* INSERT QUERY NO: 14 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
14, 'CS-T3-A (APEC)', 'MICRO SD-HC 32GB 500', 'HIKVISION', '', 15.69, 21.97, 'plástico'
);

/* INSERT QUERY NO: 15 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
15, 'HK-HS-TF-L2I/32G', 'MICRO SD-HC 64GB 500', 'HIKVISION', '', 5.90, 8.26, 'plástico'
);

/* INSERT QUERY NO: 16 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
16, 'HK-HS-TF-L2I/64G', 'MICRO SD-HC 128GB', 'HIKVISION', '', 10.80, 15.12, 'plástico'
);

/* INSERT QUERY NO: 17 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
17, 'HK-HS-TF-L2I/128G', '"MEMORIAS SD-HC 32GB 3', 'HIKVISION', '', 24.00, 33.60, ''
);

/* INSERT QUERY NO: 18 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
18, 'HK-HS-SD-P10/32G', '"MEMORIAS SD-HC 64GB 3', 'HIKVISION', '', 10.70, 14.98, ''
);

/* INSERT QUERY NO: 19 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
19, 'HK-DS2CD1123G0E-I', 'DOMO IP', 'HIKVISION', 'HD 1080p 30fps | CMOS 1/2.8 ICR| IR 20 a 30m | IP67 | PoE', 0, 0, ''
);

/* INSERT QUERY NO: 20 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
20, 'HK-DS2CD1027G0-L', 'CAMARA IP COLORVU', '', 'Imagen a Color 24/7 / PoE / Lente 2.8 mm / Luz Blanca 30 mts /  Exterior IP67 / D-wdr', 52.4, 75, 'plástico'
);

/* INSERT QUERY NO: 21 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
21, 'HK-DS2DE2A404IW-DE3', 'DOMO PTZ IP', 'HIKVISION', 'Resolución: 2560×1440@30 fps 1280×960@30 fps • L: 2.8 a 12mm', 0, 0, '');

/* INSERT QUERY NO: 22 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
22, 'HK-DS2PT3326IZ-DE3', 'MINI PANOVU', 'HIKVISION', 'MINI PANOVU: INTEGRA 3 Chip CMOS DE 1/2.8 de Escaneo Progresivo + 1 PTZ CMOS 1/2.8', 0, 0, ''
);

/* INSERT QUERY NO: 23 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
23, 'HK-DS7104NI-Q1', 'NVR 4Ch', 'HIKVISION', 'Resolución Grabación: 4 MP/3 MP/1080p/1.3 MP/UXGA/720p/VGA/4CIF/DCIF/2CIF/ CIF/QCIF', 0, 0, 'plástico'
);

/* INSERT QUERY NO: 24 */
INSERT INTO producto(id_prod, codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
VALUES
(
24, 'ST-DVR16CH/2HDD', 'DVR 16Ch', '', 'RAM 512MB DDR3 |Compatible cámaras CVBS y HD-TVI| H.264 | Resolución 720P (1280 X 720)', 155.10, 169.80, ''
);

--Cámaras
/* INSERT QUERY NO: 1 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
1, 1, '720P', 2.8, '', 'S', 'N', 1, 0, 'N', 'S', 0, 220, 0, 0, 0
);

/* INSERT QUERY NO: 2 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
2, 2, '1080P', 2.8, '', 'S', 'N', 1, 0, 'N', 'S', 0, 220, 0, 0, 0
);

/* INSERT QUERY NO: 3 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
3, 3, '1080P', 2.8, 'tubo', 'S', 'N', 1, 0, 'N', 'S', 0, 220, 0, 0, 0
);

/* INSERT QUERY NO: 4 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
4, 4, '720P', 0, 'tubo', 'S', 'S', 0, 128, 'N', 'N', 0, 0, 0, 0, 0
);

/* INSERT QUERY NO: 5 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
5, 5, '2MP', 2.8, '', 'S', 'S', 0, 128, 'S', 'N', 12, 0, 103, 0, 0
);

/* INSERT QUERY NO: 6 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
6, 6, '720P', 4, '', 'S', 'S', 0, 128, 'N', 'N', 0, 0, 0, 0, 0
);

/* INSERT QUERY NO: 7 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
7, 7, '1080P', 4, '', 'S', 'S', 0, 128, 'N', 'N', 0, 0, 0, 0, 0
);

/* INSERT QUERY NO: 8 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
8, 8, '2MP', 4, '', 'S', 'N', 0, 128, 'N', 'N', 5, 0, 95, 0, 0
);

/* INSERT QUERY NO: 9 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
9, 9, '3MP', 1.2, '', 'S', 'N', 0, '128', 'N', 'N', 5, 0, 360, 0, 0
);

/* INSERT QUERY NO: 10 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
10, 19, '1080P', 2.8, 'domo', 'S', 'N', 0, 0, 'N', 'N', 12, 0, 0, 0, 0
);

/* INSERT QUERY NO: 11 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
11, 20, '2MP', 2.8, 'tubo', 'S', 'N', 0, 0, 'S', 'N', 0, 0, 0, 0, 0
);

/* INSERT QUERY NO: 12 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
12, 21, '4MP', 2.8, 'domo', 'S', 'N', 0, 128, 'N', 'N', 0, 0, 0, 0, 0
);

/* INSERT QUERY NO: 13 */
INSERT INTO camara(id_camara, id_prod, resolucion, lente, forma, ip, microfono, infrarojo, max_mem, exterior, inc_fuente, alimentacion, consumo, angulo_vision, proteccion_ip, id_especif_camara)
VALUES
(
13, 22, '2MP', 2.8, '', 'N', 'N', 0, 256, 'N', 'N', 0, 0, 0, 0, 0
);


--C. Grabadora WIFI
/* INSERT QUERY NO: 1 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
1, 1, 'S', 'N', 'S', 'N', 'N'
);

/* INSERT QUERY NO: 2 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
2, 2, 'S', 'N', 'S', 'N', 'N'
);

/* INSERT QUERY NO: 3 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
3, 3, 'S', 'N', 'S', 'N', 'N'
);

/* INSERT QUERY NO: 4 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
4, 4, 'S', 'S', 'N', 'S', 'S'
);

/* INSERT QUERY NO: 5 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
5, 5, 'S', 'S', 'N', 'S', 'S'
);

/* INSERT QUERY NO: 6 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
6, 6, 'S', 'N', 'N', 'N', 'N'
);

/* INSERT QUERY NO: 7 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
7, 7, 'S', 'N', 'N', 'N', 'N'
);

/* INSERT QUERY NO: 8 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
8, 8, 'S', 'N', 'N', 'N', 'N'
);

/* INSERT QUERY NO: 9 */
INSERT INTO camara_grabadora_wifi(id_camara_grabadora_wifi, id_camara, wifi, altavoz, audio_bidireccional, luz_estroboscopica, sirena)
VALUES
(
9, 9, 'S', 'N', 'N', 'N', 'N'
);

--C. IP
/* INSERT QUERY NO: 1 */
INSERT INTO camara_ip(id_camara_ip, id_camara, compresion, dual_stream, compatible_software, poe, color_vu, luz_blanca, velocidad_obturador_ini, velocidad_obturador_fin, dnr)
VALUES
(
1, 10, 'H.265+ H.265 H.264+ H.264', 'S', 'IVMS 4200', 'S', 'N', 0, 0, 0, 'S'
);

/* INSERT QUERY NO: 2 */
INSERT INTO camara_ip(id_camara_ip, id_camara, compresion, dual_stream, compatible_software, poe, color_vu, luz_blanca, velocidad_obturador_ini, velocidad_obturador_fin, dnr)
VALUES
(
2, 11, '', '', '', 'S', 'S', 1, 0, 0, 'N'
);

--C. PTZ IP
/* INSERT QUERY NO: 1 */
INSERT INTO camara_ptz_ip(id_camara_ptz_ip, id_camara, zoom, dual_stream, poe, pan, tilt_ini, tilt_fin, auto_flip, compatible_software, inc_soporte, smart_tracking, smart_detection)
VALUES
(
1, 12, 0, 'S', 'S', 330, 0, 90, 'N', 'IVMS 4200', 'N', 'N', 'N'
);

--C. Especial
/* INSERT QUERY NO: 1 */
INSERT INTO camara_especial(id_camara_especial, id_camara, funcion, compresion, alarma, pan, tilt_ini, tilt_fin, smart_detection, intrusion_detection, angulo_vision)
VALUES
(
1, 13, 'Escaneo Progresivo', 'H.265', 'N', 350, 0, 90, 'N', 'N', 0
);

--NVR
/* INSERT QUERY NO: 1 */
INSERT INTO nvr(id_nvr, id_producto, ch_input, max_hdd, max_resolucion, tasa_bits, alarmas, onvif, compatible_software, inc_fuente, soporte, audio_in, audio_out, usb2, usb3)
VALUES
(
1, 23, 1, 1, '1080P', 40, 0, 'N', 'IVMS 4200', 'S', '', 1, 1, 2, 0
);

--DVR
/* INSERT QUERY NO: 1 */
INSERT INTO dvr(id_dvr, id_producto, ch_input, ch_input_ip, max_hdd, max_resolucion, alarmas, compatible_software, inc_fuente, soporte, audio_in, audio_out, video_in)
VALUES
(
1, 24, 16, 0, 1, '720P', 0, '', '', '', 0, 0, ''
);

--Cliente
insert into cliente (id_cliente, nombre, direccion, telefono, email) values (1, 'Gearalt', '970 Northland Drive', '681-515-4415', 'ghanmore0@census.gov');
insert into cliente (id_cliente, nombre, direccion, telefono, email) values (2, 'Grayce', '6 Forster Junction', '418-637-2999', 'ghatche@addtoany.com');
insert into cliente (id_cliente, nombre, direccion, telefono, email) values (3, 'Remington', '1497 Golf Course Place', '540-879-3944', 'rcoulsen2@photo.com');
insert into cliente (id_cliente, nombre, direccion, telefono, email) values (4, 'Rodney', '8 Debs Terrace', '680-519-6581', 'rkiehl3@list.org');
insert into cliente (id_cliente, nombre, direccion, telefono, email) values (5, 'Lorinda', '26879 Tennessee Plaza', '352-820-3305', 'lmerton4@techno.com');

--Cliente natural
insert into cliente_natural (id_cliente, dni, apellido) values (1, '6532236', 'Batts');
insert into cliente_natural (id_cliente, dni, apellido) values (2, '1309925', 'Baldick');
insert into cliente_natural (id_cliente, dni, apellido) values (3, '5466445', 'Mackriell');
insert into cliente_natural (id_cliente, dni, apellido) values (4, '1166531', 'Steanyng');
insert into cliente_natural (id_cliente, dni, apellido) values (5, '5668163', 'Bownas');

--Cliente empresa

--Pedido
insert into pedido (id_pedido, id_cliente, fecha, dir_entrega) values (1, 1, TO_DATE('08/28/2022', 'mm/dd/yyyy'), '82476 Lunder Park');
insert into pedido (id_pedido, id_cliente, fecha, dir_entrega) values (2, 5, TO_DATE('1/11/2021', 'mm/dd/yyyy'), '952 Scoville Street');
insert into pedido (id_pedido, id_cliente, fecha, dir_entrega) values (3, 2, TO_DATE('12/13/2021', 'mm/dd/yyyy'), '08307 Sommers Terrace');
insert into pedido (id_pedido, id_cliente, fecha, dir_entrega) values (4, 3, TO_DATE('10/11/2021', 'mm/dd/yyyy'), '893 Londonderry Drive');
insert into pedido (id_pedido, id_cliente, fecha, dir_entrega) values (5, 3, TO_DATE('11/2/2022', 'mm/dd/yyyy'), '767 Briar Crest Plaza');

--Detalle Pedido
insert into det_pedido (id_pedido, id_producto, cantidad) values (1, 20, 8);
insert into det_pedido (id_pedido, id_producto, cantidad) values (2, 7, 1);
insert into det_pedido (id_pedido, id_producto, cantidad) values (3, 18, 7);
insert into det_pedido (id_pedido, id_producto, cantidad) values (4, 2, 6);
insert into det_pedido (id_pedido, id_producto, cantidad) values (5, 20, 1);

-- Crear Cliente
CREATE OR REPLACE PROCEDURE create_cliente (nom_cli varchar2, dir_cli
	varchar2, tel_cli varchar2, email_cli varchar2 )
IS
	id_cli number;
BEGIN
	select max(c.id_cliente) into id_cli from cliente c;
	id_cli := id_cli + 1;
	insert into cliente (ID_CLIENTE, NOMBRE, DIRECCION, TELEFONO, EMAIL)
	values (id_cli, nom_cli, dir_cli, tel_cli, email_cli);
END;
call create_cliente('Juan Perez', 'algún lado', '0000', 'juan@correo.com');

-- CRUD de Clientes
select c.id_cliente, c.nombre, c.direccion, c.telefono, c.email FROM cliente c;

CREATE OR REPLACE PROCEDURE read_clientes
AS
	CURSOR cur_cli IS
	select c.id_cliente, c.nombre, c.direccion, c.telefono, c.email from
	cliente c;
	r_cli cur_cli%ROWTYPE;
BEGIN
	OPEN cur_cli;
	LOOP
	-- fetch information from cursor into record
	FETCH cur_cli INTO r_cli;
	EXIT WHEN cur_cli%NOTFOUND;
	-- print department - chief
	DBMS_OUTPUT.PUT_LINE(r_cli.id_cliente || ' ' || r_cli.nombre || ' ' ||
	r_cli.direccion || ' ' || r_cli.telefono || ' ' || r_cli.email);
	END LOOP;
	-- close cursor cur_chief
	CLOSE cur_cli;
END;

call read_clientes();


-- Actualizar Cliente
select * from cliente c where c.id_cliente = 6;

CREATE OR REPLACE PROCEDURE update_cliente (id_cli int, nom_cli
	varchar2, dir_cli varchar2, tel_cli varchar2, email_cli varchar2 )
IS
BEGIN
	UPDATE cliente
	SET NOMBRE = nom_cli,
	DIRECCION = dir_cli,
	TELEFONO = tel_cli,
	EMAIL = email_cli
	WHERE id_cliente = id_cli;
END;
call update_cliente(6, 'Juan Perez', 'Calle Las Nubes', '123456789', 'juan@hotmail.com');
select * from cliente where id_cliente = 6;

-- Eliminar Cliente
CREATE OR REPLACE PROCEDURE delete_cliente (id_cli number)
IS
BEGIN
	DELETE FROM cliente c WHERE c.id_cliente = id_cli;
END;
call delete_cliente(6);
select * from cliente;

SELECT * FROM producto;

-- CRUD Productos

--Leer
CREATE OR REPLACE PROCEDURE read_productos(cur_prod OUT sys_refcursor)
IS
BEGIN
   
    FOR i IN (SELECT * FROM PRODUCTO) LOOP
        OPEN cur_prod FOR
        SELECT ID_PROD, CODIGO , NOMBRE, PRECIO_COMPRA, PRECIO_VENTA  FROM PRODUCTO ORDER BY ID_PROD;
    END LOOP;
END;

--Actualizar
CREATE OR REPLACE PROCEDURE update_producto (id_pr int, cod_pro varchar2, nom_pro varchar2, marca_pro varchar2, 
descri_pro varchar2, prec_com real, prec_venta real, mat_pro varchar2)
IS
BEGIN
	UPDATE PRODUCTO
	SET codigo = cod_pro,
	nombre = nom_pro,
	marca = marca_pro,
	descripcion = descri_pro,
	precio_compra = prec_com,
	precio_venta = prec_venta,
	material = mat_pro
	WHERE ID_PROD = id_pr;
END;

--Eliminar
CREATE OR REPLACE PROCEDURE delete_producto (id_pr int)
IS
BEGIN
	DELETE FROM PRODUCTO p WHERE p.ID_PROD = id_pr;
END;

--Crear
CREATE SEQUENCE id_seq START WITH 25 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER idprod_seq_tr 
BEFORE INSERT ON PRODUCTO 
FOR EACH ROW
BEGIN
  SELECT idprod_seq.NEXTVAL
  INTO   :new.id_prod
  FROM   dual;
END;

CREATE OR REPLACE PROCEDURE create_producto (cod_pro producto.CODIGO%TYPE, nom_pro producto.NOMBRE %TYPE, marca_pro producto.MARCA %TYPE, 
descri_pro producto.DESCRIPCION %TYPE, prec_com producto.PRECIO_COMPRA %TYPE, prec_venta producto.PRECIO_VENTA %TYPE, mat_pro producto.MATERIAL%TYPE)
IS
BEGIN
	INSERT INTO producto(codigo, nombre, marca, descripcion, precio_compra, precio_venta, material)
	VALUES (cod_pro, nom_pro, marca_pro, descri_pro, prec_com, prec_venta, mat_pro);
END;

SELECT * FROM PRODUCTO p ;
INSERT INTO PRODUCTO (codigo, nombre, marca, descripcion, precio_compra, precio_venta, material) VALUES ('ZZZZZ', 'Lampara', 'Luminus', 'Es una lampara', 24.25, 33.95, 'pl�stico');