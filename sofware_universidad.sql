-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-12-2024 a las 17:11:52
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sofware_universidad`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivosdocentes`
--

CREATE TABLE `archivosdocentes` (
  `id` int(11) NOT NULL,
  `docente_id` int(11) NOT NULL,
  `silabo` tinyint(1) DEFAULT 0,
  `carpeta` tinyint(1) DEFAULT 0,
  `archivo_nombre` varchar(255) NOT NULL,
  `archivo_ruta` varchar(255) NOT NULL,
  `fecha_subida` datetime DEFAULT current_timestamp(),
  `asignatura` enum('Ing. Industrial','Ing. Civil','Arquitectura','Ingeniería de Sistemas y Computación','Ingeniería Ambiental') NOT NULL DEFAULT 'Ing. Industrial',
  `ciclo` int(11) NOT NULL DEFAULT 1,
  `curso_asignatura` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `archivosdocentes`
--

INSERT INTO `archivosdocentes` (`id`, `docente_id`, `silabo`, `carpeta`, `archivo_nombre`, `archivo_ruta`, `fecha_subida`, `asignatura`, `ciclo`, `curso_asignatura`) VALUES
(64, 1008, 1, 1, 'TESIS.docx', 'uploads/TESIS.docx', '2024-12-14 17:35:29', 'Arquitectura', 4, 'Suelo 2'),
(66, 1008, 1, 1, 'TESIS.docx', 'uploads/TESIS.docx', '2024-12-14 17:38:03', 'Arquitectura', 4, 'Suelo 2'),
(69, 1008, 1, 1, 'TESIS.docx', 'uploads/TESIS.docx', '2024-12-14 17:39:38', 'Arquitectura', 4, 'Suelo 2'),
(70, 1004, 0, 1, 'VI_ELECTRONICA INDUSTRIAL_SILABO.docx', 'uploads/VI_ELECTRONICA INDUSTRIAL_SILABO.docx', '2024-12-16 12:36:16', '', 1, 'Habilidades  investigativas'),
(71, 1005, 1, 0, 'III_PSICOLOGIA INDUSTRIAL_CARPETA.docx', 'uploads/III_PSICOLOGIA INDUSTRIAL_CARPETA.docx', '2024-12-19 10:36:04', '', 6, 'BASE DATOS II'),
(72, 1008, 1, 0, 'III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', 'uploads/III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', '2024-12-19 10:49:18', 'Arquitectura', 1, 'BASE DATOS II'),
(73, 1008, 1, 0, 'III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', 'uploads/III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', '2024-12-19 10:52:27', 'Arquitectura', 1, 'BASE DATOS II'),
(74, 1008, 1, 0, 'III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', 'uploads/III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', '2024-12-19 10:56:46', 'Arquitectura', 1, 'BASE DATOS II'),
(75, 1008, 1, 0, 'III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', 'uploads/III_PSICOLOGIA INDUSTRIAL_CARPETA (1).docx', '2024-12-19 11:03:50', 'Arquitectura', 1, 'BASE DATOS II');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracioncheckbox`
--

CREATE TABLE `configuracioncheckbox` (
  `id` int(11) NOT NULL,
  `docente_id` int(11) NOT NULL,
  `silabo` tinyint(1) DEFAULT 0,
  `carpeta` tinyint(1) DEFAULT 0,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracioncheckbox`
--

INSERT INTO `configuracioncheckbox` (`id`, `docente_id`, `silabo`, `carpeta`, `actualizado_por`, `fecha_actualizacion`, `fecha`) VALUES
(26, 1006, 0, 1, NULL, '2024-12-14 20:36:01', '2024-12-14 15:36:01'),
(27, 1006, 0, 1, NULL, '2024-12-14 20:36:20', '2024-12-14 15:36:20'),
(28, 1006, 0, 1, NULL, '2024-12-14 20:37:02', '2024-12-14 15:37:02'),
(29, 1006, 0, 1, NULL, '2024-12-14 20:38:35', '2024-12-14 15:38:35'),
(30, 1006, 0, 1, NULL, '2024-12-14 20:39:51', '2024-12-14 15:39:51'),
(31, 1006, 0, 1, NULL, '2024-12-14 20:40:03', '2024-12-14 15:40:03'),
(32, 1006, 0, 1, NULL, '2024-12-14 20:40:21', '2024-12-14 15:40:21'),
(33, 1006, 0, 1, NULL, '2024-12-14 20:40:28', '2024-12-14 15:40:28'),
(34, 1008, 1, 1, NULL, '2024-12-14 20:40:39', '2024-12-14 15:40:39'),
(35, 1008, 0, 0, NULL, '2024-12-14 20:41:07', '2024-12-14 15:41:07'),
(36, 1008, 0, 0, NULL, '2024-12-14 20:41:31', '2024-12-14 15:41:31'),
(37, 1006, 0, 1, NULL, '2024-12-14 20:41:35', '2024-12-14 15:41:35'),
(38, 1008, 0, 0, NULL, '2024-12-14 22:40:41', '2024-12-14 17:40:41'),
(39, 1007, 0, 0, NULL, '2024-12-14 22:40:56', '2024-12-14 17:40:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docenteuniversitario`
--

CREATE TABLE `docenteuniversitario` (
  `id` int(11) NOT NULL,
  `docente` varchar(100) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `titulo_profesional` varchar(100) DEFAULT NULL,
  `carrera_profesional` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `docenteuniversitario`
--

INSERT INTO `docenteuniversitario` (`id`, `docente`, `telefono`, `titulo_profesional`, `carrera_profesional`) VALUES
(1000, 'Aliaga Contreras Aron Jhonathan', '945599502', 'Ingeniero Civil', 'INGENIERIA CIVIL'),
(1001, 'Almonacid Ordoñez Lidia Leonor', '997887866', 'Ingeniero Civil', 'INGENIERIA CIVIL'),
(1002, 'Alvarez Montalvan Carlos Enrique', '968040122', 'Ingeniero Forestal y Ambiental', 'INGENIERIA'),
(1003, 'Alvarez Montalvan Carlos Enrique', '968040122', 'Ingeniero Forestal y Ambiental', 'INGENIERIA DEL MEDIO AMBIENTE Y DESARROLLO'),
(1004, 'Alvarez Tolentino Daniel Martin', '979702605', 'Biologo Hidrobiologia y Pesqueria', 'INGENIERIA'),
(1005, 'Anaya Ureña Antonio', '964818118', 'Ingeniero Industrial', 'INGENIERIA'),
(1006, 'Anccasi Rojas Carlos Arturo', '937668008', 'Ingeniero Civil', 'INGENIERIA CIVIL'),
(1007, 'Apaclla Inga Carlos Alberto', '999980239', 'Arquitecto', 'ARQUITECTURA'),
(1008, 'Arana Caparachin Maglioni', '964755083', 'Ingeniero en Informatica', 'INGENIERIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` int(11) NOT NULL,
  `id_docente` int(11) DEFAULT NULL,
  `nombre_documento` varchar(255) NOT NULL,
  `ruta_documento` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `infodocentes`
--

CREATE TABLE `infodocentes` (
  `id` varchar(10) NOT NULL,
  `docente` varchar(255) NOT NULL,
  `telefono` varchar(10) NOT NULL,
  `Titulo_Profesional` varchar(255) NOT NULL,
  `Carrera_Profesional` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `infodocentes`
--

INSERT INTO `infodocentes` (`id`, `docente`, `telefono`, `Titulo_Profesional`, `Carrera_Profesional`) VALUES
('1000', 'Aliaga Contreras Aron Jhonathan ', '945599502', 'Ingeniero Civil', 'INGENIERIA CIVIL'),
('1001', 'Almonacid Ordoñez Lidia Leonor ', '997887866', 'Ingenieria Civil', 'INGENIERIA CIVIL'),
('1002', 'Alvarez Montalvan Carlos Enrique ', '968040122', 'Ingeniero Forestal y Ambiental', 'INGENIERIA'),
('1003', 'Alvarez Montalvan Carlos Enrique ', '968040122', 'Ingeniero Forestal y Ambiental', 'INGENIERIA DEL MEDIO AMBIENTE Y DESARROLLO'),
('1004', 'Alvarez Tolentino Daniel Martin ', '979702605', 'Biologo Hidrobiologia y Pesqueria', 'INGENIERIA'),
('1005', 'Anaya Ure?a Antonio', '964818118', 'Ingeniero Industrial', 'INGENIERIA'),
('1006', 'Anccasi Rojas Carlos Arturo ', '937668008', 'Ingeniero Civil', 'INGENIERIA CIVIL'),
('1007', 'Apaclla Inga Carlos Alberto ', '999980239', 'Arquitecto', 'ARQUITECTURA'),
('1008', 'Arana Caparachin Maglioni ', '964755083', 'Ingeniero en Informatica', 'INGENIERIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recordatorios`
--

CREATE TABLE `recordatorios` (
  `id` int(11) NOT NULL,
  `id_docente` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recordatorios`
--

INSERT INTO `recordatorios` (`id`, `id_docente`, `descripcion`, `fecha`) VALUES
(14, 1008, 'wadssd', '2024-12-03 16:51:29'),
(15, 1005, 'SFDGHKHGJFJBNKUHKN', '2024-12-05 01:00:10'),
(17, 1005, '122586754', '2024-12-10 16:39:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `tipo_usuario` enum('admin','usuario') NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `contrasena`, `tipo_usuario`, `fecha_creacion`) VALUES
(1, 'admin', 'admin123', 'admin', '2024-12-01 20:40:04'),
(2, 'usuario', '1010', 'usuario', '2024-12-01 20:40:04');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `archivosdocentes`
--
ALTER TABLE `archivosdocentes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `docente_id` (`docente_id`);

--
-- Indices de la tabla `configuracioncheckbox`
--
ALTER TABLE `configuracioncheckbox`
  ADD PRIMARY KEY (`id`),
  ADD KEY `docente_id` (`docente_id`);

--
-- Indices de la tabla `docenteuniversitario`
--
ALTER TABLE `docenteuniversitario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_docente` (`id_docente`);

--
-- Indices de la tabla `infodocentes`
--
ALTER TABLE `infodocentes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recordatorios`
--
ALTER TABLE `recordatorios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_docente` (`id_docente`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `archivosdocentes`
--
ALTER TABLE `archivosdocentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT de la tabla `configuracioncheckbox`
--
ALTER TABLE `configuracioncheckbox`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `docenteuniversitario`
--
ALTER TABLE `docenteuniversitario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1009;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `recordatorios`
--
ALTER TABLE `recordatorios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivosdocentes`
--
ALTER TABLE `archivosdocentes`
  ADD CONSTRAINT `archivosdocentes_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `docenteuniversitario` (`id`);

--
-- Filtros para la tabla `configuracioncheckbox`
--
ALTER TABLE `configuracioncheckbox`
  ADD CONSTRAINT `configuracioncheckbox_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `docenteuniversitario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docenteuniversitario` (`id`);

--
-- Filtros para la tabla `recordatorios`
--
ALTER TABLE `recordatorios`
  ADD CONSTRAINT `fk_docente` FOREIGN KEY (`id_docente`) REFERENCES `docenteuniversitario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
