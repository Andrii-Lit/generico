-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-05-2025 a las 11:55:06
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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
