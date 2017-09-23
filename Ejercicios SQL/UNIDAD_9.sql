set SERVEROUTPUT ON;


DECLARE
V_NUM NUMBER(2);
BEGIN
V_NUM :=2;
DBMS_OUTPUT.PUT_line(V_NUM);
END;

--EJERCICIO 1 

/*NO SON V�LIDADS:
B(CADA DECLARACION EN UNA LINEA)
C(SI ES NOT NULL, DEBEMOS INICIALIZAR)
D(SI BOOLEAN -- TRUE OR FALSE)
F(POR EL ORDEN)
*/
--EJERCICIO 2 
/*
A.- 2
B.- WESTERN EUROPE
C.- 601
D.- PRODUCT 10012 IS IN STOCK
E.- 
*/
--EJERCICIO 3
BEGIN
DBMS_OUTPUT.PUT_line('HELLO WORLD');
END;
--EJERECICO 4

DECLARE
V_APELLIDO EMPLE.APELLIDO%TYPE;
V_OFICIO EMPLE.OFICIO%TYPE;
BEGIN
SELECT APELLIDO, OFICIO INTO V_APELLIDO, V_OFICIO FROM EMPLE WHERE EMP_NO=7839;
DBMS_OUTPUT.PUT_line(V_APELLIDO ||' '|| V_OFICIO);
END;

--EJERCICIO 5

DECLARE
V_DEPT_NO EMPLE.DEPT_NO%TYPE;
BEGIN
SELECT MAX(DEPT_NO) INTO V_DEPT_NO FROM DEPART; 
DBMS_OUTPUT.PUT_line(V_DEPT_NO);
END;
-- EJERCICIO 6
DECLARE
V_numEmple number(10);
BEGIN
SELECT COUNT(*) INTO V_NUMEMPLE FROM EMPLE;
DBMS_OUTPUT.PUT_line(V_numEmple);
END;
--EJERCICIO 7
SELECT * FROM DEPART;

DECLARE
V_numDepartMax DEPART.DEPT_NO%type;
BEGIN
SELECT MAX(DEPT_NO) INTO V_numDepartMax FROM DEPART ;
if V_numDepartMax is not null then
INSERT INTO DEPART values(V_numDepartMax+10, upper('Educacion'), Null);
DBMS_OUTPUT.PUT_line(V_numDepartMax);
end if;
IF SQL%NOTFOUND
then 
DBMS_OUTPUT.PUT_line('Ning�n registro insertado');
else
DBMS_OUTPUT.PUT_line('Insertado el departamento '|| to_char(V_numDepartMax+10));
commit;
end if;
END;

select * from DEPART;
delete from depart where DNOMBRE like 'Educacion';

-- EJercicio 8

DECLARE
V_numDepartMax DEPART.DEPT_NO%type;
v_loc DEPART.LOC%TYPE:= 'GASTEIZ';
BEGIN
SELECT MAX(DEPT_NO) INTO V_numDepartMax FROM DEPART ;
if V_numDepartMax is not null then
UPDATE DEPART set loc=v_loc where dept_no = V_numDepartMax;
DBMS_OUTPUT.PUT_line(V_numDepartMax);
end if;
IF SQL%NOTFOUND
then 
DBMS_OUTPUT.PUT_line('Ning�n registro insertado');
else
DBMS_OUTPUT.PUT_line('Update al departamento '|| to_char(V_numDepartMax));
commit;
end if;
END;

-- ejercicio 9
DECLARE
v_dept_no DEPART.DEPT_NO%type;
BEGIN
select max(dept_no) into v_dept_no from depart;
if v_dept_no is not null then
delete from depart where DEPT_NO=V_DEPT_NO;
end IF;
IF SQL%NOTFOUND
then 
DBMS_OUTPUT.PUT_line('Ning�n registro modificado');
else
DBMS_OUTPUT.PUT_line(SQL%ROWCOUNT||' Filas Borradas');
DBMS_OUTPUT.PUT_line('Delete del departamento '|| to_char(v_dept_no));
end if;
END;
-- Ejercicio 10
SELECT * FROM EMPLE;

DECLARE
v_min_salario EMPLE.SALARIO%TYPE;
BEGIN
SELECT min(SALARIO) INTO V_MIN_SALARIO FROM EMPLE;
IF V_MIN_SALARIO IS NOT NULL 
THEN
UPDATE EMPLE SET SALARIO=SALARIO+V_MIN_SALARIO WHERE DEPT_NO=30;
END IF;
IF  SQL%FOUND THEN 
DBMS_OUTPUT.PUT_line(SQL%ROWCOUNT||' Filas Modificadas');
DBMS_OUTPUT.PUT_line(v_min_salario ||' incrementado');
else
DBMS_OUTPUT.PUT_LINE('No se ha modificado nada');
end if;
END;

-- Ejercicio 11
DECLARE
v_salMedio EMPLE.SALARIO%TYPE;
BEGIN
SELECT avg(SALARIO) INTO v_salMedio FROM EMPLE;
update emple set salario=salario*1.10 where salario<v_salMedio;
DBMS_OUTPUT.PUT_line(SQL%ROWCOUNT||' Filas Modificadas');
END;

-- Ejercicio 12

