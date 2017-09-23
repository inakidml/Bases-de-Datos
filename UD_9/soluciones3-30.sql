3.
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hola Mundo');
END;


4.
DECLARE 
   v_apel	emple.apellido%type; 
   v_ofi  emple.oficio%type;
BEGIN
v_ofi:='pastelero';
SELECT APELLIDO , oficio into v_apel, v_ofi
FROM emple
WHERE emp_no=7839;
--DBMS_OUTPUT.PUT_LINE ('Empleado seleccionado: '||v_apel||' '||
--v_ofi);

END;

5.
DECLARE 
   v_max_deptno	depart.dept_no%type; 
BEGIN 
   SELECT MAX(dept_no)  INTO v_max_deptno  FROM	depart; 
   dbms_output.put_line(v_max_deptno); 
  END; 
  
  
  6.
  DECLARE
v_num NUMBER;
 BEGIN
SELECT count(*) INTO v_num
 FROM emple;
DBMS_OUTPUT.PUT_LINE(v_num);
 END;
 
 
 
 7.
 
 
 
 DECLARE
	v_deptno depart.dept_no%TYPE;
	
BEGIN


	-- Consulto el codigo de departamento mas alto
	SELECT MAX(dept_no) INTO v_deptno
	  FROM depart;
	  
	  
     INSERT INTO depart (dept_no, dnombre,loc) 
			VALUES (v_deptno+10,UPPER('Educacion'),NULL);
 
 
 
 END;
 
 
 
 
 
 
 
 
 
 
 
 
 DECLARE
	v_deptno depart.dept_no%TYPE;
BEGIN
	-- Consulto el codigo de departamento mas alto
	SELECT MAX(dept_no) INTO v_deptno
	  FROM depart;
	/* OJO!! No hacemos la pregunta con el atributo SQL%NOTFOUND 
	porque las select con funciones de grupo si no hay nada 
	devuelve NULL, pero devuelven. 
	Para saber si hay codigo o no tengo que preguntar
	por el valor de la variable.*/
    IF v_deptno IS NOT NULL
     THEN	
	-- Si tengo código, inserto el departamento nuevo  
		INSERT INTO depart (dept_no, dnombre,loc) 
			VALUES (v_deptno+10,UPPER('Educacion'),NULL);
		--Compruebo se ha realizado insert
        IF SQL%NOTFOUND
		THEN
			DBMS_OUTPUT.PUT_LINE('Ningun registro insertado');
		ELSE	
			DBMS_OUTPUT.PUT_LINE('Insertado el departamento '
			  ||to_char(v_deptno+10));
			COMMIT;	
        END IF;
     ELSE
           DBMS_OUTPUT.PUT_LINE(' La tabla depart esta vacia');
	END IF;
END;

8.
Añadir una localidad al depto anterior
DECLARE
v_loc depart.loc%TYPE:='Amurrio';

v_dept_no depart.dept_no%TYPE;
-- Supongo que es el 60
--v_dept_no depart.dept_no%TYPE:=60;
BEGIN
SELECT MAX(dept_no) INTO v_dept_no
	  FROM depart;
	  
	UPDATE depart
	   SET loc=UPPER(v_loc)
	   WHERE dept_no=v_dept_no; 
	IF SQL%FOUND
	THEN
	 COMMIT;
	ELSE
	 DBMS_OUTPUT.PUT_LINE('No existe el departamento'|| v_dept_no);
    END IF;
END;

9.
Eliminar el departamento anterior, diciendo el numero de filas eliminadas, y avisando de cualquier error.

DECLARE
-- Supongo que es el 60
--v_dept_no depart.dept_no%TYPE:=60;

v_dept_no depart.dept_no%TYPE;

BEGIN

 SELECT MAX(dept_no) INTO v_dept_no
	  FROM depart;
	  
  DELETE 
  FROM		depart
  WHERE	dept_no = v_dept_no; 
  IF SQL%FOUND
  THEN
      dbms_output.put_line(SQL%ROWCOUNT || ' filas(s) borradas.'); 
      ELSE
       dbms_output.put_line('EL DEPARTAMENTO NO EXISTE');
  END IF;
END; 


10.
DECLARE
   VSAL_MIN EMPLE.SALARIO%TYPE;

