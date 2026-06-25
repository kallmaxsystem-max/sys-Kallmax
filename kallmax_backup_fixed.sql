-- CREATE DATABASE  IF NOT EXISTS `KallMax_BD` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
-- USE `KallMax_BD`;
-- Importar directamente en la base de datos seleccionada en phpMyAdmin (kallgwkn_kallmax_bd)
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 209.74.89.191    Database: KallMax_BD
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `TblAreas`
--

DROP TABLE IF EXISTS `TblAreas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblAreas` (
  `id_area` int NOT NULL AUTO_INCREMENT COMMENT 'ID único del área',
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del área (Ventas, Marketing, etc.)',
  `nombre_resumen` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Descripción del área',
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo' COMMENT 'Estado del área',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Última actualización',
  PRIMARY KEY (`id_area`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `idx_nombre` (`nombre`),
  KEY `idx_estado` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de áreas organizacionales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblAreas`
--

LOCK TABLES `TblAreas` WRITE;
/*!40000 ALTER TABLE `TblAreas` DISABLE KEYS */;
INSERT INTO `TblAreas` VALUES (1,'Dirección General','Dirección','Área encargada de la dirección estratégica y toma de decisiones','Activo','2026-06-19 16:05:29','2026-06-19 16:26:14'),(2,'Ventas Inmobiliarias','Ventas','Área encargada de la comercialización y venta de propiedades','Activo','2026-06-19 16:05:29','2026-06-19 16:26:14'),(3,'Marketing y Publicidad','Marketing','Área encargada de promoción y estrategias de marketing','Activo','2026-06-19 16:05:29','2026-06-19 16:26:15'),(4,'Administración','Administración','Área encargada de la gestión administrativa general','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(5,'Finanzas y Contabilidad','Finanzas','Área encargada de la gestión financiera y contable','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(6,'Recursos Humanos','RRHH','Área encargada de la gestión del talento humano','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(7,'Área Legal','Legal','Área encargada de asuntos legales y contratos','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(8,'Gestión de Propiedades','Propiedades','Área encargada de administración de inmuebles','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(9,'Alquileres y Arrendamientos','Alquileres','Área encargada de gestión de alquileres','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(10,'Servicio al Cliente','Atención','Área encargada de atención y soporte al cliente','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(11,'Tecnología y Sistemas','TI','Área encargada de infraestructura tecnológica','Activo','2026-06-19 16:05:30','2026-06-19 16:26:15'),(12,'Desarrollo Inmobiliario','Desarrollo','Área encargada de proyectos de construcción','Activo','2026-06-19 16:05:31','2026-06-19 16:26:16'),(13,'Compras y Proveedores','Compras','Área encargada de adquisiciones y proveedores','Activo','2026-06-19 16:05:31','2026-06-19 16:26:16'),(14,'Operaciones','Operaciones','Área encargada de operaciones y logística','Activo','2026-06-19 16:05:31','2026-06-19 16:26:16');
/*!40000 ALTER TABLE `TblAreas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblCargos`
--

DROP TABLE IF EXISTS `TblCargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblCargos` (
  `id_cargo` int NOT NULL AUTO_INCREMENT COMMENT 'ID único del cargo',
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del cargo (Asesor, Supervisor, etc.)',
  `id_area` int NOT NULL COMMENT 'ID del área a la que pertenece',
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Descripción del cargo',
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo' COMMENT 'Estado del cargo',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Última actualización',
  PRIMARY KEY (`id_cargo`),
  KEY `idx_nombre` (`nombre`),
  KEY `idx_area` (`id_area`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `TblCargos_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `TblAreas` (`id_area`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de cargos por área';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblCargos`
--

LOCK TABLES `TblCargos` WRITE;
/*!40000 ALTER TABLE `TblCargos` DISABLE KEYS */;
INSERT INTO `TblCargos` VALUES (1,'Director General',1,'Máxima autoridad ejecutiva de la empresa','Activo','2026-06-19 16:05:31','2026-06-19 16:05:31'),(2,'Gerente General',1,'Responsable de la gestión general de la empresa','Activo','2026-06-19 16:05:31','2026-06-19 16:05:31'),(3,'Asistente de Gerencia',1,'Apoyo directo a la gerencia general','Activo','2026-06-19 16:05:31','2026-06-19 16:05:31'),(4,'Gerente Comercial',2,'Responsable de estrategia comercial','Activo','2026-06-19 16:05:31','2026-06-19 16:05:31'),(5,'Jefe de Ventas',2,'Supervisor del equipo de ventas','Activo','2026-06-19 16:05:31','2026-06-19 16:05:31'),(6,'Supervisor de Ventas',2,'Coordinador de asesores de ventas','Activo','2026-06-19 16:05:31','2026-06-19 16:05:31'),(7,'Asesor Inmobiliario',2,'Asesor de venta de propiedades','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(8,'Ejecutivo de Ventas',2,'Ejecutivo especializado en ventas','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(9,'Captador de Propiedades',2,'Encargado de captación de inmuebles','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(10,'Gerente de Marketing',3,'Responsable de estrategia de marketing','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(11,'Coordinador de Marketing',3,'Coordinador de campañas de marketing','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(12,'Community Manager',3,'Gestor de redes sociales','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(13,'Diseñador Gráfico',3,'Diseñador de material publicitario','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(14,'Especialista en Publicidad Digital',3,'Especialista en publicidad online','Activo','2026-06-19 16:05:32','2026-06-19 16:05:32'),(15,'Fotógrafo Inmobiliario',3,'Fotógrafo de propiedades','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(16,'Gerente Administrativo',4,'Responsable de gestión administrativa','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(17,'Administrador',4,'Encargado de administración general','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(18,'Asistente Administrativo',4,'Apoyo en tareas administrativas','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(19,'Recepcionista',4,'Atención en recepción','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(20,'Archivista',4,'Gestión de archivo documental','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(21,'Gerente Financiero',5,'Responsable de gestión financiera','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(22,'Contador General',5,'Contador principal de la empresa','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(23,'Analista Financiero',5,'Analista de estados financieros','Activo','2026-06-19 16:05:33','2026-06-19 16:05:33'),(24,'Auxiliar Contable',5,'Apoyo en contabilidad','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(25,'Tesorero',5,'Encargado de tesorería','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(26,'Encargado de Cobranza',5,'Gestión de cobranzas','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(27,'Gerente de Recursos Humanos',6,'Responsable de gestión de RRHH','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(28,'Analista de Recursos Humanos',6,'Analista de procesos de RRHH','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(29,'Reclutador',6,'Encargado de reclutamiento','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(30,'Coordinador de Capacitación',6,'Coordinador de formación','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(31,'Auxiliar de Nómina',6,'Apoyo en gestión de nómina','Activo','2026-06-19 16:05:34','2026-06-19 16:05:34'),(32,'Gerente Legal',7,'Responsable del área legal','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(33,'Abogado Inmobiliario',7,'Abogado especializado en inmuebles','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(34,'Asistente Legal',7,'Apoyo en tareas legales','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(35,'Gestor de Trámites',7,'Encargado de trámites legales','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(36,'Especialista en Contratos',7,'Especialista en contratos','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(37,'Gerente de Propiedades',8,'Responsable de gestión de propiedades','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(38,'Administrador de Inmuebles',8,'Administrador de inmuebles','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(39,'Coordinador de Mantenimiento',8,'Coordinador de mantenimiento','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(40,'Inspector de Propiedades',8,'Inspector de inmuebles','Activo','2026-06-19 16:05:35','2026-06-19 16:05:35'),(41,'Ejecutivo de Atención al Cliente',8,'Atención a clientes de propiedades','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(42,'Jefe de Arrendamientos',9,'Responsable de arrendamientos','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(43,'Ejecutivo de Alquileres',9,'Ejecutivo de alquileres','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(44,'Coordinador de Contratos',9,'Coordinador de contratos de alquiler','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(45,'Gestor de Cobranza de Rentas',9,'Gestor de cobranza de alquileres','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(46,'Jefe de Atención al Cliente',10,'Responsable de atención al cliente','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(47,'Ejecutivo de Servicio al Cliente',10,'Ejecutivo de servicio al cliente','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(48,'Asistente de Postventa',10,'Asistente de postventa','Activo','2026-06-19 16:05:36','2026-06-19 16:05:36'),(49,'Gestor de Reclamos',10,'Gestor de reclamos','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(50,'Gerente de TI',11,'Responsable de tecnología','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(51,'Administrador de Sistemas',11,'Administrador de sistemas','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(52,'Soporte Técnico',11,'Soporte técnico','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(53,'Desarrollador Web',11,'Desarrollador web','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(54,'Analista de Datos',11,'Analista de datos','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(55,'Director de Proyectos',12,'Director de proyectos inmobiliarios','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(56,'Gerente de Desarrollo',12,'Gerente de desarrollo','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(57,'Arquitecto',12,'Arquitecto','Activo','2026-06-19 16:05:37','2026-06-19 16:05:37'),(58,'Ingeniero Civil',12,'Ingeniero civil','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(59,'Supervisor de Obras',12,'Supervisor de obras','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(60,'Coordinador de Proyectos',12,'Coordinador de proyectos','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(61,'Jefe de Compras',13,'Responsable de compras','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(62,'Analista de Compras',13,'Analista de compras','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(63,'Coordinador de Proveedores',13,'Coordinador de proveedores','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(64,'Gerente de Operaciones',14,'Responsable de operaciones','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(65,'Coordinador Operativo',14,'Coordinador operativo','Activo','2026-06-19 16:05:38','2026-06-19 16:05:38'),(66,'Supervisor Operativo',14,'Supervisor operativo','Activo','2026-06-19 16:05:39','2026-06-19 16:05:39');
/*!40000 ALTER TABLE `TblCargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblClientes`
--

DROP TABLE IF EXISTS `TblClientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblClientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `num_documento` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_documento_asesor` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Documento del asesor que atiende al cliente',
  `id_fuente_contacto` int DEFAULT NULL,
  `id_proyecto` int DEFAULT NULL,
  `id_estado_prospeccion` int DEFAULT NULL,
  `id_tipo_compra` int DEFAULT NULL,
  `estado` enum('Activo','En revisión','Pendiente','Inactivo','Convertido') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `fecha_proximo_seguimiento` datetime DEFAULT NULL COMMENT 'Fecha y hora del próximo seguimiento',
  `prioridad` enum('Baja','Media','Alta','Urgente') COLLATE utf8mb4_unicode_ci DEFAULT 'Media',
  `fecha_conversion` date DEFAULT NULL COMMENT 'Fecha en que el cliente se convirtió en venta/alquiler',
  `monto_conversion` decimal(12,2) DEFAULT NULL COMMENT 'Monto de la conversión si aplica',
  `observaciones` text COLLATE utf8mb4_unicode_ci COMMENT 'Notas y observaciones sobre el cliente',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creado_por` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Documento del usuario que creó el registro',
  `actualizado_por` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Documento del usuario que actualizó el registro',
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `num_documento` (`num_documento`),
  KEY `idx_num_documento` (`num_documento`),
  KEY `idx_asesor` (`num_documento_asesor`),
  KEY `idx_estado` (`estado`),
  KEY `idx_fecha_seguimiento` (`fecha_proximo_seguimiento`),
  KEY `fk_clientes_fuente_contacto` (`id_fuente_contacto`),
  KEY `fk_clientes_proyecto` (`id_proyecto`),
  KEY `fk_clientes_estado_prospeccion` (`id_estado_prospeccion`),
  KEY `fk_clientes_tipo_compra` (`id_tipo_compra`),
  CONSTRAINT `fk_clientes_estado_prospeccion` FOREIGN KEY (`id_estado_prospeccion`) REFERENCES `TblEstadoProspeccion` (`id_estado_prospeccion`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_clientes_fuente_contacto` FOREIGN KEY (`id_fuente_contacto`) REFERENCES `TblFuenteContacto` (`id_fuente_contacto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_clientes_proyecto` FOREIGN KEY (`id_proyecto`) REFERENCES `TblProyectos` (`id_proyecto`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_clientes_tipo_compra` FOREIGN KEY (`id_tipo_compra`) REFERENCES `TblTipoCompra` (`id_tipo_compra`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `TblClientes_ibfk_1` FOREIGN KEY (`num_documento_asesor`) REFERENCES `TblPersona` (`num_documento`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de clientes del sistema inmobiliario';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblClientes`
--

LOCK TABLES `TblClientes` WRITE;
/*!40000 ALTER TABLE `TblClientes` DISABLE KEYS */;
INSERT INTO `TblClientes` VALUES (1,'10000001','72542994',1,1,2,1,'Activo','2026-07-01 10:00:00','Alta',NULL,NULL,'Cliente de prueba con TODAS las llaves foráneas','2026-06-22 22:01:01','2026-06-22 22:01:01','72542994',NULL),(2,'10000002','72542994',5,NULL,1,NULL,'En revisión',NULL,'Media',NULL,NULL,'Cliente de prueba con ALGUNAS FK en NULL','2026-06-22 22:01:10','2026-06-22 22:01:10','72542994',NULL),(3,'10000003','72542994',NULL,NULL,NULL,NULL,'Pendiente',NULL,'Baja',NULL,NULL,NULL,'2026-06-22 22:01:14','2026-06-22 22:01:14','72542994',NULL);
/*!40000 ALTER TABLE `TblClientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblDepartamentos`
--

DROP TABLE IF EXISTS `TblDepartamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblDepartamentos` (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `uk_departamento_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblDepartamentos`
--

LOCK TABLES `TblDepartamentos` WRITE;
/*!40000 ALTER TABLE `TblDepartamentos` DISABLE KEYS */;
INSERT INTO `TblDepartamentos` VALUES (74,'AMAZONAS'),(75,'ANCASH'),(76,'APURÍMAC'),(77,'AREQUIPA'),(78,'AYACUCHO'),(79,'CAJAMARCA'),(97,'CALLAO'),(80,'CUSCO'),(81,'HUANCAVELICA'),(82,'HUÁNUCO'),(83,'ICA'),(84,'JUNÍN'),(85,'LA LIBERTAD'),(86,'LAMBAYEQUE'),(87,'LIMA'),(88,'LORETO'),(89,'MADRE DE DIOS'),(90,'MOQUEGUA'),(91,'PASCO'),(92,'PIURA'),(93,'PUNO'),(94,'TACNA'),(95,'TUMBES'),(96,'UCAYALI');
/*!40000 ALTER TABLE `TblDepartamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblDistritos`
--

DROP TABLE IF EXISTS `TblDistritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblDistritos` (
  `id_distrito` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_provincia` int NOT NULL,
  PRIMARY KEY (`id_distrito`),
  UNIQUE KEY `uk_distrito_provincia` (`nombre`,`id_provincia`),
  KEY `fk_distrito_provincia` (`id_provincia`),
  CONSTRAINT `fk_distrito_provincia` FOREIGN KEY (`id_provincia`) REFERENCES `TblProvincias` (`id_provincia`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3630 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblDistritos`
--

LOCK TABLES `TblDistritos` WRITE;
/*!40000 ALTER TABLE `TblDistritos` DISABLE KEYS */;
INSERT INTO `TblDistritos` VALUES (3538,' KOLLAO',516),(2828,'ABANCAY',404),(2929,'ABANCAY',423),(2848,'ACACHUASI',408),(2870,'ACARÍ',411),(2876,'ACARI',412),(3177,'ACAYA',470),(3141,'ACAYMARCA',467),(3018,'ACCHA',442),(2805,'ACÉ',399),(3547,'ACHAYA',517),(3040,'ACOBAMBA',447),(3036,'ACOBAMBILLA',446),(3176,'ACOBAMBILLA',470),(2849,'ACOCRO',408),(2917,'ACOCRO',420),(2843,'ACOMAYO',407),(2983,'ACOMAYO',434),(3061,'ACOMAYO',452),(2798,'ACOPALCA',398),(3531,'ACORA',516),(3037,'ACORIA',446),(3329,'ACOS',491),(3056,'ACOSTAMBO',451),(2898,'ACOSVINCHOS',416),(3224,'AGALLPAMPA',478),(3305,'AGUANTÍA',489),(3620,'AGUAYTÍA',539),(3057,'AHUAC',451),(3151,'AHUAC',468),(3322,'AHUAHUASI',490),(2784,'AIJA',395),(2793,'AIJÍN',397),(2892,'ALCA',415),(3621,'ALEXANDER VON HUMBOLDT',539),(3399,'ALIS',494),(3400,'ALLAUCA',494),(3445,'ALLPAHUAYO',495),(3589,'ALTO DE LA ALIANZA',530),(3106,'ALTO LARAN',462),(2858,'ALTO SELVA ALEGRE',410),(3532,'AMANTANI',516),(3062,'AMARILIS',452),(2799,'AMASHCA',398),(3066,'AMBO',453),(3518,'AMOTAPE',513),(2988,'ANCAHUASI',435),(3266,'ANCÓN',487),(3041,'ANDABAMBA',447),(2834,'ANDAHUAYLAS',405),(3026,'ANDAHUAYLILLAS',444),(3152,'ANDAMARCA',468),(2835,'ANDARAPA',405),(3044,'ANGARAES',448),(2794,'ANGUIA',397),(2951,'ANGUIA',427),(2810,'ANRA',400),(2987,'ANTA',435),(2839,'ANTABAMBA',406),(3574,'ANTAUTA',524),(3341,'ANTIOQUÍA',492),(2882,'APLAO',413),(3058,'APLAO',451),(2921,'APONGO',421),(2933,'APONGO',424),(3049,'AQUIMAYO',449),(3342,'ARAHUAY',492),(3381,'ARAHUAY',493),(2762,'ARAMANGO',389),(3548,'ARAYA',517),(2857,'AREQUIPA',410),(2908,'ASCENSIÓN',418),(3210,'ASCOPE',474),(3306,'ASIA',489),(3178,'ASILLO',470),(3496,'ASILLO',508),(2811,'ASQUIPAMPA',400),(3053,'ASQUIPAMPA',450),(2754,'ASUNCIÓN',388),(2769,'ASUNCIÓN',390),(2775,'ASUNCIÓN',392),(2778,'ASUNCIÓN',393),(2788,'ASUNCIÓN',396),(2938,'ASUNCIÓN',425),(3196,'ASUNCIÓN',472),(3470,'ATALAYA',501),(3618,'ATALAYA',538),(3330,'ATAVILLOS ALTO',491),(3331,'ATAVILLOS BAJO',491),(3267,'ATE',487),(2871,'ATICO',411),(2877,'ATICO',412),(3533,'ATUNCOLLA',516),(3382,'AUCAMPI',493),(3506,'AYABACA',510),(2900,'AYACUCHO',416),(2912,'AYACUCHO',419),(3552,'AYAPATA',518),(2850,'AYAVÍ',408),(3401,'AYAVIRI',494),(3573,'AYAVIRI',524),(2899,'AYNA',416),(3063,'AYNA',452),(3067,'AYNA',453),(3179,'AYNA',470),(2883,'AYO',413),(3402,'AYUCAYA',494),(3403,'AZÁNGARO',494),(3546,'AZÁNGARO',517),(2763,'BAGUA',389),(2764,'BAGUA GRANDE',389),(2939,'BAMBAMARCA',425),(2945,'BAMBAMARCA',426),(2952,'BAMBAMARCA',427),(3214,'BAMBAMARCA',475),(3083,'BAÑOS',457),(3300,'BARRANCA',488),(3268,'BARRANCO',487),(2878,'BELLA UNIÓN',412),(3522,'BELLAVISTA',514),(3624,'BELLAVISTA',541),(3343,'BERGARA',492),(3469,'BOCA MANU',501),(3213,'BOLÍVAR',475),(2795,'BOLOGNESI',397),(2974,'BOLOGNESI',432),(3269,'BREÑA ALTA',487),(3270,'BREÑA BAJA',487),(2826,'BUENAVISTA',403),(3332,'BUJAMA',491),(3232,'BULDIBUYO',480),(3455,'CABALLOCOCHA',497),(3584,'CABANA',528),(3570,'CABANILLAS',523),(3585,'CABANILLAS',528),(3153,'CACHICANCHA',468),(2990,'CACHIMAYO',435),(3112,'CAHUACHI',463),(3022,'CAICAY',443),(3595,'CAIRANI',531),(2940,'CAJA',425),(2941,'CAJABAMBA',425),(2937,'CAJAMARCA',425),(3590,'CALANA',530),(3307,'CALANGO',489),(2991,'CALCA',436),(3604,'CALETA DE CAMPOS',534),(3323,'CALETA DE CARQUIN',490),(3344,'CALLAHUANCA',492),(3625,'CALLAO',541),(3615,'CALLERÍA',537),(2869,'CAMANÁ',411),(2934,'CANARIA',424),(2996,'CANAS',437),(3260,'CANCHAQUE',485),(3511,'CANCHAQUE',511),(3594,'CANDARAVE',531),(2903,'CANGALLO',417),(3383,'CANTARRAYOC',493),(3534,'CAPACHICA',516),(3005,'CAPACHIQUE',439),(3404,'CAPANYA',494),(3586,'CARACOTO',528),(3345,'CARAMPOMA',492),(3405,'CARANIA',494),(2875,'CARAVELÍ',412),(3171,'CARHUACAYAN',469),(2800,'CARHUAZ',398),(3626,'CARMEN DE LA LEGUA REYNOSO',541),(3324,'CARQUIN',490),(3474,'CARUMAS',503),(3610,'CASITAS',535),(2823,'CASMA',402),(2825,'CASMA',403),(2881,'CASTILLA',413),(3500,'CASTILLA',509),(3087,'CASTILLO GRANDE',458),(3048,'CASTROVIRREYNA',449),(3501,'CATACAOS',509),(3406,'CATAHUASI',494),(2975,'CATILLUC',432),(3245,'CAYALTI',484),(2935,'CAYARA',424),(2859,'CAYMA',410),(2922,'CCATCCA',421),(2978,'CCATCCA',433),(3006,'CCATCCA',439),(3054,'CCATCCA',450),(2946,'CELEDIN',426),(2944,'CELENDÍN',426),(3308,'CERRO AZUL',489),(2860,'CERRO VERDE',410),(3064,'CHACABAMBA',452),(3154,'CHACABAMBA',468),(3172,'CHACAPALCA',469),(3193,'CHACAPALCA',471),(3124,'CHACAPAMPA',466),(2789,'CHACAS',396),(3492,'CHACAYÁN',507),(2756,'CHACHAPOYAS',388),(2884,'CHACHAS',413),(3271,'CHACLACAYO',487),(2829,'CHACOCHE',404),(3093,'CHAGLLA',460),(3180,'CHALA',470),(3181,'CHALACÁN',470),(2930,'CHALHUANCA',423),(3155,'CHAMBARA',468),(3182,'CHANCAHUASI',470),(3333,'CHANCAY',491),(3150,'CHANCHAMAYO',468),(3197,'CHANCHAS',472),(3243,'CHAO',483),(2879,'CHAPARRA',412),(2844,'CHAPIMARCA',407),(2861,'CHARACATO',410),(3225,'CHARAT',478),(3487,'CHAUPIMARCA',506),(2812,'CHAVÍN',400),(3045,'CHAVÍN',448),(3079,'CHAVIN',456),(3107,'CHAVIN',462),(2997,'CHECCA',437),(3217,'CHEPÉN',476),(2943,'CHETILLA',425),(2755,'CHETO',388),(3550,'CHI',517),(2801,'CHIA',398),(2836,'CHIARA',405),(2901,'CHIARA',416),(3211,'CHICAMA',474),(3042,'CHICCHE',447),(3346,'CHICLA',492),(3244,'CHICLAYO',484),(2862,'CHIGUATA',410),(3090,'CHIGUIRIP',459),(3497,'CHIGUIRIP',508),(3125,'CHILCA',466),(3309,'CHILCA',489),(2918,'CHILCAYOC',420),(2956,'CHILETE',428),(3238,'CHIMBOTE',482),(3105,'CHINCHA ALTA',462),(3108,'CHINCHA BAJA',462),(3031,'CHINCHERO',445),(2851,'CHINCHEROS',408),(2796,'CHINGALPO',397),(2923,'CHIQUINTIRCA',421),(2965,'CHIRIMOTO',430),(3156,'CHIRIPA',468),(2893,'CHOCO',415),(3478,'CHOJATA',504),(3246,'CHONGOYAPE',484),(3263,'CHONGOYAPE',486),(3071,'CHORRILLOS',454),(3272,'CHORRILLOS',487),(2950,'CHOTA',427),(3535,'CHUCUITO',516),(3236,'CHUGAY',481),(3513,'CHULUCANAS',512),(3571,'CHUMBIVILCAS',523),(3126,'CHUPACA',466),(2853,'CHUQUIBAMBILLA',409),(3237,'CHUQUICATAQUILLA',481),(3052,'CHURCAMPA',450),(3065,'CHURUBAMBA',452),(2770,'CHURUJA',390),(2904,'CHUSCHI',417),(3273,'CIENEGUILLA',487),(2830,'CIRCA',404),(3479,'COALAQUE',504),(3536,'COATA',516),(3310,'COAYLLO',489),(2887,'COCACHACRA',414),(2816,'COCHABAMBA',401),(3075,'COCHABAMBA',455),(2852,'COCHARCAS',408),(3407,'COCHAS',494),(2785,'CODASPÉ',395),(3239,'COISHCO',482),(3519,'COLAN',513),(3127,'COLCA',466),(3408,'COLCA',494),(2817,'COLCABAMBA',401),(2845,'COLCABAMBA',407),(3068,'COLPA',453),(2827,'COMANDANTE NOEL',403),(3274,'COMAS',487),(3001,'COMBAPATA',438),(3128,'CONCEPCIÓN',466),(3215,'CONDORMARCA',475),(3561,'CONDURIRI',520),(3046,'CONGACHA',448),(2779,'CONILA',393),(3577,'CONIMA',525),(3462,'CONTAMANA',499),(2955,'CONTUMAZÁ',428),(2765,'COPALILLO',389),(3010,'COPORAQUE',440),(2925,'CORACORA',422),(3553,'CORANI',518),(3334,'CÓRDOVA',491),(2806,'CORONGO',399),(3605,'CORRALES',534),(2894,'COTAHUASI',415),(2846,'COTARUSE',407),(3142,'COVIRIALI',467),(2947,'CROMANGA',426),(3475,'CUCHUMBAYA',503),(3347,'CUENCA',492),(2824,'CULEBRAS',402),(3575,'CUPI',524),(3596,'CURIBAYA',531),(2854,'CURPAHUASI',409),(2807,'CUSCA',399),(2977,'CUSCO',433),(3463,'CUYABENO',499),(3579,'CUYOCUYO',526),(2888,'DEAN',414),(3472,'DELTA 1',502),(3555,'DESAGUADERO',519),(2771,'DIANCHICUY',390),(2948,'DV. JESUS',426),(3014,'ECHARATI',441),(3484,'EL ALGARROBAL',505),(3520,'EL ALGARROBO',513),(3512,'EL CARMEN DE LA FRONTERA',511),(2766,'EL MILAGRO',389),(2840,'EL ORO',406),(3203,'EL PORVENIR',473),(2802,'ENCO',398),(3009,'ESPINAR',440),(3600,'ESTIQUE',533),(3601,'ESTIQUE PAMPA',533),(3247,'ETEN',484),(3248,'FERREÑAFE',484),(3259,'FERREÑAFE',485),(3566,'FILADELFIA',522),(3204,'FLORIDABLANCA',473),(3507,'FRIAS',510),(2797,'FUJIMARCA',397),(2855,'GAMARRA',409),(2856,'GRAU',409),(3228,'GUADALUPE',479),(2958,'GUAMBOS',428),(2814,'HUACACHINA',400),(3074,'HUACAYBAMBA',455),(3129,'HUACHAC',466),(2776,'HUACHIS',392),(2813,'HUACHIS',400),(3321,'HUACHO',490),(3038,'HUACHOCOLPA',446),(3488,'HUACHON',506),(3348,'HUACHUPAMPA',492),(3089,'HUACRACHUCO',459),(3556,'HUACULLANI',519),(3198,'HUAHUACA',472),(3325,'HUALMAY',490),(2960,'HUAMACHUCO',429),(3216,'HUAMACHUCO',475),(3233,'HUAMACHUCO',480),(3235,'HUAMACHUCO',481),(3183,'HUAMALI',470),(2897,'HUAMANGA',416),(2913,'HUAMANGUILLA',419),(3384,'HUAMANTANGA',493),(2895,'HUAMBO',415),(2936,'HUANCA SANCOS',424),(3498,'HUANCABAMBA',508),(3510,'HUANCABAMBA',511),(3385,'HUANCAHUASI',493),(3130,'HUANCALÍ',466),(3565,'HUANCANÉ',522),(3120,'HUANCANO',465),(2932,'HUANCAPI',424),(2837,'HUANCARAMA',405),(3023,'HUANCARANI',443),(2907,'HUANCAVELICA',418),(3035,'HUANCAVELICA',446),(3409,'HUANCAYA',494),(3123,'HUANCAYO',466),(3205,'HUANCHACO',473),(3410,'HUANGASCAR',494),(2831,'HUANIPACA',404),(3019,'HUANOQUITE',442),(2911,'HUANTA',419),(3411,'HUANTLA',494),(3060,'HUÁNUCO',452),(3349,'HUANZA',492),(3412,'HUANZA',494),(2841,'HUAQUIRCA',406),(3328,'HUARAL',491),(2970,'HUARANGO',431),(2815,'HUARAZ',401),(2809,'HUARI',400),(3157,'HUARIACA',468),(3184,'HUARIACA',470),(2822,'HUARMEY',402),(3027,'HUARO',444),(3340,'HUAROCHIRÍ',492),(3158,'HUASAHUASI',468),(3131,'HUASICANCHA',466),(3221,'HUASO',477),(3537,'HUATA',516),(3350,'HUAUCLACTA',492),(3326,'HUAURA',490),(2847,'HUAYLLO',407),(3095,'ICA',461),(3480,'ICHUÑA',504),(3562,'ICON',520),(3523,'IGNACIO ESCUDERO',514),(2914,'IGUAIN',419),(3598,'ILABAYA',532),(3560,'ILAVE',520),(3483,'ILO',505),(2767,'IMAZA',389),(3311,'IMPERIAL',489),(3456,'INAHUAYA',497),(3471,'IÑAPARI',502),(3623,'IÑAPARI',540),(3591,'INCLÁN',530),(2818,'INDEPENDENCIA',401),(3446,'INDIANA',495),(3466,'INFIERNO',500),(3444,'IQUITOS',495),(3447,'ISLANDIA',495),(2889,'ISLAY',414),(3327,'IXTLA',490),(3080,'JACAS GRANDE',456),(3091,'JACAS GRANDE',459),(2863,'JACOBO HUNTER',410),(2964,'JAÉN',430),(2819,'JANGAS',401),(2880,'JAQUI',412),(3264,'JAYANCA',486),(3451,'JEBEROS',496),(3460,'JENARO HERRERA',498),(3218,'JEQUETEPEQUE',476),(3229,'JEQUETEPEQUE',479),(3082,'JESUS',457),(2902,'JESUS NAZARENO',416),(3508,'JILILI',510),(3199,'JUAN DE DIOS',472),(3220,'JULCÁN',477),(3554,'JULI',519),(3583,'JULIACA',528),(3195,'JUNÍN',472),(3557,'KELLUYO',519),(3527,'LA BREA',515),(3606,'LA CRUZ',534),(2864,'LA JOYA',410),(2820,'LA LIBERTAD',401),(2916,'LA MAR',420),(3514,'LA MATANZA',512),(3192,'LA OROYA',471),(2808,'LA PAMPA',399),(2803,'LA PAZ',398),(2768,'LA PECA',389),(3627,'LA PERLA',541),(3628,'LA PUNTA',541),(3096,'LA TINGUIÑA',461),(3070,'LA UNIÓN',454),(3502,'LA UNIÓN',509),(3159,'LABRADOR',468),(3386,'LACHAQUI',493),(3249,'LAGUNAS',484),(3452,'LAGUNAS',496),(3509,'LAGUNAS',510),(3351,'LAHUAYTAMBO',492),(3413,'LAJAS',494),(3262,'LAMBAYEQUE',486),(2832,'LAMBRAMA',404),(3569,'LAMPA',523),(3335,'LAMPIAN',491),(3352,'LANGA',492),(2910,'LARAMARCA',418),(3353,'LARAOS',492),(3387,'LARAOS',493),(3206,'LAREDO',473),(2993,'LARES',436),(2891,'LAURA',415),(3084,'LAURICOCHA',457),(2777,'LEVANTO',392),(3414,'LINCHA',494),(3007,'LIVITACA',439),(3078,'LLATA',456),(3143,'LLAYA',467),(2786,'LLIPA',395),(3116,'LLIPATA',464),(3528,'LOBITOS',515),(3097,'LOS AQUIJES',461),(2905,'LOS MOROCHUCOS',417),(3503,'LOS ÓRGANOS',509),(3611,'LOS ÓRGANOS',535),(2920,'LUCANAS',421),(3028,'LUCRE',444),(3336,'LUMBRA',491),(3312,'LUNAHUANÁ',489),(3276,'LURÍN',487),(2780,'LUYA',393),(2790,'MACA',396),(3240,'MACATE',482),(3551,'MACUSANI',518),(3415,'MADEAN',494),(3277,'MAGDALENA DEL MAR',487),(3313,'MALA',489),(3616,'MANANTAY',537),(3539,'MAÑAZO',516),(3388,'MANTA',493),(3002,'MARANGANI',438),(3032,'MARAS',445),(2962,'MARCABAL',429),(3524,'MARCAVELICA',514),(3113,'MARCONA',463),(2865,'MARIANO MELGAR',410),(2757,'MARISCAL CASTILLA',388),(2782,'MARISCAL CASTILLA',394),(2872,'MARISCAL CASTILLA',411),(3072,'MARISCAL CASTILLA',454),(3314,'MÁRQUEZ',489),(3613,'MATAPALO',536),(3354,'MATUCANA',492),(3144,'MAZAMARI',467),(2890,'MEJÍA',414),(3504,'MIGUEL CHECA',509),(3355,'MINA',492),(3081,'MIRAFLORES',456),(3278,'MIRAFLORES',487),(3416,'MIRAFLORES',494),(3207,'MOCHE',473),(3265,'MOCHUMÍ',486),(3576,'MOHO',525),(3094,'MOLINO',460),(2758,'MOLINOPAMPA',388),(2866,'MOLLEBAYA',410),(2873,'MOLLENDO',411),(2886,'MOLLENDO',414),(3250,'MONSEFÚ',484),(2759,'MONTEVIDEO',388),(2783,'MONTEVIDEO',394),(3473,'MOQUEGUA',503),(3481,'MOQUEGUA',504),(3453,'MORALES',496),(3356,'MORAYA',492),(3173,'MOROCOCHA',469),(3194,'MOROCOCHA',471),(3515,'MORROPÓN',512),(2986,'MOSOC LLACTA',434),(3357,'MOYOPAMPA',492),(3185,'MUQUIYAUYO',470),(2971,'NAMBALLE',431),(3454,'NAUTA',496),(3050,'ÑAWIMPUQUIO',449),(3111,'NAZCA',463),(3241,'NEPEÑA',482),(3251,'NEW CAJAMARCA',484),(2773,'NIEVA',391),(3315,'NUEVO IMPERIAL',489),(3055,'ÑUÑUNHUACA',450),(3389,'OBRAJILLO',493),(3316,'OCA',489),(2874,'OCOÑA',411),(3098,'OCUCAJE',461),(3033,'OLLANTAYTAMBO',445),(3564,'OLLARAYA',521),(2821,'OLLEROS',401),(3358,'OLLEROS',492),(3020,'OMACHA',442),(3417,'OMAS',494),(2896,'OMATE',415),(3477,'OMATE',504),(3390,'OQUENDO',493),(2885,'ORCOPAMPA',413),(3132,'ORCOTUNA',466),(3200,'ORCOTUNA',472),(2842,'OROPESA',406),(3223,'OTUZCO',478),(3160,'OXAPAMPA',468),(3495,'OXAPAMPA',508),(3252,'OYOTÚN',484),(3317,'PACARÁN',489),(3418,'PACARÁN',494),(3337,'PACARAOS',491),(3227,'PACASMAYO',479),(3099,'PACHACAMAC',461),(3279,'PACHACAMAC',487),(3359,'PACHACAYO',492),(3419,'PACHACAYO',494),(3493,'PACHANGAMAYO',507),(3482,'PACHANGARA',504),(2838,'PACOBAMBA',405),(3485,'PACOCHA',505),(3212,'PAIJÁN',474),(3219,'PAIJÁN',476),(3230,'PAIJÁN',479),(3517,'PAITA',513),(3186,'PALCA',470),(3592,'PALCA',530),(3187,'PALCAMAYO',470),(3115,'PALPA',464),(3145,'PAMPA HERMOSA',467),(3464,'PAMPA HERMOSA',499),(3391,'PAMPAHUASI',493),(2791,'PAMPALLAQTA',396),(3003,'PAMPALLAQTA',438),(3607,'PAMPAMARCA',534),(2804,'PAMPAROMAS',398),(3043,'PAMPAS',447),(3188,'PAMPAS',470),(3420,'PAMPAS',494),(3092,'PANAO',460),(3189,'PANCÁN',470),(3146,'PANGOA',467),(3201,'PANGOA',472),(3421,'PAPAYAL',494),(3121,'PARACAS',465),(3529,'PARACAS',515),(3392,'PARACOTO',493),(2906,'PARAS',417),(3572,'PARATIA',523),(3100,'PARCONA',461),(3133,'PARIAHUACA',466),(2924,'PARINACOCHAS',422),(3017,'PARURO',442),(3486,'PASCO',506),(3231,'PATAZ',480),(2867,'PAUCARPATA',410),(3021,'PAUCARTAMBO',443),(2931,'PAUSA',423),(3422,'PAYOC',494),(3580,'PHARA',526),(3541,'PICHACANI',516),(3162,'PICHANAQUI',468),(3161,'PICHÁTARO',468),(3011,'PICHIGUA',440),(2833,'PICHIRHUA',404),(3253,'PICSI',484),(3134,'PILCOMAYO',466),(3077,'PINRA',455),(3393,'PIRCA',493),(2994,'PISAC',436),(3558,'PISACOMA',519),(3119,'PISCO',465),(3499,'PIURA',509),(3540,'PLATERIA',516),(3593,'POCOLLAY',530),(2868,'POCSI',410),(2984,'POMACANCHI',434),(2772,'POMACOCHAS',390),(2979,'POROY',433),(2781,'PROVIDENCIA',393),(3614,'PUCALLPA',537),(2967,'PUCARA',430),(3280,'PUCUSANA',487),(3275,'PUEBLO LIBRE',487),(3281,'PUENTE PIEDRA',487),(3465,'PUERTO MALDONADO',500),(3147,'PUERTO OCOPA',467),(3448,'PUNCHANA',495),(3530,'PUNO',516),(3282,'PUNTA HERMOSA',487),(3283,'PUNTA NEGRA',487),(2926,'PUQUIO',422),(3622,'PURÚS',540),(3582,'PUTINA',527),(3015,'QUELLOUNO',441),(3525,'QUERECOTILLO',514),(3085,'QUEROPALCA',457),(3135,'QUICHUAY',466),(3163,'QUIMARICO',468),(3360,'QUINCHES',492),(3423,'QUINCHES',494),(3059,'QUIPICHANQUI',451),(3008,'QUIQUIJANA',439),(3424,'QUISAMA',494),(3029,'QUISPICANCHI',444),(3073,'QUIVILLA',454),(3619,'RAYMONDI',538),(3164,'REALILLO',468),(3254,'REQUE',484),(3459,'REQUENA',498),(3361,'RICAURTE',492),(3394,'RICAURTE',493),(3425,'RICAURTE',494),(3284,'RÍMAC',487),(3148,'RÍO NEGRO',467),(2774,'RÍO SANTIAGO',391),(3149,'RIO TAMBO',467),(3567,'ROSASPATA',522),(3088,'RUPA RUPA',458),(3102,'SALAS',461),(3255,'SALAS',484),(3208,'SALAVERRY',473),(3516,'SALITRAL',512),(3476,'SAMEGUA',503),(3285,'SAN ANDRÉS',487),(3395,'SAN ANDRÉS DE CANTA',493),(3362,'SAN ANDRÉS DE TUPICOCHA',492),(3363,'SAN ANTONIO',492),(3543,'SAN ANTONIO DE ESQUILACHI',516),(3581,'SAN ANTONIO DE PUTINA',527),(3286,'SAN BARTOLO',487),(3338,'SAN BARTOLOMÉ',491),(3364,'SAN BARTOLOMÉ',492),(3380,'SAN BUENAVENTURA DE CANTA',493),(3365,'SAN CRISTÓBAL',492),(3366,'SAN DAMIÁN',492),(2969,'SAN IGNACIO',431),(3287,'SAN ISIDRO',487),(2980,'SAN JERÓNIMO',433),(3101,'SAN JERÓNIMO',461),(3256,'SAN JOSÉ',484),(3367,'SAN JUAN',492),(3396,'SAN JUAN',493),(3449,'SAN JUAN BAUTISTA',495),(2792,'SAN JUAN DE ABELINO',396),(3339,'SAN JUAN DE IRIS',491),(3288,'SAN JUAN DE LURIGANCHO',487),(3289,'SAN JUAN DE MIRAFLORES',487),(3290,'SAN LUIS',487),(3291,'SAN MARTÍN DE PORRES',487),(3368,'SAN MATEO',492),(2973,'SAN MIGUEL',432),(3292,'SAN MIGUEL',487),(3369,'SAN MIGUEL',492),(3370,'SAN PEDRO',492),(3165,'SAN RAMÓN',468),(2981,'SAN SEBASTIÁN',433),(3304,'SAN VICENTE DE CAÑETE',489),(3426,'SANCO',494),(3578,'SANDIA',526),(3427,'SANGALLAYA',494),(3137,'SAÑO',466),(3013,'SANTA ANA',441),(3166,'SANTA ANA DE TUSI',468),(3494,'SANTA ANA DE TUSI',507),(3293,'SANTA ANITA',487),(3174,'SANTA BÁRBARA DE CARHUACAYAN',469),(3118,'SANTA CRUZ',464),(3318,'SANTA CRUZ DE FLORES',489),(2959,'SANTA CRUZ DE TOLEDO',428),(3371,'SANTA EULALIA',492),(3372,'SANTA INÉS',492),(3373,'SANTA JUSTA',492),(3294,'SANTA MARÍA DEL MAR',487),(2968,'SANTA ROSA',430),(3257,'SANTA ROSA',484),(3295,'SANTA ROSA',487),(3397,'SANTA ROSA DE QUIVES',493),(3167,'SANTA ROSA DE SACCO',468),(3428,'SANTANILLA',494),(2982,'SANTIAGO',433),(3374,'SANTIAGO DE ANCHUCAYA',492),(3296,'SANTIAGO DE SURCO',487),(3375,'SANTIAGO DE TUNA',492),(2915,'SANTILLANA',419),(3047,'SANTO DOMINGO',448),(3376,'SANTO DOMINGO',492),(3136,'SANTO DOMINGO DE ACOBAMBA',466),(3429,'SANTO DOMINGO DE CHINCHA',494),(3168,'SANTO DOMINGO DE OLLEROS',468),(3489,'SANTO DOMINGO DE OLLEROS',506),(3004,'SANTO TOMÁS',439),(3377,'SANTO TOMÁS',492),(3430,'SANTO TOMÁS',494),(3490,'SANTO TOMÁS',506),(3140,'SATIPO',467),(3378,'SEGUNDA',492),(3431,'SEGUNDA',494),(3000,'SICUANI',438),(3138,'SINCOS',466),(2963,'SÑAN',429),(2760,'SOLOCO',388),(2761,'SÓNGARO',388),(2949,'SOROCHUCO',426),(2787,'SUCCHA',395),(2928,'SUCRE',423),(3432,'SUELO',494),(3521,'SULLANA',514),(3109,'SUNAMPE',462),(3301,'SUPE',488),(3302,'SUPE PUERTO',488),(3297,'SURQUILLO',487),(3602,'SUSAPAYA',533),(2954,'TACABAMBA',427),(3258,'TACNA',484),(3588,'TACNA',530),(3597,'TACNA',532),(3526,'TALARA',515),(3103,'TAMBILLO',461),(3110,'TAMBO DE MORA',462),(3467,'TAMBOPATA',500),(3433,'TANA',494),(3434,'TANTA',494),(3051,'TANTARÁ',449),(3461,'TAPICHE',498),(3568,'TARACO',522),(3599,'TARATA',533),(3175,'TARMA',470),(3190,'TARMATAMBO',470),(3104,'TATE',461),(3191,'TAYA',470),(3234,'TAYABAMBA',480),(3435,'TEMISGAYA',494),(3436,'TESIA',494),(3086,'TINGO MARÍA',458),(3437,'TINTA',494),(3457,'TIPISHCA',497),(3544,'TIQUILLACA',516),(3069,'TOMAYRICA',453),(3438,'TONGSUPA',494),(3319,'TOPARÁ',489),(3202,'TRUJILLO',473),(3603,'TUMBES',534),(2999,'TUPAC AMARU',437),(3122,'TUPAC AMARU',465),(3379,'TUPIA',492),(3439,'TUPIA',494),(2919,'UCO',420),(3169,'ULCUMAYO',468),(2927,'UPAHUACHO',422),(3458,'URARINAS',497),(3025,'URUBAMBA',444),(3030,'URUBAMBA',445),(3226,'USQUIL',478),(3440,'UYARACCAY',494),(3441,'VARILLA',494),(3303,'VÉGUETA',488),(3442,'VEGUETA',494),(3629,'VENTANILLA',541),(3209,'VICTOR LARCO HERRERA',473),(3443,'VILCA',494),(3016,'VILCABAMBA',441),(3468,'VILLA CARMEN',501),(3298,'VILLA EL SALVADOR',487),(3299,'VILLA MARÍA DEL TRIUNFO',487),(3545,'VILQUE',516),(3139,'VIQUES',466),(3242,'VIRÚ',483),(3491,'YANAHUANCA',507),(2995,'YANATILE',436),(3617,'YARINACOCHA',537),(3320,'YAUCA DEL ROSARIO',489),(3039,'YAULI',446),(3170,'YAULI',469),(3012,'YAURI',440),(3398,'YAUYOS',494),(3034,'YUCAY',445),(3563,'YUNGUYO',521),(3587,'YUNGUYO',529),(3450,'YURIMAGUAS',496),(3612,'ZARUMILLA',536),(3559,'ZEPITA',519),(3609,'ZORRITOS',535);
/*!40000 ALTER TABLE `TblDistritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblEstadoProspeccion`
--

DROP TABLE IF EXISTS `TblEstadoProspeccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblEstadoProspeccion` (
  `id_estado_prospeccion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_estado_prospeccion`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblEstadoProspeccion`
--

LOCK TABLES `TblEstadoProspeccion` WRITE;
/*!40000 ALTER TABLE `TblEstadoProspeccion` DISABLE KEYS */;
INSERT INTO `TblEstadoProspeccion` VALUES (1,'FRIO',1,'2026-06-20 18:21:30','2026-06-20 18:21:30'),(2,'CALIENTE',1,'2026-06-20 18:21:30','2026-06-20 18:21:30'),(3,'DESCARTADO',1,'2026-06-20 18:21:30','2026-06-20 18:21:30'),(4,'POTENCIAL',1,'2026-06-20 18:21:30','2026-06-20 18:21:30'),(5,'TRATAMIENTO',1,'2026-06-20 18:21:30','2026-06-20 18:21:30');
/*!40000 ALTER TABLE `TblEstadoProspeccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblFuenteContacto`
--

DROP TABLE IF EXISTS `TblFuenteContacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblFuenteContacto` (
  `id_fuente_contacto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_fuente_contacto`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblFuenteContacto`
--

LOCK TABLES `TblFuenteContacto` WRITE;
/*!40000 ALTER TABLE `TblFuenteContacto` DISABLE KEYS */;
INSERT INTO `TblFuenteContacto` VALUES (1,'MKT FISICO BANNER',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(2,'MKT FISICO VISITA PRESENCIAL',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(3,'MKT FISICO ACTIVACIONES',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(4,'MKT DIGITAL ENLACE DIRECTO',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(5,'MKT DIGITAL TRANS EN VIVO',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(6,'MKT DIGITAL BASE DE DATOS',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(7,'MKT DIGITAL PUBLICIDAD PERSONAL',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(8,'MKT DIGITAL FACEBOOK FANPAGE',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(9,'MKT DIGITAL FACEBOOK MESSENGER',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(10,'FORMULARIO',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(11,'DERIVADO',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(12,'RECOMENDADO',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(13,'REMARKETING WAPI',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(14,'REMARKETING PERSONAL',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(15,'RECURRENTE',1,'2026-06-20 18:11:30','2026-06-20 18:11:30'),(16,'TIKTOK LIVE',1,'2026-06-20 18:11:30','2026-06-20 18:11:30');
/*!40000 ALTER TABLE `TblFuenteContacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblJerarquiaUsuarios`
--

DROP TABLE IF EXISTS `TblJerarquiaUsuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblJerarquiaUsuarios` (
  `id_jerarquia` int NOT NULL AUTO_INCREMENT,
  `num_documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nivel` int NOT NULL DEFAULT '1',
  `num_documento_padre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_jerarquia`),
  UNIQUE KEY `unique_usuario` (`num_documento`),
  KEY `idx_padre` (`num_documento_padre`),
  KEY `idx_nivel` (`nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblJerarquiaUsuarios`
--

LOCK TABLES `TblJerarquiaUsuarios` WRITE;
/*!40000 ALTER TABLE `TblJerarquiaUsuarios` DISABLE KEYS */;
INSERT INTO `TblJerarquiaUsuarios` VALUES (2,'12345678',0,NULL,'2026-06-19 20:45:03','2026-06-19 22:43:01'),(4,'73017554',0,NULL,'2026-06-19 20:45:03','2026-06-19 22:24:56'),(14,'72542994',0,NULL,'2026-06-19 22:32:16','2026-06-19 22:43:01');
/*!40000 ALTER TABLE `TblJerarquiaUsuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblLoginHistory`
--

DROP TABLE IF EXISTS `TblLoginHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblLoginHistory` (
  `id_login` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(100) NOT NULL,
  `fecha_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `exitoso` tinyint DEFAULT '0',
  `mensaje` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_login`),
  KEY `idx_usuario` (`usuario`),
  KEY `idx_fecha` (`fecha_hora`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblLoginHistory`
--

LOCK TABLES `TblLoginHistory` WRITE;
/*!40000 ALTER TABLE `TblLoginHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `TblLoginHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblPersona`
--

DROP TABLE IF EXISTS `TblPersona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblPersona` (
  `num_documento` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Número de documento (DNI, RUC, etc.)',
  `tipo_documento` enum('DNI','RUC','CE','Pasaporte') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Tipo de documento de identidad',
  `nombres` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombres de la persona',
  `apellido_paterno` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Apellido paterno',
  `apellido_materno` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Apellido materno',
  `celular` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Número de celular',
  `numero_emergencia` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Número de contacto de emergencia',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Correo electrónico',
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Dirección completa',
  `fecha_nacimiento` date DEFAULT NULL COMMENT 'Fecha de nacimiento',
  `genero` enum('M','F','Otro') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Género',
  `estado_civil` enum('Soltero','Casado','Divorciado','Viudo','Conviviente') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Estado civil',
  `id_distrito` int DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci COMMENT 'Observaciones adicionales',
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo' COMMENT 'Estado del registro',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de registro',
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Última actualización',
  PRIMARY KEY (`num_documento`),
  KEY `idx_tipo_documento` (`tipo_documento`),
  KEY `idx_nombres` (`nombres`),
  KEY `idx_apellidos` (`apellido_paterno`,`apellido_materno`),
  KEY `idx_email` (`email`),
  KEY `idx_estado` (`estado`),
  KEY `fk_persona_distrito` (`id_distrito`),
  CONSTRAINT `fk_persona_distrito` FOREIGN KEY (`id_distrito`) REFERENCES `TblDistritos` (`id_distrito`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla maestra de personas (clientes, proveedores, empleados, etc.)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblPersona`
--

LOCK TABLES `TblPersona` WRITE;
/*!40000 ALTER TABLE `TblPersona` DISABLE KEYS */;
INSERT INTO `TblPersona` VALUES ('10000001','DNI','CLIENTE','PRUEBA','UNO','+51 900 000 001',NULL,'cliente1@test.com','Av. Test 123','1990-01-01','M','Soltero',3125,NULL,'Activo','2026-06-22 22:00:55','2026-06-22 22:00:55'),('10000002','DNI','CLIENTE','PRUEBA','DOS','+51 900 000 002',NULL,'cliente2@test.com','Jr. Test 456','1992-02-02','F','Casado',3126,NULL,'Activo','2026-06-22 22:00:55','2026-06-22 22:00:55'),('10000003','DNI','CLIENTE','PRUEBA','TRES','+51 900 000 003',NULL,'cliente3@test.com','Calle Test 789','1995-03-03','M','Soltero',3127,NULL,'Activo','2026-06-22 22:00:55','2026-06-22 22:00:55'),('12345678','DNI','Administrador','Sistema','KallMax','999999999',NULL,'admin@kallmax.com',NULL,NULL,NULL,NULL,NULL,NULL,'Activo','2026-06-18 21:08:35','2026-06-18 21:08:35'),('72542994','DNI','EDISON FRANCO','SUAREZ','HUAMAN','918163200','918163201','fila2159@gmail.com','#1458 JR FLORIDA Y 14 DE JHULIO','1995-11-04','M','Soltero',3125,NULL,'Activo','2026-06-19 22:32:16','2026-06-20 00:47:16'),('73017554','DNI','DANIELA','HUAMÁN','CARDENAS','918163201','918163202','FILA@GMAIL.COM','#123465 JR FLORIDA',NULL,'F',NULL,NULL,'','Activo','2026-06-18 23:08:25','2026-06-18 23:08:25');
/*!40000 ALTER TABLE `TblPersona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblProvincias`
--

DROP TABLE IF EXISTS `TblProvincias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblProvincias` (
  `id_provincia` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_departamento` int NOT NULL,
  PRIMARY KEY (`id_provincia`),
  UNIQUE KEY `uk_provincia_departamento` (`nombre`,`id_departamento`),
  KEY `fk_provincia_departamento` (`id_departamento`),
  CONSTRAINT `fk_provincia_departamento` FOREIGN KEY (`id_departamento`) REFERENCES `TblDepartamentos` (`id_departamento`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=542 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblProvincias`
--

LOCK TABLES `TblProvincias` WRITE;
/*!40000 ALTER TABLE `TblProvincias` DISABLE KEYS */;
INSERT INTO `TblProvincias` VALUES (404,'ABANCAY',76),(447,'ACOBAMBA',81),(434,'ACOMAYO',80),(395,'AIJA',75),(496,'ALTO AMAZONAS',88),(453,'AMBO',82),(405,'ANDAHUAYLAS',76),(448,'ANGARAES',81),(435,'ANTA',80),(406,'ANTABAMBA',76),(410,'AREQUIPA',77),(474,'ASCOPE',85),(396,'ASUNCIÓN',75),(538,'ATALAYA',96),(510,'AYABACA',92),(407,'AYMARAES',76),(517,'AZÁNGARO',93),(389,'BAGUA',74),(488,'BARRANCA',87),(475,'BOLÍVAR',85),(397,'BOLOGNESI',75),(390,'BONGARÁ',74),(425,'CAJAMARCA',79),(436,'CALCA',80),(541,'CALLAO',97),(411,'CAMANÁ',77),(437,'CANAS',80),(438,'CANCHIS',80),(531,'CANDARAVE',94),(489,'CAÑETE',87),(417,'CANGALLO',78),(493,'CANTA',87),(518,'CARABAYA',93),(412,'CARAVELÍ',77),(398,'CARHUAZ',75),(403,'CASMA',75),(413,'CASTILLA',77),(449,'CASTROVIRREYNA',81),(426,'CELENDÍN',79),(388,'CHACHAPOYAS',74),(468,'CHANCHAMAYO',84),(476,'CHEPÉN',85),(484,'CHICLAYO',86),(462,'CHINCHA',83),(408,'CHINCHEROS',76),(427,'CHOTA',79),(519,'CHUCUITO',93),(439,'CHUMBIVILCAS',80),(450,'CHURCAMPA',81),(520,'COLLAO',93),(391,'CONDORCANQUI',74),(535,'CONTRALMIRANTE VILLAR',95),(428,'CONTUMAZÁ',79),(537,'CORONEL PORTILLO',96),(399,'CORONGO',75),(433,'CUSCO',80),(507,'DANIEL ALCIDES CARRIÓN',91),(454,'DOS DE MAYO',82),(521,'EL COLLAO',93),(440,'ESPINAR',80),(485,'FERREÑAFE',86),(504,'GENERAL SÁNCHEZ CERRO',90),(409,'GRAU',76),(455,'HUACAYBAMBA',82),(392,'HUACHIS',74),(490,'HUACHO',87),(429,'HUAMACHUCO',79),(456,'HUAMALÍES',82),(416,'HUAMANGA',78),(511,'HUANCABAMBA',92),(522,'HUANCANÉ',93),(418,'HUANCAVELICA',78),(446,'HUANCAVELICA',81),(466,'HUANCAYO',84),(419,'HUANTA',78),(452,'HUÁNUCO',82),(491,'HUARAL',87),(401,'HUARAZ',75),(400,'HUARI',75),(402,'HUARMEY',75),(492,'HUAROCHIRÍ',87),(461,'ICA',83),(505,'ILO',90),(414,'ISLAY',77),(430,'JAÉN',79),(532,'JORGE BASADRE',94),(477,'JULCÁN',85),(472,'JUNÍN',84),(441,'LA CONVENCIÓN',80),(420,'LA MAR',78),(471,'LA OROYA',84),(486,'LAMBAYEQUE',86),(523,'LAMPA',93),(415,'LAURA',77),(457,'LAURICOCHA',82),(458,'LEONCIO PRADO',82),(487,'LIMA',87),(421,'LUCANAS',78),(393,'LUYA',74),(501,'MANU',89),(459,'MARAÑÓN',82),(394,'MARISCAL CASTILLA',74),(503,'MARISCAL NIETO',90),(497,'MARISCAL RAMÓN CASTILLA',88),(495,'MAYNAS',88),(524,'MELGAR',93),(525,'MOHO',93),(512,'MORROPÓN',92),(463,'NAZCA',83),(478,'OTUZCO',85),(508,'OXAPAMPA',91),(479,'PACASMAYO',85),(460,'PACHITEA',82),(539,'PADRE ABAD',96),(513,'PAITA',92),(464,'PALPA',83),(422,'PARINACOCHAS',78),(442,'PARURO',80),(506,'PASCO',91),(480,'PATAZ',85),(443,'PAUCARTAMBO',80),(465,'PISCO',83),(509,'PIURA',92),(516,'PUNO',93),(540,'PURÚS',96),(444,'QUISPICANCHI',80),(498,'REQUENA',88),(527,'SAN ANTONIO DE PUTINA',93),(431,'SAN IGNACIO',79),(432,'SAN MIGUEL',79),(528,'SAN ROMÁN',93),(481,'SÁNCHEZ CARRIÓN',85),(526,'SANDIA',93),(482,'SANTA',85),(467,'SATIPO',84),(423,'SUCRE',78),(514,'SULLANA',92),(530,'TACNA',94),(502,'TAHUAMANU',89),(515,'TALARA',92),(500,'TAMBOPATA',89),(533,'TARATA',94),(470,'TARMA',84),(451,'TAYACAJA',81),(473,'TRUJILLO',85),(534,'TUMBES',95),(499,'UCAYALI',88),(445,'URUBAMBA',80),(424,'VÍCTOR FAJARDO',78),(483,'VIRU',85),(469,'YAULI',84),(494,'YAUYOS',87),(529,'YUNGUYO',93),(536,'ZARUMILLA',95);
/*!40000 ALTER TABLE `TblProvincias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblProyectos`
--

DROP TABLE IF EXISTS `TblProyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblProyectos` (
  `id_proyecto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_proyecto`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblProyectos`
--

LOCK TABLES `TblProyectos` WRITE;
/*!40000 ALTER TABLE `TblProyectos` DISABLE KEYS */;
INSERT INTO `TblProyectos` VALUES (1,'LA FLORESTA 2',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(2,'VILLA VERDE',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(3,'NUEVO TAMBO',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(4,'PRADO VERDE',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(5,'LAS PALMERAS',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(6,'PRADO VERDE 3',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(7,'LA ARBOLEDA',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(8,'LA ARBOLEDA 2',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(9,'VILLA DE LOS NISPEROS',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(10,'VILLA DE LOS NISPEROS LA FINCA',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(11,'PRADO VERDE 1',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(12,'EL GUINDAL',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(13,'LOS EUCALIPTOS',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(14,'PRADO VERDE 2',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(15,'LA VILLA',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(16,'DEPARTAMENTO',1,'2026-06-20 18:18:03','2026-06-20 18:18:03'),(17,'CONCEPCION',1,'2026-06-20 18:18:03','2026-06-20 18:18:03');
/*!40000 ALTER TABLE `TblProyectos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblRol`
--

DROP TABLE IF EXISTS `TblRol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblRol` (
  `id_rol` int NOT NULL AUTO_INCREMENT COMMENT 'ID único del rol',
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del rol (Asesor, Vendedor, Gerente, Administrador)',
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Descripción del rol y responsabilidades',
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo' COMMENT 'Estado del rol',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación',
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Última actualización',
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `idx_nombre` (`nombre`),
  KEY `idx_estado` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla maestra de roles del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblRol`
--

LOCK TABLES `TblRol` WRITE;
/*!40000 ALTER TABLE `TblRol` DISABLE KEYS */;
INSERT INTO `TblRol` VALUES (1,'Asesor','Usuario que vende propiedades y gestiona clientes','Activo','2026-06-19 15:25:20','2026-06-19 15:25:20'),(2,'Vendedor','Vendedor de propiedades con permisos limitados','Activo','2026-06-19 15:25:20','2026-06-19 15:25:20'),(3,'Gerente','Supervisor de equipo con permisos de reporte y análisis','Activo','2026-06-19 15:25:20','2026-06-19 15:25:20'),(4,'Administrador','Acceso total al sistema, gestión de usuarios y configuración','Activo','2026-06-19 15:25:20','2026-06-19 15:25:20');
/*!40000 ALTER TABLE `TblRol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblTipoCompra`
--

DROP TABLE IF EXISTS `TblTipoCompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblTipoCompra` (
  `id_tipo_compra` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tipo_compra`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblTipoCompra`
--

LOCK TABLES `TblTipoCompra` WRITE;
/*!40000 ALTER TABLE `TblTipoCompra` DISABLE KEYS */;
INSERT INTO `TblTipoCompra` VALUES (1,'CONTADO',1,'2026-06-20 18:26:31','2026-06-20 18:26:31'),(2,'FINANCIADO',1,'2026-06-20 18:26:31','2026-06-20 18:26:31');
/*!40000 ALTER TABLE `TblTipoCompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TblUsuarios`
--

DROP TABLE IF EXISTS `TblUsuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TblUsuarios` (
  `num_documento` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Número de documento (PK y FK a TblPersona) - Relación 1:1',
  `usuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre de usuario para login',
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Contraseña encriptada',
  `id_rol` int NOT NULL COMMENT 'ID del rol (FK a TblRol)',
  `id_cargo` int DEFAULT NULL COMMENT 'ID del cargo (FK a TblCargos)',
  `estado` enum('Activo','Inactivo','Bloqueado') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo' COMMENT 'Estado de la cuenta',
  `ultimo_acceso` timestamp NULL DEFAULT NULL COMMENT 'Última fecha de acceso al sistema',
  `intentos_fallidos` int DEFAULT '0' COMMENT 'Número de intentos fallidos de login',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación del usuario',
  `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Última actualización',
  PRIMARY KEY (`num_documento`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `idx_usuario` (`usuario`),
  KEY `idx_estado` (`estado`),
  KEY `fk_usuarios_rol` (`id_rol`),
  KEY `fk_usuarios_cargo` (`id_cargo`),
  CONSTRAINT `fk_usuarios_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `TblCargos` (`id_cargo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_usuarios_rol` FOREIGN KEY (`id_rol`) REFERENCES `TblRol` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TblUsuarios_ibfk_1` FOREIGN KEY (`num_documento`) REFERENCES `TblPersona` (`num_documento`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de usuarios del sistema - Relación 1:1 con TblPersona';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TblUsuarios`
--

LOCK TABLES `TblUsuarios` WRITE;
/*!40000 ALTER TABLE `TblUsuarios` DISABLE KEYS */;
INSERT INTO `TblUsuarios` VALUES ('12345678','admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',4,1,'Activo','2026-06-18 21:23:33',0,'2026-06-18 21:13:14','2026-06-19 15:57:27'),('72542994','esuarezh','f521f9cf4f8ab0d88ecba26dc41480bfd1347e062b00daaecca6325f811828ef',1,7,'Activo',NULL,0,'2026-06-19 22:32:16','2026-06-19 22:32:16'),('73017554','dhuamanc','2d7ec05428e8cb59193a595f369a748751f2add5b6b7fc8fd6182d62c22b8879',4,1,'Activo',NULL,0,'2026-06-18 23:08:25','2026-06-20 16:10:21');
/*!40000 ALTER TABLE `TblUsuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'KallMax_BD'
--

--
-- Dumping routines for database 'KallMax_BD'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_ActualizarAsesorPorNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ActualizarAsesorPorNombre`(
    IN p_documento_original VARCHAR(20),
    IN p_num_documento VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_apellido_paterno VARCHAR(100),
    IN p_apellido_materno VARCHAR(100),
    IN p_fecha_nacimiento DATE,
    IN p_estado_civil VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_celular VARCHAR(20),
    IN p_numero_emergencia VARCHAR(20),
    IN p_direccion VARCHAR(200),
    IN p_id_distrito INT,
    IN p_genero VARCHAR(20),
    IN p_usuario VARCHAR(50),
    IN p_rol_nombre VARCHAR(50),
    IN p_cargo_nombre VARCHAR(100),
    IN p_num_documento_creador VARCHAR(20),
    OUT p_actualizado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    -- Declarar variables
    DECLARE v_id_rol INT;
    DECLARE v_id_cargo INT;
    DECLARE v_nivel_hijo INT DEFAULT 0;
    
    -- SIN EXIT HANDLER para ver errores reales
    
    -- Inicializar OUT params INMEDIATAMENTE
    SET p_actualizado = 0;
    SET p_mensaje = 'TEST: SP iniciado';
    
    -- Buscar rol
    SELECT id_rol INTO v_id_rol
    FROM TblRol
    WHERE UPPER(TRIM(nombre)) = UPPER(TRIM(p_rol_nombre))
      AND estado = 'Activo'
    LIMIT 1;
    
    IF v_id_rol IS NULL THEN
        SET p_mensaje = CONCAT('Rol "', p_rol_nombre, '" no encontrado');
        -- NO salir, solo establecer mensaje
    ELSE
        SET p_mensaje = CONCAT('Rol encontrado: ID ', v_id_rol);
    END IF;
    
    -- Buscar cargo
    SELECT id_cargo INTO v_id_cargo
    FROM TblCargos
    WHERE UPPER(TRIM(nombre)) = UPPER(TRIM(p_cargo_nombre))
      AND estado = 'Activo'
    LIMIT 1;
    
    IF v_id_cargo IS NULL THEN
        SET p_mensaje = CONCAT('Cargo "', p_cargo_nombre, '" no encontrado');
    ELSE
        SET p_mensaje = CONCAT(p_mensaje, ' | Cargo encontrado: ID ', v_id_cargo);
    END IF;
    
    -- Si llegamos aquí, actualizar
    IF v_id_rol IS NOT NULL AND v_id_cargo IS NOT NULL THEN
        START TRANSACTION;
        
        UPDATE TblPersona SET
            tipo_documento = p_tipo_documento,
            nombres = p_nombres,
            apellido_paterno = p_apellido_paterno,
            apellido_materno = p_apellido_materno,
            fecha_nacimiento = p_fecha_nacimiento,
            estado_civil = p_estado_civil,
            email = p_email,
            celular = p_celular,
            numero_emergencia = p_numero_emergencia,
            direccion = p_direccion,
            id_distrito = p_id_distrito,
            genero = p_genero
        WHERE num_documento = p_documento_original;
        
        UPDATE TblUsuarios SET
            usuario = p_usuario,
            id_rol = v_id_rol,
            id_cargo = v_id_cargo
        WHERE num_documento = p_documento_original;
        
        COMMIT;
        
        SET p_actualizado = 1;
        SET p_mensaje = 'Actualizado exitosamente';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_AutenticarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_AutenticarUsuario`(
    IN p_usuario VARCHAR(100),
    IN p_password_hash VARCHAR(255),
    OUT p_autenticado TINYINT,
    OUT p_num_documento VARCHAR(20),
    OUT p_rol VARCHAR(50),
    OUT p_estado VARCHAR(20),
    OUT p_nombres VARCHAR(100),
    OUT p_apellido_paterno VARCHAR(100),
    OUT p_apellido_materno VARCHAR(100),
    OUT p_email VARCHAR(150),
    OUT p_area VARCHAR(100),
    OUT p_cargo VARCHAR(100),
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_password_bd VARCHAR(255);
    DECLARE v_estado_usuario VARCHAR(20);
    DECLARE v_intentos_fallidos INT DEFAULT 0;
    
    -- Valores por defecto
    SET p_autenticado = 0;
    SET p_num_documento = NULL;
    SET p_rol = NULL;
    SET p_estado = NULL;
    SET p_nombres = NULL;
    SET p_apellido_paterno = NULL;
    SET p_apellido_materno = NULL;
    SET p_email = NULL;
    SET p_area = NULL;
    SET p_cargo = NULL;
    SET p_mensaje = 'Usuario o contraseña incorrectos';
    
    -- Buscar usuario y obtener todos los datos con JOIN a TblPersona
    SELECT 
        u.num_documento,
        u.password_hash,
        u.estado,
        u.intentos_fallidos,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        p.email,
        r.nombre AS rol_nombre,
        c.nombre AS cargo_nombre,
        a.nombre AS area_nombre
    INTO 
        p_num_documento,
        v_password_bd,
        v_estado_usuario,
        v_intentos_fallidos,
        p_nombres,
        p_apellido_paterno,
        p_apellido_materno,
        p_email,
        p_rol,
        p_cargo,
        p_area
    FROM TblUsuarios u
    INNER JOIN TblPersona p ON u.num_documento = p.num_documento
    LEFT JOIN TblRol r ON u.id_rol = r.id_rol
    LEFT JOIN TblCargos c ON u.id_cargo = c.id_cargo
    LEFT JOIN TblAreas a ON c.id_area = a.id_area
    WHERE u.usuario = p_usuario
    LIMIT 1;
    
    -- Validaciones
    IF p_num_documento IS NULL THEN
        -- Usuario no existe
        SET p_mensaje = 'Usuario no encontrado';
        INSERT INTO TblLoginHistory (usuario, fecha_hora, exitoso, mensaje)
        VALUES (p_usuario, NOW(), 0, p_mensaje);
        
    ELSEIF v_estado_usuario = 'Bloqueado' THEN
        -- Usuario bloqueado
        SET p_estado = v_estado_usuario;
        SET p_mensaje = 'Usuario bloqueado. Contacte al administrador';
        INSERT INTO TblLoginHistory (usuario, fecha_hora, exitoso, mensaje)
        VALUES (p_usuario, NOW(), 0, p_mensaje);
        
    ELSEIF v_estado_usuario != 'Activo' THEN
        -- Usuario inactivo
        SET p_estado = v_estado_usuario;
        SET p_mensaje = CONCAT('Usuario ', v_estado_usuario, '. Contacte al administrador');
        INSERT INTO TblLoginHistory (usuario, fecha_hora, exitoso, mensaje)
        VALUES (p_usuario, NOW(), 0, p_mensaje);
        
    ELSEIF v_password_bd != p_password_hash THEN
        -- Contraseña incorrecta
        SET v_intentos_fallidos = v_intentos_fallidos + 1;
        
        -- Bloquear si llega a 5 intentos fallidos
        IF v_intentos_fallidos >= 5 THEN
            UPDATE TblUsuarios 
            SET estado = 'Bloqueado', intentos_fallidos = v_intentos_fallidos
            WHERE usuario = p_usuario;
            
            SET p_mensaje = 'Usuario bloqueado por múltiples intentos fallidos';
        ELSE
            UPDATE TblUsuarios 
            SET intentos_fallidos = v_intentos_fallidos
            WHERE usuario = p_usuario;
            
            SET p_mensaje = CONCAT('Contraseña incorrecta. Intentos restantes: ', 5 - v_intentos_fallidos);
        END IF;
        
        INSERT INTO TblLoginHistory (usuario, fecha_hora, exitoso, mensaje)
        VALUES (p_usuario, NOW(), 0, p_mensaje);
        
    ELSE
        -- Autenticación exitosa
        SET p_autenticado = 1;
        SET p_estado = v_estado_usuario;
        SET p_mensaje = 'Autenticación exitosa';
        
        -- Resetear intentos fallidos y actualizar último acceso
        UPDATE TblUsuarios 
        SET intentos_fallidos = 0, ultimo_acceso = NOW()
        WHERE usuario = p_usuario;
        
        -- Registrar login exitoso
        INSERT INTO TblLoginHistory (usuario, fecha_hora, exitoso, mensaje)
        VALUES (p_usuario, NOW(), 1, p_mensaje);
        
        -- Si no tiene cargo asignado, establecer valores por defecto
        IF p_cargo IS NULL THEN
            SET p_cargo = 'Sin cargo asignado';
        END IF;
        
        IF p_area IS NULL THEN
            SET p_area = 'Sin área asignada';
        END IF;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_BuscarClientePorDocumento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_BuscarClientePorDocumento`(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        c.id_cliente,
        c.num_documento,
        p.tipo_documento,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        CONCAT(p.nombres, ' ', p.apellido_paterno, ' ', COALESCE(p.apellido_materno, '')) AS nombre_completo,
        p.fecha_nacimiento,
        p.genero,
        p.estado_civil,
        p.email,
        p.celular,
        p.direccion,
        p.id_distrito,
        d.nombre AS distrito,
        c.num_documento_asesor,
        c.id_fuente_contacto,
        c.id_proyecto,
        c.id_estado_prospeccion,
        c.id_tipo_compra,
        c.estado,
        c.fecha_proximo_seguimiento,
        c.prioridad,
        c.observaciones
    FROM TblClientes c
    INNER JOIN TblPersona p ON c.num_documento = p.num_documento
    LEFT JOIN TblDistritos d ON p.id_distrito = d.id_distrito
    WHERE c.num_documento = p_num_documento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_BuscarUsuarioPorDocumento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_BuscarUsuarioPorDocumento`(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        u.num_documento,
        u.usuario,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        CONCAT(p.nombres, ' ', p.apellido_paterno, ' ', COALESCE(p.apellido_materno, '')) as nombre_completo,
        r.nombre as rol,
        c.nombre as cargo,
        a.nombre as area,
        u.estado,
        COALESCE(j.nivel, 0) as nivel,
        (SELECT COUNT(*) FROM TblJerarquiaUsuarios WHERE num_documento_padre COLLATE utf8mb4_unicode_ci = u.num_documento COLLATE utf8mb4_unicode_ci) as total_hijos
    FROM TblUsuarios u
    INNER JOIN TblPersona p ON u.num_documento COLLATE utf8mb4_unicode_ci = p.num_documento COLLATE utf8mb4_unicode_ci
    LEFT JOIN TblRol r ON u.id_rol = r.id_rol
    LEFT JOIN TblCargos c ON u.id_cargo = c.id_cargo
    LEFT JOIN TblAreas a ON c.id_area = a.id_area
    LEFT JOIN TblJerarquiaUsuarios j ON u.num_documento COLLATE utf8mb4_unicode_ci = j.num_documento COLLATE utf8mb4_unicode_ci
    WHERE u.num_documento = p_num_documento
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_EliminarAsesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_EliminarAsesor`(
    IN p_num_documento VARCHAR(20),
    OUT p_eliminado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    -- Variables
    DECLARE v_existe INT DEFAULT 0;
    DECLARE v_tiene_hijos INT DEFAULT 0;
    DECLARE v_nombre_completo VARCHAR(300);
    
    -- Handler para errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 @error_message = MESSAGE_TEXT;
        SET p_eliminado = 0;
        SET p_mensaje = CONCAT('Error SQL: ', @error_message);
    END;
    
    -- Inicializar OUT params
    SET p_eliminado = 0;
    SET p_mensaje = 'Iniciando eliminación';
    
    -- 1. Verificar que el usuario existe
    SELECT COUNT(*) INTO v_existe
    FROM TblUsuarios
    WHERE num_documento = p_num_documento;
    
    IF v_existe = 0 THEN
        SET p_mensaje = CONCAT('Usuario con documento ', p_num_documento, ' no existe');
    ELSE
        -- Obtener nombre para el mensaje
        SELECT CONCAT(nombres, ' ', apellido_paterno, ' ', COALESCE(apellido_materno, ''))
        INTO v_nombre_completo
        FROM TblPersona
        WHERE num_documento = p_num_documento;
        
        -- 2. Verificar si tiene hijos en la jerarquía
        SELECT COUNT(*) INTO v_tiene_hijos
        FROM TblJerarquiaUsuarios
        WHERE num_documento_padre COLLATE utf8mb4_unicode_ci = p_num_documento COLLATE utf8mb4_unicode_ci;
        
        IF v_tiene_hijos > 0 THEN
            SET p_mensaje = CONCAT('No se puede eliminar. El usuario tiene ', v_tiene_hijos, ' subordinados en la jerarquía');
        ELSE
            -- 3. Proceder a eliminar (orden importante por FK)
            START TRANSACTION;
            
            -- Primero: Eliminar de TblJerarquiaUsuarios
            DELETE FROM TblJerarquiaUsuarios
            WHERE num_documento COLLATE utf8mb4_unicode_ci = p_num_documento COLLATE utf8mb4_unicode_ci;
            
            -- Segundo: Eliminar de TblUsuarios
            DELETE FROM TblUsuarios
            WHERE num_documento = p_num_documento;
            
            -- Tercero: Eliminar de TblPersona
            DELETE FROM TblPersona
            WHERE num_documento = p_num_documento;
            
            COMMIT;
            
            SET p_eliminado = 1;
            SET p_mensaje = CONCAT('Usuario "', v_nombre_completo, '" eliminado exitosamente');
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_InsertarCliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_InsertarCliente`(
    -- Datos personales (para TblPersona)
    IN p_num_documento VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_apellido_paterno VARCHAR(100),
    IN p_apellido_materno VARCHAR(100),
    IN p_fecha_nacimiento DATE,
    IN p_genero CHAR(1),
    IN p_estado_civil ENUM('Soltero','Casado','Divorciado','Viudo','Conviviente'),
    IN p_email VARCHAR(150),
    IN p_celular VARCHAR(20),
    IN p_direccion VARCHAR(250),
    IN p_id_distrito INT,
    -- Datos de gestión comercial (para TblClientes)
    IN p_num_documento_asesor VARCHAR(20),
    IN p_id_fuente_contacto INT,
    IN p_id_proyecto INT,
    IN p_id_estado_prospeccion INT,
    IN p_id_tipo_compra INT,
    IN p_estado VARCHAR(20),
    IN p_fecha_proximo_seguimiento DATETIME,
    IN p_prioridad VARCHAR(20),
    IN p_observaciones TEXT,
    IN p_creado_por VARCHAR(20),
    OUT p_id_cliente INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_existe_persona INT DEFAULT 0;
    DECLARE v_existe_cliente INT DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_id_cliente = 0;
        SET p_mensaje = 'Error al insertar el cliente';
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Verificar si ya existe en TblPersona
    SELECT COUNT(*) INTO v_existe_persona
    FROM TblPersona 
    WHERE num_documento = p_num_documento;
    
    -- Verificar si ya existe en TblClientes
    SELECT COUNT(*) INTO v_existe_cliente
    FROM TblClientes 
    WHERE num_documento = p_num_documento;
    
    IF v_existe_cliente > 0 THEN
        SET p_id_cliente = 0;
        SET p_mensaje = 'Este documento ya está registrado como cliente';
        ROLLBACK;
    ELSE
        -- Si no existe en TblPersona, insertar los datos personales
        IF v_existe_persona = 0 THEN
            INSERT INTO TblPersona (
                num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
                fecha_nacimiento, genero, estado_civil,
                email, celular, direccion, id_distrito
            ) VALUES (
                p_num_documento, p_tipo_documento, p_nombres, p_apellido_paterno, p_apellido_materno,
                p_fecha_nacimiento, p_genero, p_estado_civil,
                p_email, p_celular, p_direccion, p_id_distrito
            );
        END IF;
        
        -- Insertar en TblClientes (solo datos de gestión comercial)
        INSERT INTO TblClientes (
            num_documento,
            num_documento_asesor,
            id_fuente_contacto,
            id_proyecto,
            id_estado_prospeccion,
            id_tipo_compra,
            estado,
            fecha_proximo_seguimiento,
            prioridad,
            observaciones,
            creado_por
        ) VALUES (
            p_num_documento,
            p_num_documento_asesor,
            p_id_fuente_contacto,
            p_id_proyecto,
            p_id_estado_prospeccion,
            p_id_tipo_compra,
            p_estado,
            p_fecha_proximo_seguimiento,
            p_prioridad,
            p_observaciones,
            p_creado_por
        );

        SET p_id_cliente = LAST_INSERT_ID();
        SET p_mensaje = 'Cliente registrado exitosamente';
        COMMIT;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarAsesores` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarAsesores`()
BEGIN
    SELECT 
        u.usuario,
        u.id_rol,
        r.nombre as rol_nombre,
        r.descripcion as rol_descripcion,
        u.id_cargo,
        c.nombre as cargo_nombre,
        c.id_area,
        a.nombre as area_nombre,
        a.nombre_resumen as area_resumen,
        u.estado,
        u.fecha_registro,
        p.num_documento,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        p.email,
        p.celular,
        p.numero_emergencia,
        p.genero,
        p.direccion,
        p.fecha_nacimiento,
        p.estado_civil,
        p.tipo_documento,
        p.id_distrito,
        CONCAT(p.nombres, ' ', p.apellido_paterno, ' ', COALESCE(p.apellido_materno, '')) as nombre_completo,
        COALESCE(j.nivel, 0) as nivel,
        j.num_documento_padre,
        CASE 
            WHEN j.num_documento_padre IS NOT NULL 
            THEN CONCAT(pp.nombres, ' ', pp.apellido_paterno, ' ', COALESCE(pp.apellido_materno, ''))
            ELSE NULL
        END as nombre_padre,
        up.usuario as usuario_padre
    FROM TblUsuarios u
    INNER JOIN TblPersona p ON u.num_documento COLLATE utf8mb4_unicode_ci = p.num_documento COLLATE utf8mb4_unicode_ci
    INNER JOIN TblRol r ON u.id_rol = r.id_rol
    LEFT JOIN TblCargos c ON u.id_cargo = c.id_cargo
    LEFT JOIN TblAreas a ON c.id_area = a.id_area
    LEFT JOIN TblJerarquiaUsuarios j ON u.num_documento COLLATE utf8mb4_unicode_ci = j.num_documento COLLATE utf8mb4_unicode_ci
    LEFT JOIN TblPersona pp ON j.num_documento_padre COLLATE utf8mb4_unicode_ci = pp.num_documento COLLATE utf8mb4_unicode_ci
    LEFT JOIN TblUsuarios up ON j.num_documento_padre COLLATE utf8mb4_unicode_ci = up.num_documento COLLATE utf8mb4_unicode_ci
    ORDER BY u.fecha_registro DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarClientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarClientes`(
    IN p_num_documento_asesor VARCHAR(20)
)
BEGIN
    SELECT 
        c.id_cliente,
        c.num_documento,
        p.tipo_documento,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        CONCAT(p.nombres, ' ', p.apellido_paterno, ' ', COALESCE(p.apellido_materno, '')) AS nombre_completo,
        p.fecha_nacimiento,
        p.genero,
        p.estado_civil,
        p.email,
        p.celular,
        p.direccion,
        d.nombre AS distrito,
        pr.nombre AS provincia,
        dep.nombre AS departamento,
        c.num_documento_asesor,
        CONCAT(pa.nombres, ' ', pa.apellido_paterno) AS nombre_asesor,
        fc.nombre AS fuente_contacto,
        proy.nombre AS proyecto,
        ep.nombre AS estado_prospeccion,
        tc.nombre AS tipo_compra,
        c.estado,
        c.fecha_proximo_seguimiento,
        c.prioridad,
        c.observaciones,
        c.fecha_creacion
    FROM TblClientes c
    INNER JOIN TblPersona p ON c.num_documento = p.num_documento
    LEFT JOIN TblDistritos d ON p.id_distrito = d.id_distrito
    LEFT JOIN TblProvincias pr ON d.id_provincia = pr.id_provincia
    LEFT JOIN TblDepartamentos dep ON pr.id_departamento = dep.id_departamento
    LEFT JOIN TblPersona pa ON c.num_documento_asesor = pa.num_documento
    LEFT JOIN TblFuenteContacto fc ON c.id_fuente_contacto = fc.id_fuente_contacto
    LEFT JOIN TblProyectos proy ON c.id_proyecto = proy.id_proyecto
    LEFT JOIN TblEstadoProspeccion ep ON c.id_estado_prospeccion = ep.id_estado_prospeccion
    LEFT JOIN TblTipoCompra tc ON c.id_tipo_compra = tc.id_tipo_compra
    WHERE c.num_documento_asesor = p_num_documento_asesor
    ORDER BY c.fecha_creacion DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarClientesPorAsesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarClientesPorAsesor`(
    IN p_num_documento_asesor VARCHAR(20)
)
BEGIN
    SELECT 
        c.id_cliente,
        c.num_documento,
        c.tipo_documento,
        CONCAT(c.nombres, ' ', c.apellido_paterno, ' ', IFNULL(c.apellido_materno, '')) AS nombre_completo,
        c.email,
        c.celular,
        c.tipo_cliente,
        c.interes,
        c.estado,
        c.fecha_proximo_seguimiento,
        c.prioridad,
        c.presupuesto_min,
        c.presupuesto_max,
        CONCAT(p.nombres, ' ', p.apellido_paterno) AS nombre_asesor,
        c.fecha_creacion,
        c.observaciones
    FROM TblClientes c
    LEFT JOIN TblPersona p ON c.num_documento_asesor = p.num_documento COLLATE utf8mb4_unicode_ci
    WHERE c.num_documento_asesor = p_num_documento_asesor COLLATE utf8mb4_unicode_ci
    ORDER BY 
        CASE c.prioridad
            WHEN 'Urgente' THEN 1
            WHEN 'Alta' THEN 2
            WHEN 'Media' THEN 3
            WHEN 'Baja' THEN 4
        END,
        c.fecha_proximo_seguimiento ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarEstadosProspeccion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarEstadosProspeccion`()
BEGIN
    SELECT 
        id_estado_prospeccion AS id,
        nombre
    FROM TblEstadoProspeccion
    WHERE activo = TRUE
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarFuentesContacto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarFuentesContacto`()
BEGIN
    SELECT 
        id_fuente_contacto AS id,
        nombre
    FROM TblFuenteContacto
    WHERE activo = TRUE
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarProyectos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarProyectos`()
BEGIN
    SELECT 
        id_proyecto AS id,
        nombre
    FROM TblProyectos
    WHERE activo = TRUE
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarTiposCompra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarTiposCompra`()
BEGIN
    SELECT 
        id_tipo_compra AS id,
        nombre
    FROM TblTipoCompra
    WHERE activo = TRUE
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ListarTodosLosClientes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ListarTodosLosClientes`()
BEGIN
    SELECT 
        c.id_cliente,
        c.num_documento,
        p.tipo_documento,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        CONCAT(p.nombres, ' ', p.apellido_paterno, ' ', COALESCE(p.apellido_materno, '')) AS nombre_completo,
        p.fecha_nacimiento,
        p.genero,
        p.estado_civil,
        p.email,
        p.celular,
        p.direccion,
        d.nombre AS distrito,
        pr.nombre AS provincia,
        dep.nombre AS departamento,
        c.num_documento_asesor,
        CONCAT(pa.nombres, ' ', pa.apellido_paterno) AS nombre_asesor,
        fc.nombre AS fuente_contacto,
        proy.nombre AS proyecto,
        ep.nombre AS estado_prospeccion,
        tc.nombre AS tipo_compra,
        c.estado,
        c.fecha_proximo_seguimiento,
        c.prioridad,
        c.observaciones,
        c.fecha_creacion
    FROM TblClientes c
    INNER JOIN TblPersona p ON c.num_documento = p.num_documento
    LEFT JOIN TblDistritos d ON p.id_distrito = d.id_distrito
    LEFT JOIN TblProvincias pr ON d.id_provincia = pr.id_provincia
    LEFT JOIN TblDepartamentos dep ON pr.id_departamento = dep.id_departamento
    LEFT JOIN TblPersona pa ON c.num_documento_asesor = pa.num_documento
    LEFT JOIN TblFuenteContacto fc ON c.id_fuente_contacto = fc.id_fuente_contacto
    LEFT JOIN TblProyectos proy ON c.id_proyecto = proy.id_proyecto
    LEFT JOIN TblEstadoProspeccion ep ON c.id_estado_prospeccion = ep.id_estado_prospeccion
    LEFT JOIN TblTipoCompra tc ON c.id_tipo_compra = tc.id_tipo_compra
    ORDER BY c.fecha_creacion DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerAsesorPorDocumento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ObtenerAsesorPorDocumento`(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        -- Datos de usuario
        u.usuario,
        u.id_rol,
        r.nombre as rol_nombre,
        u.id_cargo,
        c.nombre as cargo_nombre,
        c.id_area,
        a.nombre as area_nombre,
        u.estado as usuario_estado,
        
        -- Datos de persona
        p.num_documento,
        p.tipo_documento,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        p.email,
        p.celular,
        p.numero_emergencia,
        p.genero,
        p.direccion,
        p.fecha_nacimiento,
        p.estado_civil,
        p.id_distrito,
        
        -- Datos de ubicación
        d.nombre as distrito_nombre,
        d.id_provincia,
        pr.nombre as provincia_nombre,
        pr.id_departamento,
        dp.nombre as departamento_nombre,
        
        -- Datos de jerarquía
        COALESCE(j.nivel, 0) as nivel,
        j.num_documento_padre,
        CASE 
            WHEN j.num_documento_padre IS NOT NULL 
            THEN CONCAT(pp.nombres, ' ', pp.apellido_paterno, ' ', COALESCE(pp.apellido_materno, ''))
            ELSE NULL
        END as nombre_padre
        
    FROM TblUsuarios u
    INNER JOIN TblPersona p ON u.num_documento = p.num_documento
    INNER JOIN TblRol r ON u.id_rol = r.id_rol
    LEFT JOIN TblCargos c ON u.id_cargo = c.id_cargo
    LEFT JOIN TblAreas a ON c.id_area = a.id_area
    LEFT JOIN TblDistritos d ON p.id_distrito = d.id_distrito
    LEFT JOIN TblProvincias pr ON d.id_provincia = pr.id_provincia
    LEFT JOIN TblDepartamentos dp ON pr.id_departamento = dp.id_departamento
    LEFT JOIN TblJerarquiaUsuarios j ON u.num_documento = j.num_documento
    LEFT JOIN TblPersona pp ON j.num_documento_padre = pp.num_documento
    WHERE u.num_documento = p_num_documento
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerDatosEdicionAsesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ObtenerDatosEdicionAsesor`(
    IN p_num_documento VARCHAR(20)
)
BEGIN
    SELECT 
        -- Datos de usuario
        u.usuario,
        u.id_rol,
        r.nombre as rol_nombre,
        u.id_cargo,
        c.nombre as cargo_nombre,
        c.id_area,
        a.nombre as area_nombre,
        u.estado as usuario_estado,
        
        -- Datos de persona
        p.num_documento,
        p.tipo_documento,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        p.email,
        p.celular,
        p.numero_emergencia,
        p.genero,
        p.direccion,
        p.fecha_nacimiento,
        p.estado_civil,
        p.id_distrito,
        
        -- Datos de ubicación (pre-calculados)
        d.nombre as distrito_nombre,
        d.id_provincia,
        pr.nombre as provincia_nombre,
        pr.id_departamento,
        dp.nombre as departamento_nombre,
        
        -- Datos de jerarquía
        COALESCE(j.nivel, 0) as nivel,
        j.num_documento_padre,
        CASE 
            WHEN j.num_documento_padre IS NOT NULL 
            THEN CONCAT(pp.nombres, ' ', pp.apellido_paterno, ' ', COALESCE(pp.apellido_materno, ''))
            ELSE NULL
        END as nombre_padre
        
    FROM TblUsuarios u
    INNER JOIN TblPersona p ON u.num_documento COLLATE utf8mb4_unicode_ci = p.num_documento COLLATE utf8mb4_unicode_ci
    INNER JOIN TblRol r ON u.id_rol = r.id_rol
    LEFT JOIN TblCargos c ON u.id_cargo = c.id_cargo
    LEFT JOIN TblAreas a ON c.id_area = a.id_area
    LEFT JOIN TblDistritos d ON p.id_distrito = d.id_distrito
    LEFT JOIN TblProvincias pr ON d.id_provincia = pr.id_provincia
    LEFT JOIN TblDepartamentos dp ON pr.id_departamento = dp.id_departamento
    LEFT JOIN TblJerarquiaUsuarios j ON u.num_documento COLLATE utf8mb4_unicode_ci = j.num_documento COLLATE utf8mb4_unicode_ci
    LEFT JOIN TblPersona pp ON j.num_documento_padre COLLATE utf8mb4_unicode_ci = pp.num_documento COLLATE utf8mb4_unicode_ci
    WHERE u.num_documento = p_num_documento
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerDepartamentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ObtenerDepartamentos`()
BEGIN
    SELECT id_departamento, nombre
    FROM TblDepartamentos
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerDistritos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ObtenerDistritos`(
    IN p_id_provincia INT
)
BEGIN
    SELECT id_distrito, nombre, id_provincia
    FROM TblDistritos
    WHERE id_provincia = p_id_provincia
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerProvincias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ObtenerProvincias`(
    IN p_id_departamento INT
)
BEGIN
    SELECT id_provincia, nombre, id_departamento
    FROM TblProvincias
    WHERE id_departamento = p_id_departamento
    ORDER BY nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerUsuarioPorDocumento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ObtenerUsuarioPorDocumento`(
    IN p_num_documento VARCHAR(20)
)
    READS SQL DATA
    COMMENT 'Obtiene información completa del usuario por documento'
BEGIN
    SELECT 
        u.num_documento,
        u.usuario,
        u.rol,
        u.estado,
        u.ultimo_acceso,
        u.intentos_fallidos,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        p.email,
        p.celular,
        p.direccion,
        p.distrito,
        p.provincia,
        p.departamento,
        p.pais
    FROM TblUsuarios u
    INNER JOIN TblPersona p ON u.num_documento = p.num_documento
    WHERE u.num_documento = p_num_documento;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegistrarAsesor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RegistrarAsesor`(
    IN p_num_documento VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_apellido_paterno VARCHAR(100),
    IN p_apellido_materno VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_celular VARCHAR(20),
    IN p_numero_emergencia VARCHAR(20),
    IN p_direccion VARCHAR(200),
    IN p_id_distrito INT,
    IN p_genero VARCHAR(20),
    IN p_usuario VARCHAR(50),
    IN p_password_hash VARCHAR(255),
    IN p_id_rol INT,
    IN p_id_cargo INT,
    OUT p_registrado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_registrado = 0;
        SET p_mensaje = 'Error al registrar el asesor';
    END;
    
    -- Verificar si el documento ya existe
    IF EXISTS(SELECT 1 FROM TblPersona WHERE num_documento = p_num_documento) THEN
        SET p_registrado = 0;
        SET p_mensaje = 'Este número de documento ya está registrado';
    -- Verificar si el usuario ya existe
    ELSEIF EXISTS(SELECT 1 FROM TblUsuarios WHERE usuario = p_usuario) THEN
        SET p_registrado = 0;
        SET p_mensaje = CONCAT('El usuario ', p_usuario, ' ya existe en el sistema');
    -- Verificar si el rol existe
    ELSEIF NOT EXISTS(SELECT 1 FROM TblRol WHERE id_rol = p_id_rol AND estado = 'Activo') THEN
        SET p_registrado = 0;
        SET p_mensaje = 'El rol seleccionado no existe o está inactivo';
    -- Verificar si el cargo existe
    ELSEIF NOT EXISTS(SELECT 1 FROM TblCargos WHERE id_cargo = p_id_cargo AND estado = 'Activo') THEN
        SET p_registrado = 0;
        SET p_mensaje = 'El cargo seleccionado no existe o está inactivo';
    ELSE
        -- Iniciar transacción
        START TRANSACTION;
        
        -- Insertar en TblPersona
        INSERT INTO TblPersona (
            num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
            email, celular, numero_emergencia, direccion, id_distrito, genero,
            estado, fecha_registro
        ) VALUES (
            p_num_documento, p_tipo_documento, p_nombres, p_apellido_paterno, p_apellido_materno,
            p_email, p_celular, p_numero_emergencia, p_direccion, p_id_distrito, p_genero,
            'Activo', NOW()
        );
        
        -- Insertar en TblUsuarios (con id_rol e id_cargo)
        INSERT INTO TblUsuarios (
            num_documento, usuario, password_hash, id_rol, id_cargo, rol, estado,
            fecha_registro, ultimo_acceso, intentos_fallidos
        ) VALUES (
            p_num_documento, p_usuario, p_password_hash, p_id_rol, p_id_cargo,
            (SELECT nombre FROM TblRol WHERE id_rol = p_id_rol),
            'Activo', NOW(), NULL, 0
        );
        
        -- Confirmar transacción
        COMMIT;
        
        SET p_registrado = 1;
        SET p_mensaje = CONCAT('Asesor ', p_nombres, ' registrado exitosamente');
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegistrarAsesorPorNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RegistrarAsesorPorNombre`(
    IN p_num_documento VARCHAR(20),
    IN p_tipo_documento VARCHAR(20),
    IN p_nombres VARCHAR(100),
    IN p_apellido_paterno VARCHAR(100),
    IN p_apellido_materno VARCHAR(100),
    IN p_fecha_nacimiento DATE,              -- NUEVO
    IN p_estado_civil VARCHAR(20),           -- NUEVO
    IN p_email VARCHAR(100),
    IN p_celular VARCHAR(20),
    IN p_numero_emergencia VARCHAR(20),
    IN p_direccion VARCHAR(200),
    IN p_id_distrito INT,  
    IN p_genero VARCHAR(20),
    IN p_usuario VARCHAR(50),
    IN p_password_hash VARCHAR(255),
    IN p_rol_nombre VARCHAR(50),
    IN p_cargo_nombre VARCHAR(100),
    IN p_num_documento_creador VARCHAR(20),  -- Documento del usuario que crea (padre)
    OUT p_registrado INT,
    OUT p_mensaje VARCHAR(255)
)
BEGIN
    DECLARE v_id_rol INT;
    DECLARE v_id_cargo INT;
    DECLARE v_nivel_padre INT;
    DECLARE v_nivel_hijo INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 
            p_mensaje = MESSAGE_TEXT;
        SET p_registrado = 0;
        SET p_mensaje = CONCAT('Error SQL: ', p_mensaje);
    END;
    
    -- Verificar si el distrito existe
    IF NOT EXISTS(SELECT 1 FROM TblDistritos WHERE id_distrito = p_id_distrito) THEN
        SET p_registrado = 0;
        SET p_mensaje = CONCAT('El distrito con ID ', p_id_distrito, ' no existe');
    ELSE
        -- Buscar ID del rol por nombre
        SELECT id_rol INTO v_id_rol
        FROM TblRol
        WHERE UPPER(TRIM(nombre)) = UPPER(TRIM(p_rol_nombre))
          AND estado = 'Activo'
        LIMIT 1;
        
        IF v_id_rol IS NULL THEN
            SET p_registrado = 0;
            SET p_mensaje = CONCAT('Rol "', p_rol_nombre, '" no encontrado o está inactivo');
        ELSE
            -- Buscar ID del cargo por nombre
            SELECT id_cargo INTO v_id_cargo
            FROM TblCargos
            WHERE UPPER(TRIM(nombre)) = UPPER(TRIM(p_cargo_nombre))
              AND estado = 'Activo'
            LIMIT 1;
            
            IF v_id_cargo IS NULL THEN
                SET p_registrado = 0;
                SET p_mensaje = CONCAT('Cargo "', p_cargo_nombre, '" no encontrado o está inactivo');
            ELSE
                -- Verificar si el documento ya existe
                IF EXISTS(SELECT 1 FROM TblPersona WHERE num_documento = p_num_documento) THEN
                    SET p_registrado = 0;
                    SET p_mensaje = 'Este número de documento ya está registrado';
                -- Verificar si el email ya existe
                ELSEIF EXISTS(SELECT 1 FROM TblPersona WHERE email = p_email) THEN
                    SET p_registrado = 0;
                    SET p_mensaje = 'Este email ya está registrado';
                -- Verificar si el usuario ya existe
                ELSEIF EXISTS(SELECT 1 FROM TblUsuarios WHERE usuario = p_usuario) THEN
                    SET p_registrado = 0;
                    SET p_mensaje = CONCAT('El usuario "', p_usuario, '" ya existe en el sistema');
                ELSE
                    -- *** LÓGICA DE NIVELES DE JERARQUÍA ***
                    -- Si no hay creador/padre, el nivel es 0 (nivel más alto)
                    IF p_num_documento_creador IS NULL OR p_num_documento_creador = '' THEN
                        SET v_nivel_hijo = 0;  -- NIVEL 0 cuando no hay padre
                        SET p_num_documento_creador = NULL;
                    ELSE
                        -- Verificar que el padre existe
                        IF NOT EXISTS(SELECT 1 FROM TblUsuarios WHERE num_documento = p_num_documento_creador) THEN
                            SET p_registrado = 0;
                            SET p_mensaje = CONCAT('El usuario padre con documento "', p_num_documento_creador, '" no existe');
                        ELSE
                            -- Obtener nivel del padre
                            SELECT nivel INTO v_nivel_padre
                            FROM TblJerarquiaUsuarios
                            WHERE num_documento COLLATE utf8mb4_0900_ai_ci = p_num_documento_creador COLLATE utf8mb4_0900_ai_ci
                            LIMIT 1;
                            
                            -- Si el padre no tiene nivel asignado, darle nivel 0
                            IF v_nivel_padre IS NULL THEN
                                SET v_nivel_padre = 0;
                                -- Insertar al padre en la jerarquía si no existe
                                INSERT INTO TblJerarquiaUsuarios (num_documento, nivel, num_documento_padre)
                                VALUES (p_num_documento_creador, 0, NULL)
                                ON DUPLICATE KEY UPDATE nivel = 0;
                            END IF;
                            
                            -- El hijo es nivel padre + 1
                            SET v_nivel_hijo = v_nivel_padre + 1;
                        END IF;
                    END IF;
                    
                    -- Solo continuar si no hay errores
                    IF p_registrado IS NULL THEN
                        -- Iniciar transacción
                        START TRANSACTION;
                        
                        -- Insertar en TblPersona (INCLUYENDO NUEVOS CAMPOS)
                        INSERT INTO TblPersona (
                            num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
                            fecha_nacimiento, estado_civil,  -- NUEVOS CAMPOS
                            email, celular, numero_emergencia, direccion, id_distrito, genero,
                            estado, fecha_registro
                        ) VALUES (
                            p_num_documento, p_tipo_documento, p_nombres, p_apellido_paterno, p_apellido_materno,
                            p_fecha_nacimiento, p_estado_civil,  -- NUEVOS VALORES
                            p_email, p_celular, p_numero_emergencia, p_direccion, p_id_distrito, p_genero,
                            'Activo', NOW()
                        );
                        
                        -- Insertar en TblUsuarios
                        INSERT INTO TblUsuarios (
                            num_documento, usuario, password_hash, id_rol, id_cargo,
                            estado, fecha_registro
                        ) VALUES (
                            p_num_documento, p_usuario, p_password_hash, v_id_rol, v_id_cargo,
                            'Activo', NOW()
                        );
                        
                        -- Insertar en jerarquía
                        INSERT INTO TblJerarquiaUsuarios (
                            num_documento, nivel, num_documento_padre
                        ) VALUES (
                            p_num_documento, v_nivel_hijo, p_num_documento_creador
                        );
                        
                        -- Confirmar transacción
                        COMMIT;
                        
                        SET p_registrado = 1;
                        SET p_mensaje = CONCAT('Asesor registrado exitosamente con nivel ', v_nivel_hijo);
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegistrarLoginExitoso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RegistrarLoginExitoso`(
    IN p_num_documento VARCHAR(20),
    OUT p_resultado INT
)
    MODIFIES SQL DATA
    COMMENT 'Registra un login exitoso: resetea intentos y actualiza ultimo_acceso'
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_resultado = 0;
    END;
    UPDATE TblUsuarios 
    SET 
        intentos_fallidos = 0,
        ultimo_acceso = NOW()
    WHERE num_documento = p_num_documento;
    IF ROW_COUNT() > 0 THEN
        SET p_resultado = 1;
    ELSE
        SET p_resultado = 0;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_RegistrarLoginFallido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_RegistrarLoginFallido`(
    IN p_num_documento VARCHAR(20),
    OUT p_resultado INT,
    OUT p_intentos_restantes INT
)
    MODIFIES SQL DATA
    COMMENT 'Registra un intento fallido y bloquea si supera 5 intentos'
BEGIN
    DECLARE v_intentos INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_resultado = 0;
    END;
    SELECT intentos_fallidos INTO v_intentos
    FROM TblUsuarios
    WHERE num_documento = p_num_documento;
    SET v_intentos = v_intentos + 1;
    SET p_intentos_restantes = 5 - v_intentos;
    IF v_intentos >= 5 THEN
        UPDATE TblUsuarios 
        SET 
            intentos_fallidos = v_intentos,
            estado = 'Bloqueado'
        WHERE num_documento = p_num_documento;
    ELSE
        UPDATE TblUsuarios 
        SET intentos_fallidos = v_intentos
        WHERE num_documento = p_num_documento;
    END IF;
    IF ROW_COUNT() > 0 THEN
        SET p_resultado = 1;
    ELSE
        SET p_resultado = 0;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ValidarUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE PROCEDURE `sp_ValidarUsuario`(
    IN p_usuario VARCHAR(50),
    OUT p_existe INT,
    OUT p_num_documento VARCHAR(20),
    OUT p_password_hash VARCHAR(255),
    OUT p_rol VARCHAR(20),
    OUT p_estado VARCHAR(20),
    OUT p_intentos_fallidos INT,
    OUT p_nombres VARCHAR(100),
    OUT p_apellido_paterno VARCHAR(100),
    OUT p_apellido_materno VARCHAR(100),
    OUT p_email VARCHAR(100)
)
    READS SQL DATA
    COMMENT 'Valida usuario y obtiene información'
BEGIN
    SELECT 
        1,
        u.num_documento,
        u.password_hash,
        u.rol,
        u.estado,
        u.intentos_fallidos,
        p.nombres,
        p.apellido_paterno,
        p.apellido_materno,
        p.email
    INTO 
        p_existe,
        p_num_documento,
        p_password_hash,
        p_rol,
        p_estado,
        p_intentos_fallidos,
        p_nombres,
        p_apellido_paterno,
        p_apellido_materno,
        p_email
    FROM TblUsuarios u
    INNER JOIN TblPersona p ON u.num_documento = p.num_documento
    WHERE u.usuario = p_usuario;
    IF p_existe IS NULL THEN
        SET p_existe = 0;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-24 17:54:03

