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
DECLARE

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