BEGIN
 
  SELECT MIN(SALARIO) INTO VSAL_MIN
  FROM EMPLE;

 
  UPDATE EMPLE SET SALARIO=SALARIO+VSAL_MIN 
  WHERE DEPT_NO=30;
  dbms_output.put_line('los empleados cuyo sueldo ha sido modificado son: ' || SQL%ROWCOUNT);

END;






11.

DECLARE
  
 VSAL_MED EMPLE.SALARIO%TYPE;

BEGIN
   
SELECT AVG(SALARIO) INTO VSAL_MED
  
FROM EMPLE;
   
  UPDATE EMPLE 
   SET SALARIO=SALARIO*1.1
   WHERE SALARIO<VSAL_MED;
   dbms_output.put_line('los empleados cuyo sueldo ha sido modificado son: ' || SQL%ROWCOUNT);

END;

12.
CREATE TABLE mensajes (resul NUMBER (4)); 

BEGIN
	
	FOR i IN 1..10 LOOP
	
   	 IF i <> 6 and i <> 8 THEN
	 
    	 	INSERT INTO mensajes VALUES (i);
	
    	 END IF;
	
	END LOOP;

END;

BEGIN
	
	FOR i IN 1..10 LOOP
	
   	 IF i not in (6,8) THEN
	 
    	 	INSERT INTO mensajes VALUES (i);
	
    	 END IF;
	
	END LOOP;

END;



13.
DECLARE 
	
v_empno         emple.emp_no%TYPE := 7521; 
v_sal	        emple.salario%TYPE;
v_bono_porc     NUMBER(7,2);
v_bono          NUMBER(7,2); 

BEGIN 

	SELECT salario 	INTO v_sal 
	FROM emple
  	WHERE emp_no = v_empno; 

	
	IF v_sal < 200000 THEN 
  
		  v_bono_porc := 0.10; 

	ELSIF v_sal BETWEEN 200000 and 300000 THEN 

   		 v_bono_porc := 0.15;
 
	ELSIF v_sal > 300000 THEN 
  
 		 v_bono_porc := 0.20;
 
  	ELSE 
   
		 v_bono_porc := 0; 

  	END IF; 
 
  
    v_bono := v_sal * v_bono_porc;  
 	
    DBMS_OUTPUT.PUT_LINE ('La comision para el empleado de codigo ' || v_empno 
	|| ' y salario ' || v_sal || ' es ' || v_bono); 


END; 

DECLARE 
	 v_empno         emple.emp_no%TYPE := 7521; 
	 v_sal	         emple.salario%TYPE; 
	 v_bono_porc     NUMBER(7,2); 
     v_bono          NUMBER(7,2); 
BEGIN 
	SELECT salario 	INTO v_sal 
	FROM emple
  	WHERE emp_no = v_empno; 

v_bono_porc := case
	           when v_sal< 200000 THEN   0.10
			   when v_sal BETWEEN 200000 and 300000 THEN 0.15 
			   when v_sal > 300000 THEN  0.20 
			   else 0 
			   end;
   
    v_bono := v_sal * v_bono_porc;  	   	
    DBMS_OUTPUT.PUT_LINE ('La comision para el empleado de codigo ' || v_empno 
	|| ' y salario ' || v_sal || ' es ' || v_bono); 
END; 





14.

CREATE TABLE emp
AS
SELECT *
FROM emple;

ALTER TABLE	emp
ADD stars 	VARCHAR2(50); 


DECLARE 
  v_empno         emp.emp_no%TYPE := 7902; 
  v_asteris 	  emp.stars%TYPE := NULL; 
  v_sal		      emp.salario%TYPE; 
BEGIN 
  	SELECT ROUND(salario/100000) 
  	INTO v_sal 
	FROM emp 
	WHERE emp_no = v_empno; 
	
	DBMS_OUTPUT.PUT_LINE(V_SAL);
	
	FOR i IN 1..v_sal LOOP 
  		v_asteris := v_asteris ||'*'; 
	END LOOP; 
  	
	UPDATE emp 
  	SET stars = v_asteris 
  	WHERE emp_no = v_empno; 
END; 



15.
--FOR

DECLARE
-- Declaracion de variables
CURSOR c1 IS
	SELECT apellido, fecha_alt
	  FROM emple
	  ORDER BY apellido;
