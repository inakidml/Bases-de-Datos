/* OPERADORES */
/* Ejemplo de Aplicación 1 */
CREATE TABLE NOTAS_ALUMNOS
(
  NOMBRE_ALUMNO    VARCHAR2(25) PRIMARY KEY,
  NOTA1 NUMBER(2),
  NOTA2 NUMBER(2),
  NOTA3 NUMBER(2));
INSERT INTO NOTAS_ALUMNOS VALUES('Alcalde García, Elena', 5,5,5);
INSERT INTO NOTAS_ALUMNOS VALUES('Benito Martín, Luis', 7,6,8);
INSERT INTO NOTAS_ALUMNOS VALUES('Casas Martinez, Manuel', 7,5,5);
INSERT INTO NOTAS_ALUMNOS VALUES('Corregidor Sanchez,Ana',6,9,8);
COMMIT;

SELECT   NOMBRE_ALUMNO AS Nombre_Alumno,
ROUND((NOTA1+NOTA2+NOTA3)/3,2)  AS "Nota Media"
FROM NOTAS_ALUMNOS;

/* Ejemplo de Aplicación 2 */
SELECT   APELLIDO,  SALARIO,  DEPT_NO 
FROM     EMPLE
WHERE   (SALARIO > 200000)   AND   (DEPT_NO IN (10, 20));
(SALARIO > 200000)   AND   ((DEPT_NO=10 OR  DEPT_NO=20))

/* Ejemplo de Aplicación 3 */
SELECT    NOMBRE_ALUMNO, NOTA1
FROM      NOTAS_ALUMNOS 
WHERE    (NOTA1=7)    AND    ((NOTA1+NOTA2+NOTA3)/3 >6);

/* Ejemplo de Aplicación 4 */
SELECT   APELLIDO
FROM     EMPLE
WHERE    (UPPER(APELLIDO)) LIKE 'J%';

/* Ejemplo de Aplicación 5 */
SELECT  APELLIDO
FROM    EMPLE
WHERE   UPPER(APELLIDO) LIKE '__R%';

/* Ejemplo de Aplicación 6 */
SELECT   APELLIDO
FROM      EMPLE
WHERE   UPPER(APELLIDO) LIKE 'A%O%';

/* Ejemplo de Aplicación 7 */
SELECT   APELLIDO,  SALARIO
FROM      EMPLE
WHERE    SALARIO BETWEEN  150000 AND 200000;

(SALARIO >=150000) AND (SALARIO<=200000)

/* Ejemplo de Aplicación 8 */
SELECT APELLIDO, SALARIO
FROM    EMPLE
WHERE   SALARIO  NOT   BETWEEN  150000 AND 200000;

(SALARIO <150000) OR (SALARIO>200000)

/* Ejemplo de Aplicación 9 */
SELECT   APELLIDO, OFICIO
FROM      EMPLE
WHERE    OFICIO IN('VENDEDOR', 'ANALISTA', 'EMPLEADO');

(OFICIO='VENDEDOR') OR (OFICIO='ANALISTA') OR (OFICIO='EMPLEADO')

/* Ejemplo de Aplicación 10 */
SELECT   APELLIDO, OFICIO
FROM      EMPLE
WHERE    OFICIO NOT IN('VENDEDOR', 'ANALISTA', 'EMPLEADO');

(OFICIO<>'VENDEDOR') AND (OFICIO<>'ANALISTA') AND (OFICIO!='EMPLEADO')

/* Ejemplo de Aplicación 11 */
SELECT APELLIDO , COMISION   
FROM   EMPLE    
WHERE  COMISION IS NULL;

/* Ejemplo de Aplicación 12 */
SELECT DISTINCT OFICIO
FROM EMPLE;

/* Ejemplo de Aplicación 13 */
SELECT   EMP_NO,  APELLIDO,  OFICIO,  DEPT_NO
FROM     EMPLE
WHERE    DEPT_NO=20
ORDER BY APELLIDO ASC, SALARIO DESC;

/* Ejemplo de Aplicación 14 */
SELECT   * 
FROM     EMPLE 
WHERE    OFICIO='ANALISTA'
ORDER BY EMP_NO ASC;

/* Ejemplo de Aplicación 15 */
SELECT    * 
FROM      EMPLE
WHERE     (DEPT_NO=20) AND (OFICIO='ANALISTA')
ORDER BY  APELLIDO DESC, EMP_NO DESC;

/* Ejemplo de Aplicación 16*/
SELECT APELLIDO, OFICIO, FECHA_ALT
FROM EMPLE
where fecha_alt between ('01/05/1981') and ('30/09/1981')
ORDER BY FECHA_ALT;

