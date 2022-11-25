--Login
CREATE SEQUENCE admin_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE ADMIN(
	id INT NOT NULL, 
	nombre VARCHAR(90),
	apellido varchar(90),
	fecha_nac DATE,
	cargo varchar(90),
	usuario varchar(10),
	pass varchar(10)
);

ALTER TABLE ADMIN ADD (
  CONSTRAINT admin_pk PRIMARY KEY (id));
  
CREATE OR REPLACE TRIGGER admin_id_tgr 
BEFORE INSERT ON ADMIN 
FOR EACH ROW
BEGIN
  SELECT admin_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;

INSERT INTO ADMIN (nombre, apellido, fecha_nac, cargo, usuario, pass)
values('John', 'OConnor', to_date('05-03-1993', 'dd-mm-yyyy'), 'supervisor', 'jhoc050393', '123');

SELECT * FROM admin;

--Procedimientos
--create
CREATE OR REPLACE PROCEDURE admin_create (nom_ad varchar2, app_ad varchar2, fec_nac varchar2, cargo varchar2, 
usuario varchar2, pass varchar2 )
IS
BEGIN
	insert into ADMIN (nombre, apellido, fecha_nac, cargo, usuario, pass)
	values (nom_ad, app_ad, to_date(fec_nac, 'dd-mm-yyyy'), cargo, usuario, pass);
END;

CALL admin_create('Susan', 'Vega', '14-04-1996', 'mantenimiento', 'susv140496', '1234');
SELECT * FROM admin;

--UPDATE 
CREATE OR REPLACE PROCEDURE admin_update_dp(id_ad int, nom_ad varchar2, app_ad varchar2, fec_nac varchar2, cargo_ad varchar2)
IS
BEGIN
	UPDATE ADMIN
	SET nombre = nom_ad,
	apellido = app_ad,
	fecha_nac = to_date(fec_nac, 'dd-mm-yyyy'),
	cargo = cargo_ad
	WHERE id = id_ad;
END;

CALL admin_update_dp(2, 'Susan', 'Vargas', '14-04-1995', 'admin');
SELECT * FROM admin;

CREATE OR REPLACE PROCEDURE admin_update_user(id_ad int, us_ad varchar2, pass_ad varchar2)
IS
BEGIN
	UPDATE ADMIN
	SET usuario = us_ad,
	pass = pass_ad
	WHERE id = id_ad;
END;
CALL admin_update_user(2, 'susv140496', '123abc');
SELECT * FROM admin;

--Read
CREATE OR REPLACE PROCEDURE admin_read(cur_admin OUT sys_refcursor)
IS
BEGIN
   
    FOR i IN (SELECT * FROM ADMIN) LOOP
        OPEN cur_admin FOR
        SELECT a.ID, a.NOMBRE, a.APELLIDO, a.FECHA_NAC, a.CARGO FROM ADMIN a;
    END LOOP;
END;

CREATE OR REPLACE PROCEDURE LOGIN(us_nm IN VARCHAR2, passw IN VARCHAR2, id_admin_us OUT NUMBER)AS
V_USUARIO NUMBER;
BEGIN
  SELECT ID INTO V_USUARIO FROM ADMIN WHERE USUARIO = us_nm AND pass = passw;
  id_admin_us := V_USUARIO;

  EXCEPTION
  WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('ERROR');
END;

--DELETE 
CREATE OR REPLACE PROCEDURE admin_delete (id_ad int)
IS
BEGIN
	DELETE FROM ADMIN a WHERE a.id = id_ad;
END;
CALL admin_create('Juan', 'Error', '15-11-1900', 'antiguo', 'error', 'error');
SELECT * FROM admin;
CALL admin_delete(3);
SELECT * FROM admin;