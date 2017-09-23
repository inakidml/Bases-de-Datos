--SELECT--

SELECT [* | ALL | DISTINCT ] <nombre_campo> [{,<nombre_campo>}]
FROM <nombre_tabla>|<nombre_vista> [{,<nombre_tabla>|<nombre_vista>}]
[WHERE <condicion> [{ AND|OR <condicion>}]]
[GROUP BY <nombre_campo> [{,<nombre_campo >}]]
[HAVING <condicion>[{ AND|OR <condicion>}]]
[ORDER BY <nombre_campo>|<indice_campo> [ASC | DESC]
[{,<nombre_campo>|<indice_campo>[ASC | DESC ]}]];

--Seleccionar columnas en una consulta
SELECT codigo_cli,nombre_cli, nif, direccion, ciudad, telefono
FROM clientes;

--Expresiones aritméticas
SELECT nombre, precio, precio*1.16
FROM articulos;

--Operador de concatenación
SELECT tipo, modelo, tipo || '-' || modelo
FROM piezas;

--Cláusula WHERE
SELECT codigo_empl
FROM empleados
WHERE num_proyec = 4;

--Operadores de comparación:
>, <, >=, <=, =, <>(distinto), !=

--Operadores lógicos
AND, OR, NOT

--Operador BETWEEN

SELECT codigo_empl
FROM empleados
WHERE sueldo BETWEEN 2.0E+4 AND 5.0E+4;

--Operador IN

SELECT nombre_dep, ciudad_dep
FROM departamentos
WHERE ciudad_dep IN ('Lleida', 'Tarragona');

--Operador LIKE
SELECT codigo_empl, nombre_empl
FROM empleados
WHERE nombre_empl LIKE 'J%'; -->(% -> serie cualquiera de caracteres)

SELECT codigo_proyec
FROM proyectos
WHERE nombre_proyec LIKE 'S_ _ _ _'; -->(_ -> un caracter)

--Operador IS NULL
SELECT codigo_empl, nombre_empl
FROM empleados
WHERE num_proyec IS NULL;

--Cláusula DISTINCT
filas resultantes sin repeticiones

SELECT DISTINCT sueldo
FROM empleados;

--Cláusula ORDER BY
SELECT codigo_empl, nombre_empl, apellido_empl, sueldo
FROM empleados
ORDER BY sueldo, nombre_empl DESC; -->--ASC por defecto, si queremos descendente, pondremos DESC 

--Funciones


--Obtener datos de múltiples tablas

--Producto cartesiano
SELECT EMPLOYEE_ID, DEPARTMENT_ID, LOCATION_ID
FROM
EMPLOYEES, DEPARTMENTS;

--Combinaciones internas o de igualdad: equijoin
SELECT proyectos.codigo_proyecto, proyectos.precio, clientes.nif
FROM clientes, proyectos
WHERE clientes.codigo_cli = proyectos.codigo_cliente
AND clientes.codigo_cli = 20;

SELECT p.codigo_proyecto, p.precio, c.nif, p.codigo_cliente,
c.codigo_cli
FROM clientes c, proyectos p
WHERE c.codigo_cli = p.codigo_cliente 
AND c.codigo_cli = 20;

--Combinaciones de no igualdad
SELECT a.empleado, a.sueldo, b.categoria
FROM empleados a, categorias b
WHERE a.sueldo BETWEEN b.sueldo_minimo AND b.sueldo_maximo;

--Combinaciones externas: outer join
En las combinaciones internas, si una fila no satisface una condición de unión, no aparecerá
en el resultado de la consulta.

SELECT e.code_no, e.experimentos, r.res1, r.res2
FROM
experimentos e, resultados r
WHERE e.code_no = r.code_no(+);

--Combinaciones de una tabla consigo misma: self join
SELECT worker.last_name ||' trabaja para '||manager.last_name
FROM employees worker, employees manager
WHERE worker.manager_id = manager.employee_id;

--Sintaxis SQL 1999
--Cross Join (producto cartesiano)
SELECT * FROM piezas CROSS JOIN existencias;