SELECT APELLIDO, OFICIO, FECHA_ALT
FROM EMPLE
WHERE (FECHA_ALT>='01/05/1981') AND (FECHA_ALT<='30/09/1981')
ORDER BY FECHA_ALT;
/* FUNCIONES */
/* Ejemplo de Aplicación 17*/
SELECT EMP_NO,APELLIDO,LENGTH(APELLIDO),INSTR(APELLIDO,'A') AS "POSICION A"
FROM EMPLE
WHERE UPPER(APELLIDO) LIKE '%Z';

WHERE SUBSTR(APELLIDO,-1,1)='Z';

/* Ejemplo de Aplicación 18*/
SELECT APELLIDO,SALARIO, MOD(SALARIO,550) AS RESTO
FROM EMPLE
WHERE OFICIO='VENDEDOR';

/* Ejemplo de Aplicación 19*/
SELECT APELLIDO,TRUNC((SYSDATE-FECHA_ALT)/7,0) AS "SEMANAS"
FROM EMPLE
WHERE DEPT_NO=10;

/* Ejemplo de Aplicación 20*/
SELECT EMP_NO,FECHA_ALT, ROUND(FECHA_ALT,'MONTH'),                                                                                                                                SELECT EMP_NO,FECHA_ALT,ROUND(FECHA_ALT, 'MONTH'),
TRUNC(FECHA_ALT,'MONTH')
FROM EMPLE
WHERE FECHA_ALT LIKE '%81';  

SELECT EMP_NO,FECHA_ALT,to_char(FECHA_ALT,'MONTH')
FROM EMPLE
WHERE EXTRACT(YEAR FROM FECHA_ALT)= 1981;  
 
SELECT EMP_NO,FECHA_ALT,to_char(FECHA_ALT,'MONTH'),
TRUNC(FECHA_ALT), round (fecha_ALT)
FROM EMPLE
WHERE EXTRACT(YEAR FROM FECHA_ALT)= 1981;    
							   
/* CONSULTAR MÁS DE UNA TABLA */
/* Ejemplo de Aplicación 21 */
SELECT EMP_NO, APELLIDO, OFICIO, DNOMBRE, LOC
FROM   EMPLE E, DEPART D
WHERE  E.DEPT_NO = D.DEPT_NO;

SELECT EMP_NO, APELLIDO, OFICIO, DNOMBRE, LOC
FROM   EMPLE natural join DEPART ;

select apellido,oficio,emp_no,dnombre,loc 
from emple join depart using(dept_no)

/* Ejemplo de Aplicación 22 */
SELECT E.*,LOC
FROM EMPLE E, DEPART D
WHERE (LOC IN ('MADRID', 'BARCELONA'))
AND (E.DEPT_NO=D.DEPT_NO);

SELECT E.apellido,d.LOC
FROM EMPLE E natural join DEPART D 
where loc='MADRID' or loc='BARCELONA'

SELECT E.apellido,d.LOC
FROM EMPLE E  join DEPART D using (dept_no)
where loc='MADRID' or loc='BARCELONA'

/* Ejemplo de Aplicación 23 */
SELECT E.EMP_NO AS "CODIGO EMPLEADO",
E.APELLIDO AS "Apellidos",
J.APELLIDO AS "SU JEFE ES..."
FROM EMPLE E, EMPLE J
WHERE J.EMP_NO=E.DIR;

SELECT E.EMP_NO AS "CODIGO EMPLEADO",
E.APELLIDO AS "Apellidos",
J.APELLIDO AS "SU JEFE ES..."
FROM EMPLE E join EMPLE J on J.EMP_NO=E.DIR;

/* Ejemplo de Aplicación 24 */
SELECT APELLIDO, OFICIO, LOC
FROM EMPLE E, DEPART D
WHERE OFICIO='ANALISTA' 
AND E.DEPT_NO = D.DEPT_NO;

SELECT APELLIDO,OFICIO, LOC
FROM EMPLE E NATURAL JOIN DEPART D
WHERE OFICIO='ANALISTA' 

/* Ejemplo de Aplicación 25 */
SELECT E.APELLIDO EMPLEADO, J.APELLIDO JEFE
FROM EMPLE E,EMPLE J
WHERE E.DIR=J.EMP_NO(+);

/* Ejemplo de Aplicación 26 */
SELECT D.DEPT_NO, DNOMBRE, APELLIDO
FROM EMPLE E,DEPART D
WHERE E.DEPT_NO(+)=D.DEPT_NO
ORDER BY D.DEPT_NO;

