CALL reguistra('edsiodfr@gmail.com','dfr','diego','fulgencio','aliens123456789Q');



DROP PROCEDURE if EXISTS login;
DELIMITER //
CREATE PROCEDURE login
(
    IN _username VARCHAR(100),
    IN _pass VARCHAR(255),
    OUT _Result TINYINT
)
BEGIN
    SET _Result = -1;
    IF(EXISTS(SELECT 1 FROM usuarios WHERE(username = _username AND pass = _pass)))THEN
    SET _Result := (SELECT username  FROM usuarios WHERE(usuarios = _usuarios AND pass = _pass));
END IF;
END
//
DELIMITER ;





DROP PROCEDURE IF EXISTS actualisa;
USE p_login;
DELIMITER //
CREATE PROCEDURE actualisa(
    IN _id int(11)
    IN _name text
    IN _Lname text
    IN _username varchar(100)
    IN _email varchar(255)
    IN _id_p int(11)
)
BEGIN
	UPDATE usuarios SET id=_id,name=_name,Lname=_Lname,username=_username,email=_email,id_p=_id_p
    WHERE id=_id
END
//



DROP PROCEDURE IF EXISTS actualisa;
USE p_login;
DELIMITER //
CREATE PROCEDURE actualisa
(
    IN _id int
    IN _name text
    IN _Lname text
    IN _username varchar(100)
    IN _email varchar(255)
    IN _id_p int(11)
)
BEGIN
	UPDATE usuarios SET id=_id,name=_name,Lname=_Lname,username=_username,email=_email,id_p=_id_p
    WHERE id=_id;
END
//



DROP PROCEDURE IF EXISTS insertar_datos
USE p_login;
DELIMITER//
CREATE PROCEDURE insertar_datos
(
	IN _name text,
    IN _Lname text,
    IN _username varchar(100),
    IN _email varchar(255),
    IN _pass varchar(255),
    IN _id_p int(11)
)
BEGIN
	INSERT INTO usuarios (name,Lname,username,email,pass,id_p) VALUES (_name,_Lname,_username,_email,_pass,_id_p);
//
DELIMITER ;


DROP PROCEDURE IF EXISTS ver_token;
USE p_login;
DELIMITER //
CREATE PROCEDURE ver_token
(
    INOUT _token varchar(255),
)
BEGIN
    declare token
END
//
DELIMITER ;









delimiter //
CREATE procedure miProc
 (
     IN p1 int
 )
begin
declare var int ;
SET var = p1 +2 ;
case var
when 2 then INSERT INTO lista VALUES (66666);
when 3 then INSERT INTO lista VALUES (4545665);
else INSERT INTO lista VALUES (77777777);
end case;
end;
//













DROP PROCEDURE IF EXISTS reguistra_token;
USE p_login;
DELIMITER //
CREATE PROCEDURE reguistra_token
(
    INOUT _id int(11),
    INOUT _name text,
    INOUT _Lname text,
    INOUT _dt_registro time
)
BEGIN

    /*DECLARA PROSEDIMINTO */
    declare pos int DEFAULT 0;
    declare parte1 varchar(255) DEFAULT ' ';
    declare aux varchar(255) DEFAULT ' ';

    /*declarar para la mescla de caracateres*/
    declare digitos varchar(5) DEFAULT ' ';
    declare letraN varchar(1) DEFAULT ' ';
    declare letraA1 varchar(1) DEFAULT ' ';
    declare letraA2 varchar(1) DEFAULT ' ';

    /*declara cuenta y pass */
    declare username varchar(100) DEFAULT ' ';
    declare pass varchar(255) DEFAULT ' ';

    /*convinasion de usuario*/
    SET pos = INSTR( _Lname, ' ');
    SET aux = SUBSTRING( _Lname, 1, pos - 1);
    SET parte1 = CONCAT( UPPER( LEFT(aux, 1)),LOWER( SUBSTRING(aux, 2, pos -2)));
    SET username= CONCAT( parte1, '-', now());

    /*GENARA EL PASSWOR*/
    SET aux = CONCAT( ' ', _id);
    SET digitos = RIGHT( aux, 5);

    /*mayusculas*/
    SET letraN = UPPER( LEFT( _name, 1));

    /*minusculas*/
    SET letraA1 = LOWER( LEFT( _Lname, 1));
    SET letraA2 = LOWER( SUBSTRING( _Lname, pos + 1, 1));
    SET pass = CONCAT( digitos, letraN, '-', letraA1, letraA2);

    /*insertar fecha*/
    /*INSERT INTO usuarios VALUES( now());*/

    /*insertar usuario*/
    INSERT INTO usuarios VALUES(id, name, Lname, username, pass, dt_registro, 1);


END
//
DELIMITER ;














DROP PROCEDURE IF EXISTS CONCATOKEM;
USE p_login;
DELIMITER //
CREATE PROCEDURE CONCATOKEM
(
   IN _id int(11),
   IN _name text,
   IN _Lname text,
   IN _username varchar(100)
)
BEGIN
/*SELECT CONCAT(id,name,Lname,username,'ARBEI') AS 'lv-426' FROM usuarios*/
/*UPDATE*/
    DECLARE _token varchar(255)
    SET _token=SELECT CONCAT(id, name, Lname, username, 'lv-426') FROM usuarios;
    UPDATE usuarios SET token=_token WHERE id=_id;
END
//
DELIMITER ;


alter table usuarios DROP foreign key id_p;
DROP index email ON usuarios;



