--Natural Join
SELECT codigo_empl, nombre_empl
FROM empleados NATURAL JOIN departamentos
WHERE telefono = '977.333.852';

La unión sólo puede ocurrir en columnas que tengan los mismos nombres y tipos de datos

--Join Using
SELECT codigo_empl, nombre_empl
FROM empleados JOIN departamentos USING (nombre_dep, ciudad_dep)
WHERE telefono = '977.333.852';

--Join On
SELECT p.codigo_proyecto, p.precio, c.nif, p.codigo_cliente,
c.codigo_cli
FROM clientes c JOIN proyectos p ON c.codigo_cli = p.codigo_cliente
WHERE c.codigo_cli = 20;

--Combinaciones externas
SELECT e.codigo_empl, e.nombre_empl, e.nombre_dep, e.ciudad_dep,
d.telefono
FROM empleados e NATURAL JOIN departamentos d;
--Combinación externa izquierda
SELECT e.codigo_empl, e.nombre_empl, e.nombre_dep,
e.ciudad_dep, d.telefono
FROM empleados e NATURAL LEFT OUTER JOIN departamentos d;
--Combinación externa derecha
SELECT e.codigo_empl, e.nombre_empl, e.nombre_dep, e.ciudad_dep,
d.telefono
FROM empleados e NATURAL RIGHT OUTER JOIN departamentos d;
--Combinación externa plena
SELECT e.codigo_empl, e.nombre_empl, e.nombre_dep, e.ciudad_dep,
d.telefono
FROM empleados e NATURAL FULL OUTER JOIN departamentos d;

--Combinaciones con más de dos tablas
SELECT *
FROM empleados, proyectos, clientes
WHERE num_proyec = codigo_proyec AND codigo_cliente = codigo_cli;

SELECT *
FROM (empleados JOIN proyectos ON num_proyec = codigo_proyec)
JOIN clientes ON codigo_cliente = codigo_cli;

--Agrupaciones: GROUP BY y HAVING

SELECT [column,] group_function(column), ...
FROM table
[WHERE condition]
[GROUP BY column]
[ORDER BY column];

Los argumentos que pueden tener estas funciones son:
COUNT({* | [DISTINCT | ALL] expr} )
AVG( [DISTINCT | ALL] n)
MAX( [DISTINCT | ALL] expr )
MIN( [DISTINCT | ALL] expr )
SUM( [DISTINCT | ALL] n )

SELECT COUNT(*) AS numero_dep
FROM departamentos
WHERE ciudad_dep = ‘Lleida’;

---Cláusula GROUP BY
SELECT nombre_dep, ciudad_dep, AVG(sueldo) AS sueldo_medio
FROM empleados
GROUP BY nombre_dep, ciudad_dep;

--Cláusula HAVING
SELECT num_proyec
FROM empleados
GROUP BY num_proyec
HAVING SUM (sueldo) >1.8E+5;


--Subconsultas
SELECT listaExpresiones
FROM tabla
WHERE expresión OPERADOR
(SELECT listaExpresiones
FROM tabla);
En la sintaxis OPERADOR es un operador de comparación, que pueden ser de dos clases:
• Operadores de una sola fila (<, >, <>, <=,...).
• Operadores de varias filas ( IN, ANY, ALL , ...).
IN Igual a cualquier miembro de la lista
ANY compara el valor con cada valor devuelto de la subconsulta
ALL compara el valor con todos los valores devueltos por la subconsulta
• < ANY significa menos que el máximo.
• > ANY significa más que el mínimo.
• = ANY es equivalente a IN.
• < ALL significa menos que el mínimo.
• > ALL significa más que el máximo.
El operador NOT se puede utilizar con los operadores IN, ANY y ALL.

Podemos colocar la subconsulta en diversas cláusulas SQL como, por ejemplo:
• La cláusula WHERE .
• La cláusula HAVING .
• La cláusula FROM .

SELECT APELLIDO, SALARIO, DEPT_NO
FROM EMPLE
WHERE SALARIO IN (SELECT MIN(SALARIO)
FROM EMPLE
GROUP BY DEPT_NO);