/* Ejemplo de Aplicación 27 */
SELECT DISTINCT OFICIO, LOC
FROM EMPLE E,DEPART D
WHERE E.DEPT_NO = D.DEPT_NO 
AND E.DEPT_NO=30;

SELECT   DISTINCT E.OFICIO, D.LOC
FROM EMPLE E NATURAL join DEPART D 
WHERE DEPT_NO=30

/* Ejemplo de Aplicación 28 */
SELECT E.APELLIDO, E.FECHA_ALT 
FROM EMPLE E CROSS JOIN EMPLE J
WHERE E.FECHA_ALT > J.FECHA_ALT AND J.APELLIDO='JIMENEZ';

SELECT E.APELLIDO, E.FECHA_ALT 
FROM EMPLE E JOIN EMPLE J
ON J.APELLIDO='JIMENEZ'
WHERE E.FECHA_ALT > J.FECHA_ALT;

SELECT E.APELLIDO, E.FECHA_ALT 
FROM EMPLE E , EMPLE J
WHERE J.APELLIDO='JIMENEZ' AND E.FECHA_ALT > J.FECHA_ALT;

SELECT APELLIDO,FECHA_ALT 
FROM EMPLE 
WHERE FECHA_ALT > (SELECT FECHA_ALT FROM EMPLE WHERE APELLIDO='JIMENEZ');

/* Ejemplo de Aplicación 29 */
SELECT E.APELLIDO AS EMPLEADO,E.FECHA_ALT AS "FECHA EMPLEADO",
J.APELLIDO AS JEFE, J.FECHA_ALT AS "FECHA JEFE"
FROM EMPLE E JOIN EMPLE J
ON J.EMP_NO = E.DIR
WHERE E.FECHA_ALT < J.FECHA_ALT;

SELECT E.APELLIDO AS EMPLEADO,E.FECHA_ALT AS "FECHA EMPLEADO",
J.APELLIDO AS JEFE, J.FECHA_ALT AS "FECHA JEFE"
FROM EMPLE E , EMPLE J
WHERE J.EMP_NO = E.DIR 
AND E.FECHA_ALT < J.FECHA_ALT;

/* Ejemplo aplicación 30 */
SELECT AVG(SALARIO) AS MEDIA, MAX(SALARIO) AS MAYOR, 
MIN(SALARIO) AS MENOR, SUM(SALARIO) AS SUMA
FROM EMPLE
WHERE OFICIO='VENDEDOR';

/* Ejemplo aplicación 31 */
SELECT  MAX(FECHA_ALT)AS "MENOR ANTIGÜEDAD", 
MIN(FECHA_ALT) AS "MAYOR ANTIGÜEDAD"
FROM EMPLE;

Para poder obtener el nombre del empleado de contratacion mas reciente
SELECT apellido, fecha_alt FROM EMPLE
 where fecha_alt= (select MAX(fecha_alt) from emple);

/* Ejemplo aplicación 32 */
SELECT  COUNT(*) "NUMERO DE EMPLEADOS"
FROM EMPLE
WHERE DEPT_NO=40;

/* Ejemplo aplicación 33*/
SELECT  COUNT(COMISION) AS "NºEMPLEADOS CON COMISION"
FROM EMPLE
WHERE DEPT_NO=30;

SELECT  COUNT(*) AS "NºEMPLEADOS CON COMISION"
FROM EMPLE
WHERE DEPT_NO=30 and COMISION>=0
					 COMISION IS NOT NULL;
 
/* Ejemplo aplicación 34*/
SELECT DEPT_NO, COUNT(*) "NUMERO DE EMPLEADOS"
FROM EMPLE
GROUP BY DEPT_NO;

/* Ejemplo aplicación 35*/
SELECT DEPT_NO, COUNT(*) "NÚMERO DE EMPLEADOS"
FROM EMPLE
GROUP BY DEPT_NO
HAVING COUNT(*) >4
ORDER BY COUNT(*) DESC;

SELECT  DNOMBRE, COUNT(EMP_NO) "NUMERO DE EMPLEADOS"
FROM DEPART D, EMPLE E
WHERE D.DEPT_NO=E.DEPT_NO
GROUP BY DNOMBRE
HAVING COUNT(*) >4;
			
SELECT D.DEPT_NO, DNOMBRE, COUNT(*) "NUMERO DE EMPLEADOS"
FROM DEPART D, EMPLE E
WHERE D.DEPT_NO=E.DEPT_NO
GROUP BY D.DEPT_NO,DNOMBRE
HAVING COUNT(*) >4;

