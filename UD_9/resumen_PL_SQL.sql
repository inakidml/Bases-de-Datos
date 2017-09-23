PL/SQL
------

bloque anónimo

DECLARE  (OPCIONAL)
BEGIN    (OBLIGATORIO)
EXCEPTION(OPCIONAL)
END;

-- VARIABLES

identificador [CONSTANT] tipo_de_dato [NOT NULL] [:= | DEFAULT expr];

v_num_emple emple.num_emple%TYPE := 2345; --%type copia el tipo de dato del campo num_emple de la tabla emple y asigna el 2345

-- DBMS_OUTPUT.PUT_LINE

set SERVEROUTPUT ON; --hacer visible el buffer que utiliza el paquete en la sesión de SQL*Plus.

DBMS_OUTPUT.PUT_LINE(V_NUM);  --imprime en CONSOLA DBMS_OUTPUT es pqte de Oracle y PUT_LINE es una fn contnida en ese paquete.

--SENTENCIAS SQL
/*
	PL/SQL no admite directamente sentencias DDL (Lenguaje de Definición de Datos) como, por
	ejemplo, CREATE TABLE, ALTER TABLE o DROP TABLE .
	PL/SQL no admite sentencias DCL (Lenguaje de Control de Datos) como, por ejemplo,
	GRANT o REVOKE .
*/

  --CURSORES SQL
	
   --SQL%ROWCOUNT Número de filas afectadas por la sentencia SQL más reciente (un valor entero) 
   --SQL%FOUND Atributo booleano que se evalúa como TRUE si la sentencia SQL más reciente afecta a una o varias filas
   --SQL%NOTFOUND Atributo booleano que se evalúa como TRUE si la sentencia SQL más reciente no afecta a ninguna fila
   --SQL%ISOPEN Siempre se evalúa como FALSE porque PL/SQL cierra los cursores implícitos inmediatamente después de ejecutarlos

--SENTENCIA SELECT