CREATE TABLE MENSAJES ( NUMEROS NUMBER(2) not null);
SELECT * FROM MENSAJES;
delete from mensajes;
DECLARE
BEGIN
for i IN 1..10 LOOP
  IF i <>6 AND i<>8 then
  insert into mensajes VALUeS(i);
  end if;
END LOOP;
END;

-- Ejercicio 13
DECLARE
v_sueldo EMPLE.SALARIO%type;
BEGIN
SELECT SALARIO INTO v_sueldo from EMPLE where EMP_NO=7521;
if v_sueldo < 200000 then
  DBMS_OUTPUT.PUT_LINE('Bonificaci�n = ' || v_sueldo/10);
elsif v_sueldo> 200000 and v_sueldo <300000 then
  DBMS_OUTPUT.PUT_LINE('Bonificaci�n = ' || v_sueldo/15);
elsif v_sueldo>300000 then
  DBMS_OUTPUT.PUT_LINE('Bonificaci�n = ' || v_sueldo/20);
elsif v_sueldo is null then
  DBMS_OUTPUT.PUT_LINE('Bonificaci�n = ' || 0);
end if;
END;

-- Ejercicio 14

create table emp as select * from emple;
select * from emp;
select round(salario/100000) from emp where emp_no=7902;
alter table emp add(stars VARCHAR2(50));

declare
v_stars varchar2(50);
v_contStars number(2);
begin
select round(salario/100000) into v_contStars from emp where emp_no=7902;
for i in 1..v_contStars loop
v_stars:=v_stars||'*';
end loop;
DBMS_OUTPUT.PUT_LINE(v_stars);
update emp set stars=v_stars where emp_no=7902;
end;

--Ejercicio 15
SELECT * FROM EMPLE;
SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO DESC;

DECLARE
V_FECHA_ALT EMPLE.FECHA_ALT%TYPE;
V_APELLIDO EMPLE.APELLIDO%TYPE;
CURSOR C_EMPLE IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO ASC;

BEGIN
OPEN C_EMPLE;
LOOP
FETCH C_EMPLE INTO V_APELLIDO, V_FECHA_ALT;
EXIT WHEN C_EMPLE%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(V_APELLIDO ||'   '|| V_FECHA_ALT);
END LOOP;
CLOSE C_EMPLE;
END;

DECLARE
CURSOR C_EMPLE IS SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO ASC;
EMPLE_FECHA_ROW C_EMPLE%ROWTYPE;
BEGIN
OPEN C_EMPLE;
LOOP
FETCH C_EMPLE INTO EMPLE_FECHA_ROW;
EXIT WHEN C_EMPLE%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(EMPLE_FECHA_ROW.APELLIDO ||'   '||  EMPLE_FECHA_ROW.FECHA_ALT);
END LOOP;
CLOSE C_EMPLE;
END;

DECLARE
BEGIN
FOR C_EMPLE IN (SELECT APELLIDO, FECHA_ALT 
                FROM EMPLE 
                ORDER BY APELLIDO ASC) 
LOOP
DBMS_OUTPUT.PUT_LINE(C_EMPLE.APELLIDO || '   '|| C_EMPLE.FECHA_ALT);
END LOOP;
END;

--Ejercicio 16

CREATE OR REPLACE PROCEDURE SUMA_NUMEROS (NUMERO1 NUMBER, NUMERO2 NUMBER)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE('lA SUMA ES: ' || TO_CHAR(NUMERO1+NUMERO2));
END SUMA_NUMEROS;
EXECUTE SUMA_NUMEROS(1,5);

--Ejercicio 17

CREATE OR REPLACE PROCEDURE SUMA_5_NUMEROS (NUMERO1 NUMBER:=0, --si lo inicializamos no hace falta que le pasemos todos los parametros
  NUMERO2 NUMBER:=0, 
  NUMERO3 NUMBER:=0, 
  NUMERO4 NUMBER:=0, 
  NUMERO5 NUMBER:=0)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE('lA SUMA ES: ' || TO_CHAR(NUMERO1+NUMERO2+NUMERO3+NUMERO4+NUMERO5));
END SUMA_5_NUMEROS;


EXECUTE SUMA_5_NUMEROS(1,5,8);

--Ejercicio 18
CREATE OR REPLACE PROCEDURE BORRAR_EMPLE(V_EMPNO EMPLE.EMP_NO%TYPE)
IS
BEGIN
DELETE FROM EMPLE WHERE EMP_NO=V_EMPNO;
IF SQL%ROWCOUNT>0
THEN DBMS_OUTPUT.PUT_LINE('EMPLEADO '|| V_EMPNO ||' BORRADO');
END IF;
END BORRAR_EMPLE;
SELECT * FROM EMPLE;
EXECUTE BORRAR_EMPLE(1111);
--EJERCICIO 19
SELECT * FROM DEPART;
CREATE OR REPLACE PROCEDURE CAMBIAR_LOC_DEPART(V_DEPT_NO DEPART.DEPT_NO%TYPE,
                             V_LOC DEPART.LOC%TYPE )
IS 
BEGIN
UPDATE DEPART SET LOC=V_LOC WHERE DEPT_NO=V_DEPT_NO;
IF SQL%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE('NO EXISTE EL DEPARTAMENTO');
ELSE
DBMS_OUTPUT.PUT_LINE('EL DEPT: '|| V_DEPT_NO ||' TIENE COMO LOCALIDAD: '||V_LOC);
COMMIT;
END IF;
END CAMBIAR_LOC_DEPART;

