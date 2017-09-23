--VISTAS

--CREATE VIEW
La sintaxis es:

CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view [(alias[, alias]...)]
AS subquery
[WITH CHECK OPTION [CONSTRAINT constraint]]
[WITH READ ONLY [CONSTRAINT constraint]];

La subconsulta puede contener sintaxis SELECT compleja.

En la sintaxis:
OR REPLACE vuelve a crear la vista si ésta existe.
FORCE crea la vista independientemente de si las tablas base existen o
no.

NOFORCE crea la vista sólo si las tablas base existen (es el valor por
defecto).

VIEW es el nombre de la vista.

alias Lista de alias que se establecen para las columnas devueltas
por la consulta SELECT en la que se basa esta vista. El número
de alias debe coincidir con el número de columnas devueltas
por SELECT .

subquery es una sentencia SELECT completa.

WITH CHECK OPTION especifica que sólo las filas accesibles a la vista se pueden
insertar o actualizar.

constraint es el nombre asignado a la restricción CHECK OPTION .

WITH READ ONLY asegura que no se puede realizar ninguna operación DML en
esta vista.


CREATE VIEW clientes_Barcelona_Girona AS
(SELECT *
FROM clientes
WHERE ciudad IN ('Barcelona', 'Girona'))
WITH CHECK OPTION;

CREATE VIEW proyectos_por_cliente (codigo_cli, numero_proyectos)
AS
(SELECT c.codigo_cli, COUNT(*)
FROM proyectos p, clientes c
WHERE p.codigo_cliente = c.codigo_cli
GROUP BY c.codigo_cli);

---cláusula WITH CHECK OPTION
CREATE OR REPLACE VIEW EMP_20
AS
SELECT *
FROM EMPLE
WHERE DEPT_NO = 20
WITH CHECK OPTION CONSTRAINT EMP20_CK;

UPDATE EMP_20
SET DEPT_NO=10
WHERE EMP_NO = 7788; --> Da error

--Denegación de operaciones DML
CREATE OR REPLACE VIEW EMP_10(NUM_EMPLE, APE_EMPLE, CARGO)
AS
SELECT EMP_NO, APELLIDO, OFICIO
FROM EMPLE
WHERE DEPT_NO = 10
WITH READ ONLY;


--Modificación de una vista
CREATE OR REPLACE VIEW clientes_Barcelona_Girona AS
(SELECT *
FROM clientes
WHERE ciudad IN ('Barcelona', 'Girona') AND telefono is NULL)
WHITH CHECK OPTION;

--Borrado de una vista: DROP VIEW
DROP VIEW clientes_Barcelona_Girona;