-- No hace falta declara reg c1%ROWTYPE;, pues voy a usar FOR

BEGIN
	-- No necesito abrir con OPEN c1;, lo hace FOR implicitamente
	FOR reg IN c1
	 LOOP
	  --NO leo con FETCH C1 INTO reg;, pues lo hace FOR implicitamente
	  --Sacar por pantalla el apellido y la fecha
		DBMS_OUTPUT.PUT_LINE('El apellido es:'||reg.apellido||' y la fecha alta es '||TO_CHAR(reg.fecha_alt) );	
	  END LOOP;
	-- NO libero el area de memoria con CLOSE c1;, pues lo hace FOR implicitamente
END ;





DECLARE
-- Declaracion de variables
CURSOR c1 IS
	SELECT apellido, fecha_alt
	  FROM emple
	  ORDER BY apellido;
	  reg c1%rowtype;
	  v_emple number;
BEGIN
select count(*) into v_emple from emple;
open c1;

for i in 1..v_emple loop
fetch c1 into reg;
DBMS_OUTPUT.PUT_LINE('El apellido es:'||reg.apellido||' y la fecha alta es '||TO_CHAR(reg.fecha_alt));
end loop;
close c1;
end;




--LOOP

DECLARE
-- Declaracion de variables
CURSOR c1 IS
	SELECT apellido,  fecha_alt
	  FROM emple
	  ORDER BY apellido;
reg c1%ROWTYPE;

BEGIN
	OPEN c1;
	LOOP
	  -- Leo del cursor y guardo en la variable reg
		FETCH C1 INTO reg;
		-- Si esta vacio salgo de mi repetitiva 
		EXIT WHEN c1%NOTFOUND;
		--Si he leido, sacar por pantalla el apellido y la fecha
		DBMS_OUTPUT.PUT_LINE('El apellido es:'||reg.apellido||' y la fecha alta es '||TO_CHAR(reg.fecha_alt));	
	END LOOP;
	-- Libero el area de memoria
	CLOSE c1;
END;


--WHILE

DECLARE
-- Declaracion de variables y cursores
CURSOR c1 IS
	SELECT apellido, fecha_alt
		FROM emple
		ORDER BY apellido;
VREG   c1%ROWTYPE;
BEGIN
	-- Abro el cursor para poder usarlo
	OPEN c1;
	--Leo el PRIMER EMPLEADO
	FETCH c1 INTO VREG;
	-- Compruebo si la tabla esta vacia
	IF c1%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('TABLA EMPLE VACIA');
	ELSE
	-- Hago una repetitiva para tratar empleado
    --	a empleado hasta que llege al final del cursor
	  WHILE c1%FOUND LOOP
	    -- Saco por partalla para cada empleado su apellido y su fecha
		DBMS_OUTPUT.PUT_LINE('EL apellido es: '||vreg.apellido||' dado de alta el dia: '|| to_char(vreg.fecha_alt));
		-- Leo otro empleado
		FETCH c1 INTO VREG;
	  END LOOP;	
	END IF;
	--Libero la memoria ocupada por el cursor
	CLOSE c1;

END;




16.

CREATE OR REPLACE PROCEDURE sumar_numeros (	p_num1 IN NUMBER, p_num2 IN NUMBER)
AS
	vsuma NUMBER(6);
BEGIN
	vsuma := p_num1 + p_num2;
	DBMS_OUTPUT.PUT_LINE('Suma es : '|| vsuma);
END sumar_numeros;

execute sumar_numeros(3,5);


begin
sumar_numeros(3,5);
end;


17

CREATE OR REPLACE PROCEDURE sumar_5numeros (
	p_Num1 IN NUMBER:=0 ,
	p_Num2 IN NUMBER :=0,
    p_Num3 IN NUMBER :=0,
	p_Num4 IN NUMBER:=0 ,
    p_Num5 IN NUMBER :=0)
AS
BEGIN
-- si no inicializo me puede dar error si no paso exactamente los 5 numeros a sumar
	DBMS_OUTPUT.PUT_LINE(p_Num1 + p_Num2 + p_Num3 + p_Num4 + p_Num5);
	
END sumar_5numeros;


begin
sumar_5numeros(1,2,3,4,5);
end;