EXECUTE CAMBIAR_LOC_DEPART(40, 'VITORIA');

--TEOR�A
SELECT * FROM USER_OBJECTS;
DESCRIBE SUMA_5_NUMEROS;
--EJERCICIO 20
SELECT OBJECT_NAME, STATUS FROM USER_OBJECTS 
WHERE OBJECT_TYPE IN 'PROCEDURE' OR OBJECT_TYPE = 'FUNCTION';
-- EJERCICIO 21
CREATE OR REPLACE PROCEDURE INCREMENTAR_SALARIO(V_EMP_NO EMPLE.EMP_NO%TYPE, V_INCREMENTO EMPLE.SALARIO%TYPE)
IS
BEGIN
UPDATE EMPLE SET SALARIO=SALARIO+V_INCREMENTO WHERE EMP_NO=V_EMP_NO;
IF SQL%NOTFOUND THEN
DBMS_OUTPUT.PUT_LINE('NO EXISTE EL EMPLEADO');
ELSE
DBMS_OUTPUT.PUT_LINE('SUELDO INCREMENTADO ');
COMMIT;
END IF;
END;
SELECT * FROM EMPLE;
EXECUTE INCREMENTAR_SALARIO(7369, 100);
-- EJERCICIO 22
CREATE OR REPLACE FUNCTION SALARIO_ANUAL(V_SUELDO_MENSUAL EMPLE.SALARIO%TYPE , V_COMISION EMPLE.COMISION%TYPE)
RETURN NUMBER
IS
V_TOTAL NUMBER;
BEGIN
RETURN (NVL(V_SUELDO_MENSUAL,0)+NVL(V_COMISION,0)) * 12;
END;
SELECT EMP_NO, APELLIDO, SALARIO_ANUAL(SALARIO, COMISION) 
FROM EMPLE WHERE DEPT_NO=30;

--EJERCICIO 23
CREATE OR REPLACE FUNCTION FACTORIAL(N NUMBER)
RETURN NUMBER
IS 
V_TOTAL NUMBER:=1;
BEGIN
FOR I IN 1..N LOOP
V_TOTAL:=V_TOTAL*I;
END LOOP;
RETURN V_TOTAL;
END;
DECLARE
V_FACTORIAL NUMBER;
BEGIN
V_FACTORIAL := FACTORIAL(3);
DBMS_OUTPUT.PUT_LINE(TO_CHAR(V_FACTORIAL));
END;



--Ejercicio 24
CREATE OR REPLACE FUNCTION VALIDAR_DEPT_NO(N DEPART.DEPT_NO%TYPE)
RETURN BOOLEAN
IS
V_DNOMBRE DEPART.DNOMBRE%TYPE:='NULL';
BEGIN
SELECT DNOMBRE INTO V_DNOMBRE FROM DEPART WHERE DEPT_NO=N;
RETURN SQL%FOUND;

EXCEPTION
  WHEN no_data_found then
return false;
END VALIDAR_DEPT_NO;

SELECT * FROM EMPLE;

CREATE OR REPLACE PROCEDURE NUEVO_EMP(V_APELLIDO EMPLE.APELLIDO%TYPE, 
                                      V_EMP_NO EMPLE.EMP_NO%TYPE, 
                                      V_DEPT_NO EMPLE.DEPT_NO%TYPE)
IS
BEGIN
IF VALIDAR_DEPT_NO(V_DEPT_NO) THEN
  DBMS_OUTPUT.PUT_LINE('INSERTANDO REGISTRO...');
  INSERT INTO EMPLE(APELLIDO, EMP_NO, DEPT_NO) VALUES(V_APELLIDO, V_EMP_NO, V_DEPT_NO);
      IF SQL%FOUND THEN 
         DBMS_OUTPUT.PUT_LINE('REGISTRO INSERTADO');
      END IF;
ELSE
DBMS_OUTPUT.PUT_LINE('EL DEPARTAMENTO NO EXISTE');
END IF;
END NUEVO_EMP;

EXECUTE NUEVO_EMP('DIAZ', '1257', '31');

--Ejercicio 25

CREATE OR REPLACE FUNCTION DIF_SALARIO(V_EMP_NO EMPLE.EMP_NO%TYPE)
RETURN EMPLE.SALARIO%TYPE
IS
V_SALARIO_MAX EMPLE.SALARIO%TYPE;
V_SALARIO_EMP EMPLE.SALARIO%TYPE;
V_DEPT_NO_EMP EMPLE.DEPT_NO%TYPE;
BEGIN
SELECT DEPT_NO INTO V_DEPT_NO_EMP FROM EMPLE WHERE EMP_NO=V_EMP_NO;
SELECT MAX(SALARIO) INTO V_SALARIO_MAX FROM EMPLE WHERE DEPT_NO=V_DEPT_NO_EMP; 
SELECT SALARIO INTO V_SALARIO_EMP FROM EMPLE WHERE EMP_NO=V_EMP_NO;

RETURN V_SALARIO_MAX-V_SALARIO_EMP;

