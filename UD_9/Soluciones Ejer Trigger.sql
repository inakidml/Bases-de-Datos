

Atencion: los triggers solo se ejecutaran si las operaciones DDL o eventos que los lanzan se dan correctamente.

1.create table auditar
(nombre varchar(20),
fecha date
)
CREATE OR REPLACE TRIGGER CONTROLUSUARIO
AFTER LOGON
ON DATABASE
BEGIN
INSERT INTO AUDITAR VALUES(USER,SYStimestamp)
END

2.

CREATE OR REPLACE TRIGGER  insert_comision
BEFORE INSERT ON emple
FOR EACH ROW
declare
--comision_invalida EXCEPTION;
BEGIN
IF :new.comision < 1 THEN  
--raise comision_invalida
RAISE_APPLICATION_ERROR(-20000, 'Recuerde que la
comision minima admitida es 1');
END IF;
--exception
--when comision_invalida then
--dbms_output.put_line("Error");


END;
insert into emple values(324566,434354,1);


3.
Alter TRIGGER insert_comision DISABLE;


CREATE OR REPLACE TRIGGER  insert_comision
BEFORE INSERT ON emple
FOR EACH ROW

BEGIN
IF :new.comision < 1 THEN
:new.comision:=1;

END IF;



END;
Insert into emple values(pepe,aiudfi,1);





4.
CREATE TABLE Ctrl_Empleados(
Tabla varchar2(25),
Usuario varchar2(20),
fecha date,
op varchar2(20)
)

CREATE OR REPLACE TRIGGER Control_Empleados
AFTER INSERT OR DELETE OR UPDATE ON Emple 
declare
op varchar(20);
BEGIN
if inserting then
op:='insercion';
elsif updating then
op:= 'modificacion';
elsif deleting then
 op:='borrado';
end if;
INSERT INTO Ctrl_Empleados (Tabla,Usuario,Fecha,op)
VALUES ('Emple', USER, SYSDATE,op);
END Control_Empleados;

Otra forma:

CREATE OR REPLACE TRIGGER Control_Empleados
AFTER INSERT OR DELETE OR UPDATE ON Emple
BEGIN
IF INSERTING THEN
INSERT INTO Ctrl_Empleados (Tabla,Usuario,Fecha,Oper)
VALUES ('Empleados', USER, SYSDATE,'INSERT');
ELSIF DELETING THEN
INSERT INTO Ctrl_Empleados (Tabla,Usuario,Fecha,Oper)
VALUES ('Empleados', USER, SYSDATE,'DELETE');
ELSE
INSERT INTO Ctrl_Empleados (Tabla,Usuario,Fecha,Oper)
VALUES ('Empleados', USER, SYSDATE,'UPDATE');
end If;
END Control_Empleados;


5.CREATE OR REPLACE TRIGGER dis_empleados_insertar
  BEFORE INSERT on emple
   FOR EACH ROW
	declare
	v_num number(2);
	nuevo number(2);
  BEGIN 
	SELECT DEPT_NO into v_num FROM DEPART WHERE DNOMBRE='VENTAS';
	if (:new.dept_no = v_num ) then
	SELECT DEPT_NO into nuevo FROM DEPART WHERE DNOMBRE='PRODUCCION';
	:NEW.dept_no:= nuevo;
    raise_application_error(-20111,'No puede ingresar empleados en el departamnto "Ventas".');
  END IF;
  end;



CREATE OR REPLACE TRIGGER dis_empleados_insertar
 BEFORE INSERT on emple
  FOR EACH ROW
  WHEN NEW.dept_no =(SELECT DEPT_NO FROM DEPARTAMENTO WHERE NOMBRE='ventas')
  BEGIN 
 
	raise_application_error('No puede ingresar empleados en l departamnto "Ventas".');

   end;

6.

CREATE OR REPLACE TRIGGER aumentoSalario
BEFORE UPDATE OF salario ON emple
FOR EACH ROW
BEGIN
IF :NEW.salario > :OLD.salario*1.20
THEN raise_application_error
(-20600,:new.Salario||'no se puede aumentar el
salario más de un 20%');
END IF;
END;




7.
SOLUCIÓN 1: EVITAR TRATAMIENTO A NIVEL DE FILA

En vez de tratar a nivel de registro, se pudiera tratar a nivel de sentencia evitando poner “FOR EACH ROW”, 
se solventaría el problema. 

CREATE OR REPLACE TRIGGER jefesb
BEFORE INSERT ON emple FOR EACH ROW
DECLARE supervisa INTEGER;
BEGIN
SELECT count(*) INTO supervisa
FROM emple
WHERE dir = :new.dir;
IF supervisa > 4
THEN raise_application_error (-20600,:new.dir||'no se puede supervisar
mas de 5');
END IF;
END;

SOLUCIÓN 2: EVITAR ACCEDER A LA MISMA TABLA
Debemos solucionarlo con un cursor para evitar el error de tabla mutante(no se puede
utilizar la tabla relacionado con el trigger en el bloque de codigo del mismo)
CREATE OR REPLACE TRIGGER jefes
BEFORE
INSERT or UPDATE ON emple
FOR EACH ROW 
DECLARE

							 
CURSOR CEMPLE IS select *
				 from emple
				where jefe.emp_no=:new.dir;	
				
CCEMPLE 		CEMPLE%ROWTYPE;
CONTAR 			NUMBER(3):=0;
MAS_DE_CINCO	EXCEPTION;
BEGIN
	OPEN CEMPLE;
	loop
		FETCH CEMPLE INTO CCEMPLE;
		
		EXIT WHEN CEMPLE%NOTFOUND;
	END LOOP;
	CONTAR:=CEMPLE%ROWCOUNT;
	CLOSE CEMPLE;
	IF CONTAR >4 THEN
		RAISE MAS_DE_CINCO;
	END IF;
EXCEPTION
	WHEN MAS_DE_CINCO THEN
		DBMS_OUTPUT.PUT_LINE('NO PUEDE SER JEFE DE MÁS DE CINCO PERSONAS.');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('APLICACIÓN CERRADA INESPERADAMENTE.');
END;







8.CREATE VIEW EmpleadoDpto as
SELECT E.emp_no, D.DNombre FROM Emple E, Depart D
WHERE E.Dept_no = D.dept_no;

CREATE OR REPLACE TRIGGER InsertEmpleadoDpto
INSTEAD OF INSERT ON EmpleadoDpto
DECLARE
V_Cod number;
BEGIN
SELECT dept_no INTO V_Cod FROM DEPART Where DNombre= :NEW.DNombre;
INSERT INTO Emple VALUES(:NEW.emp_no,NULL,NULL,NULL,sysdate, 0,0,V_Cod);
END;



Solución en la que se contempla la posibilidad de que el departamento no exista y se quiera cargar en la tabla depart.
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





9.


create table auditarbis(
usuario varchar2(20),
tipo VARCHAR2(20),
nombre_obj  VARCHAR2(30),
fecha date
)


CREATE OR REPLACE TRIGGER Control_creates
AFTER CREATE ON SCHEMA
BEGIN
INSERT INTO auditarbis
VALUES (USER, ORA_DIcT_OBJ_TYPE,ORA_DICT_OBJ_NAME,SYSDATE);
END;

10.
SELECT TRIGGER_NAME , STATUS FROM USER_TRIGGERS;

ALTER TRIGGER nombre_disparador DISABLE;