/* Ejemplo aplicación 36*/
SELECT dept_no,OFICIO, COUNT(*) "Numero_empleados"
FROM EMPLE 
GROUP BY OFICIO, dept_no;

/* Ejemplo aplicación 37*/
SELECT MAX(COUNT(*))  "Número máximo de empleados"
FROM EMPLE
GROUP BY DEPT_NO;

/* Ejemplo aplicación 38*/
SELECT E.DEPT_NO, DNOMBRE,OFICIO, COUNT(*) "NÚMERO DE EMPLEADOS"
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO=D.DEPT_NO
GROUP BY E.DEPT_NO, DNOMBRE,OFICIO;

/* Ejemplo aplicación 39*/
SELECT DEPT_NO, ROUND(AVG(SALARIO),0) AS "Salario medio"
FROM EMPLE 
GROUP BY DEPT_NO
HAVING MAX(SALARIO)>250000;

/* Ejemplo aplicación 40*/
SELECT MAX(ROUND(AVG(SALARIO),0)) 
FROM EMPLE 
GROUP BY DEPT_NO;

/* Ejemplo aplicación 41*/
SELECT OFICIO, COUNT(*) Numero_empleados
FROM EMPLE 
GROUP BY OFICIO;

/* Ejemplo aplicación 42*/
SELECT DIR, MIN(SALARIO) 
FROM EMPLE 
WHERE DIR IS NOT NULL
GROUP BY DIR
HAVING MIN(SALARIO)>200000
ORDER BY MIN(SALARIO) DESC;



/* Ejemplo aplicación 43*/
SELECT DNOMBRE AS "Nombre_depto", LOC AS "Localidad",
COUNT(*) AS "Nº empleados", 
ROUND(AVG(SALARIO),2) AS "Media salarial"
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO=D.DEPT_NO
GROUP BY DNOMBRE, LOC;

/* Ejemplo aplicación 44*/
SELECT  COUNT(*)
FROM EMPLE E, DEPART D
WHERE DNOMBRE='VENTAS' AND OFICIO='VENDEDOR'
AND E.DEPT_NO=D.DEPT_NO;

/* Ejemplo aplicación 45*/
SELECT OFICIO, SUM(SALARIO)
FROM EMPLE E,DEPART D
WHERE E.DEPT_NO=D.DEPT_NO AND DNOMBRE='VENTAS' 
GROUP BY OFICIO;



/* Ejemplo aplicación 46*/
SELECT DEPT_NO,COUNT(*) "Nº DE EMPLEADOS"
FROM EMPLE
WHERE OFICIO ='EMPLEADO'
GROUP BY DEPT_NO;

SELECT E.DEPT_NO,DNOMBRE,COUNT(*) "Nº DE EMPLEADOS"
FROM EMPLE E, DEPART D
WHERE OFICIO ='EMPLEADO' 
AND D.DEPT_NO=E.DEPT_NO
GROUP BY E.DEPT_NO, DNOMBRE;

SELECT D.DEPT_NO,DNOMBRE, COUNT(*) "Nº DE EMPLEADOS"
FROM EMPLE E, DEPART D 
WHERE D.DEPT_NO=E.DEPT_NO
GROUP BY D.DEPT_NO, D.DNOMBRE, E.OFICIO
HAVING OFICIO='EMPLEADO'

/* Ejemplo aplicación 47*/
SELECT DEPT_NO,OFICIO,COUNT(*) 
FROM EMPLE 
GROUP BY DEPT_NO, OFICIO  
HAVING COUNT(*) >2;

/* Ejemplo aplicación 48*/
SELECT APELLIDO, OFICIO
FROM EMPLE
WHERE OFICIO =(SELECT OFICIO
	            FROM EMPLE
                WHERE APELLIDO='GIL')
AND APELlIDO<>'GIL';   

/* Ejemplo aplicación 49 */
SELECT EMP_NO, APELLIDO
FROM   EMPLE
WHERE  SALARIO = ( SELECT MIN(SALARIO)
			   FROM EMPLE
			   GROUP BY DEPT_NO);
			   
/*ERROR en línea 3:
ORA-01427: la subconsulta de una sola fila 
devuelve más de una fila */			  

/* Ejemplo aplicación 50*/
SELECT APELLIDO, OFICIO
FROM   EMPLE
WHERE  OFICIO = ( SELECT OFICIO
			  FROM EMPLE
			  WHERE APELLIDO = 'PEREZ');

* ninguna fila seleccionada */
/*  Si existiera un oficio con valor nulo, 
la fila no se devolvería porque la comparación de
dos valores nulos origina un valor nulo, 
por lo tanto la condición WHERE no es verdadera */