18.
CREATE OR REPLACE PROCEDURE borrar_emple(
	p_num_emple emple.emp_no%TYPE)
AS
BEGIN
  DELETE FROM emple WHERE emp_no =p_num_emple;

  IF SQL%NOTFOUND THEN
	DBMS_OUTPUT.PUT_LINE('EL EMPLEADO NO EXISTE');
  ELSE
	COMMIT;
  END IF;
END borrar_emple;



begin
borrar_emple(1);     
end;

19.
  
  CREATE OR REPLACE PROCEDURE modificar_localidad(
	vnum_dep IN DEPART.DEPT_NO%TYPE,
	vloc     IN DEPART.LOC%TYPE)
AS
BEGIN
	UPDATE DEPART SET LOC=VLOC
	WHERE DEPT_NO=VNUM_DEP;
	
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('EL DEPARTAMENTO NO EXISTE');
	ELSE
		COMMIT;
	END IF;
		
END modificar_localidad;



20.

SELECT OBJECT_NAME , OBJECT_TYPE, STATUS 
FROM USER_OBJECTS 
WHERE OBJECT_TYPE IN ('PROCEDURE','FUNCTION');









21.
CREATE OR REPLACE PROCEDURE incrementar_salario(
	num_emple  IN EMPLE.EMP_NO%TYPE,
	incremento IN NUMBER)
AS
BEGIN
	UPDATE EMPLE SET SALARIO=SALARIO+INCREMENTO
    WHERE EMP_NO=NUM_EMPLE;

    IF SQL%NOTFOUND  THEN 
		dbms_output.put_line('Empleado no encontrado.');
    ELSE 
		COMMIT;
	END IF;
END incrementar_salario;

BEGIN 
incrementar_salario(45,200);
END;


22.
CREATE OR REPLACE FUNCTION salario_anual
    (p_sal  IN emple.salario%TYPE, 
     p_comm IN emple.comision%TYPE) 
RETURN NUMBER 
IS 

BEGIN 
    RETURN ((NVL(p_sal,0) + NVL(p_comm,0)) * 12); 
END salario_anual; 
 

SELECT emp_no, apellido, salario_anual(salario,comision) "Compensacion anual" 
FROM   emple
WHERE dept_no=30; 




23.
CREATE OR REPLACE FUNCTION Factorial 
(n NUMBER)
RETURN NUMBER
IS 
BEGIN 
IF (n<=1) THEN 
	RETURN 1;
ELSE 
	RETURN n * Factorial(n-1); 
END IF; 
END FACTORIAL;



CREATE OR REPLACE FUNCTION FACTORIAL (p_num NUMBER)
return number
IS
v_factorial NUMBER(20) := 1;
begin
for	i in 1..p_num loop
v_factorial := v_factorial * i;
end loop;
RETURN v_factorial;
end;

VARIABLE g_FACTORIAL NUMBER
execute :g_FACTORIAL := FACTORIAL(5)
PRINT g_FACTORIAL





24.
CREATE OR REPLACE FUNCTION validar_dept_no 
    (p_dept_no IN depart.dept_no%TYPE) 
    RETURN BOOLEAN 
IS	 	
    v_dept_no  depart.dept_no%TYPE ; 
BEGIN 
    SELECT  dept_no  INTO    v_dept_no
    FROM    depart
    WHERE   dept_no = p_dept_no;
	
    if v_dept_no IS NOT NULL then
	
	RETURN TRUE;
	else
		return false;
	end if;
		
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		RETURN FALSE;
END validar_dept_no; 
 
 
 
 
 
 

CREATE OR REPLACE PROCEDURE nuevo_emp 
  (p_emp_no   emple.emp_no%TYPE,
   p_ape      emple.apellido%TYPE, 
   p_ofi      emple.oficio%TYPE,
   p_dir      emple.dir%TYPE, 
   p_falt     emple.fecha_alt%TYPE,
   p_sal      emple.salario%TYPE , 
   p_com      emple.comision%TYPE, 
   p_dept_no  emple.dept_no%TYPE) 
IS 
BEGIN 

IF validar_dept_no(p_dept_no) THEN 
    INSERT INTO emple	
    VALUES (p_emp_no, p_ape,p_ofi, p_dir, p_falt, p_sal,p_com, p_dept_no); 
	commit;