SELECT EMP_NO, APELLIDO, OFICIO, SALARIO
FROM EMPLE
WHERE SALARIO < ANY (SELECT SALARIO
FROM EMPLE
WHERE OFICIO = 'ANALISTA')
AND OFICIO <> 'ANALISTA';


SELECT APELLIDO
FROM EMPLE
WHERE SALARIO > (SELECT SALARIO
FROM EMPLE
WHERE APELLIDO='Abel');

SELECT APELLIDO, OFICIO, SALARIO
FROM EMPLE
WHERE SALARIO = (SELECT MIN(SALARIO)
FROM EMPLE );

--Subconsultas de varias columnas
SELECT EMP_NO, APELLIDOS, DIR, DEPT_NO
FROM EMPLE
WHERE (DIR, DEPT_NO) IN (SELECT DIR, DEPT_NO
FROM EMPLE
WHERE EMP_NO IN (7788, 7844))
AND EMP_NO NOT IN (7788, 7844);

SELECT EMP_NO, APELLIDOS, DIR, DEPT_NO
FROM EMPLE
WHERE DIR IN
(SELECT DIR
FROM EMPLE
WHERE EMP_NO IN (7788, 7844))
AND DEPT_NO IN (SELECT DEPT_NO
FROM EMPLE
WHERE EMP_NO IN (7788, 7844))
AND EMP_NO NOT IN (7788, 7844);

--Uso de una subconsulta en la cláusula FROM
SELECT APELLIDO, SALARIO, DEPT_NO, AVG(SALARIO)
FROM EMPLE P, (SELECT DEPT_NO, AVG(SALARIO) SALMEDIO
FROM EMPLE
GROUP BY DEPT_NO) S
WHERE P.DEPT_NO = S.DEPT_NO
AND P.SALARIO > S.SALMEDIO;

--operador EXISTS
SELECT EMP_NO, APELLIDO, OFICIO
FROM
EMPLE P
WHERE EXISTS (SELECT 'X'
FROM EMPLE
WHERE DIR=P.EMP_NO);
Si la subconsulta devuelve al menos 1 fila, el
operador devuelve TRUE . Si el valor no existe, devuelve FALSE .

alternativa
SELECT EMP_NO, APELLIDO, OFICIO
FROM
EMPLE
WHERE EMP_NO IN (SELECT DIR
FROM EMPLE
WHERE DIR IS NOT NULL);

--Recuperación jerárquica
SELECT [LEVEL,] listaDeColumnasYExpresiones
FROM tabla(s)...
[WHERE condiciones...]
[START WITH condiciones]
CONNECT BY [PRIOR] expresion1=[PRIOR] expresion2
En la sintaxis:
• LEVEL Para cada fila devuelta por una consulta
jerárquica, la pseudocolumna LEVEL devuelve 1 para la fila
raíz, 2 para un secundario de la raíz, ...
• START WITH Especifica las filas raíz de la jerarquía (donde
empezar). Esta cláusula es necesaria para una consulta
jerárquica verdadera.
• CONNECT BY PRIOR Especifica las columnas en las que existe la relación entre
las filas principal y secundaria. Esta cláusula es necesaria
para una consulta jerárquica.

SELECT nombre FROM emple
START WITH nombre='Andrés'
CONNECT BY dir= PRIOR emp_no;

SELECT LEVEL, nombre FROM emple
START WITH nombre='Ángel'
CONNECT BY dir= PRIOR emp_no;

SELECT LEVEL, nombre FROM emple
WHERE nombre!='Eva'
START WITH nombre='Ángel'
CONNECT BY dir= PRIOR emp_no;

--Los operadores SET
UNION Todas las filas seleccionadas por cada una de las consultas.
UNION ALL Todas las filas seleccionadas por cualquiera de las consultas,
incluidos duplicados.
INTERSECT Todas las filas distintas seleccionadas por ambas consultas.
MINUS Todas las filas distintas seleccionadas por la primera
sentencia SELECT y no seleccionadas por la segunda sentencia
SELECT.

SELECT ciudad
FROM clientes
UNION
SELECT ciudad_dep
FROM departamentos;

SELECT ciudad
FROM clientes
INTERSECT
SELECT ciudad_dep
FROM departamentos;




