SELECT lista_select
INTO {nombre_variable [, nombre_variable ...| nombre_registro}
FROM tabla
[WHERE condicion];

--MANIPULACION DE DATOS
/* 
Se pueden emitir los comandos DML INSERT, UPDATE y DELETE sin ninguna restricción. Para
liberar los bloqueos de filas (y de tablas), hay que incluir sentencias COMMIT o ROLLBACK en
el código PL/SQL. 
*/

--ESTRUCUTRAS DE CONTROL

	--IF

IF condición THEN
sentencias;
[ELSIF condición THEN
sentencias;]
[ELSE
sentencias;]
END IF;

EJEMPLOS
IF apellido = 'Vargas' AND salario > 6.500 THEN
v_deptno := 60;
END IF;

DECLARE
v_fecha_alta DATE := '12/12/90';
v_five_years BOOLEAN;
BEGIN
. . .
IF MONTHS_BETWEEN(SYSDATE,v_fecha_alta)/12 > 5 THEN
v_five_years := TRUE;
ELSE
v_five_years := FALSE;
END IF;

	--CASE
CASE selector
WHEN condición1_búsqueda THEN resultado1;
WHEN condición2_búsqueda THEN resultado2;
...
WHEN condiciónN_búsqueda THEN resultadoN;
[ELSE resultadoN+1;]
END CASE;

EJEMPLOS
texto:= CASE actitud
WHEN 'A' THEN 'Muy buena';
WHEN 'B' THEN 'Buena';
WHEN 'C' THEN 'Normal';
WHEN 'D' THEN 'Mala';
ELSE 'Desconocida';
END CASE;

aprobado:= CASE
WHEN actitud='A' AND nota>=4 THEN TRUE;
WHEN nota>=5 AND (actitud='B' OR actitud='C')
THEN TRUE;
WHEN nota>=7 THEN TRUE;
ELSE FALSE
END CASE;

	--LOOP

LOOP
sentencia1;
. . .
EXIT [WHEN condición];
END LOOP;

EJEMPLO
DECLARE
v_pais_id
lugares.pais_id%TYPE := 'CA';
v_lugar_id lugares.lugar_id%TYPE;
v_cont NUMBER(2) := 1;
v_ciudad lugares.ciudad%TYPE := 'Montreal';
BEGIN
SELECT MAX(lugar_id) INTO v_lugar_id FROM lugares
WHERE ciudad_id = v_ciudad_id;
LOOP
INSERT INTO lugares(lugar_id, ciudad, pais_id)
VALUES((v_lugar_id + v_cont),v_ciudad, v_pais_id);
v_cont := v_cont + 1;
EXIT WHEN v_cont > 3;
END LOOP;
END;

	--WHILE
WHILE condición LOOP
sentencia1;
sentencia2;
. . .
END LOOP;

EJEMPLO
DECLARE
v_pais_id
lugares.pais_id%TYPE := 'CA';
v_lugar_id lugares.lugar_id%TYPE;
v_cont NUMBER(1) := 1;
v_ciudad lugares.ciudad%TYPE := 'Montreal';
24BEGIN
SELECT MAX(lugar_id) INTO v_lugar_id FROM lugares
WHERE ciudad_id = v_ciudad_id;
WHILE v_cont<=3 LOOP
INSERT INTO lugares(lugar_id, ciudad, pais_id)
VALUES((v_lugar_id + v_cont),v_ciudad, v_pais_id);
v_cont := v_cont + 1;
END LOOP;
END;

	--FOR
FOR contador IN [REVERSE] límite_inferior .. límite_superior LOOP
sentencia1;
sentencia2;
. . .
END LOOP;

EJEMPLO
DECLARE
v_lower NUMBER := 1;
v_upper NUMBER := 100;
BEGIN
FOR i IN v_lower..v_upper LOOP
SENTENCIA; 
END LOOP;
END;

--PROCEDIMIENTOS

CREATE [OR REPLACE] PROCEDURE nombre_procedimiento
[(parametro1 [modo1] tipodato1,
parametro2 [modo2] tipodao2,
. . .)]
IS|AS
Bloque PL/SQL;
/*

PARAMETROS
No se puede limitar el tamaño del tipo de dato en los parámetros.

El modo de parámetro IN es el modo por defecto. Es decir, si no se especifica ningún modo
con un parámetro, se considera que el parámetro es IN. Los modos OUT e IN OUT se deben especificar 
explícitamente delante de dichos parámetros.

A un parámetro formal IN no se le puede asignar un valor. Es decir, los parámetros IN no se
pueden modificar en el cuerpo del procedimiento.

Hay que asignar un valor a los parámetros OUT o IN OUT antes de que regresen al entorno
de llamada.

A los parámetros IN se les puede asignar un valor por defecto en la lista de parámetros. A
los parámetros OUT e IN OUT no se les pueden asignar valores por defecto.

Por defecto, los parámetros IN se pasan por referencia y los parámetros OUT e IN OUT por
valor.
*/

Ejemplo PARÁMETROS OUT:
CREATE OR REPLACE PROCEDURE consultar_empleado
(p_id IN emple.emp_no%TYPE, p_nombre OUT emple.apellido%TYPE,
p_salario OUT emple.salario%TYPE, p_comi OUT emple.comision%TYPE)
IS
BEGIN
SELECT apellido, salario, comision
INTO
p_nombre, p_salario, p_comision
FROM emple
WHERE emp_no = p_id;
END consultar_empleado;

EXECUTE consultar_empleado(1712,:nombre, :salario, :comision);

Donde :nombre, :salario y:comision son variables del host en
SQL*Plus definidas utilizando el comando VARIABLE:

VARIABLE nombre VARCAHAR2(25)
VARIABLE salario NUMBER
VARIABLE comision NUMBER

Tenga en cuenta el uso de los dos puntos (:) para hacer
referencia a las variables del host en el comando EXECUTE.

Para ver los valores que se transfieren desde el procedimiento
al entorno de llamada, utilice el comando PRINT.
PRINT nombre salario comision
PRINT y VARIABLE son comandos de SQL*Plus

EJEMPLO IN OUT

CREATE OR REPLACE PROCEDURE formatear_tfno
(p_tfno_no IN OUT VARCHAR2)
IS
BEGIN
p_tfno_no := '(' || SUBSTR(p_tfno_no,1,3) ||
')' || SUBSTR(p_tfno_no,4,3) ||
'-' || SUBSTR(p_tfno_no,7);
END formatear_tfno;

Los parámetros IN OUT funcionan como variables inicializadas.

Para ejecutar el procedimiento:
VARIABLE g_tfno_no VARCHAR2(15)
BEGIN
:g_tfno_no := '8006330575';
END;
/
PRINT g_tfno_no
EXECUTE formatear_ tfno (:g_tfno_no)
PRINT g_tfno_no

--ELIMINANCION PROCEDIMIENTOS
DROP PROCEDURE nombre_procedimiento

--FUNCIONES

CREATE [OR REPLACE] FUNCTION function_name
[(parameter1 [mode1] datatype1,
parameter2 [mode2] datatype2,
. . .)]
RETURN datatype
IS|AS
PL/SQL Block;

Debe haber al menos una sentencia RETURN (expression) .

CREATE OR REPLACE FUNCTION obtener_salario
(p_id IN emple.emp_no%TYPE)
RETURN NUMBER
IS
v_salario emple.salario%TYPE :=0;
BEGIN
SELECT salario INTO v_salario FROM emple WHERE empno = p_id;
RETURN v_salario;
END obtener_salario;


Desde SQL*PLUS:
VARIABLE g_salario NUMBER
EXECUTE :g_salario := obtener_salario(117)
PRINT g_salario

	--Llamadas a funciones pl/sql desde sentencias SQL

CREATE OR REPLACE FUNCTION impuesto (p_value IN NUMBER)
RETURN NUMBER
IS
BEGIN
RETURN (p_value * 0.08);
END tax;
/
SELECT emp_no, apellido, salario, impuesto(salario) FROM emple WHERE dept_no = 10;

/*
Las funciones PL/SQL almacenadas no se pueden llamar desde la cláusula de
restricción CHECK de un comando CREATE o ALTER TABLE ni se pueden utilizar
para especificar un valor por defecto para una columna
No pueden contener instrucciones DML

Si una instrucción DML modifica una determinada tabla, en dicha instrucción no se
puede invocar a una función que realice consultas sobre la misma tabla

No pueden utilizar instrucciones de transacciones ( COMMIT, ROLLBACK ,...)

Desde las sentencias SQL sólo se puede llamar a funciones almacenadas. No se
puede llamar a procedimientos almacenados.
*/

--ELIMINCAION DE FUNCIONES
DROP FUNCTION nombre_función

--VISTAS DICCIONARIO DE DATOS

USER_OBJECTS
También puede examinar las vistas ALL_OBJECTS y DBA_OBJECTS

SELECT object_name, object_type
FROM USER_OBJECTS
WHERE object_type in ('PROCEDURE','FUNCTION')
ORDER BY object_name;

USER_SOURCE
texto de un procedimiento o una función almacenada
también las vistas ALL_SOURCE y DBA_SOURCE

SELECT text
FROM USER_SOURCE
WHERE name = 'QUERY_EMPLOYEE'
ORDER BY line;

Obtención de Errores de Compilación
USER_ERRORS o el comando SHOW ERRORS de SQL*Plus
también las vistas ALL_ERRORS y DBA_ERRORS

Utilice SHOW ERRORS sin ningún argumento en el prompt de SQL para obtener los errores de
compilación del último objeto que haya compilado
SHOW ERRORS PROCEDURE log_execution

--Descripción de Procedimientos y Funciones

DESCRIBE NOMBRE_FUNCION_O_PROCEDIMIENTO;

--EXCEPCIONES

EXCEPTION
WHEN exception1 [OR exception2 . . .] THEN
statement1;
statement2;
. . .
[WHEN exception3 [OR exception4 . . .] THEN
statement1;
statement2;
. . . ]
[WHEN OTHERS THEN
statement1;
statement2;
. . . ]

--Es conveniente manejar siempre las excepciones NO_DATA_FOUND y TOO_MANY_ROWS , que son las más habituales.

Errores no predefinidos de Oracle Server(dan un número pero no nombre
)
Declarar un nombre para la excepción que capturaremos. Eso se hace en el apartado
--DECLARE con esta sintaxis:
nombreDeExcepción EXCEPTION;
--Asociar ese nombre al número de error correspondiente mediante esta sintaxis en el apartado DECLARE :
PRAGMA EXCEPTION_INIT(nombreDeExcepción, noDeExcepción);
--En el apartado EXCEPTION capturar el nombre de la excepción como si fuera unaexcepción normal.

DECLARE
e_integridad EXCEPTION;
PRAGMA EXCEPTION_INIT(e_integridad, -2292);
BEGIN
DELETE FROM depart WHERE dept_no=20;
COMMIT;
EXCEPTION
WHEN e_integridad THEN
DBMS_OUTPUT.PUT_LINE(‘No se puede borrar ese departamento
porque tiene empleados relacionados’);
END;

/*
Cuando se produce una excepción, se puede identificar el código de error o el mensaje de
error asociado utilizando dos funciones. Basándose en los valores del código o del mensaje,
puede decidir qué acción va a realizar posteriormente en función del error.
SQLCODE devuelve el número de error de Oracle de las excepciones internas. Puede enviar
un número de error a SQLERRM , para que le devuelva el mensaje asociado a ese número de
error.*/

ejemplos

DECLARE
v_error_code
v_error_message
BEGIN
...
EXCEPTION
...
WHEN OTHERS THEN
NUMBER;
VARCHAR2(255);
ROLLBACK;
v_error_code := SQLCODE ;
v_error_message := SQLERRM ;
INSERT INTO errors
VALUES(v_error_code, v_error_message);
END;

EXCEPTION
...
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE(‘Ocurrió el error ‘ || SQLCODE
||‘mensaje: ‘ || SQLERRM);
END;


	--excepciones creadas por el usuario RAISE
DEFINE p_depart_nombre = 'Information Technology '
DEFINE p_depart_no = 300
DECLARE
e_invalid_depart EXCEPTION;
BEGIN
UPDATE depart SET dnombre = '&p_depart_nombre' WHERE dept_no = &p_depart_no;
IF SQL%NOTFOUND THEN
RAISE e_invalid_department;
END IF;
COMMIT;
EXCEPTION
WHEN e_invalid_department THEN
DBMS_OUTPUT.PUT_LINE('No existe el departamento.');
END;

--la función RAISE_APPLICATION_ERROR que simplifica los tres pasos anteriores. Sintaxis:
RAISE_APPLICATION_ERROR(noDeError, mensaje, [{TRUE|FALSE}]);
--Esta instrucción se coloca en la sección ejecutable o en la de excepciones y sustituye a los tres pasos anteriores. 
--Lo que hace es lanzar un error cuyo número debe de estar entre el -20000 y el -20999 y hace que Oracle muestre el mensaje indicado. 
--El tercer parámetro puede ser TRUE o FALSE (por defecto TRUE) e indica si el error se añade a la pila de errores existentes.

DECLARE
BEGIN
DELETE FROM depart WHERE dept_no=60;
IF SQL%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20001,'No existe ese departamento');
END IF;
END;

