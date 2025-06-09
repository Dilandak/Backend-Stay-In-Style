-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-06-2025 a las 22:40:51
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
-- Base de datos: `stayprueba`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('058ae75d1239');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carritos`
--

CREATE TABLE `carritos` (
  `id` int(11) NOT NULL,
  `total` float DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carritos`
--

INSERT INTO `carritos` (`id`, `total`, `estado`, `id_usuario`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(2, 0, 'Completado', 10, '2025-05-10 13:04:15', '2025-05-16 16:49:36'),
(5, 0, 'Cancelado', 2, '2025-05-10 14:10:56', '2025-05-12 15:31:09'),
(9, 0, 'Cancelado', 2, '2025-05-12 15:32:24', '2025-05-12 15:38:20'),
(10, 0, 'Completado', 2, '2025-05-12 15:38:36', '2025-05-12 17:08:02'),
(11, 0, 'Cancelado', 2, '2025-05-12 17:31:41', '2025-05-12 17:32:03'),
(12, 0, 'Completado', 2, '2025-05-12 17:32:08', '2025-05-12 17:32:21'),
(13, 0, 'Completado', 2, '2025-05-13 14:39:47', '2025-05-13 15:39:14'),
(14, 0, 'Completado', 2, '2025-05-13 16:47:36', '2025-05-13 16:47:54'),
(25, 0, 'Completado', 2, '2025-05-15 10:34:37', '2025-05-15 11:31:53'),
(26, 0, 'Completado', 2, '2025-05-15 11:48:24', '2025-05-15 11:48:31'),
(27, 0, 'Completado', 2, '2025-05-15 17:09:21', '2025-05-16 16:51:39'),
(28, 0, 'Completado', 2, '2025-05-16 16:55:35', '2025-05-16 16:55:48'),
(29, 0, 'Completado', 2, '2025-05-19 11:47:55', '2025-05-20 14:51:23'),
(30, 150000, 'Abierto', 1, '2025-05-20 14:50:44', '2025-05-20 14:50:44'),
(31, 0, 'Completado', 2, '2025-05-20 15:00:57', '2025-05-20 15:01:12'),
(32, 0, 'Completado', 2, '2025-05-20 15:02:31', '2025-05-20 15:02:42'),
(33, 0, 'Completado', 11, '2025-05-20 19:14:09', '2025-05-20 19:14:55'),
(34, 0, 'Completado', 11, '2025-05-20 19:32:21', '2025-05-20 19:32:40'),
(35, 0, 'Completado', 11, '2025-05-20 19:38:23', '2025-05-20 19:38:32'),
(36, 0, 'Completado', 11, '2025-05-20 19:39:07', '2025-05-20 19:39:28'),
(37, 0, 'Completado', 2, '2025-05-22 13:49:34', '2025-05-22 13:50:51'),
(38, 0, 'Cancelado', 2, '2025-05-22 13:58:30', '2025-05-22 13:59:01'),
(39, 1410000, 'Abierto', 11, '2025-05-23 11:50:33', '2025-05-23 12:06:24'),
(40, 0, 'Completado', 2, '2025-05-23 15:31:44', '2025-05-23 15:32:10'),
(41, 0, 'Completado', 2, '2025-05-23 15:58:57', '2025-05-23 17:14:32'),
(43, 0, 'Completado', 32, '2025-05-30 16:44:04', '2025-05-30 17:05:31'),
(44, 180000, 'Abierto', 2, '2025-05-30 16:45:59', '2025-05-30 16:57:48'),
(45, 0, 'Completado', 32, '2025-05-30 17:20:24', '2025-05-30 17:20:34'),
(46, 0, 'Completado', 32, '2025-05-30 17:20:57', '2025-05-30 17:21:36'),
(47, 0, 'Completado', 32, '2025-05-30 17:22:52', '2025-05-30 17:32:59'),
(48, 0, 'Completado', 32, '2025-05-30 17:33:28', '2025-05-30 17:33:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito_productos`
--

CREATE TABLE `carrito_productos` (
  `id` int(11) NOT NULL,
  `id_carrito` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `subtotal` float NOT NULL,
  `id_talla` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito_productos`
--

INSERT INTO `carrito_productos` (`id`, `id_carrito`, `id_producto`, `cantidad`, `subtotal`, `id_talla`) VALUES
(51, 30, 13, 2, 150000, 1),
(64, 39, 18, 10, 1000000, 3),
(65, 39, 2, 2, 210000, 5),
(66, 39, 4, 2, 200000, 2),
(75, 44, 3, 2, 180000, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1, 'Chaqueta'),
(2, 'Camiseta'),
(3, 'Pantalón'),
(4, 'Short'),
(5, 'Camisa'),
(6, 'Cargo'),
(7, 'Jeans');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `barrio` varchar(100) NOT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_compra` datetime DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `metodo_pago_id` int(11) NOT NULL,
  `estado_pedido` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `barrio`, `observaciones`, `fecha_compra`, `usuario_id`, `metodo_pago_id`, `estado_pedido`) VALUES
(1, 'Usme', 'cuidado', '2025-04-24 03:46:09', 2, 2, 'Procesado'),
(3, 'hola', 'hola', '2025-04-24 04:14:48', 1, 3, 'Procesado'),
(4, 'usme', 'bonita', '2025-04-24 04:17:10', 1, 2, 'Procesado'),
(5, 'Usme', 'queir oqeu llegue de 8 a 10 de la mañana', '2025-04-25 13:22:46', 1, 3, 'Procesado'),
(6, 'hola', 'hola', '2025-04-25 13:26:59', 1, 2, 'Procesado'),
(7, 'usme', 'quiero que sea por la mañna', '2025-04-29 22:01:13', 1, 2, 'Procesado'),
(8, 'usme', 'usme por dios', '2025-04-30 22:19:38', 1, 3, 'Enviado'),
(10, 'usme', 'el diablo, en usme porfavor wey a la verga ', '2025-04-30 22:31:38', 1, 1, 'Procesado'),
(11, 'chaínero usaquen', 'ssssss', '2025-04-30 22:35:50', 1, 3, 'Procesado'),
(12, 'Usme', 'ffff', '2025-05-05 16:15:09', 1, 1, 'Procesado'),
(13, 'essss', 'sasas', '2025-05-06 16:49:48', 3, 1, 'Procesado'),
(16, 'Centro', 'Entrega urgente', '2025-05-07 05:34:03', 1, 2, 'Procesado'),
(18, 'Centro', 'Enssssss', '2025-05-07 05:39:26', 4, 3, 'Procesado'),
(20, 'sosologia', 'porfavor111', '2025-05-07 17:27:13', 5, 1, 'Cancelado'),
(29, 'gg', 'ggg', '2025-05-07 18:46:10', 2, 1, 'Procesado'),
(34, 'pruebastock', 'pruebastock', '2025-05-12 22:08:02', 2, 1, 'Procesado'),
(35, 'Pruebastock2', 'Pruebastock2', '2025-05-12 22:32:21', 2, 1, 'Procesado'),
(36, 'pruebastock4', 'pruebastock4', '2025-05-13 20:39:14', 2, 1, 'Procesado'),
(37, 'x', 'x', '2025-05-13 21:47:53', 2, 2, 'Procesado'),
(38, 'prueba final', 'prueba final', '2025-05-13 22:02:06', 2, 3, 'Procesado'),
(45, 'SSSSSS', 'SSSSSS', '2025-05-15 16:31:53', 2, 1, 'Procesado'),
(46, '1', '1', '2025-05-15 16:48:31', 2, 2, 'Procesado'),
(47, 'pruebahisorialcompras', 'pruebahisorialcompras', '2025-05-16 21:49:36', 10, 3, 'Procesado'),
(48, 'prueanfoto', 'foto', '2025-05-16 21:51:39', 2, 3, 'Procesado'),
(49, 'final', 'final', '2025-05-16 21:55:48', 2, 2, 'Entregado'),
(50, 'Prueba stock', 'Prueba stock', '2025-05-20 19:51:23', 2, 3, 'Procesado'),
(51, 'PRUEBA STOCK ACTUALIZADO PRODUCTO', 'PRUEBA STOCK ACTUALIZADO PRODUCTO', '2025-05-20 20:01:12', 2, 2, 'Cancelado'),
(52, 'JMAR', 'JMAR', '2025-05-20 20:02:42', 2, 1, 'Enviado'),
(53, 'El espino', 'porfavor llegue de 6 a 9 de la mañana ', '2025-05-21 00:14:54', 11, 1, 'Procesado'),
(54, 'Prueba stock', 'pruebastock', '2025-05-21 00:32:40', 11, 2, 'Procesado'),
(55, 'ss', 'ss', '2025-05-21 00:38:32', 11, 3, 'Procesado'),
(56, 'j', 'j', '2025-05-21 00:39:28', 11, 3, 'Procesado'),
(57, 'ddddd', 'dd', '2025-05-22 18:50:51', 2, 2, 'Enviado'),
(58, 'asdads', 'qeewqqew', '2025-05-23 20:32:10', 2, 2, 'Entregado'),
(59, 'ssss', 'sssss', '2025-05-23 22:14:32', 2, 3, 'Procesado'),
(61, 'x', 'x', '2025-05-26 21:49:31', 2, 1, 'Procesado'),
(62, 'Usme', 'LLegar de 6 a 9 porfa', '2025-05-30 22:05:31', 32, 1, 'Procesado'),
(63, 'usmes', 'usme', '2025-05-30 22:20:34', 32, 3, 'Procesado'),
(64, 'prueb', 'asddaspeuba', '2025-05-30 22:21:36', 32, 1, 'Enviado'),
(65, 'usme', 'usme', '2025-05-30 22:32:59', 32, 2, 'Procesado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_producto`
--

CREATE TABLE `compra_producto` (
  `compra_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `precio_unitario` float NOT NULL,
  `cantidad` int(11) NOT NULL,
  `id_talla` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compra_producto`
--

INSERT INTO `compra_producto` (`compra_id`, `producto_id`, `precio_unitario`, `cantidad`, `id_talla`) VALUES
(29, 2, 105000, 1, NULL),
(34, 3, 90000, 1, NULL),
(35, 3, 90000, 1, NULL),
(36, 4, 100000, 2, NULL),
(36, 8, 90000, 2, NULL),
(37, 3, 90000, 1, NULL),
(38, 3, 90000, 1, NULL),
(45, 1, 119900, 2, 1),
(45, 3, 90000, 1, 1),
(46, 4, 100000, 1, 5),
(47, 21, 150000, 1, 4),
(48, 4, 100000, 1, 3),
(49, 4, 100000, 1, 3),
(50, 13, 75000, 2, 1),
(51, 13, 75000, 3, 1),
(52, 1, 119900, 2, 2),
(53, 16, 95000, 2, 2),
(53, 18, 100000, 1, 4),
(55, 3, 90000, 1, 2),
(56, 14, 100000, 1, 3),
(56, 17, 100000, 1, 2),
(56, 20, 90000, 1, 3),
(57, 1, 119900, 1, 1),
(58, 1, 119900, 2, 1),
(59, 2, 105000, 2, 5),
(59, 4, 100000, 2, 2),
(59, 18, 100000, 10, 3),
(62, 2, 105000, 16, 1),
(62, 3, 90000, 12, 1),
(63, 2, 105000, 1, 1),
(64, 2, 105000, 2, 1),
(65, 2, 105000, 1, 2),
(65, 3, 90000, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`id`, `nombre`) VALUES
(1, 'Hombre'),
(2, 'Mujer');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_stock`
--

CREATE TABLE `historial_stock` (
  `id` int(11) NOT NULL,
  `id_inventario` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `stock_anterior` int(11) NOT NULL,
  `stock_nuevo` int(11) NOT NULL,
  `diferencia` int(11) NOT NULL,
  `fecha_cambio` datetime NOT NULL,
  `motivo` varchar(100) DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  `id_talla` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_stock`
--

INSERT INTO `historial_stock` (`id`, `id_inventario`, `id_usuario`, `stock_anterior`, `stock_nuevo`, `diferencia`, `fecha_cambio`, `motivo`, `id_producto`, `id_talla`) VALUES
(2, 107, 1, 2, 22, 20, '2025-05-19 22:00:32', 'PRUEBA9', 1, 1),
(3, 107, 1, 2, 22, 20, '2025-05-19 22:00:32', 'PRUEBA9', 1, 1),
(4, 107, 1, 22, 10, -12, '2025-05-19 22:03:52', 'sss', 1, 1),
(5, 138, 1, 9, 12, 3, '2025-05-19 22:05:54', 'AJUSTAMOS EL STOCK talla s', 7, 2),
(6, 112, 1, 0, 19, 19, '2025-05-19 22:07:25', 'ajajja', 2, 1),
(7, 107, 1, 10, 0, -10, '2025-05-19 22:18:29', 'x', 1, 1),
(8, 108, 1, 8, 0, -8, '2025-05-19 22:18:36', 'x', 1, 2),
(9, 109, 1, 10, 0, -10, '2025-05-19 22:18:44', 'x', 1, 3),
(10, 110, 1, 7, 0, -7, '2025-05-19 22:18:52', 'x', 1, 4),
(11, 111, 1, 3, 0, -3, '2025-05-19 22:19:02', 'x', 1, 5),
(12, 107, 1, 0, 1, 1, '2025-05-20 19:41:19', 'ss', 1, 1),
(13, 107, 1, 1, 0, -1, '2025-05-20 19:44:54', 'Probar nueva vista', 1, 1),
(14, 167, 1, 8, 0, -8, '2025-05-20 19:47:43', 'PRUEBA STOCK', 13, 1),
(15, 168, 1, 12, 0, -12, '2025-05-20 19:47:51', 'PRUEBA STOCK', 13, 2),
(16, 169, 1, 20, 0, -20, '2025-05-20 19:47:59', 'PRUEBA STOCK', 13, 3),
(17, 170, 1, 15, 0, -15, '2025-05-20 19:48:09', 'PRUEBA STOCK', 13, 4),
(18, 171, 1, 10, 0, -10, '2025-05-20 19:48:17', 'PRUEBA STOCK', 13, 5),
(19, 167, 1, 0, 2, 2, '2025-05-20 19:50:32', 'PRUEBA', 13, 1),
(20, 167, 1, 0, 3, 3, '2025-05-20 20:00:30', 'pruebaxd', 13, 1),
(21, 108, 1, 0, 2, 2, '2025-05-20 20:02:17', 'sxsxss', 1, 2),
(22, 107, 1, 0, 1, 1, '2025-05-20 20:05:36', 'prueanadmin', 1, 1),
(23, 107, 1, 0, 1, 1, '2025-05-20 20:05:36', 'prueanadmin', 1, 1),
(24, 107, 1, 0, 2, 2, '2025-05-22 18:58:09', 'Se acabo el stock', 1, 1),
(25, 226, 1, 2, 6, 4, '2025-05-27 06:15:48', 'PRUEBA STOCK', 1, 7),
(26, 226, 1, 6, 0, -6, '2025-05-27 06:47:02', 'Actualización manual', 1, 7),
(28, 147, 1, 7, 15, 8, '2025-05-31 20:21:28', 'Sumamos', 9, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `id_talla` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id`, `id_producto`, `stock`, `id_talla`) VALUES
(107, 1, 0, 1),
(108, 1, 0, 2),
(109, 1, 0, 3),
(110, 1, 0, 4),
(111, 1, 0, 5),
(112, 2, 0, 1),
(113, 2, 10, 2),
(114, 2, 15, 3),
(115, 2, 9, 4),
(116, 2, 2, 5),
(117, 3, 6, 1),
(118, 3, 24, 2),
(119, 3, 30, 3),
(120, 3, 15, 4),
(121, 3, 0, 5),
(122, 4, 3, 1),
(123, 4, 5, 2),
(124, 4, 8, 3),
(125, 4, 8, 4),
(126, 4, 1, 5),
(127, 5, 1, 1),
(128, 5, 0, 2),
(129, 5, 15, 3),
(130, 5, 20, 4),
(131, 5, 12, 5),
(132, 6, 6, 1),
(133, 6, 8, 2),
(134, 6, 12, 3),
(135, 6, 10, 4),
(136, 6, 5, 5),
(137, 7, 4, 1),
(138, 7, 12, 2),
(139, 7, 14, 3),
(140, 7, 11, 4),
(141, 7, 7, 5),
(142, 8, 0, 1),
(143, 8, 5, 2),
(144, 8, 8, 3),
(145, 8, 6, 4),
(146, 8, 3, 5),
(147, 9, 15, 1),
(148, 9, 10, 2),
(149, 9, 18, 3),
(150, 9, 12, 4),
(151, 9, 8, 5),
(152, 10, 2, 1),
(153, 10, 5, 2),
(154, 10, 10, 3),
(155, 10, 7, 4),
(156, 10, 4, 5),
(157, 11, 0, 1),
(158, 11, 0, 2),
(159, 11, 5, 3),
(160, 11, 8, 4),
(161, 11, 6, 5),
(162, 12, 3, 1),
(163, 12, 6, 2),
(164, 12, 9, 3),
(165, 12, 7, 4),
(166, 12, 4, 5),
(167, 13, 0, 1),
(168, 13, 0, 2),
(169, 13, 0, 3),
(170, 13, 0, 4),
(171, 13, 0, 5),
(172, 14, 0, 1),
(173, 14, 4, 2),
(174, 14, 6, 3),
(175, 14, 5, 4),
(176, 14, 2, 5),
(177, 15, 5, 1),
(178, 15, 8, 2),
(179, 15, 12, 3),
(180, 15, 9, 4),
(181, 15, 6, 5),
(182, 16, 2, 1),
(183, 16, 3, 2),
(184, 16, 8, 3),
(185, 16, 6, 4),
(186, 16, 3, 5),
(187, 17, 10, 1),
(188, 17, 14, 2),
(189, 17, 25, 3),
(190, 17, 20, 4),
(191, 17, 12, 5),
(192, 18, 0, 1),
(193, 18, 7, 2),
(194, 18, 0, 3),
(195, 18, 7, 4),
(196, 18, 5, 5),
(197, 19, 15, 1),
(198, 19, 20, 2),
(199, 19, 30, 3),
(200, 19, 25, 4),
(201, 19, 15, 5),
(202, 20, 3, 1),
(203, 20, 6, 2),
(204, 20, 8, 3),
(205, 20, 7, 4),
(206, 20, 4, 5),
(207, 21, 2, 1),
(208, 21, 0, 2),
(209, 21, 5, 3),
(210, 21, 2, 4),
(211, 21, 2, 5),
(212, 22, 4, 1),
(213, 22, 4, 2),
(214, 22, 6, 3),
(215, 22, 5, 4),
(216, 22, 3, 5),
(217, 23, 10, 1),
(218, 23, 15, 2),
(219, 23, 25, 3),
(220, 23, 20, 4),
(221, 23, 15, 5),
(224, 32, 2, 2),
(225, 35, 2, 1),
(226, 1, 0, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos_pago`
--

CREATE TABLE `metodos_pago` (
  `id` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `detalle` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodos_pago`
--

INSERT INTO `metodos_pago` (`id`, `tipo`, `detalle`) VALUES
(1, 'Nequi', 'Nequi'),
(2, 'Daviplata', 'Daviplata'),
(3, 'Bancolombia', 'Bancolombia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` float NOT NULL,
  `estado` varchar(10) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `imagen_url` varchar(500) DEFAULT NULL,
  `id_genero` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `estado`, `id_categoria`, `imagen_url`, `id_genero`) VALUES
(1, 'Chaqueta Cargo 610', 'Esta chaqueta de mezclilla se destaca por su diseño audaz y contemporáneo. Presenta un patrón de bloques de colores en tonos azul claro, beige y púrpura, combinado con denim oscuro que le da un estilo único y moderno. Los múltiples bolsillos en el pecho y los laterales no solo añaden funcionalidad, sino que también realzan el diseño asimétrico. El cuello en contraste de color púrpura profundo añade un toque extra de sofisticación, haciendo de esta chaqueta una prenda perfecta para quienes buscan destacar con un look vanguardista.', 119900, 'Agotado', 1, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252212/chaqueta_cargo_610_qvelrh.jpg', 1),
(2, 'Chaqueta Polo', 'Eleva tu estilo con esta elegante chaqueta Polo, perfecta para un look sofisticado y versátil. Su diseño minimalista en color beige con cuello de pana marrón añade un toque vintage y atemporal. Confeccionada en materiales de alta calidad, ofrece comodidad y durabilidad, ideal para el día a día o para ocasiones especiales. Cuenta con cierre frontal de cremallera, bolsillos laterales funcionales y puños elásticos para un ajuste perfecto. Combínala con jeans y botas para un outfit casual o con pantalones de vestir para un estilo más refinado.', 105000, 'Disponible', 1, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252229/chaqueta_ovejera_blanca_ixksn9.jpg', 1),
(3, 'Camiseta Choize', 'Camiseta negra de estilo urbano con detalles en blanco, destacando el logotipo central \'CHOIZE\' en el pecho. Los gráficos en los hombros añaden un toque distintivo y moderno. Confeccionada en un corte amplio y cómodo, es perfecta para un look casual pero con actitud. Ideal para combinar con jeans o pantalones deportivos, esta prenda es una elección versátil para el día a día.', 90000, 'Disponible', 2, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252221/camiseta_choize_qkbjzo.jpg', 1),
(4, 'Camisa boxy fit', 'Es una camiseta de estilo urbano con un diseñográfico llamativo centrado en una palabra y una frase. El corte holgado y los colores vibrantes la hacen una prenda ideal para quienes buscan un look casual y moderno.', 100000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252224/camiseta_bbs_njuhns.jpg', 1),
(5, 'Camisa Blanca Overzice A3ORFEND', 'Una camiseta blanca de algodón, de corte holgado, con un gran logo negro \'A3OFEND\' impreso en el centro del pecho. El logo presenta un diseño geométrico abstracto con detalles en gris y rojo, creando un contraste llamativo con el fondo blanco.', 80000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252204/Camisa_H_4_jy4rjm.jpg', 1),
(6, 'Camisa Araña WPADF', 'Esta camiseta negra de corte relajado se caracteriza por su llamativo estampado gráfico en el frente, que presenta una araña sobre una telaraña en tonos grises. El diseño transmite un estilo oscuro y vanguardista, ideal para quienes buscan una prenda con personalidad. Confeccionada en un tejido suave y cómodo, es perfecta para crear un look casual pero con un toque atrevido. Los detalles gráficos, junto con el corte suelto, la hacen ideal para combinar con jeans y zapatillas, completando un outfit urbano y moderno.', 90000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252204/Camisa_H_5_qusw7c.jpg', 1),
(7, 'Camisa Overzice ATSOBER', 'Esta camiseta de corte amplio destaca por su diseño gráfico en tonos grises, que simula llamas ascendentes en la parte inferior. El logo \'ATSOBER\' en el pecho le añade un toque moderno y urbano. Confeccionada en un material suave y transpirable, es ideal para quienes buscan una prenda cómoda pero con un estilo audaz. Perfecta para combinar con jeans o shorts, esta camiseta aporta un look contemporáneo y versátil, ideal para cualquier ocasión casual.', 85000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252204/Camisa_H_6_io8iop.jpg', 1),
(8, 'Camisa Overzice Sencilla', 'Esta camiseta oversize en color negro lavado ofrece un estilo urbano y moderno. Confeccionada con materiales de alta calidad, destaca por su textura suave y un ajuste relajado que brinda comodidad durante todo el día. Su diseño minimalista y su tonalidad desgastada la hacen una prenda versátil, perfecta para combinar con cualquier outfit casual. Ideal para quienes buscan un look contemporáneo sin sacrificar confort.', 90000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252204/Camisa_h_7_huywtp.jpg', 1),
(9, 'Camisa Overzice AW SPIKY HEAD', 'Esta camiseta de estilo deportivo y moderno destaca por su diseño gráfico llamativo. En un elegante color negro con detalles en blanco, presenta mangas con franjas contrastantes que aportan un toque dinámico al look. El logotipo central \'AW Spiky Head\' le da un carácter distintivo y juvenil, ideal para quienes buscan expresar su estilo personal. Confeccionada con materiales cómodos y de alta calidad, esta prenda es perfecta para un look casual y desenfadado, sin dejar de lado el confort.', 110000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252205/camiseta_ae_afy2rf.jpg', 1),
(10, 'Camisa Overzice XOMOCLOTHES', 'Esta camiseta en tonos blancos y grises es la elección perfecta para un estilo futurista y minimalista. Su diseño incorpora paneles en contraste que añaden profundidad y textura a la prenda, mientras que el logotipo central \'Xomoclothes\' con un gráfico moderno le da un toque vanguardista. El ajuste holgado y los materiales transpirables aseguran una comodidad óptima, convirtiéndola en una opción ideal para quienes buscan un look moderno y funcional, perfecto para cualquier ocasión casual.', 98000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252213/camiseta_gris_bbs_iwgvwb.jpg', 1),
(11, 'Camisa BlackStar', 'Esta camiseta negra de estilo urbano destaca por su diseño gráfico único con detalles en blanco y un estampado en el centro que resalta la marca \'BlackStar Skatepark\'. Ideal para los amantes del skate y la moda casual, esta prenda combina confort y estilo, perfecta para llevar en cualquier ocasión. Confeccionada en materiales de alta calidad, garantiza durabilidad y comodidad.', 70000, 'Disponible', 2, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252204/Camisa_H_2_ivbh6x.jpg', 1),
(12, 'Camisa Overizece Eterning', 'Esta camiseta negra de corte relajado presenta un diseño gótico con un estampado gráfico impactante en la parte trasera que resalta la palabra \'Eternig\' en una tipografía estilo medieval. Con una cruz intrincada en el centro, acompañada de detalles en tonos grises, es ideal para quienes buscan un look alternativo y con actitud. Fabricada con materiales de alta calidad, esta prenda no solo ofrece estilo, sino también comodidad para el día a día.', 99000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252204/Camisa_H_3_uyqawy.jpg', 1),
(13, 'Camisa Overzice 97', 'Jersey corto estilo deportivo con el número 97 y detalles gráficos en las mangas, ideal para un look urbano y casual.', 75000, 'Agotado', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252206/Camisa_M_1_z9yvn0.jpg', 2),
(14, 'Camisa Colmillos', 'Destaca con esta camiseta blanca única que presenta un diseño gráfico audaz de colmillos en la parte frontal. El estampado en negro crea un contraste impactante que añade un toque artístico y rebelde a cualquier atuendo. Ideal para quienes buscan un estilo atrevido y fuera de lo común, esta prenda es perfecta para hacer una declaración de moda. Confeccionada en algodón suave, garantiza comodidad durante todo el día.', 100000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252205/Camisa_M_2_imuxs6.jpg', 2),
(15, 'Camisa SideStreet', 'El diseño consiste en una figura humana estilizada en tonos de gris, con la cabeza reemplazada por el texto “SIDESTREET” en letras mayúsculas y un bloque de texto debajo que dice “PARENTAL ADVISORY EXPLICIT CONTENT”. El fondo es blanco y el logo “SIDESTREET EST. 1984” se repite a lo largo de los bordes inferiores de las mangas. Este diseño es relevante por su estilo urbano y contemporáneo, capturando la atención con su audaz tipografía y el uso del conocido sello de advertencia parental, sugiriendo una prenda dirigida a un público joven y consciente de la moda.', 90000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252205/Camisa_M_3_wbdw8e.jpg', 2),
(16, 'Camisa Saint Tears', 'En la parte frontal de la camiseta, se encuentra el número “52” y el texto “Saint Tears”. El diseño incluye paneles blancos con contornos negros en los hombros y los costados, creando un contraste dinámico. La tela parece ser de malla, lo que sugiere que está diseñada para la transpiración durante actividades físicas.', 95000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252205/Camisa_M_4_uuyndy.jpg', 2),
(17, 'Pantalon Anything', 'Los pantalones deportivos de color azul presentan un diseño moderno y relajado. El área del muslo izquierdo muestra el texto “Anything” con estrellas arriba y abajo. Además, se destacan líneas blancas a lo largo de los costados de las piernas, añadiendo un toque de estilo. Estos pantalones son ideales para quienes buscan comodidad sin sacrificar la originalidad.', 100000, 'Disponible', 3, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252219/pantalon_M_1_a0neo9.jpg', 2),
(18, 'Cargo Morado', 'Estos pantalones cargo de corte amplio en color púrpura son una pieza audaz y versátil. Confeccionados en un material resistente y con múltiples bolsillos grandes a lo largo de las piernas, ofrecen tanto funcionalidad como estilo. El diseño de cintura alta y los detalles de costura visible añaden un toque moderno, mientras que los puños elásticos en la parte inferior proporcionan un ajuste cómodo y ajustado. Perfectos para un look urbano y desenfadado.', 100000, 'Disponible', 6, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252227/Pantalon_M_3_neyvpu.jpg', 2),
(19, 'shorts cargo', 'Estos shorts cargo en tonos beige y verde oliva son la elección perfecta para un look casual y funcional. Confeccionados en un material ligero y cómodo, cuentan con una cintura elástica ajustable mediante un cordón, lo que garantiza un ajuste personalizado. Los bolsillos laterales profundos y los bolsillos cargo con detalles de cordones y clips añaden un toque utilitario y moderno al diseño. Ideales para actividades al aire libre o para un estilo relajado y fresco durante el verano.', 60000, 'Disponible', 4, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252221/Pantalon_M_4_iveom3.jpg', 2),
(20, 'jeans Atractivos', 'Estos jeans de corte recto destacan por su diseño artístico y llamativo. Confeccionados en denim de alta calidad, presentan un estampado único de llamas abstractas en tonos morados y azulados que cubren gran parte de las piernas, creando un efecto visual impactante. Los detalles desgastados en el dobladillo y el acabado ligeramente envejecido añaden un toque de estilo urbano y rebelde. Estos jeans son ideales para quienes buscan expresar su personalidad a través de la moda y llevar su look al siguiente nivel con una pieza verdaderamente única.', 90000, 'Disponible', 7, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252235/Pantalon_M_5_a6hi16.jpg', 2),
(21, 'Chaqueta Azul Nike x NOCTA', 'La chaqueta azul Nike x NOCTA fusiona estilo y funcionalidad. Diseñada en colaboración con NOCTA, este modelo ofrece un look contemporáneo con un ajuste cómodo y una estética moderna. Perfecta para cualquier ocasión, su color azul vibrante y detalles distintivos reflejan una elegancia urbana, mientras que su tecnología de tejido garantiza comodidad y resistencia.', 150000, 'Disponible', 1, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252224/prenda_video_w6fxdo.jpg', 1),
(22, 'Black Fleece Jacket 2.0 Trendt Vision', 'La Black Fleece Jacket 2.0 de Trendt Vision redefine el confort y el estilo casual. Confeccionada en un suave forro polar negro, esta chaqueta ofrece una sensación de calidez superior y un diseño minimalista. Ideal para los días fríos, su corte moderno y detalles refinados hacen de esta prenda una opción versátil y elegante para cualquier guardarropa.', 250000, 'Disponible', 1, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252226/chaqueta_negra_carrusel_zzazd6.jpg', 1),
(23, 'TIDAL BLUE Paneled Oversized Jersey', 'El \'TIDAL BLUE\' Paneled Oversized Jersey destaca por su diseño audaz y su ajuste relajado. Con un vibrante colorazul marea, esta prenda presenta paneles contrastantesque aportan un toque moderno y dinámico. Confeccionadoen un tejido suave y de alta calidad, ofrece un confortexcepcional y una caída fluida. Ideal para quienesbuscan una mezcla de estilo contemporáneo y comodidadsin esfuerzo.', 100000, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1746252212/camiseta_carrusel_bsciit.jpg', 1),
(32, 'PRUEBA1CREARPRODUCTO', 'PRUEBA1CREARPRODUCTO', 1, 'Disponible', 5, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1747329828/productos/evbzogilcyktmv8y4m42.jpg', 1),
(35, 'Prueba ropa CAMBIADO', 'Prueba ropa CAMBIADO', 222222000000000, 'Disponible', 2, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1748291410/productos/me27fcdtmmbxm2oa60uz.jpg', 2),
(37, 'Productoprueba', 'Chaqueta linda', 10000, 'Disponible', 1, 'https://res.cloudinary.com/dodecmh9s/image/upload/v1748644977/productos/j1cqyndphfevdnwqsywz.jpg', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reseñas`
--

CREATE TABLE `reseñas` (
  `id` int(11) NOT NULL,
  `comentario` varchar(150) NOT NULL,
  `calificacion` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reseñas`
--

INSERT INTO `reseñas` (`id`, `comentario`, `calificacion`, `id_producto`, `id_usuario`) VALUES
(1, 'Esta bonita la chqueta', 5, 1, 2),
(2, 'sip', 5, 17, 2),
(3, 'ss', 3, 1, 2),
(4, 'esta lindala polo', 5, 2, 2),
(5, 'Choize? wow esta increible!', 5, 3, 2),
(6, 'Esta linda good!!!', 4, 4, 2),
(7, 'Boof! DURAAAAAAAAAAAAAAA', 3, 5, 2),
(8, 'ME ENCANTOOOOOOOO!!!!!!! BOOOFFFFF', 4, 6, 2),
(9, 'Linda linda', 3, 7, 2),
(10, 'q bonitaaaaaaaaaaaaaa', 5, 8, 2),
(11, 'Very very good you produc', 4, 9, 2),
(12, 'bien bien', 5, 10, 2),
(13, 'me gusta el estilo ', 5, 11, 2),
(14, 'akajja hermosa', 4, 12, 2),
(16, 'Ushh lol hermosa', 4, 13, 4),
(17, 'Bonita bonita', 2, 14, 4),
(18, 'GOOD', 4, 15, 4),
(19, 'me encanto|!', 5, 16, 4),
(20, 'deberia ser ilegal tener algo tan lindo sabes?', 3, 17, 4),
(21, 'Estan de locura ese cargo!', 5, 18, 4),
(22, 'WOW QUE COOLL!!!!', 4, 19, 4),
(23, 'TU ERES BOOF ALGO RADIENTEEEEEEEEEEE', 1, 20, 4),
(24, 'good', 3, 21, 4),
(25, 'ajaj boof', 5, 22, 4),
(27, 'ñlol', 5, 22, 4),
(28, 'lol', 4, 23, 4),
(30, 'asddsa', 3, 22, 4),
(31, 'asddas', 3, 22, 4),
(32, 'asddas', 4, 3, 4),
(33, 'asddsa', 3, 3, 4),
(34, 'lwow esta expectacular', 5, 3, 1),
(36, 'prueb', 2, 1, 2),
(38, 'Esta genial!', 4, 3, 2),
(39, 'wow', 5, 3, 2),
(40, 'Hermosa', 4, 3, 2),
(41, 'Esta genial!', 4, 3, 2),
(43, 'hermosisima', 5, 3, 2),
(44, 'Esta genial!', 4, 3, 1),
(45, 'wow', 5, 3, 1),
(46, 'Hermosa', 4, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'Administrador'),
(2, 'Usuario'),
(3, 'x');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tallas`
--

CREATE TABLE `tallas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tallas`
--

INSERT INTO `tallas` (`id`, `nombre`) VALUES
(1, 'XS '),
(2, 'S'),
(3, 'M'),
(4, 'L'),
(5, 'XL'),
(7, 'prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `num_cel` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `reset_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `num_cel`, `direccion`, `contrasena_hash`, `id_rol`, `estado`, `reset_token`) VALUES
(1, 'Super Admin', 'superadmin@example.com', '3170000000', 'Calle Ficticia 123', 'scrypt:32768:8:1$jVYYZr3rT8JYjhiw$9fb6339baa4b464932844fac90368a4800e5feb01948c5c76f9dd985f5a15eec662248182028ca2bf4cf73b0c59bff6a18f023003c0bd9ae27944fead83446d0', 1, 'Activo', NULL),
(2, 'DilandakRg', 'dilandakrg@gmail.com', '3177828999', 'calle 109 sur # 245', 'scrypt:32768:8:1$MLT4e1EYtZq5xrhP$94600b363d4e248fb5d6bd19adac7f83a7614a9bf8ea59b343e5b1b8f4d280a285f702706a6da1025e8a51569924328003347d7ef6984f79f1992cb940163506', 2, 'Activo', NULL),
(3, 'yurley', 'kathedak@gmail.com', '323232323', 'adsdasdas', 'scrypt:32768:8:1$OFuc1ZSOawpKRqMk$966fea7c781bc631148561fcad1b9093809418bb7ee355f1b938cd6787af158d6a3f764ba26b19b7ec72b8ec24ff581233d209c985da88cc051a26dd90cd6af8', 2, 'Activo', NULL),
(4, 'Anderson', 'ande27e@gmail.com', '31998574', 'Calle sucre 27 sur', 'scrypt:32768:8:1$iC4Y0pxtSomcCRMV$f7d40081c6e2dc707f9a31a5189357e664f542580c0fb65f03f8c5d436b79ee2cf7ca77a2ebaf10edff0fa7e8bf3a178dd6180ebbb3900e16d408e73dc484619', 1, 'Activo', 'i8B8Z2Dcc4O9C2nsS1tTx9UIH2b6KKmrU1UmRJKynJU'),
(5, 'Prueba', 'zpatriciaog@gmail.com', '317782999', 'Calle 1111', 'scrypt:32768:8:1$iaOo25ZDzqAep9Nl$963ec3d01dfde438491044b1f31f2e6037603c3b661ac5c186b03f6d926d610be77bd2ce0cfdbb96dfe9d4bb3ba5268db6cd71cfdc292c26436c58fcf28491d1', 2, 'Activo', NULL),
(6, 'DilanDak', 'dariao38@soy.sena.edu.co', '3177289982', 'Calle 11', 'scrypt:32768:8:1$l9oQiDpPcmO7dd92$1849e1cfcee608abde9409c4debc072746b0299414485d32cd6a4397595d4bd866aaa55f18a977e87bc597819b4c1bc333ba71d92a59ee5981db1279560ebd3c', 2, 'Activo', NULL),
(10, 'pruebas', 'prueba1@gmail.com', '1231321231', 'asdad', 'scrypt:32768:8:1$42aCdQIjPNKr7T7r$b7b5875cf74e32f03453c09e1d3bbf93c75c2bf7a0f315bc70778a7f24da3b1db3f576696df3fc34738a5ecd98b4f541698a987f4565606e6164c3111a594d07', 2, 'Activo', NULL),
(11, 'Leila', 'leilacristalcl45@gmail.com', '3224667890', 'Calle 123', 'scrypt:32768:8:1$SV4TxuTULGviUibE$24726efa06cf392274747a229bbf581c48edce34e9b790d4d2770d0f8ccb55e6f9fb3ca587d0ed3ce805c1e4052702876c709de3c114ffff7f9f2e38f8c75cd9', 2, 'Activo', NULL),
(14, 'Dilanprueba', 'dilanprueba@gmail.com', '3178291331', 'Calle 114bsur#2a78', 'scrypt:32768:8:1$SZlXSZsihh7T9T1s$ebb1a83b744b22fa8393c1a7fdde1a03099af6ab21aabf0201a7c3cbf526fb65e218481757a2b4c588409842beff0f5a7effa1672ad02aab1ab6f200ae72263b', 2, 'Activo', NULL),
(15, 'dilanpruebados', 'dilanprueba2@gmail.com', '318830991', 'Calle 20 sur', 'scrypt:32768:8:1$QdBc1fozWqErgdjz$f165039727bf893fcb34cdc180c92e4755e216f5d974ab18015d8003d6bc4d25c0b8b153c57e7f83e63e46881a1d38db5cff0c1ff92e7c66033619cd9c7bf1ac', 2, 'Activo', NULL),
(16, 'prueba', 'holaaaaaaa@gmai.com', '333333', 'adsdas', 'scrypt:32768:8:1$vP5REB8nrkt6Gndg$6641278a3fdde94d929411786ede113e179b16ad2f29548eba8645e2cff26cc89483ef4e04ad7dac2190fb6c527d7077342122577e49b541d0a64acfea85077c', 2, 'Activo', NULL),
(17, 'asdd', 'dilandassssskrg@gmail.com', '4444444444', 'adsasdads', 'scrypt:32768:8:1$inGhJwpZ6F7yUeIw$0b3557e79b6a42a487eba621e947788dcec7748128162a2d6d4bdbe321c8c08a162ea66a79f023bda4295e607801f463e328ccd4eac6027956834572b5770557', 2, 'Activo', NULL),
(18, 'dsdaadsadsads', 'adsadsads@gmail.com', '1111111111', 'adsjkadskadsk2', 'scrypt:32768:8:1$7PtEKz0rYwPhOypM$6182fed9c3657c9434519229dc8ac1ebabdbb9bfb6229bb411199f8f3436765e0d40cb91119fb21f65a46ca8edfe560feb93d603af5f1b8b8c2ecda7d8ec3ca2', 2, 'Activo', NULL),
(19, 'daadsdas', 'adsda@gmail.com', '1111111111', 'asdads', 'scrypt:32768:8:1$CsPCYSyyVuCp3NML$db5a1a786064bc5ea281721ccd893c3817c890a13bc1cf7dc3ccd61e17ba51a42fb804db217a591ae3e8b78cebc4f8ac1746d880154c31863db8682b0e5899c4', 2, 'Activo', NULL),
(20, 'daadsdas', 'adsdsssssa@gmail.com', '3333333333', 'asdads', 'scrypt:32768:8:1$yjWvUC0gZwGZIm0e$ade0158be4b38602157bedd0f986acfc27b3708425879f1b2633fc68af56719d2b614df01463058761115f51ebe8565e615b4083c191f962b1651f0345311bab', 2, 'Activo', NULL),
(21, 'daadsdas', 'pruebaa@gmail.com', '3333333333', 'asdads', 'scrypt:32768:8:1$oyovfB8zqY7r84aj$c475d4061094fbc400a6c3ecffc8670ee00b89d754e1ae13b1cb2474c77b2e56ea30f76570a8c171e060a516a8bb8f717cc81bf6b23893352100530b7b81ad0d', 2, 'Activo', NULL),
(22, 'daadsdas', 'pruebaa222222@gmail.com', '4444444444', 'asdads', 'scrypt:32768:8:1$12d7OR89lIs7gWNb$b4039bc3f7598bb0b889433cc561239ecadb9dc32c22ce60e3af53953d2020c4ea23157dce80907203f695c4c22cfb1681018a98fbb674f74cbd1d6e3baf5619', 2, 'Activo', NULL),
(23, 'daadsdas', 'pruebj2@gmail.com', '7777777777', 'asdadsyuu', 'scrypt:32768:8:1$6t8tv2e6akMtyRws$42402b8f8461c8c10fe0c3ed0f6c2af6afb8c0bf941562bce054a507d159f032626b7435983f3c19ae37ff845df7919e07a3031324757cd8079c5476efeadf2d', 2, 'Activo', NULL),
(24, 'pruebaaa', 'pruebass2a@gmail.com', '3155678833', 'Calle 2020%', 'scrypt:32768:8:1$WQczfuC5UVmaAS3b$63535388c8fe208d6fa64100aee879c45d0f93c6c1c1a7ec73f31579057398b745cdcc1013b60572ac2323ef9f36dc240c5879af40e43465f6866d3a51e97e58', 2, 'Activo', NULL),
(25, 'pruebaaa', 'pruebassa@gmail.com', '3155678833', 'Calle 2020%', 'scrypt:32768:8:1$Ix6cf2AwJVXCMyUc$575bf9f14d9078d083b281aefe8e9ecd9ec67ae6615d30e7dd73096f7608b7e5c0c0beed67b8b2a7d5907749036ad3cc639029c86d6566a8149443d0e440bc98', 2, 'Activo', NULL),
(26, 'pruebaaa', 'pruebas222255@gmail.com', '3155678833', 'Calle 2020%', 'scrypt:32768:8:1$FSeAtADVRob55Znk$652e2a927fb94320c975ea8513bf15fa6ace10582695647417d37f9be223617ec323f3920f812c985e21dfbaca2aadb7feb9559e72b749fa4f2ded5e2384641f', 2, 'Activo', NULL),
(27, 'asdadsdas', 'asdads@gmail.com', '1231323123', 'qwwqeqweeqw', 'scrypt:32768:8:1$h1PRmRx2GJ6Rvlcw$c46395ba96d785ab6e23b18d3f7e3a2a84c1e54f13e263429df20022603f00a95152f1d090abca83f3e61d846d2470555bdd05f430bde23140a246a1fa4a3f16', 2, 'Activo', NULL),
(28, 'asdadsads', 'adsads@gmail.com', '2222222222', 'adsadsads', 'scrypt:32768:8:1$XGQ2ObLdncZBvKxo$b651ae90213a159e37ce6b2eded1a926bd0c9c6301ae8dd97b2d7a47fdaba4851450274533f2d137785037084d60a80062052d08fad5f9fd033df639ec301c85', 2, 'Activo', NULL),
(29, 'pruebaaa', 'pruebaslenium@gmail.com', '3122311211', 'Calle 30 ', 'scrypt:32768:8:1$yWfuzBtBsejpF4ld$f51fd040eebf7d73ef6c2d2f5e5401fc9799080c3d66847753d0a4dfc8ce0970dc1808e1bb972855967ddee798609d641c42c18a4d5bd4be53c7769d847baf1b', 2, 'Activo', NULL),
(30, 'registroprueba', 'registroprueba@gmail.com', '3122344458', 'Calleprueba1', 'scrypt:32768:8:1$Bz6hOGoawAhExDip$1fb0689e800ae0da3b7530f48a02f845e98dc20117c197b2d661ad74bff9ca9db58f52b913f8eb8ea3eabe66e7cc2bc474f0eb9cb124705cf02048c1116aee88', 2, 'Activo', NULL),
(31, 'jose', 'jose@gmail.com', '3214567898', 'Calle123', 'scrypt:32768:8:1$54Df5TWURHL8Qr7A$658f8f687c828a880602be78d4b70e94a8f84dd33b80a40cbf91c43d62c8801cf3b91e15272378ab46a2faed36f80f4539146cf450065975c65a3f41a69c209b', 2, 'Activo', NULL),
(32, 'joseantonio', 'joseantonio@gmail.com', '3214567899', 'Calle23', 'scrypt:32768:8:1$jBTwHV7qjlsARFTx$630d6c3cb6e8e95d5161fa887ee2547d0a191aa0f1d27659ca607fec5fab8d8870674118a61b0407d1cf7fd46d3903636f904654dfc37ab771ff66c5e9ce5de7', 2, 'Activo', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indices de la tabla `carritos`
--
ALTER TABLE `carritos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `carrito_productos`
--
ALTER TABLE `carrito_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_carrito` (`id_carrito`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_talla` (`id_talla`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `metodo_pago_id` (`metodo_pago_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `compra_producto`
--
ALTER TABLE `compra_producto`
  ADD PRIMARY KEY (`compra_id`,`producto_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `historial_stock`
--
ALTER TABLE `historial_stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_inventario` (`id_inventario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_talla` (`id_talla`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_talla` (`id_talla`);

--
-- Indices de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_genero` (`id_genero`);

--
-- Indices de la tabla `reseñas`
--
ALTER TABLE `reseñas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `tallas`
--
ALTER TABLE `tallas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carritos`
--
ALTER TABLE `carritos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `carrito_productos`
--
ALTER TABLE `carrito_productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `genero`
--
ALTER TABLE `genero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `historial_stock`
--
ALTER TABLE `historial_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=229;

--
-- AUTO_INCREMENT de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `reseñas`
--
ALTER TABLE `reseñas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tallas`
--
ALTER TABLE `tallas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carritos`
--
ALTER TABLE `carritos`
  ADD CONSTRAINT `carritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `carrito_productos`
--
ALTER TABLE `carrito_productos`
  ADD CONSTRAINT `carrito_productos_ibfk_1` FOREIGN KEY (`id_carrito`) REFERENCES `carritos` (`id`),
  ADD CONSTRAINT `carrito_productos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `carrito_productos_ibfk_3` FOREIGN KEY (`id_talla`) REFERENCES `tallas` (`id`);

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`metodo_pago_id`) REFERENCES `metodos_pago` (`id`),
  ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `compra_producto`
--
ALTER TABLE `compra_producto`
  ADD CONSTRAINT `compra_producto_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `compra_producto_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `historial_stock`
--
ALTER TABLE `historial_stock`
  ADD CONSTRAINT `historial_stock_ibfk_1` FOREIGN KEY (`id_inventario`) REFERENCES `inventario` (`id`),
  ADD CONSTRAINT `historial_stock_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `historial_stock_ibfk_3` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `historial_stock_ibfk_4` FOREIGN KEY (`id_talla`) REFERENCES `tallas` (`id`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`id_talla`) REFERENCES `tallas` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_genero`) REFERENCES `genero` (`id`);

--
-- Filtros para la tabla `reseñas`
--
ALTER TABLE `reseñas`
  ADD CONSTRAINT `reseñas_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `reseñas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