EXCEPTION
  WHEN NO_DATA_FOUND 
    THEN
      RETURN -1;
END DIF_SALARIO;

SELECT * FROM EMPLE;

BEGIN 
DBMS_OUTPUT.PUT_LINE(DIF_SALARIO(7876));
END;

--EJERCICIO 26
DESC EMPLE;
DROP TABLE MENSAJES;
CREATE TABLE MENSAJES(MENSAJE VARCHAR2(50), APELLIDO VARCHAR2(10), SALARIO NUMBER(10));

CREATE OR REPLACE PROCEDURE APELLIDO_SUELDO(V_SAL EMPLE.SALARIO%TYPE)
IS
V_APELLIDO EMPLE.APELLIDO%TYPE;
BEGIN
SELECT APELLIDO INTO V_APELLIDO FROM EMPLE WHERE SALARIO=V_SAL;
IF SQL%FOUND THEN
    INSERT INTO MENSAJES (APELLIDO, SALARIO) VALUES(V_APELLIDO, V_SAL);
END IF;
EXCEPTION
WHEN TOO_MANY_ROWS THEN
  INSERT INTO MENSAJES (MENSAJE) VALUES('M�s de un empleado con el salario ' || V_SAL);
WHEN NO_DATA_FOUND THEN
  INSERT INTO MENSAJES (MENSAJE) VALUES('No hay empleados con el salario de ' || V_SAL);
  WHEN OTHERS THEN
   INSERT INTO MENSAJES (MENSAJE) VALUES('Cualquier otro error producido');
END APELLIDO_SUELDO;

EXECUTE APELLIDO_SUELDO(390000);
SELECT * FROM EMPLE;
SELECT * FROM MENSAJES;

--Ejercicio 27
CREATE OR REPLACE PROCEDURE NUMERO_EMPLEADOS(V_SALARIO EMPLE.SALARIO%TYPE)
IS
V_EMPLE EMPLE.APELLIDO%TYPE;
V_NUMERO_EMPLE NUMBER;
BEGIN
SELECT APELLIDO INTO V_EMPLE FROM EMPLE WHERE SALARIO BETWEEN V_SALARIO-1000 AND V_SALARIO+1000;
IF V_EMPLE IS NOT NULL THEN
DBMS_OUTPUT.put_line('1. ' || V_EMPLE);
END IF;
EXCEPTION
WHEN TOO_MANY_ROWS THEN
 SELECT COUNT(*) INTO V_NUMERO_EMPLE FROM EMPLE WHERE SALARIO BETWEEN V_SALARIO-1000 AND V_SALARIO+1000;
DBMS_OUTPUT.put_line('N�MERO DE EMPLEADOS QUE COBRAN ENTRE '
                    ||TO_CHAR(V_SALARIO -1000)||' Y '||TO_CHAR(V_SALARIO+1000)
                    ||' = '||TO_CHAR(V_NUMERO_EMPLE));
WHEN NO_DATA_FOUND THEN
 DBMS_OUTPUT.put_line('NO HAY NADIE EN ESE RANGO');
WHEN OTHERS THEN
   DBMS_OUTPUT.put_line('ERROR !!!');
END;

EXECUTE NUMERO_EMPLEADOS(0);

--EJERCICIO 28
DESC EMPLE;
CREATE OR REPLACE PROCEDURE INSERTAR_EMPLE(V_EMP_NO EMPLE.EMP_NO%TYPE, 
                                           V_APELLIDO EMPLE.APELLIDO%TYPE, 
                                           V_OFICIO EMPLE.OFICIO%TYPE,
                                           V_DIR EMPLE.DIR%TYPE,
                                           V_FECHA_ALT EMPLE.FECHA_ALT%TYPE,
                                           V_SALARIO EMPLE.SALARIO%TYPE,
                                           V_COMISION EMPLE.COMISION%TYPE,
                                           V_DEPT_NO EMPLE.DEPT_NO%TYPE)
AS
V_DEPT_NO_VERIF NUMBER;
DEPT_NO_NO_VALIDO EXCEPTION;
V_DIR_VERIF NUMBER;
V_DIR_NO_EXISTE EXCEPTION;
V_EMP_NO_VERIF NUMBER;
V_EMP_NO_EXISTE EXCEPTION;
BEGIN
SELECT COUNT(*) INTO V_DEPT_NO_VERIF FROM EMPLE WHERE DEPT_NO=V_DEPT_NO;
SELECT COUNT(*) INTO V_DIR_VERIF FROM EMPLE WHERE DIR=V_DIR;
SELECT COUNT(*) INTO V_EMP_NO_VERIF FROM EMPLE WHERE EMP_NO=V_EMP_NO;

IF V_DEPT_NO_VERIF=0 THEN 
RAISE DEPT_NO_NO_VALIDO;
END IF;
IF V_DIR_VERIF=0 THEN 
RAISE V_DIR_NO_EXISTE;
END IF;
IF V_EMP_NO_VERIF>0 THEN 
RAISE V_EMP_NO_EXISTE;
END IF;

INSERT INTO EMPLE VALUES(V_EMP_NO, V_APELLIDO, V_OFICIO,V_DIR, V_FECHA_ALT,V_SALARIO,V_COMISION,V_DEPT_NO);

