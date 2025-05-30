-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2025 a las 11:53:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `miravereda2425`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_nota` (IN `p_cliente_id` INT)   BEGIN
	DECLARE puntos_totales DECIMAL(10,2);
	DECLARE cantidad INT;
	DECLARE media DECIMAL(10,2);

	SELECT SUM(valor) INTO puntos_totales FROM valoracion WHERE contenido_id = p_cliente_id;
	SELECT COUNT(*) INTO cantidad FROM valoracion WHERE contenido_id = p_cliente_id;

	IF cantidad > 0 THEN 
		SET media = puntos_totales / cantidad;
	ELSE 
		SET media = 0;
	END IF;

	UPDATE contenido SET puntuacion_media = media WHERE id = p_cliente_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_precio_carrito` (IN `p_cliente_id` INT)   BEGIN
	DECLARE carrito_activo_id INT;
	DECLARE precio_total DECIMAL(10,2);

	SELECT id INTO carrito_activo_id FROM carrito WHERE cliente_id = p_cliente_id AND activo = TRUE;
	SELECT SUM(precio) INTO precio_total FROM lin_fac WHERE carrito_id = carrito_activo_id;

	UPDATE carrito SET total = precio_total WHERE id = carrito_activo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `anyadir_al_carrito` (IN `p_cliente_id` INT, IN `p_contenido_id` INT)   BEGIN
	DECLARE carrito_activo_id INT;
	DECLARE contenido_precio DECIMAL(10,2);

	SELECT id INTO carrito_activo_id FROM carrito
	WHERE cliente_id = p_cliente_id AND activo = TRUE;

	IF p_contenido_id IN (SELECT contenido_id FROM pelicula) THEN
		SELECT precio INTO contenido_precio FROM pelicula WHERE contenido_id = p_contenido_id;
	ELSEIF p_contenido_id IN (SELECT contenido_id FROM serie) THEN
		SELECT precio INTO contenido_precio FROM serie WHERE contenido_id = p_contenido_id;
	ELSEIF p_contenido_id IN (SELECT contenido_id FROM corto) THEN
		SELECT precio INTO contenido_precio FROM corto WHERE contenido_id = p_contenido_id;
	ELSE 
		SET contenido_precio = 0.00;
	END IF;

	INSERT INTO lin_fac(carrito_id, contenido_id, precio) 
	VALUES (carrito_activo_id, p_contenido_id, contenido_precio);

	CALL actualizar_precio_carrito(p_cliente_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `comprar` (IN `p_cliente_id` INT)   BEGIN
	DECLARE carrito_total DECIMAL(10,2);
	DECLARE iva_rate DECIMAL(10,2) DEFAULT 0.21;
	DECLARE total_con_iva DECIMAL(10,2);
	DECLARE carrito_activo_id INT;

	-- obtener total del carrito activo
	SELECT id INTO carrito_activo_id FROM carrito WHERE cliente_id = p_cliente_id AND activo = TRUE;
	SELECT SUM(precio) INTO carrito_total FROM lin_fac WHERE carrito_id = carrito_activo_id;

	-- calcular total con IVA
	SET total_con_iva = carrito_total + (carrito_total * iva_rate);

	-- crear factura
	INSERT INTO factura(cliente_id, total, total_con_iva)
	VALUES (p_cliente_id, carrito_total, total_con_iva);

	-- desactivar el carrito
	UPDATE carrito SET activo = FALSE WHERE id = carrito_activo_id;

	-- crear un nuevo carrito
	INSERT INTO carrito(cliente_id) VALUES (p_cliente_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cliente_por_email` (IN `p_email` VARCHAR(100))   BEGIN
	SELECT * FROM cliente WHERE email = p_email LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `iniciar_sesion` (OUT `resultado` BOOLEAN, IN `p_email` VARCHAR(100), IN `p_contrasenya` VARCHAR(255))   BEGIN
	DECLARE contra_correcta VARCHAR(255);
	SELECT contrasenya INTO contra_correcta FROM cliente WHERE email = p_email LIMIT 1;

	IF contra_correcta IS NULL THEN 
		SET resultado = FALSE;
	ELSEIF p_contrasenya = contra_correcta THEN 
		SET resultado = TRUE;
	ELSE 
		SET resultado = FALSE;
	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capitulo`
--

CREATE TABLE `capitulo` (
  `id` int(11) NOT NULL,
  `temporada_id` int(11) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT 0.00,
  `activo` tinyint(1) DEFAULT 1,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id`, `cliente_id`, `total`, `activo`, `changedTS`) VALUES
(1, 1, 0.00, 1, '2025-05-28 07:06:19'),
(2, 2, 0.00, 1, '2025-05-28 07:06:19'),
(3, 3, 0.00, 1, '2025-05-28 07:06:19'),
(4, 4, 0.00, 1, '2025-05-28 07:06:19'),
(5, 5, 0.00, 1, '2025-05-28 07:06:19'),
(6, 6, 0.00, 1, '2025-05-28 07:06:19'),
(7, 7, 0.00, 1, '2025-05-28 07:06:19'),
(8, 8, 0.00, 1, '2025-05-28 07:06:19'),
(9, 9, 0.00, 1, '2025-05-29 07:37:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `contrasenya` varchar(255) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `domicilio` varchar(255) DEFAULT NULL,
  `cod_postal` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `num_tarjeta` varchar(100) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `contrasenya`, `nombre`, `apellidos`, `domicilio`, `cod_postal`, `email`, `fecha_nac`, `num_tarjeta`, `changedTS`) VALUES
(1, 'juan123', 'Juan', 'Cuesta', 'Desengaño 21, 2ºA', '28004', 'juan.cuesta@miravereda.es', '1965-03-14', '1234567812345678', '2025-05-28 07:06:19'),
(2, 'emilio456', 'Emilio', 'Delgado', 'Desengaño 21, portería', '28004', 'emilio.delgado@miravereda.es', '1978-07-22', '2345678923456789', '2025-05-28 07:06:19'),
(3, 'lucia789', 'Lucía', 'Álvarez', 'Desengaño 21, 3ºB', '28004', 'lucia.alvarez@miravereda.es', '1980-11-05', '3456789034567890', '2025-05-28 07:06:19'),
(4, 'mauri101', 'Mauri', 'Hidalgo', 'Desengaño 21, 1ºC', '28004', 'mauri.hidalgo@miravereda.es', '1972-02-10', '4567890145678901', '2025-05-28 07:06:19'),
(5, 'belen202', 'Belén', 'López', 'Desengaño 21, 3ºA', '28004', 'belen.lopez@miravereda.es', '1979-08-30', '5678901256789012', '2025-05-28 07:06:19'),
(6, 'marisa303', 'Marisa', 'Benito', 'Desengaño 21, 1ºA', '28004', 'marisa.benito@miravereda.es', '1942-06-12', '6789012367890123', '2025-05-28 07:06:19'),
(7, 'vicenta404', 'Vicenta', 'Benito', 'Desengaño 21, 1ºA', '28004', 'vicenta.benito@miravereda.es', '1945-09-18', '7890123478901234', '2025-05-28 07:06:19'),
(8, 'concha505', 'Concha', 'Jiménez', 'Desengaño 21, 2ºB', '28004', 'concha.jimenez@miravereda.es', '1938-01-27', '8901234589012345', '2025-05-28 07:06:19'),
(9, 'andrii123', 'Andrii', 'Lit', 'Calle principal 17', '46160', 'andlit@miravereda.es', '2004-05-17', '1234567812345678', '2025-05-29 07:37:20');

--
-- Disparadores `cliente`
--
DELIMITER $$
CREATE TRIGGER `trigger_cliente_carrito` AFTER INSERT ON `cliente` FOR EACH ROW BEGIN
	INSERT INTO carrito(cliente_id) VALUES (NEW.id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido`
--

CREATE TABLE `contenido` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `nombre_dir` varchar(255) DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `actores_principales` text DEFAULT NULL,
  `fecha_estreno` date DEFAULT NULL,
  `puntuacion_media` decimal(3,1) DEFAULT NULL,
  `poster_path` varchar(255) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contenido`
--

INSERT INTO `contenido` (`id`, `titulo`, `descripcion`, `genero`, `nombre_dir`, `duracion`, `actores_principales`, `fecha_estreno`, `puntuacion_media`, `poster_path`, `changedTS`) VALUES
(1, 'El Padrino', 'La historia de la familia mafiosa Corleone, liderada por Vito Corleone, y la transformación de su hijo Michael de civil a líder criminal.', 'Drama / Crimen', 'Francis Ford Coppola', 175, 'Marlon Brando, Al Pacino, James Caan', '1972-03-24', 9.3, 'https://pics.filmaffinity.com/El_padrino-993414333-large.jpg', '2025-05-30 08:18:56'),
(2, 'Forrest Gump', 'La vida extraordinaria de Forrest Gump, un hombre con bajo coeficiente intelectual pero con un corazón puro.', 'Drama / Romance', 'Robert Zemeckis', 142, 'Tom Hanks, Robin Wright, Gary Sinise', '1994-07-06', 8.8, 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fpics.filmaffinity.com%2FForrest_Gump-212765827-large.jpg&f=1&nofb=1&ipt=555d631609a0b30ce2ca30977ef98e9d8fb987efc8cd4c39d6cfb4aba31129e1', '2025-05-30 08:04:55'),
(3, 'Inception', 'Un ladrón que roba secretos mediante la tecnología para entrar en los sueños de las personas.', 'Ciencia ficción / Thriller', 'Christopher Nolan', 148, 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page', '2010-07-16', 8.7, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fflxt.tmsimg.com%2Fassets%2Fp7825626_p_v8_af.jpg&f=1&nofb=1&ipt=fece9982d47cd73c45d51e9ca363001c895c77ce7ee9d731e012133672df68b7', '2025-05-30 08:15:29'),
(4, 'El Señor de los Anillos: La Comunidad del Anillo', 'Un hobbit y sus compañeros emprenden un viaje para destruir un anillo poderoso.', 'Fantasía / Aventura', 'Peter Jackson', 178, 'Elijah Wood, Ian McKellen, Orlando Bloom', '2001-12-19', 8.8, 'https://m.media-amazon.com/images/I/51Qvs9i5a%2BL._AC_.jpg', '2025-05-28 09:01:25'),
(5, 'Pulp Fiction', 'Historias entrelazadas de crimen y redención en Los Ángeles.', 'Crimen / Drama', 'Quentin Tarantino', 154, 'John Travolta, Uma Thurman, Samuel L. Jackson', '1994-10-14', 8.9, 'https://m.media-amazon.com/images/I/71c05lTE03L._AC_SY679_.jpg', '2025-05-28 09:01:25'),
(6, 'La La Land', 'Un músico y una actriz buscan cumplir sus sueños en Los Ángeles.', 'Musical / Romance', 'Damien Chazelle', 128, 'Ryan Gosling, Emma Stone', '2016-12-09', 8.0, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FlcYwCSTzCHv0Z2QRpfztt75JyYj.jpg&f=1&nofb=1&ipt=9fab3de2701902be0b8801a67bd18774a262b70ca66b2142bc62200dd73c3e7b', '2025-05-30 08:05:38'),
(7, 'Gladiador', 'Un general romano busca venganza tras ser traicionado y esclavizado.', 'Acción / Drama', 'Ridley Scott', 155, 'Russell Crowe, Joaquin Phoenix', '2000-05-05', 8.5, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-akwiv2qJ-9o%2FXupQNCHDiGI%2FAAAAAAAADLE%2FBQsBxNrwrl8MSvlpAgDuI4TlgAs1UKJ-gCLcBGAsYHQ%2Fs1600%2Fgladiator-522d2bd7f14a4.jpg&f=1&nofb=1&ipt=8214f092b4f2cd80b02a7a4c97b7b5186f1', '2025-05-30 08:08:26'),
(8, 'Matrix', 'Un hacker descubre la verdadera naturaleza de la realidad.', 'Ciencia ficción / Acción', 'Lana Wachowski, Lilly Wachowski', 136, 'Keanu Reeves, Laurence Fishburne', '1999-03-31', 8.7, 'https://m.media-amazon.com/images/I/51vpnbwFHrL._AC_.jpg', '2025-05-28 09:01:25'),
(9, 'Titanic', 'Un romance a bordo del fatídico transatlántico.', 'Drama / Romance', 'James Cameron', 195, 'Leonardo DiCaprio, Kate Winslet', '1997-12-19', 7.8, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Foriginalvintagemovieposters.com%2Fwp-content%2Fuploads%2F2020%2F02%2FTITANIC-8567-scaled.jpg&f=1&nofb=1&ipt=7ad0fe22c4e727d7623e54745d3e1642f9550db05639ee39e3caebef4ff5c73d', '2025-05-30 08:10:12'),
(10, 'El Club de la Pelea', 'Un hombre insomne forma un club secreto de lucha.', 'Drama / Thriller', 'David Fincher', 139, 'Brad Pitt, Edward Norton', '1999-10-15', 8.8, 'https://m.media-amazon.com/images/I/51v5ZpFyaFL._AC_SY679_.jpg', '2025-05-30 08:11:12'),
(11, 'Interstellar', 'Un grupo de exploradores viaja a través de un agujero de gusano para salvar a la humanidad.', 'Ciencia ficción / Drama', 'Christopher Nolan', 169, 'Matthew McConaughey, Anne Hathaway', '2014-11-07', 8.6, 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ffc04.deviantart.net%2Ffs71%2Ff%2F2014%2F045%2Fa%2F2%2Finterstellar_by_visuasys-d6ibj30.jpg&f=1&nofb=1&ipt=40e450f22815f8d425ff00557720b273075838a00b1297914b8bc9ba64e51b6e', '2025-05-30 08:19:26'),
(12, 'El Gran Lebowski', 'Un hombre común se ve envuelto en una complicada historia de secuestro.', 'Comedia / Crimen', 'Joel Coen, Ethan Coen', 117, 'Jeff Bridges, John Goodman', '1998-03-06', 8.1, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.justwatch.com%2Fposter%2F76802182%2Fs718&f=1&nofb=1&ipt=a2d925e102bfa3d5ed63e66eff80c0fd6f40db0b5b872320d3a6993e61ff4346', '2025-05-30 08:21:37'),
(13, 'Toy Story', 'Los juguetes cobran vida cuando los humanos no están presentes.', 'Animación / Aventura', 'John Lasseter', 81, 'Tom Hanks, Tim Allen', '1995-11-22', 8.3, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpics.filmaffinity.com%2Ftoy_story-626273371-large.jpg&f=1&nofb=1&ipt=e125d41601314a3de0de0ca1c8af31e44893772cbebd0f93e2ed6e1a8efb3858', '2025-05-30 08:22:00'),
(14, 'La lista de Schindler', 'Un empresario salva a cientos de judíos durante el Holocausto.', 'Drama / Historia', 'Steven Spielberg', 195, 'Liam Neeson, Ben Kingsley', '1993-12-15', 8.9, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.xYBbtWDsAno7WqLksl3XcQHaLb%26pid%3DApi&f=1&ipt=2525f2b984f23e7b01157e62f9bc6faca9a5673cf7d6470d44330571425f60a7', '2025-05-30 08:26:34'),
(15, 'Salvar al Soldado Ryan', 'Durante la Segunda Guerra Mundial, un grupo debe rescatar a un soldado.', 'Guerra / Drama', 'Steven Spielberg', 169, 'Tom Hanks, Matt Damon', '1998-07-24', 8.6, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.ecured.cu%2Fimages%2Fthumb%2F0%2F01%2FSalvar_al_soldado_Ryan.jpg%2F1200px-Salvar_al_soldado_Ryan.jpg&f=1&nofb=1&ipt=781cff29fe18edb3e5839d9cb4bd9017177484ad078e4ea904581af567c7f38e', '2025-05-30 08:27:21'),
(16, 'El Rey León', 'Un joven león debe asumir su destino como rey de la sabana.', 'Animación / Aventura', 'Roger Allers, Rob Minkoff', 88, 'Matthew Broderick, James Earl Jones', '1994-06-24', 8.5, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.themoviedb.org%2Ft%2Fp%2Foriginal%2Fr7DEmhFWpXWnYU9nbQhx3gPJovS.jpg&f=1&nofb=1&ipt=c9aa39fd1a46861caafeb593299efe487f3c6e8ec1e1c212c9eb0960807e837c', '2025-05-30 08:28:44'),
(17, 'El Pianista', 'Un pianista polaco sobrevive a la ocupación nazi en Varsovia.', 'Drama / Historia', 'Roman Polanski', 150, 'Adrien Brody', '2002-09-24', 8.5, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fes.web.img2.acsta.net%2Fpictures%2F14%2F05%2F27%2F12%2F07%2F438875.jpg&f=1&nofb=1&ipt=fe0923ac8a139bafc691038b5e36c4b17ec90038cfdca261a2ee1b6926362b8c', '2025-05-30 08:30:54'),
(18, 'Memento', 'Un hombre con pérdida de memoria intenta resolver el asesinato de su esposa.', 'Thriller / Misterio', 'Christopher Nolan', 113, 'Guy Pearce, Carrie-Anne Moss', '2000-09-05', 8.4, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.themoviedb.org%2Ft%2Fp%2Foriginal%2FbDgEwnPFcPrJcM5xvkt8EphZ9A3.jpg&f=1&nofb=1&ipt=c663c2d2a6f3740fca9f9c670f4426499bebe1631f9ecd39d80312132b8973d7', '2025-05-30 08:32:46'),
(19, 'El Imperio Contraataca', 'La continuación de la saga Star Wars, con batallas épicas.', 'Ciencia ficción / Aventura', 'Irvin Kershner', 124, 'Mark Hamill, Harrison Ford', '1980-05-21', 8.7, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fhttp2.mlstatic.com%2FD_NQ_NP_725340-MCO48589692950_122021-O.webp&f=1&nofb=1&ipt=a06ab4ce01e1db302f4064ebdadd751f60798403bc189d1838f3bdda1cf035a6', '2025-05-30 08:34:07'),
(20, ' Ready Player One ', 'Año 2045. Wade Watts es un adolescente al que le gusta evadirse del cada vez más sombrío mundo real a través de una popular utopía virtual a escala global llamada ', '     Ciencia ficción. Aventuras. Acción | Distopía', 'Steven Spielberg', 140, 'Tye Sheridan, Olivia Cooke', '2018-03-29', 6.3, 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.tmdb.org%2Ft%2Fp%2Foriginal%2FsbDIPdRmnviCD55qhaoNVpIT794.jpg&f=1&nofb=1&ipt=618d509a2fe01b3e4c539ec3416f0ba1b1653904d62bf7ba8926927e2b6b0401', '2025-05-30 08:04:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `corto`
--

CREATE TABLE `corto` (
  `contenido_id` int(11) NOT NULL,
  `tarifa_id` int(11) DEFAULT NULL,
  `disponibilidad` tinyint(1) DEFAULT 1,
  `precio` decimal(10,2) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `total_con_iva` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,0) DEFAULT 0,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lin_fac`
--

CREATE TABLE `lin_fac` (
  `carrito_id` int(11) NOT NULL,
  `contenido_id` int(11) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pelicula`
--

CREATE TABLE `pelicula` (
  `contenido_id` int(11) NOT NULL,
  `tarifa_id` int(11) DEFAULT NULL,
  `disponible_hasta` date DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `serie`
--

CREATE TABLE `serie` (
  `contenido_id` int(11) NOT NULL,
  `tarifa_id` int(11) DEFAULT NULL,
  `disponibilidad` tinyint(1) DEFAULT 1,
  `precio` decimal(10,2) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa`
--

CREATE TABLE `tarifa` (
  `id` int(11) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `porcentaje` decimal(5,4) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `temporada`
--

CREATE TABLE `temporada` (
  `id` int(11) NOT NULL,
  `serie_id` int(11) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoracion`
--

CREATE TABLE `valoracion` (
  `cliente_id` int(11) NOT NULL,
  `contenido_id` int(11) NOT NULL,
  `valor` int(11) DEFAULT NULL,
  `changedTS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `valoracion`
--
DELIMITER $$
CREATE TRIGGER `trigger_actualizar_nota` AFTER INSERT ON `valoracion` FOR EACH ROW BEGIN
	CALL actualizar_nota(NEW.contenido_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_valoracion_insert` BEFORE INSERT ON `valoracion` FOR EACH ROW BEGIN
	IF NEW.valor > 10 THEN 
		SET NEW.valor = 10;
	ELSEIF NEW.valor < 0 THEN 
		SET NEW.valor = 0;
	END IF;
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `capitulo`
--
ALTER TABLE `capitulo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `temporada_id` (`temporada_id`);

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `contenido`
--
ALTER TABLE `contenido`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `corto`
--
ALTER TABLE `corto`
  ADD PRIMARY KEY (`contenido_id`),
  ADD KEY `tarifa_id` (`tarifa_id`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `lin_fac`
--
ALTER TABLE `lin_fac`
  ADD PRIMARY KEY (`carrito_id`,`contenido_id`),
  ADD KEY `contenido_id` (`contenido_id`);

--
-- Indices de la tabla `pelicula`
--
ALTER TABLE `pelicula`
  ADD PRIMARY KEY (`contenido_id`),
  ADD KEY `tarifa_id` (`tarifa_id`);

--
-- Indices de la tabla `serie`
--
ALTER TABLE `serie`
  ADD PRIMARY KEY (`contenido_id`),
  ADD KEY `tarifa_id` (`tarifa_id`);

--
-- Indices de la tabla `tarifa`
--
ALTER TABLE `tarifa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `temporada`
--
ALTER TABLE `temporada`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `serie_id` (`serie_id`,`numero`);

--
-- Indices de la tabla `valoracion`
--
ALTER TABLE `valoracion`
  ADD PRIMARY KEY (`cliente_id`,`contenido_id`),
  ADD KEY `contenido_id` (`contenido_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `capitulo`
--
ALTER TABLE `capitulo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarifa`
--
ALTER TABLE `tarifa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `temporada`
--
ALTER TABLE `temporada`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `capitulo`
--
ALTER TABLE `capitulo`
  ADD CONSTRAINT `capitulo_ibfk_1` FOREIGN KEY (`temporada_id`) REFERENCES `temporada` (`id`);

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `corto`
--
ALTER TABLE `corto`
  ADD CONSTRAINT `corto_ibfk_1` FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`id`),
  ADD CONSTRAINT `corto_ibfk_2` FOREIGN KEY (`tarifa_id`) REFERENCES `tarifa` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `lin_fac`
--
ALTER TABLE `lin_fac`
  ADD CONSTRAINT `lin_fac_ibfk_1` FOREIGN KEY (`carrito_id`) REFERENCES `carrito` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lin_fac_ibfk_2` FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`id`);

--
-- Filtros para la tabla `pelicula`
--
ALTER TABLE `pelicula`
  ADD CONSTRAINT `pelicula_ibfk_1` FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`id`),
  ADD CONSTRAINT `pelicula_ibfk_2` FOREIGN KEY (`tarifa_id`) REFERENCES `tarifa` (`id`);

--
-- Filtros para la tabla `serie`
--
ALTER TABLE `serie`
  ADD CONSTRAINT `serie_ibfk_1` FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`id`),
  ADD CONSTRAINT `serie_ibfk_2` FOREIGN KEY (`tarifa_id`) REFERENCES `tarifa` (`id`);

--
-- Filtros para la tabla `temporada`
--
ALTER TABLE `temporada`
  ADD CONSTRAINT `temporada_ibfk_1` FOREIGN KEY (`serie_id`) REFERENCES `serie` (`contenido_id`);

--
-- Filtros para la tabla `valoracion`
--
ALTER TABLE `valoracion`
  ADD CONSTRAINT `valoracion_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `valoracion_ibfk_2` FOREIGN KEY (`contenido_id`) REFERENCES `contenido` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
