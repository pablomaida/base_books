-- MySQL Script generated by MySQL Workbench
-- Sat May 20 14:27:25 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema deer
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `deer` ;

-- -----------------------------------------------------
-- Schema deer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `deer` DEFAULT CHARACTER SET utf8mb4 ;
USE `deer` ;

-- -----------------------------------------------------
-- Table `deer`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`funcionario` (
  `idFuncionario` INT(11) NOT NULL,
  `ciudades_idCiudades` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `cedula` VARCHAR(45) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `celular` INT NULL,
  PRIMARY KEY (`idFuncionario`))
  
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`ciudades` (
  `idCiudades` INT(11) NOT NULL,
  `departamentos_idDepartamentos` INT(11) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
 
  PRIMARY KEY (`idCiudades`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`carreras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`carreras` (
  `idCarreras` INT(11) NOT NULL,
  `semestre_idSemestre` INT(11) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idCarreras`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`Tipos_Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`Tipos_Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `deer`.`alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`alumnos` (
  `idalumnos` INT NOT NULL AUTO_INCREMENT,
  `ciudades_idCiudades` INT(11) NOT NULL,
  `carreras_idCarreras` INT(11) NOT NULL,
  `Tipos_Usuarios_idUsuarios` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `cedula` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `celular` INT NULL,
  PRIMARY KEY (`idalumnos`),
  CONSTRAINT `fk_alumnos_ciudades1`
    FOREIGN KEY (`ciudades_idCiudades`)
    REFERENCES `deer`.`ciudades` (`idCiudades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumnos_carreras1`
    FOREIGN KEY (`carreras_idCarreras`)
    REFERENCES `deer`.`carreras` (`idCarreras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumnos_Tipos_Usuarios1`
    FOREIGN KEY (`Tipos_Usuarios_idUsuarios`)
    REFERENCES `deer`.`Tipos_Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`pais` (
  `idPais` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`autor` (
  `idAutor` INT(11) NOT NULL,
  `pais_idPais` INT(11) NOT NULL,
  `autor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAutor`),
  CONSTRAINT `fk_autor_pais1`
    FOREIGN KEY (`pais_idPais`)
    REFERENCES `deer`.`pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`restricciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`restricciones` (
  `idrestricciones` INT NOT NULL,
  `cantidadmaxima` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idrestricciones`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`Tiempo_reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`Tiempo_reserva` (
  `idTiempo_reserva` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idTiempo_reserva`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `deer`.`solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`solicitudes` (
  `idSolicitudes` INT(11) NOT NULL,
  `Tipos_Usuarios_idUsuarios` INT NOT NULL,
  `Tiempo_reserva_idTiempo_reserva` INT NOT NULL,
  `funcionario_idFuncionario` INT(11) NOT NULL,
  PRIMARY KEY (`idSolicitudes`),
  CONSTRAINT `fk_solicitudes_Tipos_Usuarios1`
    FOREIGN KEY (`Tipos_Usuarios_idUsuarios`)
    REFERENCES `deer`.`Tipos_Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_Tiempo_reserva1`
    FOREIGN KEY (`Tiempo_reserva_idTiempo_reserva`)
    REFERENCES `deer`.`Tiempo_reserva` (`idTiempo_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitudes_funcionario1`
    FOREIGN KEY (`funcionario_idFuncionario`)
    REFERENCES `deer`.`funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`moderador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`moderador` (
  `idAprobados` INT NOT NULL AUTO_INCREMENT,
  `orden_salida_idOrden_salida` INT(11) NOT NULL,
  `solicitudes_idSolicitudes` INT(11) NOT NULL,
  `funcionario_idFuncionario` INT(11) NOT NULL,
  PRIMARY KEY (`idAprobados`),
  CONSTRAINT `fk_Aprobados_solicitudes1`
    FOREIGN KEY (`solicitudes_idSolicitudes`)
    REFERENCES `deer`.`solicitudes` (`idSolicitudes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_moderador_funcionario1`
    FOREIGN KEY (`funcionario_idFuncionario`)
    REFERENCES `deer`.`funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `deer`.`devueltos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`devueltos` (
  `idDevueltos` INT(11) NOT NULL,
  `orden_entrada_idOrden_entrada` INT(11) NOT NULL,
  `Aprobados_idAprobados` INT NOT NULL,
  `libro` VARCHAR(45) NOT NULL,
  `fecha_devuelto` DATE NOT NULL,
  PRIMARY KEY (`idDevueltos`),
  CONSTRAINT `fk_devueltos_Aprobados1`
    FOREIGN KEY (`Aprobados_idAprobados`)
    REFERENCES `deer`.`moderador` (`idAprobados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`editorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`editorial` (
  `idEditorial` INT(11) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEditorial`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`Categorias` (
  `idCategorias` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idCategorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `deer`.`libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`libros` (
  `idLibros` INT(11) NOT NULL,
  `Categorias_idCategorias` INT NOT NULL,
  `restricciones_idrestricciones` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idLibros`),
  CONSTRAINT `fk_libros_Categorias1`
    FOREIGN KEY (`Categorias_idCategorias`)
    REFERENCES `deer`.`Categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_libros_restricciones1`
    FOREIGN KEY (`restricciones_idrestricciones`)
    REFERENCES `deer`.`restricciones` (`idrestricciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`profesores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`profesores` (
  `idProfesores` INT(11) NOT NULL,
  `Tipos_Usuarios_idUsuarios` INT NOT NULL,
  `ciudades_idCiudades` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `cedula` VARCHAR(45) NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `celular` INT NULL,
  PRIMARY KEY (`idProfesores`),
  CONSTRAINT `fk_profesores_Tipos_Usuarios1`
    FOREIGN KEY (`Tipos_Usuarios_idUsuarios`)
    REFERENCES `deer`.`Tipos_Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profesores_ciudades1`
    FOREIGN KEY (`ciudades_idCiudades`)
    REFERENCES `deer`.`ciudades` (`idCiudades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`rol` (
  `idRol` INT(11) NOT NULL,
  `funcionario_idFuncionario` INT(11) NOT NULL,
  PRIMARY KEY (`idRol`),
  CONSTRAINT `fk_rol_funcionario1`
    FOREIGN KEY (`funcionario_idFuncionario`)
    REFERENCES `deer`.`funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`Materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`Materias` (
  `idMaterias` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMaterias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `deer`.`detallesolicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`detallesolicitud` (
  `libros_idLibros` INT(11) NOT NULL,
  `solicitudes_idSolicitudes` INT(11) NOT NULL,
  `Materias_idMaterias` INT NOT NULL,
  PRIMARY KEY (`libros_idLibros`, `solicitudes_idSolicitudes`),
  CONSTRAINT `fk_libros_has_solicitudes_libros1`
    FOREIGN KEY (`libros_idLibros`)
    REFERENCES `deer`.`libros` (`idLibros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_libros_has_solicitudes_solicitudes1`
    FOREIGN KEY (`solicitudes_idSolicitudes`)
    REFERENCES `deer`.`solicitudes` (`idSolicitudes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detallesolicitud_Materias1`
    FOREIGN KEY (`Materias_idMaterias`)
    REFERENCES `deer`.`Materias` (`idMaterias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`detalleautores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`detalleautores` (
  `autor_idAutor` INT(11) NOT NULL,
  `libros_idLibros` INT(11) NOT NULL,
  PRIMARY KEY (`autor_idAutor`, `libros_idLibros`),
  CONSTRAINT `fk_autor_has_libros_autor1`
    FOREIGN KEY (`autor_idAutor`)
    REFERENCES `deer`.`autor` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autor_has_libros_libros1`
    FOREIGN KEY (`libros_idLibros`)
    REFERENCES `deer`.`libros` (`idLibros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`detalleeditorial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`detalleeditorial` (
  `editorial_idEditorial` INT(11) NOT NULL,
  `libros_idLibros` INT(11) NOT NULL,
  PRIMARY KEY (`editorial_idEditorial`, `libros_idLibros`),
  CONSTRAINT `fk_editorial_has_libros_editorial1`
    FOREIGN KEY (`editorial_idEditorial`)
    REFERENCES `deer`.`editorial` (`idEditorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_editorial_has_libros_libros1`
    FOREIGN KEY (`libros_idLibros`)
    REFERENCES `deer`.`libros` (`idLibros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `deer`.`detalledevolucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `deer`.`detalledevolucion` (
  `devueltos_idDevueltos` INT(11) NOT NULL,
  `libros_idLibros` INT(11) NOT NULL,
  PRIMARY KEY (`devueltos_idDevueltos`, `libros_idLibros`),
  CONSTRAINT `fk_devueltos_has_libros_devueltos1`
    FOREIGN KEY (`devueltos_idDevueltos`)
    REFERENCES `deer`.`devueltos` (`idDevueltos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_devueltos_has_libros_libros1`
    FOREIGN KEY (`libros_idLibros`)
    REFERENCES `deer`.`libros` (`idLibros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;





SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