EXCEPTION
WHEN DEPT_NO_NO_VALIDO THEN
DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO NO EXISTE');
WHEN V_DIR_NO_EXISTE THEN 
DBMS_OUTPUT.PUT_LINE('jEFE NO EXISTE');
WHEN V_EMP_NO_EXISTE THEN
DBMS_OUTPUT.PUT_LINE('ESE EMPLEADO YA EXISTE');
END INSERTAR_EMPLE;
--CON WHEN DUP_VAL_ON_INDEX THEN PODEMOS UTILIZAR EXCEPCION DEL SISTEMA PARA SABER SI ESTAMOS INTENTANDO METER DUPLICADOS
EXECUTE INSERTAR_EMPLE(6839,'SDFV','ACVDS',7839,SYSDATE,23424234,NULL,30);

--EJERCICIO 29

CREATE TABLE AVISOS(MENSAJE_ERROR VARCHAR2(50));
RENAME AVISOS TO TABLA_AVISOS;
CREATE OR REPLACE PROCEDURE DEMASIADOS_EMPLE(V_EMP_NO EMPLE.EMP_NO%TYPE)
AS
V_EMP_NO_VERIF NUMBER;
V_EMP_NO_EXISTE EXCEPTION;
E_DEMASIADOS_EMPLE EXCEPTION;
V_NUM_EMPLE_DEPT NUMBER;
V_DEPT_NO EMPLE.DEPT_NO%TYPE;
BEGIN

SELECT COUNT(*) INTO V_EMP_NO_VERIF FROM EMPLE WHERE EMP_NO=V_EMP_NO;
IF V_EMP_NO_VERIF=0 THEN 
RAISE V_EMP_NO_EXISTE;
END IF;
SELECT DEPT_NO INTO V_DEPT_NO FROM EMPLE WHERE EMP_NO=V_EMP_NO;
SELECT COUNT(*) INTO V_NUM_EMPLE_DEPT FROM EMPLE WHERE DEPT_NO=V_DEPT_NO;
IF V_NUM_EMPLE_DEPT >5 THEN 
RAISE E_DEMASIADOS_EMPLE;
END IF;
EXCEPTION
WHEN V_EMP_NO_EXISTE THEN
DBMS_OUTPUT.PUT_LINE('ESE EMPLEADO YA EXISTE');
INSERT INTO TABLA_AVISOS VALUES('ESE EMPLEADO NO EXISTE');
WHEN E_DEMASIADOS_EMPLE THEN
DBMS_OUTPUT.PUT_LINE('DEMASIADOS EMPLEADOS EN ESTE DEPARTAMENTO');
INSERT INTO TABLA_AVISOS VALUES('DEMASIADOS EMPLEADOS EN ESTE DEPARTAMENTO');
END;
EXECUTE DEMASIADOS_EMPLE(6839);
SELECT * FROM EMPLE;
SELECT * FROM TABLA_AVISOS;

--EJERCICIO 30

ALTER TABLE SALARIOS_MAS_ALTOS MODIFY (SALARIO NUMBER(10));
DESC SALARIOS_MAS_ALTOS;

CREATE OR REPLACE PROCEDURE SUELDOS_MAS_ALTOS(N NUMBER)
AS
V_N NUMBER:=N;
BEGIN
FOR SALARIOS IN (SELECT DISTINCT(SALARIO) AS SALARIOS 
                FROM EMPLE 
                ORDER BY SALARIO DESC)
  LOOP
  IF V_N>0 THEN
  INSERT INTO SALARIOS_MAS_ALTOS VALUES(SALARIOS.SALARIOS);
  DBMS_OUTPUT.PUT_LINE(SALARIOS.SALARIOS);
  V_N := V_N-1;
  END IF;
  END LOOP;
DBMS_OUTPUT.PUT_LINE('FIN');
EXCEPTION
WHEN CURSOR_ALREADY_OPEN THEN 
DBMS_OUTPUT.PUT_LINE('CURSOR YA ABIERTO');
WHEN INVALID_CURSOR THEN 
DBMS_OUTPUT.PUT_LINE('CURSOR INVALIDO');
WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE('ALGO HA FALLADO');
END SUELDOS_MAS_ALTOS;

EXECUTE SUELDOS_MAS_ALTOS (18);

SELECT * FROM SALARIOS_MAS_ALTOS;
TRUNCATE TABLE SALARIOS_MAS_ALTOS;
SELECT * FROM SALARIOS_MAS_ALTOS;

--TRIGGERS--
--ejercicio 1
CREATE TABLE AUDITAR(
USUARIO VARCHAR2(50),
FECHA DATE
);
CREATE OR REPLACE TRIGGER AUDITORIA_ACCESSOS AFTER LOGON ON SCHEMA

 BEGIN
 INSERT INTO AUDITAR VALUES(USER, SYSDATE);
 
 END;
SELECT * FROM AUDITAR;
--ejercicio 2
CREATE OR REPLACE TRIGGER COMPROBAR_COMISION BEFORE INSERT ON EMPLE  
FOR EACH ROW WHEN (NEW.COMISION=0)
BEGIN
DBMS_OUTPUT.PUT_LINE('INTRODUZCA UNA COMISION DE 1 ');
END;
INSERT INTO EMPLE (EMP_NO, APELLIDO, COMISION, DEPT_NO) VALUES(1244, 'HOLA', 0,30);
SELECT * FROM EMPLE;