--CURSORES

--CURSORES EXPLICITOS

SET SERVEROUTPUT ON
DECLARE
v_empno emple.emp_no%TYPE;
v_ape
emple.apellido%TYPE;
CURSOR emp_cursor IS SELECT emp_no, apellido FROM emple;
BEGIN
OPEN emp_cursor;
FOR i IN 1..10 LOOP
FETCH emp_cursor INTO v_empno, v_ape;
DBMS_OUTPUT.PUT_LINE (TO_CHAR(v_empno)||' '|| v_ape);
END LOOP;
END ;

-- Declaración de registros con el atributo %ROWTYPE
CREA UNA VARIABLE DE TYPE COLUMNAS, PARA METER TODOS LOS CAMPOS DE UNA TABLA...

Sintaxis
DECLARE
identificador referencia%ROWTYPE;
donde:
identificador es el nombre elegido para el registro.
referencia es el nombre de la tabla, la vista, el cursor, o la variable de cursor en el cual se va a basar el registro. 
Para que esta referencia sea válida, la tabla o la vista deben existir.

DEFINE emple_number = 124
DECLARE
emp_rec
emple%ROWTYPE;
BEGIN
SELECT * INTO emp_rec
FROM emple
WHERE emp_no = &emple_number;
INSERT INTO emp_jubilados
VALUES (emp_rec.emp_no, emp_rec.apellido, emp_rec.oficio,
emp_rec.dir, SYSDATE, emp_rec.salario,emp_rec.comision,
emp_rec.dept_no);
COMMIT;
END;