DROP procedure IF EXISTS verifica_to;
USE p_login;
DELIMITER //
CREATE PROCEDURE verifica_to
(
    IN token varchar(255),
    IN id int(11)
)
begin
    DECLARE txt VARCHAR(255);
    DECLARE resultado int(110);
    DECLARE opcion TINYINT(1);
    IF token = 1 THEN
        SELECT descripcion FROM usuarios WHERE descripcion = txt INTO resultado;
        IF resultado IS NULL THEN
            INSERT INTO  usuarios(descripcion, vigente) VALUES (id, token);

    else
        SELECT ERRORS;
    END IF;
    ELSEIF opcion = 3 THEN
        UPDATE usuarios SET descripcion = txt, vigente = token;
    ELSEIF opcion = 4 THEN
        UPDATE usuarios SET  vigente = 1 WHERE  idtiporubro = id;
    ELSEIF opcion = 5 THEN
        UPDATE usuarios SET vigente = 0 WHERE idtiporubro = id;
    else
        SELECT FALSE;
    END IF;
END
//
DELIMITER ;








/*vistas*/
CREATE VIEW masters AS
SELECT u.id, p.id_p, u.name, u.Lname, p.permisos AS privileguio
FROM usuarios AS p
WHERE username IS NOT NULL ORDER BY id_p desc
INNER JOIN privileguio AS u ON u.id=p.id_p;






CREATE VIEW administrador AS
SELECT id,name,Lname,username,email,pass FROM usuarios





CREATE VIEW generico AS
SELECT id,name,Lname,email,username,id_p FROM usuarios



CREATE VIEW cliente AS
SELECT name AS nombre,Lname AS apellido,username AS usuario,email AS correo
FROM usuarios


CREATE VIEW supervisor AS
SELECT name AS nombre,Lname AS apellido, email AS correo,
FROM usuarios



DROP PROCEDURE IF EXISTS cambio_pass;
USE p_login;
DELIMITER //
CREATE PROCEDURE cambio_pass
(
    IN _id int(11),
    IN _name text,
    IN _token varchar(255),
    IN _pass varchar(255)
)
BEGIN
    IF NOT EXISTS(SELECT 1 FROM usuarios WHERE _name = name)THEN
        IF NOT EXISTS(SELECT 2 FROM usuarios WHERE _id = id)THEN
        UPDATE usuarios SET pass=_pass WHERE _token=token;
            SELECT 0 AS error;
        ELSE
        	SELECT 2 AS error;
        END if;
    ELSE
    	SELECT 1 AS error;
    END IF;
END
//
DELIMITER ;




DROP FUNCTION IF EXISTS fn_createKeySha1;
USE p_login;
DELIMITER //
 CREATE FUNCTION fn_createKeySha1(_str VARCHAR(100), _op INT) RETURNS varchar(250)

BEGIN
	SET @secret='arbeitapp'; # EJEMPLO LLAVE SECRETA :P

    SET @cifrado='';
    IF _op=0 THEN	#para la contraseña
		SET @cifrado=SHA1(CONCAT(@secret,_str));
    ELSE			#para el token
		SET @hoy=DATE_FORMAT(NOW(), "%M %d %Y");
        SET @cifrado=SHA1(CONCAT(@secret,_str,@hoy));
    END IF;

	RETURN @cifrado;
END
//
DELIMITER ;





DROP FUNCTION fn_createKeySha1;
DELIMITER //
CREATE FUNCTION fn_createKeySha1(_str VARCHAR(100), _op INT) RETURNS varchar(250)
BEGIN
    SET @secret="arbeitapp";
    SET @cifrado='';
    IF _op=0 THEN
    SET @cifrado=SHA1(CONCAT(@secret,_str));
    ELSE
    SET @hoy=DATE_FORMAT(NOW(), "%M %D %y");
    SET @cifrado=SHA1(CONCAT(@secret,_str,@hoy));
    END IF;
RETURN @cifrado;
END
 //
DELIMITER ;



SELECT fn_createKeySha1()

DROP PROCEDURE IF EXISTS RegistraUsuarioDemo;
USE p_login;
DELIMITER //
CREATE PROCEDURE RegistraUsuarioDemo
(
  IN _name
  IN _Lname
  IN _username
  IN _email
  IN _pass
  IN _id_p
  IN _dt_registro
)
BEGIN
SET @extEmail=(
  CASE WHEN EXISTS(SELECT 1 FROM usuarios WHERE(email = _email))
    THEN false
          ELSE true
      END
  );

  SET @extUser=(
  CASE WHEN EXISTS(SELECT 1 FROM usuarios WHERE(username = _username))
    THEN false
          ELSE true
      END
  );

  #SELECT @extEmail,@extUser;
  SET @res='{"error":true,"msg":"El email ya esta registrado"}';
  IF @extEmail THEN
  IF @extUser THEN
        INSERT INTO usuarios (name,Lname,username,email,pass,id_p)
    VALUES (_name,_Lname,_username,_email,fn_createKeySha1(_pass,0));
    #SELECT _name,_Lname,_username,_email,fn_createKeySha1(_pass,0);
          SET @res='{"error":false,"msg":"Usuario registrado"}';
  ELSE
    SET @res='{"error":true,"msg":"El Nombre de usuario ya esta registrado"}';
  END IF;
  END IF;

  SELECT @res;
END
//
DELIMITER ;





DELIMITER //
CREATE OR REPLACE TRIGGER usuarios_demo BEFORE DELETE ON usuarios_demo FOR EACH row
BEGIN
  INSERT INTO usuarios_demo_h SELECT * FROM usuarios_demo WHERE id = old.id;
END
//
DELIMITER ;