--ejercicio 3
CREATE OR REPLACE TRIGGER COMPROBAR_COMISION BEFORE INSERT ON EMPLE  
FOR EACH ROW WHEN (NEW.COMISION=0)
BEGIN
:NEW.COMISION:=1;
DBMS_OUTPUT.PUT_LINE('MODIFICADA COMISION A 1 ');
END;
INSERT INTO EMPLE (EMP_NO, APELLIDO, COMISION, DEPT_NO) VALUES(1245, 'HOLA', 0,30);
DELETE FROM EMPLE WHERE APELLIDO LIKE 'HOLA';
SELECT * FROM EMPLE;

--EJERCICIO 4
CREATE TABLE TABLA_CONTROL_EMPLE(FECHA VARCHAR2(15), USUARIO VARCHAR2(50));

CREATE OR REPLACE TRIGGER CONTROL_EMPLE 
AFTER INSERT OR DELETE OR UPDATE ON EMPLE
FOR EACH ROW 
BEGIN
INSERT INTO TABLA_CONTROL_EMPLE VALUES(SYSDATE, USER);
END;
SELECT * FROM TABLA_CONTROL_EMPLE;

-- EJERCICIO 5
CREATE OR REPLACE TRIGGER NO_INSERT_VENTAS 
BEFORE INSERT ON EMPLE 
FOR EACH ROW
DECLARE 
V_DEPT_NO_VENTAS EMPLE.DEPT_NO%TYPE;
V_DEPT_NO_PRODUCCION EMPLE.DEPT_NO%TYPE;
BEGIN
SELECT DEPT_NO INTO V_DEPT_NO_VENTAS FROM DEPART WHERE DNOMBRE='VENTAS';
SELECT DEPT_NO INTO V_DEPT_NO_PRODUCCION FROM DEPART WHERE DNOMBRE='PRODUCCION';
IF :NEW.DEPT_NO=V_DEPT_NO_VENTAS THEN
:NEW.DEPT_NO:=V_DEPT_NO_PRODUCCION;
END IF;
END;
SELECT * FROM DEPART;
INSERT INTO EMPLE (EMP_NO, APELLIDO, COMISION, DEPT_NO) VALUES(1246, 'HOLA', 0,30);

--EJERCICIO 6
CREATE OR REPLACE TRIGGER NO_SALARIO_20PERCENT 
BEFORE UPDATE 
ON EMPLE 
FOR EACH ROW 
WHEN (NEW.SALARIO>OLD.SALARIO*1.20)
BEGIN
:NEW.SALARIO:=:OLD.SALARIO;
DBMS_OUTPUT.put_line('SALARIO DEMASIADO ALTO!!');
END;
SELECT * FROM EMPLE;
UPDATE EMPLE SET SALARIO=4000 WHERE EMP_NO=1246;

--EJERCICIO 7
CREATE OR REPLACE TRIGGER NO_EMPLEADOS_JEFE
BEFORE UPDATE OR INSERT
ON EMPLE 
FOR EACH ROW
DECLARE
V_NUM_EMPLEADOS NUMBER;
V_CONTADOR NUMBER:=0;
V_DIR_VACIO NUMBER(4):=NULL;
BEGIN
FOR EMPLEADOS IN (SELECT EMP_NO FROM EMPLE WHERE DIR=:NEW.DIR)
  LOOP
  V_CONTADOR:=V_CONTADOR+1;
  END LOOP;
  IF V_CONTADOR>=5 THEN
  DBMS_OUTPUT.PUT_LINE('DEMASIADOS TRABAJADORES');
  :NEW.DIR:=V_DIR_VACIO;
  END IF;
END;

INSERT INTO EMPLE (EMP_NO, DIR, APELLIDO,DEPT_NO)
VALUES(1321, 7698, 'HOLA',40);
--NO VA BIEN
SELECT * FROM EMPLE;
desc emple;

--EJERCICIO 8
CREATE OR REPLACE VIEW EMP_NO_DNOMBRE AS SELECT E.EMP_NO, D.DNOMBRE FROM EMPLE E, DEPART D WHERE E.DEPT_NO=D.DEPT_NO;

CREATE OR REPLACE TRIGGER INSERT_VISTA 
INSTEAD OF INSERT ON EMP_NO_DNOMBRE
FOR EACH ROW
DECLARE
V_DEPT_NO EMPLE.DEPT_NO%TYPE;
NO_ENCONTRADO BOOLEAN;
NUEVO_DEPT_NO DEPART.DEPT_NO%TYPE;
BEGIN
NO_ENCONTRADO:=TRUE;
FOR DEPARTAMENTO IN (SELECT DNOMBRE FROM DEPART)
LOOP
IF DEPARTAMENTO.DNOMBRE LIKE :NEW.DNOMBRE THEN --OJO PONEMOS .LA COLUMNA, SI NO EL CURSOR CASCA AL COMPILAR
NO_ENCONTRADO:=FALSE;
END IF;
END LOOP;
IF NO_ENCONTRADO THEN
SELECT MAX(DEPT_NO) INTO NUEVO_DEPT_NO FROM DEPART;
INSERT INTO DEPART (DEPT_NO, DNOMBRE) VALUES(NUEVO_DEPT_NO+10, :NEW.DNOMBRE);
END IF;
SELECT DEPT_NO INTO V_DEPT_NO FROM DEPART WHERE DNOMBRE=:NEW.DNOMBRE; 
INSERT INTO EMPLE (EMP_NO, APELLIDO, FECHA_ALT, DEPT_NO) VALUES(:NEW.EMP_NO, 'INSTRIG', SYSDATE, V_DEPT_NO);
END;

