-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-03-2020 a las 00:12:44
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `p_login`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualisarU` (IN `_name` TEXT, IN `_Lname` TEXT, IN `_username` VARCHAR(100), IN `_email` VARCHAR(255), IN `_id_p` INT(11), IN `_id` INT(11))  BEGIN 
	UPDATE usuarios SET name=_name,Lname=_Lname,username=_username,email=_email,id_p=_id_p WHERE id=_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cambio_pass` (IN `_id` INT(11), IN `_name` TEXT, IN `_token` VARCHAR(255), IN `_pass` VARCHAR(255))  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar` (IN `_id` INT)  BEGIN
	DELETE FROM usuarios
    WHERE id=_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `_username` VARCHAR(100), IN `_pass` VARCHAR(255), OUT `_Result` TINYINT)  BEGIN
    SET _Result = -1;
    IF(EXISTS(SELECT 1 FROM usuarios WHERE(username = _username AND pass = _pass)))THEN
    SET _Result := (SELECT username  FROM usuarios WHERE(usuarios = _usuarios AND pass = _pass));
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mustrate_abra_ca` ()  BEGIN
SELECT
	id,
	name,
    Lname,
    email,
    username,
    id_p
FROM usuarios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_regidtro` (IN `_id` INT(11))  BEGIN
	SELECT * FROM usuarios WHERE id=_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistraUsuario` (IN `_name` TEXT(50), IN `_Lname` TEXT(50), IN `_username` VARCHAR(100), IN `_email` VARCHAR(255), IN `_pass` VARCHAR(255))  BEGIN
	INSERT INTO usuarios (name, Lname, username, email, pass) VALUES(_name, _Lname, _username, _email, _pass);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reguistra` (IN `_email` VARCHAR(255), IN `_username` VARCHAR(100), IN `_name` TEXT, IN `_Lname` TEXT, IN `_pass` VARCHAR(255))  BEGIN
/*si email exite no reguistra*/
	IF NOT EXISTS(SELECT 1 FROM usuarios WHERE email = _email) THEN
/*si el susuario ya eciste no regustra */
    	IF not EXISTS(SELECT 2 FROM usuarios WHERE username = _username) THEN
/*reguistro en la tabla */
        	INSERT INTO usuarios (email, username, name, Lname, pass) VALUE (_email , _username, _name, _Lname, _pass);
            SELECT 0 AS error;
        ELSE
        	SELECT 2 AS error;
        END if;
    ELSE
    	SELECT 1 AS error;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `reguistra_token` (INOUT `_id` INT(11), INOUT `_name` TEXT, INOUT `_Lname` TEXT, INOUT `_dt_registro` TIME)  BEGIN

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


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verifica_to` (IN `token` VARCHAR(255), IN `id` INT(11))  begin
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `administrador`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `administrador` (
`id` int(11)
,`name` text
,`Lname` text
,`username` varchar(100)
,`email` varchar(255)
,`pass` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplicasiones`
--

CREATE TABLE `aplicasiones` (
  `id_apli` int(11) NOT NULL,
  `aplicasion` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `aplicasiones`
--

INSERT INTO `aplicasiones` (`id_apli`, `aplicasion`, `url`) VALUES
(1, 'inventario', ''),
(2, 'contavilidad', ''),
(3, 'faccionario ', '');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `cliente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `cliente` (
`nombre` text
,`apellido` text
,`usuario` varchar(100)
,`email` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `generico`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `generico` (
`id` int(11)
,`name` text
,`Lname` text
,`email` varchar(255)
,`username` varchar(100)
,`id_p` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `masters`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `masters` (
`id` int(11)
,`id_p` int(11)
,`name` text
,`Lname` text
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privileguio`
--

CREATE TABLE `privileguio` (
  `id_p` int(11) NOT NULL,
  `permisos` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `privileguio`
--

INSERT INTO `privileguio` (`id_p`, `permisos`) VALUES
(1, 'master'),
(2, 'administrador'),
(3, 'supervisor '),
(4, 'cliente'),
(7, 'demo');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `supervisor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `supervisor` (
`nombre` text
,`apellido` text
,`correo` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `Lname` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `pass` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_p` int(11) NOT NULL,
  `dt_registro` time NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `name`, `Lname`, `username`, `email`, `pass`, `id_p`, `dt_registro`, `token`) VALUES
(1, 'diego', 'fulgencio', 'dfr2098', 'edsiodfr@hotmail.com', 'aliens123456789QQ', 1, '00:00:00', '1diegofulgenciodfr2098ARBEI'),
(2, 'diego', 'jhvjv', 'hgxtdhtgdc', 'edsiodfr@hotmail.com', 'aliens123456789QQ', 3, '00:00:00', '2diegojhvjvhgxtdhtgdcARBEI'),
(4, 'dfjdcdc', 'mjgcmjgxc', 'htesdutw64e5rr55t', 'edscuytd@lfuvkfv.com', 'adfsdfdsfsdiens123456789Q', 2, '00:00:00', '4dfjdcdcmjgcmjgxchtesdutw64e5rr55tARBEI\r\n'),
(5, '', '', '', '', 'efqfqfqwf', 0, '00:00:00', '5ARBEI');

-- --------------------------------------------------------

--
-- Estructura para la vista `administrador`
--
DROP TABLE IF EXISTS `administrador`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `administrador`  AS  select `usuarios`.`id` AS `id`,`usuarios`.`name` AS `name`,`usuarios`.`Lname` AS `Lname`,`usuarios`.`username` AS `username`,`usuarios`.`email` AS `email`,`usuarios`.`pass` AS `pass` from `usuarios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `cliente`
--
DROP TABLE IF EXISTS `cliente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cliente`  AS  select `usuarios`.`name` AS `nombre`,`usuarios`.`Lname` AS `apellido`,`usuarios`.`username` AS `usuario`,`usuarios`.`email` AS `email` from `usuarios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `generico`
--
DROP TABLE IF EXISTS `generico`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `generico`  AS  select `usuarios`.`id` AS `id`,`usuarios`.`name` AS `name`,`usuarios`.`Lname` AS `Lname`,`usuarios`.`email` AS `email`,`usuarios`.`username` AS `username`,`usuarios`.`id_p` AS `id_p` from `usuarios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `masters`
--
DROP TABLE IF EXISTS `masters`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `masters`  AS  select `usuarios`.`id` AS `id`,`usuarios`.`id_p` AS `id_p`,`usuarios`.`name` AS `name`,`usuarios`.`Lname` AS `Lname` from `usuarios` where `usuarios`.`username` is not null order by `usuarios`.`id_p` desc ;

-- --------------------------------------------------------

--
-- Estructura para la vista `supervisor`
--
DROP TABLE IF EXISTS `supervisor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supervisor`  AS  select `usuarios`.`name` AS `nombre`,`usuarios`.`Lname` AS `apellido`,`usuarios`.`email` AS `correo` from `usuarios` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aplicasiones`
--
ALTER TABLE `aplicasiones`
  ADD PRIMARY KEY (`id_apli`),
  ADD KEY `aplicasion` (`aplicasion`);

--
-- Indices de la tabla `privileguio`
--
ALTER TABLE `privileguio`
  ADD PRIMARY KEY (`id_p`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aplicasiones`
--
ALTER TABLE `aplicasiones`
  MODIFY `id_apli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `privileguio`
--
ALTER TABLE `privileguio`
  MODIFY `id_p` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aplicasiones`
--
ALTER TABLE `aplicasiones`
  ADD CONSTRAINT `aplicasiones_ibfk_1` FOREIGN KEY (`id_apli`) REFERENCES `privileguio` (`id_p`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