/* Ejemplo aplicación 51*/
SELECT APELLIDO, DEPT_NO, SALARIO
FROM   EMPLE 
WHERE  (SALARIO, DEPT_NO) IN ( SELECT SALARIO, DEPT_NO
				 FROM EMPLE 
				 WHERE COMISION IS NOT NULL);	

						   
SELECT APELLIDO, DEPT_NO, SALARIO
FROM   EMPLE 
WHERE  SALARIO in (SELECT SALARIO
			 FROM EMPLE 
			 WHERE COMISION IS NOT NULL)
							   
AND DEPT_NO IN ( SELECT DEPT_NO
	   		FROM EMPLE 
			WHERE COMISION IS NOT NULL);					   
  	   
/* Ejemplo aplicación 52*/
SELECT APELLIDO, DNOMBRE, SALARIO, COMISION
FROM   EMPLE E, DEPART D
WHERE  E.DEPT_NO = D.DEPT_NO 
AND    (SALARIO, COMISION) IN (SELECT SALARIO, COMISION
				   FROM EMPLE E, DEPART D
				   WHERE E.DEPT_NO = D.DEPT_NO
				   AND LOC='BARCELONA');
							   
							   
SELECT APELLIDO, DNOMBRE, SALARIO, COMISION
FROM   EMPLE E, DEPART D
WHERE  E.DEPT_NO = D.DEPT_NO 
AND    (SALARIO, COMISION) IN (SELECT SALARIO, COMISION
				   FROM EMPLE 
				   WHERE DEPT_NO in (select DEPT_NO from depart
				   where LOC='BARCELONA'));

/* Ejemplo aplicación 53*/
SELECT EMP_NO,APELLIDO, DEPT_NO
FROM   EMPLE 
WHERE  DEPT_NO IN (SELECT DEPT_NO
				   FROM DEPART
				   WHERE LOC LIKE '%A');
			   
SELECT EMP_NO,APELLIDO, DEPT_NO
FROM   EMPLE e, depart d
where  E.DEPT_NO = D.DEPT_NO and loc like '%A';

/* Ejemplo aplicación 54*/
SELECT APELLIDO, SALARIO
FROM   EMPLE 
WHERE  SALARIO > (SELECT MAX(SALARIO)
				  FROM EMPLE
				  WHERE OFICIO='DIRECTOR')
ORDER BY SALARIO DESC;	


/* Ejemplo aplicación 55*/
SELECT E.APELLIDO, E.SALARIO, E.DEPT_NO, TRUNC(AVG(A.SALARIO),0) AS MEDIA_DPTO
FROM   EMPLE E, EMPLE A
WHERE E.DEPT_NO = A.DEPT_NO
AND  E.SALARIO>(SELECT AVG(SALARIO)
			    FROM EMPLE A
			    WHERE A.DEPT_NO= E.DEPT_NO)
GROUP BY E.APELLIDO, E.SALARIO, E.DEPT_NO
ORDER BY AVG(A.SALARIO);

SELECT APELLIDO, SALARIO, P.DEPT_NO, S.SALMEDIO 
FROM EMPLE P, (SELECT DEPT_NO, AVG(SALARIO) SALMEDIO FROM EMPLE GROUP BY DEPT_NO) S
WHERE P.DEPT_NO = S.DEPT_NO
AND P.SALARIO > S.SALMEDIO
ORDER BY AVG(S.SALMEDIO);

/* Ejemplo aplicación 56*/
SELECT APELLIDO, SALARIO
FROM   EMPLE 
WHERE  SALARIO> ALL (SELECT SALARIO
					 FROM EMPLE
					 WHERE OFICIO='DIRECTOR')
ORDER BY SALARIO DESC;

/* Ejemplo aplicación 57*/
SELECT APELLIDO
FROM   EMPLE E
WHERE NOT EXISTS (SELECT *
			      FROM EMPLE S
			      WHERE E.EMP_NO= S.DIR);

SELECT APELLIDO
FROM   EMPLE 
WHERE  EMP_NO NOT IN (SELECT DISTINCT DIR 
			          FROM EMPLE 
					  WHERE DIR IS NOT NULL);	

/* Ejemplo aplicación 58*/
SELECT LEVEL, APELLIDO
FROM   EMPLE
WHERE APELLIDO <> 'JIMENO'
START WITH APELLIDO= 'JIMENO'
CONNECT BY PRIOR DIR=EMP_NO;

/* Ejemplo aplicación 59*/
SELECT DEPT_NO
FROM DEPART
MINUS
SELECT DEPT_NO
FROM EMPLE
WHERE OFICIO='ANALISTA';
