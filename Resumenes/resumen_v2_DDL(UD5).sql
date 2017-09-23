--DDL--

--Crear base de Datos--
CREATE DATABASE prueba;
Pero normalmente se indican más parámetros. Ejemplo (parámetros de Oracle)
CREATE DATABASE prueba
LOGFILE prueba.log
MAXLOGFILES 25
MAXINSTANCES 10
ARCHIVELOG
CHARACTER SET WIN1214
NATIONAL CHARACTER SET UTF8
DATAFILE prueba1.dbf AUTOEXTEND ON MAXSIZE 500MB;

--Crear Tabla--
CREATE TABLE <nombre de tabla>
(nombre_columna1 tipo [restricción de columna],
........
nombre_columnaN tipo [restricción de columna],
[restricción_de_tabla]);

CREATE TABLE FACTURA
(
REFERENCIA VARCHAR2(10) NOT NULL,
DESCRIPCION VARCHAR2(50),
C_PAIS NUMBER(3),
C_CLIENTE NUMBER(5),
IMPORTE NUMBER(12),
CONSTRAINT PK_FACTURA PRIMARY KEY( REFERENCIA )
CONSTRAINT FK_CLIENTE(C_CLIENTE)
REFERENCES CLIENTE(C_CLIENTE) ON DELETE CASCADE
);

--Listar estructura de tabla --
DESCRIBE nombre_tabla;
desc nombre_tabla;

--Default --
CREATE TABLE articulo (
cod NUMBER(7), nombre VARCHAR2(25),
precio NUMBER(11,2) DEFAULT 3.5);

--Restricciones --
NN. NOT NULL.
PK. PRIMARY KEY
UK. UNIQUE
FK. FOREIGN KEY
CK. CHECK (validación)

CREATE TABLE cliente(
dni VARCHAR2(9) CONSTRAINT cli_dni_nn NOT NULL
);

CREATE TABLE cliente(
dni VARCHAR2(9) CONSTRAINT cli_dni_uk UNIQUE);

CREATE TABLE alquiler
(dni VARCHAR2(9),
cod_pelicula NUMBER(5),
CONSTRAINT alquiler_uk UNIQUE(dni,cod_pelicula) ;

CREATE TABLE cliente(
dni VARCHAR(9) CONSTRAINT CLI_DNI_PK PRIMARY KEY,
nombre VARCHAR(50)) ;

CREATE TABLE ingresos(
cod NUMBER(5) PRIMARY KEY,
concepto VARCHAR2(40) NOT NULL,
importe NUMBER(11,2) CONSTRAINT importe_min CHECK (importe>0)
CONSTRAINT importe_max CHECK (importe<8000) );

CREATE TABLE alquiler(
dni VARCHAR2(9) CONSTRAINT alquiler_dni_fk REFERENCES clientes(dni),
cod_pelicula NUMBER(5) CONSTRAINT alquiler_pelicula_fk REFERENCES
peliculas(cod),
CONSTRAINT alquiler_pk PRIMARY KEY(dni,cod_pelicula)
);

CREATE TABLE existencias(
tipo CHAR2(9),
modelo NUMBER(3),
n_almacen NUMBER(1)
cantidad NUMBER(7),
CONSTRAINT exi_t_m_fk FOREIGN KEY(tipo,modelo) REFERENCES piezas,
CONSTRAINT exi_nal_fk FOREIGN KEY(n_almacen) REFERENCES almacenes,
CONSTRAINT exi_pk PRIMARY KEY(tipo,modelo,n_almacen)
);

Por ello se nos pueden ofrecer soluciones a añadir tras la cláusula REFERENCES. Son:
• ON DELETE SET NULL. Coloca nulos todas las claves secundarias relacionadas con
la borrada.
• ON DELETE CASCADE. Borra todos los registros cuya clave secundaria es igual que
la clave del registro borrado.
• ON DELETE SET DEFAULT. Coloca en el registro relacionado el valor por defecto en
la columna relacionada
• ON DELETE NOTHING. No hace nada.

en muchas bases de datos se admite el uso tanto
de ON DELETE como de ON UPDATE.
En la base de datos Oracle sólo se permite utilizar ON DELETE SET NULL u ON DELETE
CASCADE. No se admite el uso de ON UPDATE en ningún caso.

CREATE TABLE alquiler(
dni VARCHAR(9),
cod_pelicula NUMBER(5),
CONSTRAINT alquiler_pk PRIMARY KEY(dni,cod_pelicula),
CONSTRAINT alquiler_dni_fk FOREIGN KEY (dni) REFERENCES clientes(dni)
ON DELETE SET NULL,
CONSTRAINT alquiler_pelicula_fk FOREIGN KEY (cod_pelicula)
REFERENCES peliculas(cod) ON DELETE CASCADE
);

--Creando una tabla a partir de las filas de otra tabla--
CREATE TABLE dept_80
AS
SELECT emp_no, apellido, salario * 12 SALARIO_ANUAL, fecha_nac
FROM emple
WHERE dept_no = 80;

--Eliminar una tabla--
DROP TABLE table;
DROP TABLE nombretabla CASCADE CONSTRAINTS;

--Añadir columnas a una tabla--
ALTER TABLE emple ADD (dept_no varchar2(3) NOT NULL);
ALTER TABLE emple ADD (dept_no varchar2(3) DEFAULT '118');

--Borrar columnas en una tabla--
ALTER TABLE facturas DROP (fecha);
ALTER TABLE curso DROP(fecha_inicio) CASCADE CONSTRAINTS;

--Modificar columnas--
ALTER TABLE facturas MODIFY(fecha TIMESTAMP NOT NULL);

--Renombrar columnas--
ALTER TABLE facturas RENAME COLUMN fecha TO fechaYhora;

--Renombrar una tabla--
RENAME old_name_of_the_table TO new_name;

--Borrar el contenido de una tabla--
TRUNCATE TABLE tabla;

La sentencia DELETE también puede eliminar todas las filas de la tabla, pero esta sentencia
no libera el espacio almacenado.

--Añadir restricciones a una tabla existente--
ALTER TABLE Empleados
ADD CONSTRAINT emp_supervisor_fk FOREIGN KEY (supervisor_id)
REFERENCES Empleados;

--Borrar restricciones--
ALTER TABLE curso DROP PRIMARY KEY; --> como da error pq tiene clave ajena
ALTER TABLE curso DROP PRIMARY KEY CASCADE; --> tenemos que hacer esto
ALTER TABLE Empleados DROP CONSTRAINT emp_supervisor_fk;

ALTER TABLE Departamentos DROP PRIMARY KEY CASCADE;

--Desactivar restricciones--
ALTER TABLE Empleados
DISABLE CONSTRAINT emp_pk CASCADE;

--Activar restricciones
ALTER TABLE Empleados
ENABLE CONSTRAINT emp_pk;

--Cambiar de nombre a las restricciones
ALTER TABLE table
RENAME CONSTRAINT nombreViejo TO nombreNuevo;

--Tablas de usuario --  diccionario de datos
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONSTRAINTS;

USER_CONS_COLUMNS
ALL_CONSTRAINTS
ALL_CONS_COLUMNS














