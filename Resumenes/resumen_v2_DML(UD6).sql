--DML--

-- Inserción de filas en una tabla
INSERT INTO clientes
VALUES
(10,
'ECIGSA',
'Barcelona', DEFAULT);

INSERT INTO clientes(nif, nombre_cli, codigo_cli, telefono,
direccion, ciudad)
VALUES ('37.248.573-C', 'ECIGSA', 10, DEFAULT, 'ARAGON 242',
'Barcelona');

--Insertar filas desde otra tabla
INSERT INTO tabla [(columna1[,columna2 ...]]
subquery;

--Modificación de filas de una tabla
UPDATE empleados
SET sueldo = sueldo + 1000
WHERE num_proyec = 2;

--Actualización de varias columnas con subconsultas
UPDATE EMPLE
SET OFICIO =(SELECT OFICIO
FROM EMPLE
WHERE EMP_NO=205),
SALARIO =(SELECT SALARIO
FROM EMPLE
WHERE EMP_NO=205)
WHERE EMP_NO = 114;

--Borrado de filas de una tabla
DELETE FROM proyectos
WHERE codigo_cliente = 2;

DELETE FROM proyectos; --> la deja sin filas(borra todo)

--Sentencias Explícitas de Control de Transacciones

COMMIT Termina la transacción actual haciendo permanentes todos los cambios de datos
pendientes.
SAVEPOINT name ; Marca un punto de grabación dentro de la transacción actual.
ROLLBACK; termina la transacción actual desechando todos los cambios de
datos pendientes.
ROLLBACK TO SAVEPOINT name; realiza rollback de la transacción actual al punto
de grabación especificado, desechando así los cambios o los puntos de
grabación creados después del punto de grabación al que está realizando
rollback. Si omite la cláusula TO SAVEPOINT, la sentencia ROLLBACK realiza
rollback de toda la transacción. Como los puntos de grabación son lógicos, no
hay ninguna forma de enumerar los puntos de grabación que ha creado.