ELSE 
  DBMS_OUTPUT.PUT_LINE ('El departamento no existe');
END IF; 
END nuevo_emp; 


25.
CREATE OR REPLACE FUNCTION DifSalario
(NUM_Emple IN Emple.emp_no%TYPE) 
RETURN NUMBER 
IS
	Salario_emple Emple.Salario%TYPE;
	SalarioMAX    Emple.Salario%TYPE;
	Dpto_emple    Emple.Dept_no%TYPE;
	dif number;
	e_error EXCEPTION;
BEGIN
    -- Hallar el Salario y Dpto del Empleado en cuestión:
	SELECT Salario, Dept_no INTO Salario_emple, Dpto_emple
	FROM Emple
	WHERE NUM_emple = Emp_no;
	
	-- Hallar el Salario mayor de entre todos sus colegas:
	SELECT MAX(Salario) INTO SalarioMAX 
	FROM Emple
	WHERE Dept_no = Dpto_emple;
	dif:=SalarioMAX - Salario_emple;
	IF (dif >1000) then
	RAISE error;
	end if;
	RETURN dif;
	
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	    DBMS_OUTPUT.PUT_LINE('ERROR');
		RETURN -1;
	WHEN e_error THEN
	    DBMS_OUTPUT.PUT_LINE('Salario demasiado bajo');
		RETURN -1;
	when others then
	RETURN -1;
	
END DifSalario;


declare

v_sol number;
begin
v_sol:= DifSalario(1200);
 DBMS_OUTPUT.PUT_LINE(v_sol);
end;


26.
CREATE TABLE MENSAJES(RESULTADO VARCHAR2(260));


CREATE OR REPLACE PROCEDURE ejer26( P_SALARIO IN EMPLE.SALARIO%TYPE)
AS 
  v_ape	emple.apellido%TYPE; 
  cod_error number;
  mens_error varchar2(255);
BEGIN 

  SELECT	apellido INTO v_ape 
  FROM		emple
  WHERE	    salario = p_salario; 
  
  -- Si la consulta devuelve 1 sola fila, no se produce ninguna excepción y realiza la inserción.
  
  INSERT INTO mensajes VALUES (v_ape|| ' - ' || p_salario); 
  COMMIT;

  EXCEPTION 
  WHEN no_data_found THEN -- la consulta no devuelve filas.
    INSERT INTO mensajes 
    VALUES ('No hay empleados con el salario de '||TO_CHAR(p_salario)); 
  WHEN too_many_rows THEN -- la consulta devuelve n-filas.
    INSERT INTO mensajes
	VALUES ('Más de un empleado con el salario '||TO_CHAR(p_salario)); 
  WHEN others THEN 
    cod_error:=sqlcode;
	mens_error:=sqlerrm;
    INSERT INTO mensajes VALUES 
	('Ocurrió el error '||TO_CHAR(cod_error)||' con mensaje '||mens_error); 
END ejer26; 



27.

 CREATE OR REPLACE PROCEDURE ejer27( P_SALARIO IN EMPLE.SALARIO%TYPE)
AS 
 		v_min_sal		emple.salario%TYPE := p_salario - 1000; 
  		v_max_sal		emple.salario%TYPE := p_salario + 1000; 
  		v_cont			NUMBER;
		e_ningun_emple	EXCEPTION; 
  		e_mas_de_un_emple	EXCEPTION; 
BEGIN 
		SELECT	 count(apellido) INTO v_cont
  		FROM	 emple
	    WHERE	 salario between v_min_sal and v_max_sal; 
  		
		IF v_cont  = 0 THEN 
    			RAISE e_ningun_emple; 
  		ELSIF v_cont > = 1 THEN 
				RAISE e_mas_de_un_emple; 
		END IF; 
		
EXCEPTION 
  WHEN e_ningun_emple THEN 
    DBMS_OUTPUT.PUT_LINE( 'No hay empleados con un salario entre '|| 
                  TO_CHAR(v_min_sal) || ' y '|| TO_CHAR(v_max_sal)); 
  WHEN e_mas_de_un_emple THEN 
    DBMS_OUTPUT.PUT_LINE( 'Hay '|| TO_CHAR(v_cont) || ' empleados con un salario entre '|| 
                  TO_CHAR(v_min_sal) || ' y '||   TO_CHAR(v_max_sal)); 
  WHEN others THEN 
  DBMS_OUTPUT.PUT_LINE( 'Otro error producido.'); 
