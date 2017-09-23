create or  replace PROCEDURE insert_depart(
	p_nom_dep VARCHAR2,
	p_loc VARCHAR2)
 AS
	v_ultimo_dep DEPART.DEPT_NO%TYPE;
	e_nombre_repetido EXCEPTION;
  v_nom_dep depart.DNOMBRE%TYPE; 
	 
	BEGIN
	  SELECT dnombre INTO v_nom_dep FROM depart
		WHERE upper(dnombre) = UPPER(p_nom_dep);
     if v_nom_dep is not null then
      RAISE e_nombre_repetido; 
    end if;
     
	EXCEPTION
	when no_data_found then
		SELECT MAX(DEPT_NO) INTO v_ultimo_dep FROM DEPART;
       -- Calcular el número de departamento e insertar 
        	
		IF v_ultimo_dep IS NULL THEN
			--Si la tabla departamento esta vacia, es decir, no hay ningun departamento
			INSERT INTO DEPART VALUES (10,upper(p_nom_dep),upper(p_loc));
		ELSE
			INSERT INTO DEPART VALUES (v_ultimo_dep +10, p_nom_dep,p_loc);
		END IF;
	
	 WHEN e_nombre_repetido THEN
	   DBMS_OUTPUT.PUT_LINE('ya existe un departamento con ese nombre');
      
	  WHEN others THEN
	   DBMS_OUTPUT.PUT_LINE('operacion incorrecta'); 
   
	END insert_depart;		
 
 
 
 
 
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






create or replace PROCEDURE insert_depart(
	p_nom_dep VARCHAR2,
	p_loc VARCHAR2)
 AS
	v_ultimo_dep DEPART.DEPT_NO%TYPE;
	e_nombre_repetido EXCEPTION;
 BEGIN
 -- Comprobar dpt repetido(Puede disparar NO_DATA_FOUND)
  	DECLARE
	  v_nom_dep depart.DNOMBRE%TYPE; 
	  e_nombre_repetido EXCEPTION;
	BEGIN
	  SELECT dnombre INTO v_nom_dep FROM depart
		WHERE upper(dnombre) = UPPER(p_nom_dep);
      RAISE insert_depart.e_nombre_repetido;  
	EXCEPTION
	  WHEN NO_DATA_FOUND THEN
	    NULL;
	  WHEN TOO_MANY_ROWS THEN
	    RAISE insert_Depart.e_nombre_repetido;
	END;		
  --	Fin del bloque de comprobación de departamento repetido 

-- Calcular el número de departamento e insertar 
    SELECT MAX(DEPT_NO) INTO v_ultimo_dep FROM DEPART;
	-- Como hay una funcion de grupo no funciona la exception NO_DATA_FOUND
	IF v_ultimo_dep IS NULL
	THEN
		--Si la tabla departamento esta vacia, es decir, no hay ningun departamento
		INSERT INTO DEPART VALUES (10,upper(p_nom_dep),upper(p_loc));
    ELSE
		INSERT INTO DEPART VALUES ((TRUNC(v_ultimo_dep, -1) +10), p_nom_dep,p_loc);
	END IF;
        COMMIT;
 EXCEPTION
  WHEN e_nombre_repetido THEN
    RAISE_APPLICATION_ERROR ('-20001','Err. Nombre de departamento duplicado');

END insert_depart;


create or replace PROCEDURE borrar_depart
	  (p_dep_borrar NUMBER,
	  p_dep_nue NUMBER)
 AS
 
 e_dept_no_existe EXCEPTION;
 BEGIN 
 DECLARE
	  v__dep depart.dept_no%TYPE; 
	  e_dept_no_existe EXCEPTION;
	BEGIN
	  SELECT dept_no INTO v__dep FROM depart
		WHERE dept_no = p_dep_borrar;
    EXCEPTION
	  WHEN NO_DATA_FOUND THEN
	   raise borrar_depart.e_dept_no_existe;
	  
	END;	
	UPDATE emple SET dept_no = p_dep_nue
  	  WHERE DEPT_NO=p_dep_borrar;
	DELETE FROM depart WHERE dept_no  = p_dep_borrar;
        --COMMIT;
  exception
    when e_dept_no_existe then
    DBMS_OUTPUT.PUT_line('no existe el departamento');
    when others then
    DBMS_OUTPUT.PUT_line('no se puede eliminar el departamento');
    
END borrar_depart;


create or replace PROCEDURE cambiar_localidad(
	p_num_dep NUMBER,
	p_loc VARCHAR2)
 AS
	e_dept_no_encontrado EXCEPTION;
 BEGIN
	UPDATE depart
		SET LOC=p_loc
		WHERE dept_no=p_num_dep;
	IF SQL%NOTFOUND
	THEN
		RAISE e_dept_no_encontrado;
        ELSE 
                COMMIT;
	END IF;
 EXCEPTION
	WHEN e_dept_no_encontrado THEN
		RAISE_APPLICATION_ERROR('-20011','Err Nombre Departamento no encontrado');
END cambiar_localidad;
