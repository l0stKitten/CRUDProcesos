--Tabla Usuarios_Cliente
CREATE TABLE user_client(
	id INT NOT NULL,
	usser varchar(10),
	pass varchar(10)
);

ALTER TABLE user_client ADD (
  CONSTRAINT userc_pk PRIMARY KEY (id));
 
ALTER TABLE user_client
ADD CONSTRAINT fk_id_userc
	FOREIGN KEY (id)
	REFERENCES cliente (id_cliente)
	ON DELETE CASCADE;

SELECT * FROM CLIENTE c ;

--procedimiento de crear usuario de cliente

SELECT * FROM CLIENTE;
CREATE OR REPLACE TRIGGER client_id_tgr 
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
  SELECT client_id_seq.NEXTVAL
  INTO   :new.id_cliente
  FROM   dual;
END;

CREATE SEQUENCE client_id_seq START WITH 7 INCREMENT BY 1;


CREATE OR REPLACE PROCEDURE create_cliente (nom_cli varchar2, dir_cli
	varchar2, tel_cli varchar2, email_cli varchar2, usser_c varchar2, pass_c varchar2 )
IS
	id_u_c int;
BEGIN
	insert into cliente (NOMBRE, DIRECCION, TELEFONO, EMAIL)
	values (nom_cli, dir_cli, tel_cli, email_cli);
	SELECT c.ID_CLIENTE INTO id_u_c FROM CLIENTE c WHERE c.NOMBRE = nom_cli AND c.DIRECCION = dir_cli 
											AND c.TELEFONO = tel_cli aND c.EMAIL = email_cli;
	INSERT INTO USER_CLIENT (id, usser, pass) VALUES (id_u_c, usser_c, pass_c);
END;
call create_cliente('Juana Perez', 'algun lado', '0000', 'juana@correo.com', 'juanita', '1234');
SELECT * FROM CLIENTE c ;
SELECT * FROM USER_CLIENT uc;

--procedimiento de actualizar usuario de cliente
CREATE OR REPLACE PROCEDURE client_update_user(id_cl int, us_cl varchar2, pass_cl varchar2)
IS
BEGIN
	UPDATE USER_CLIENT
	SET usser = us_cl,
	pass = pass_cl
	WHERE id = id_cl;
END;
CALL client_update_user(8, 'juansita', '12345');
SELECT * FROM USER_CLIENT uc;

-- eliminar usario de cliente, también elimina al cliente
CREATE OR REPLACE PROCEDURE user_client_delete (id_cli int)
IS
BEGIN
	DELETE FROM USER_CLIENT u WHERE u.id = id_cli;
	DELETE FROM CLIENTE c WHERE c.ID_CLIENTE = id_cli;
END;
CALL user_client_delete(8);

SELECT * FROM CLIENTE c ;
SELECT * FROM USER_CLIENT uc;