DECLARE
CURSOR emp_cursor 
IS
SELECT emp_no, apellido FROM emple;
emp_record emp_cursor%ROWTYPE;
BEGIN
OPEN emp_cursor;
LOOP
FETCH emp_cursor INTO emp_record;
EXIT WHEN emp_cursor%NOTFOUND;
INSERT INTO temp_list (empid, empape)
VALUES (emp_record.emp_no, emp_record.apellido);
END LOOP;
COMMIT;
CLOSE emp_cursor;
END ;

--BUCLES FOR DE CURSOR

FOR nombre_registro IN nombre_cursor LOOP
sentencia1;
sentencia2;
. . .
END LOOP;

DECLARE
CURSOR emp_cursor IS
SELECT apellido, dept_no FROM emple;
BEGIN
FOR emp_record IN emp_cursor 
LOOP -- se produce una apertura y una lectura implícita.
IF emp_record.dept_no = 30 THEN
DBMS_OUTPUT.PUT_LINE ('El empleado '|| emp_record.apellido|| ' trabaja en el dpto. ');
END IF;
END LOOP; -- se produce un cierre y una salida del bucle implícita
END ;

Si utiliza una subconsulta en un bucle FOR, no es necesario que declare un cursor. Este
ejemplo hace lo mismo que el de la página anterior. A continuación está el código completo:

BEGIN
FOR emp_record IN (SELECT apellido, dept_no FROM employees) 
LOOP
-- se produce una apertura y una lectura implícita.
IF emp_record.dept_no = 30 THEN
DBMS_OUTPUT.PUT_LINE ('El empleado '|| emp_record.apellido|| ' trabaja en el dpto. ');
END IF;
END LOOP; -- se produce un cierre y una salida del bucle implícita
END;
--CURSORES PARAMETRIZADOS
DECLARE
CURSOR cArt (cFml Articulos.cArtFml%TYPE)
IS 
SELECT cArtCdg,cArtDsc FROM Articulos WHERE cArtFml = cFml;
xCod Articulos.cArtCdg%TYPE;
xDes Articulos.cArtDsc%TYPE;
BEGIN
OPEN cArt('F1'); --LE PASAMOS COMO PARAMETRO F1
LOOP
FETCH cArt INTO xCod,xDes;
EXIT WHEN cArt%NOTFOUND;
DBMS_OUTPUT.PUT_LINE (xDes);
END LOOP;
CLOSE cArt;
END;

--CURSORES DE ACTUALIZACION

Los cursores de actualización se declaran igual que los cursores explícitos, añadiendo FOR
UPDATE al final de la sentencia SELECT.
CURSOR nombre_cursor
IS instrucción_SELECT FOR UPDATE
Para actualizar los datos del cursor hay que ejecutar una sentencia UPDATE especificando la
cláusula WHERE CURRENT OF .
UPDATE <nombre_tabla> SET <campo_1> = <valor_1>[,<campo_2> = <valor_2>]
WHERE CURRENT OF <cursor_name>
Cuando trabajamos con cursores de actualización debemos tener en cuenta que la sentencia
UPDATE genera bloqueos en la base de datos ( transacciones, disparadores,etc).

DECLARE
CURSOR cpaises IS
select CO_PAIS, DESCRIPCION, CONTINENTE from paises FOR UPDATE;
co_pais VARCHAR2(3);
descripcion VARCHAR2(50);
continente VARCHAR2(25);
BEGIN
OPEN cpaises;
FETCH cpaises INTO co_pais,descripcion,continente;
WHILE cpaises%found
LOOP
UPDATE PAISES SET CONTINENTE = CONTINENTE || '.' WHERE CURRENT OF cpaises;
FETCH cpaises INTO co_pais,descripcion,continente;
END LOOP;
CLOSE cpaises;
COMMIT;
END;