DESC EMP_NO_DNOMBRE;
INSERT INTO EMP_NO_DNOMBRE VALUES(1237, 'ADISV');
SELECT * FROM DEPART;
SELECT * FROM EMPLE;

--EJERCICIO 9
CREATE TABLE AUDITARBIS (
USUARIO VARCHAR2(40), 
TIPO VARCHAR2(40), 
NOMBRE_OBJ VARCHAR2(40), 
FECHA DATE
);

CREATE OR REPLACE TRIGGER CONTROL_CREATES
AFTER CREATE ON SCHEMA
BEGIN
INSERT INTO AUDITARBIS VALUES(USER, ORA_DICT_OBJ_TYPE, ORA_DICT_OBJ_NAME, SYSDATE);
END;

SELECT * FROM AUDITARBIS;

--EJERCICIO 10
SELECT trigger_name FROM USER_TRIGGERS;
ALTER TRIGGER CONTROL_CREATES DISABLE;
ALTER TRIGGER CONTROL_CREATES ENABLE;

BEGIN
FOR TRIG IN (SELECT trigger_name FROM USER_TRIGGERS)
LOOP
ALTER TRIGGER TRIG DISABLE; --NO FUNCIONA EL ALTER EN PROCEDIMIENTOS
END LOOP;
END;


--EJERCICIO EXTRA

CREATE TABLE socio (
codsoc NUMBER constraint cp_socio PRIMARY KEY ,
nombre varchar(40) NOT NULL,
dir varchar(60),
tel varchar(15),
email varchar(50),
totalpres number default 0 not null );
CREATE TABLE libro (
codlib number constraint cp_libro PRIMARY KEY,
titulo varchar(50) NOT NULL,
autores varchar(60) NOT NULL,
area varchar(20) constraint ck_libro CHECK (area IN ('Fisica','Quimica','Arte','Literatura')) );
CREATE TABLE prestamo (
codlib number,
codsoc number ,
fechapres date,
fechadev date,
constraint cp_prestamo PRIMARY KEY(codlib, fechapres),
constraint ca_pre_libro FOREIGN KEY (codlib) REFERENCES libro,
constraint ca_pre_socio FOREIGN KEY (codsoc) REFERENCES socio ,
constraint ck_fechas CHECK (fechapres <= fechadev) );

SELECT * FROM AUDITARBIS;

--EJERCICIO 1
CREATE TRIGGER CONTROLSOCIO
AFTER INSERT ON PRESTAMO
FOR EACH ROW 
BEGIN
IF :NEW.FECHADEV IS NULL THEN
UPDATE SOCIO SET TOTALPRES = TOTALPRES+1
WHERE CODSOC = :NEW.CODSOC;
END IF;
END;
--EJERCICIO 2
CREATE OR REPLACE TRIGGER MOD_CODSOC 
BEFORE UPDATE of codsoc ON PRESTAMO 
FOR EACH ROW 
begin
update socio set totalpres

--EJERCICIO 3
CREATE OR REPLACE TRIGGER PREST_NUEVO_SOCIO_TOT_0 
BEFORE INSERT ON SOCIO
FOR EACH ROW
BEGIN
:NEW.TOTALPRES:=0;
END;

--EJERCICIO 4

CREATE OR REPLACE TRIGGER DEVOLUCIONES 
AFTER UPDATE OF FECHADEV ON PRESTAMO
FOR EACH ROW
BEGIN
IF :NEW.FECHADEV IS NULL AND :OLD.FECHADEV IS NOT NULL THEN
UPDATE SOCIO SET TOTALPRES = TOTALPRES+1 WHERE CODSOC = :NEW.CODSOC;
ELSE IF :NEW.FECHADEV IS NOT NULL AND :OLD.FECHADEV IS NULL THEN 
UPDATE SOCIO SET 

--EJERCICIO 5
CREATE OR REPLACE TRIGGER ELIMINAR_PRESTAMO
before DELETE ON prestamo
FOR EACH ROW when (OLD.fechadev IS NULL)
BEGIN
UPDATE socio SET totalpres = totalpres -1 WHERE codsoc = :OLD.codsoc;
END;

--ejercicio 6
CREATE TABLE AUDITAR_PRESTAMOS(NOMBRE VARCHAR2(20), ACCION VARCHAR2(20) ,FECHA DATE);
create or REPLACE TRIGGER AUDITAR_PRESTAMO
AFTER INSERT OR UPDATE OR DELETE ON PRESTAMO
FOR EACH ROW
BEGIN
INSERT INTO AUDITAR_PRESTAMOS VALUES(USER, ORA_DICT_OBJ_NAME, SYSDATE);
END;