END ejer27; 

28.

CREATE OR REPLACE PROCEDURE altaemp(
	p_num emple.emp_no%TYPE,
	p_ape emple.apellido%TYPE,
	p_ofi emple.oficio%TYPE,
	p_jef emple.dir%TYPE,
	p_fec emple.fecha_alt%TYPE,
	p_sal emple.salario%TYPE,
	p_com emple.comision%TYPE DEFAULT NULL,
	p_dep emple.dept_no%TYPE)
AS
	vjef EMPLE.DIR%TYPE DEFAULT NULL;
	vdep DEPART.DEPT_NO%TYPE DEFAULT NULL;
	
BEGIN
	/* Comprobación de que existe el departamento */
	SELECT dept_no INTO vdep 
	FROM depart 
	WHERE dept_no = p_dep;

	/* Comprobación de que existe el jefe del empleado */
	SELECT emp_no INTO vjef  
    FROM emple 
	WHERE emp_no = p_jef;

	/* Inserción de la fila */	
    INSERT INTO EMPLE VALUES (p_num, p_ape, p_ofi, p_jef, p_fec, p_sal, p_com, p_dep);
    COMMIT;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		IF vdep IS NULL THEN
			DBMS_OUTPUT.PUT_LINE('Err. Departamento inexistente');
		ELSIF vjef IS NULL THEN
			DBMS_OUTPUT.PUT_LINE('Err. No existe el jefe');
		END IF;
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Err.numero de empleado duplicado');
	 WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inesperado');
END altaemp;

29.
CREATE TABLE TABLA_AVISOS(
	MENSAJE VARCHAR2(50));
	
CREATE OR REPLACE PROCEDURE demasiados_emple(
	p_emp_no emple.emp_no%TYPE)
AS
	VDEP     emple.dept_no%type ;
	VTOTAL NUMBER;
	DEMASIADOS_EMPLEADOS EXCEPTION;
BEGIN
	SELECT DEPT_NO INTO VDEP   --Localizamos el departamento del empleado.
	FROM EMPLE
	WHERE EMP_NO=p_emp_no;
	
	SELECT COUNT(*) INTO VTOTAL  -- Contamos cuántos empleados hay.
	FROM EMPLE
	WHERE DEPT_NO=VDEP;
	
	IF VTOTAL>5 THEN			-- Genarar explícitamente la excepción.
		RAISE DEMASIADOS_EMPLEADOS;
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		INSERT INTO TABLA_AVISOS VALUES('No existe el empleado '||p_emp_no);
	WHEN DEMASIADOS_EMPLEADOS THEN
		INSERT INTO TABLA_AVISOS VALUES('Hay '||vtotal||'
		empleados en el departamento '||vdep);
  WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('ERROR INESPERADO');
	
END demasiados_emple;

CREATE TABLE top_salarios
       (salario NUMBER(8,2)); 
	   
30.
CREATE OR REPLACE PROCEDURE ejer30(N NUMBER)
IS 
  CURSOR emp_cursor IS 
					SELECT DISTINCT salario
					FROM   emple
					ORDER BY  salario DESC; 
	
  v_sal         emple.salario%TYPE; 
BEGIN 
  OPEN emp_cursor; 
  FETCH emp_cursor INTO v_sal; 
  WHILE emp_cursor%ROWCOUNT <= N AND emp_cursor%FOUND LOOP 
   		INSERT INTO top_salarios VALUES (v_sal);	 	
        FETCH emp_cursor INTO v_sal; 
  END LOOP; 
  CLOSE emp_cursor; 
  COMMIT; 
  
  EXCEPTION
	WHEN CURSOR_ALREADY_OPEN THEN
		DBMS_OUTPUT.PUT_LINE('Err.el cursor ya esta siendo utilizado');
	WHEN INVALID_CURSOR THEN
	DBMS_OUTPUT.PUT_LINE('Err.operacion inadecuada sobre el cursor');
	when others then
  DBMS_OUTPUT.PUT_LINE('Error inesperado');
  
  
END; 