--TRIGGERS
TRIGGERS DE TABLAS, DE SUSTITUCION(VISTAS) O  DE SISTEMA
CREATE {OR REPLACE} TRIGGER nombre_disp
[BEFORE|AFTER]
[DELETE|INSERT|UPDATE {OF columnas}]
columnas}]...]
ON tabla
[FOR EACH ROW [WHEN condicion disparo]]
[DECLARE]
-- Declaración de variables locales
BEGIN
-- Instrucciones de ejecución
[EXCEPTION]
-- Instrucciones de excepción
END;

-- disparador no puede emitir ninguna orden de control de transacciones ( COMMIT, ROLLBACK o SAVEPOINT).
   El disparador se activa como parte de la ejecución de la
   orden que provocó el disparo, y forma parte de la misma transacción que dicha
   orden. Cuando la orden que provoca la orden es confirmada o cancelada, se
   confirma o se cancela también el trabajo realizado por el disparador.
-- No se utilicen comandos DDL
-- No se acceda a las tablas que están siendo modificadas con DELETE, INSERT o UPDATE en la misma sesión
-- No se violen las reglas de integridad, es decir no se pueden modificar claves primarias, ni actualizar claves externas
-- No se utilicen sentencias de control de transacciones (Commit, Rollback o Savepoint)
-- No se llamen a procedimientos que trasgredan la restricción anterior
-- No se llame a procedimientos que utilicen sentencias de control de transacciones

--Borrar un Disparador
 DROP TRIGGER <NombreT>

--Habilitar/Deshabilitar un Disparador, sin necesidad de borrarlo
 ALTER TRIGGER <NombreT> {ENABLE | DISABLE} ( Esto no puede hacerse con los subprogramas)

--Diccionario de Datos
USER_TRIGGERS.

SELECT TRIGGER_NAME FROM USER_TRIGGERS

Para ver el cuerpo de un disparador:
SELECT TRIGGER_BODY FROM USER_TRIGGERS WHERE TRIGGER_NAME =
‘nombre_disparador’;
Para ver la descripcion de un disparador:
SELECT DESCRIPTION FROM USER_TRIGGERS WHERE TRIGGER_NAME =
‘nombre_disparador’;


  --TRIGGERS DE TABLA
CREATE OR REPLACE TRIGGER Control_Empleados
AFTER INSERT OR DELETE OR UPDATE ON Empleados
BEGIN
INSERT INTO Ctrl_Empleados (Tabla,Usuario,Fecha)
VALUES ('Empleados', USER, SYSDATE);
END Control_Empleados;

Solo se puede definir un trigger de cada tipo por tabla. Esto da doce posibilidades
/*
BEFORE UPDATE row         AFTER UPDATE row
BEFORE DELETE row         AFTER DELETE row
BEFORE INSERT row         AFTER INSERT row
BEFORE UPDATE statement   AFTER UPDATE statement
BEFORE DELETE statement   AFTER DELETE statement
BEFORE INSERT statement   AFTER INSERT statement
*/

--DISPARADORES A NIVEL DE FILA

INSERT: solo existe :new
DELETE: solo existe :old
UPDATE: existen :old y :new 

CREATE OR REPLACE TRIGGER NuevoAlumno
BEFORE INSERT ON alumno
FOR EACH ROW
BEGIN  -- Establecer el nuevo número de alumno:     
SELECT MAX(cod_al)+1 INTO :new.cod_al FROM Alumno;
IF :new.cod_al IS NULL THEN
:new.cod_al := 1;
END IF;
END NuevoAlumno;

Modificar Pseudo-Registros:
• No puede modificarse el Pseudo-Registro :new en un disparador AFTER a nivel de fila.
• El Pseudo-Registro :old nunca se modificará: Sólo se leerá.

Formato: ... FOR EACH ROW WHEN <Condición_Disparo>

CREATE OR REPLACE TRIGGER Redondea_Precios_Grandes
BEFORE INSERT OR UPDATE OF Precio ON Pieza
FOR EACH ROW WHEN (new.Precio > 200)
BEGIN
:new.Precio := ROUND(:new.Precio,1);
END Redondea_Precios_Grandes;


Se puede escribir ese disparador sin la cláusula WHEN, usando un IF:
BEGIN
IF :new.Precio > 200 THEN
:new.Precio := ROUND(:new.Precio,1);
END IF;

  --Orden de ejecución de los triggers