--EJERCICIO 7
CREATE OR REPLACE TRIGGER NO_ARTE 
BEFORE INSERT ON LIBRO
FOR EACH ROW  WHEN (NEW.area='Arte')
BEGIN
:NEW.area:='Literatura';
END;

--EJERCICIO 8
CREATE TABLE MAILING 
(EMAIL varchar(50), 
FECHA_PRESTAMO DATE, 
TITULO_LIBRO varchar(50), 
DIAS NUMBER );
CREATE OR REPLACE TRIGGER CONTROL_DEV
BEFORE LOGOFF ON SCHEMA
DECLARE
V_DIAS MAILING.DIAS%TYPE;
V_EMAIL SOCIO.EMAIL%TYPE;
V_FECHA PRESTAMO.FECHAPRES%TYPE;
V_TITULO LIBRO.TITULO%TYPE;
BEGIN
FOR CODIGOLIB_CUR IN (SELECT CODLIB FROM PRESTAMO WHERE FECHAPRES+15<=SYSDATE)
LOOP
SELECT S.EMAIL, P.FECHAPRES, TITULO, SYSDATE-(P.FECHAPRES+15) 
INTO V_EMAIL, V_FECHA, V_TITULO, V_DIAS FROM SOCIO S, LIBRO L, PRESTAMO P 
WHERE P.CODLIB=L.CODLIB AND P.CODSOC = S.CODSOC;
END LOOP;
END;

--ejercicio 9
CREATE OR REPLACE TRIGGER ELIMINAR_LIBRO 
BEFORE DELETE ON LIBRO
FOR EACH ROW
BEGIN
DELETE FROM PRESTAMO WHERE CODLIB=:OLD.CODLIB;
END;


--Ejercicio Paquetes
-- 1.-
CREATE OR REPLACE PROCEDURE insertar_depart(V_DNOMBRE DEPART.DNOMBRE%TYPE, V_LOC DEPART.LOC%TYPE)
IS
NO_ENCONTRADO BOOLEAN;
NUEVO_DEPT_NO DEPART.DEPT_NO%TYPE;
BEGIN
NO_ENCONTRADO:=TRUE;
FOR DEPARTAMENTO IN (SELECT DNOMBRE FROM DEPART)
LOOP
IF DEPARTAMENTO.DNOMBRE LIKE V_DNOMBRE THEN --OJO PONEMOS .LA COLUMNA, SI NO EL CURSOR CASCA AL COMPILAR
NO_ENCONTRADO:=FALSE;

END IF;
END LOOP;
IF NO_ENCONTRADO THEN
SELECT MAX(DEPT_NO) INTO NUEVO_DEPT_NO FROM DEPART;
INSERT INTO DEPART (DEPT_NO, DNOMBRE, LOC) VALUES(NUEVO_DEPT_NO+10, V_DNOMBRE, V_LOC);
ELSE
DBMS_OUTPUT.PUT_line('DEPARTAMENTO EXISTENTE');
END IF;
END;

DESC DEPART;
SELECT * FROM DEPART;
EXECUTE INSERTAR_DEPART('HOLA', 'VITORIA');

-- 2.-
CREATE OR REPLACE PROCEDURE borrar_depart(V_DEPT_NO_BORRAR DEPART.DEPT_NO%TYPE, 
                                         V_DEPT_NO_EMPLE_HUERF DEPART.DEPT_NO%TYPE)
IS
DEPT_NO_EXISTE_EXCEPTION EXCEPTION;
SELECT_DEPT_NO EMPLE.DEPT_NO%TYPE;
BEGIN
SELECT DEPT_NO INTO SELECT_DEPT_NO FROM DEPART WHERE DEPT_NO=V_DEPT_NO_BORRAR;

UPDATE EMPLE SET DEPT_NO=V_DEPT_NO_EMPLE_HUERF WHERE DEPT_NO=V_DEPT_NO_BORRAR;
DELETE FROM DEPART WHERE DEPT_NO=V_DEPT_NO_BORRAR;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_line('DEPARTAMENTO NO EXISTE');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_line('NO SE PUEDE');
END;

INSERT INTO EMPLE VALUES('1212', 'DIAZ', 'ASCA', '7839', SYSDATE, 12, 12, 70);
SELECT * FROM EMPLE;
EXECUTE BORRAR_DEPART(60, 50);
SELECT * FROM DEPART;
SELECT * FROM EMPLE;

ALTER TRIGGER NO_EMPLEADOS_JEFE DISABLE;
-- 3.-
CREATE OR REPLACE PROCEDURE CAMBIAR_LOCALIDAD(V_DEPT_NO DEPART.DEPT_NO%TYPE, V_LOC DEPART.LOC%TYPE)
AS
DEPT_EXCEPTION DEPART.DEPT_NO%TYPE;
BEGIN
SELECT DEPT_NO INTO DEPT_EXCEPTION FROM DEPART WHERE DEPT_NO=V_DEPT_NO;
UPDATE DEPART SET LOC=V_LOC WHERE DEPT_NO=V_DEPT_NO;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_line('DEPARTAMENTO NO EXISTE');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_line('NO SE PUEDE MODIFICAR');
END;

EXECUTE CAMBIAR_LOCALIDAD (50, 'LUGO');
SELECT * FROM DEPART;
-- 4.- 