Los disparadores se activan al ejecutarse la sentencia SQL.
• Si existe, se ejecuta el disparador de tipo BEFORE (disparador previo) con nivel de orden.
• Para cada fila a la que afecte la orden:
• Se ejecuta si existe, el disparador de tipo BEFORE con nivel de fila.
• Se ejecuta la propia orden.
• Se ejecuta si existe, el disparador de tipo AFTER (disparador posterior) con nivel de fila.
• Se ejecuta, si existe, el disparador de tipo AFTER con nivel de orden.

  --PREDICADOS CONDICIONALES

INSERTING, UPDATING y DELETING.
– Inserting: Retorna true cuando el trigger ha sido disparado por un INSERT
– Deleting: Retorna true cuando el trigger ha sido disparado por un DELETE
– Updating: Retorna true cuando el trigger ha sido disparado por un UPDATE
– Updating (columna): Retorna true cuando el trigger ha sido disparado por un UPDATE y la columna ha sido modificada.


CREATE TRIGGER audit_trigger BEFORE INSERT OR DELETE OR UPDATE
ON classified_table FOR EACH ROW
BEGIN
IF INSERTING THEN
INSERT INTO audit_table
VALUES (USER || ' esta insertando' || ' la clave: ' || :new.key);
ELSIF DELETING THEN
INSERT INTO audit_table
VALUES (USER || ' esta borrando' || ' la clave: ' || :old.key);
ELSIF UPDATING THEN
INSERT INTO audit_table
VALUES (USER || ' esta cambiando' || ' el dato: ' || old.formula || ' por
este nuevo dato ' || :new.formula);
END IF;
END;

CREATE OR REPLACE TRIGGER tr_actualizar_libros
BEFORE UPDATE
ON libros
FOR EACH ROW
BEGIN
if updating('codigo') then
raise_application_error(-20001,'No se puede modificar el código libros');
else
insert into control values(user,sysdate);
end if;
END;



--TRIGGERS DE SUSTITUCION

-Sólo pueden definirse sobre Vistas.
-Se activan en lugar de la Orden DML que provoca el disparo, o sea, la orden disparadora no se ejecutará nunca.
-Deben tener Nivel de Filas.
-Se declaran usando INSTEAD OF en vez de BEFORE/AFTER.

Supongamos que tenemos la siguiente vista
CREATE VIEW vista AS SELECT edificio, sum(numero_asientos)
FROM habitaciones
GROUP BY edificio;
No se puede hacer una operacion de borrado directamente en la vista:
DELETE FROM vista WHERE edificio=’edificio 7’;
Sin embargo, se puede crear un disparador de sustitucion que efectue el borrado
equivalente pero sobre la tabla habitaciones.
CREATE TRIGGER borra_en_vista
INSTEAD OF DELETE ON vista FOR EACH ROW
BEGIN
DELETE FROM habitaciones
WHERE edificio = :OLD.edificio;
END borra_en_vista;

--DISPARADORES DE SISTEMA

Pueden funcionar para un esquema (o usuario) concreto o para toda la base de datos
(todos los usuarios).
Los eventos que se pueden considerar son:
• CREATE, ALTER o DROP
• Conexión y desconexión
• Arranque y parada de la base de datos.
• Cuando se produzca un error concreto o un error cualquiera.
Sintaxis:

	•Evento DDL (creación, modificación o borrado de un objeto):
CREATE OR REPLACE TRIGGER NombreTrigger
[BEFORE | AFTER]
[CREATE|ALTER|DROP] OR [CREATE|ALTER|DROP] ...
ON [DATABASE | SCHEMA]
DECLARE
BEGIN
EXCEPTION
END;

	•Eventos del sistema:
CREATE OR REPLACE TRIGGER NombreTrigger
[eventosys] OR [eventosys] ... ON [DATABASE | SCHEMA]
DECLARE
BEGIN
EXCEPTION
END;

	•eventosys puede ser uno de los siguientes:
AFTER SERVERERROR
AFTER LOGON
BEFORE LOGOFF
AFTER STARTUP
BEFORE SHUTDOWN



