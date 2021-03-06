1-
CREATE TABLE PROVINCIAS
(
COD_PROVI NUMBER(2) CONSTRAINT PRO_COD_PK PRIMARY KEY,
NOMBRE VARCHAR2(25) NOT NULL,
PAIS VARCHAR2(20)CONSTRAINT PRO_PAI_CK CHECK (PAIS in('ESPA�A','ITALIA','PORTUGAL'))
);

2-
INSERT INTO PROVINCIAS VALUES(1,'Alava','ESPA�A')


3-
CREATE TABLE EMPRESAS
(
COD_EMPRE NUMBER(2) CONSTRAINT EMP_COD_PK PRIMARY KEY,
NOMBRE VARCHAR2(25) NOT NULL,
FECHA_CREA DATE DEFAULT SYSDATE +1
)
4-

INSERT INTO EMPRESAS VALUES(20,'ArriagaDAM S.A')
5-

CREATE TABLE CONTINENTES
(
COD_CONTI NUMBER CONSTRAINT CON_COD_PK PRIMARY KEY,
NOMBRE VARCHAR2(20) DEFAULT 'EUROPA' NOT NULL,
POBLACION integer,
DENSIDAD NUMBER(3,1),
AREA integer
)
6-
INSERT INTO CONTINENTES VALUES(1,'Asia',3879000000,88.5,43810000)
INSERT INTO CONTINENTES VALUES(2,'America',910000000,21.5,42330000)
INSERT INTO CONTINENTES VALUES(3,'Africa',922011000,30.4,30370000)
INSERT INTO CONTINENTES VALUES(4,'Europa',731000000,71.8,10180000)
INSERT INTO CONTINENTES VALUES(5,'Oceania',32000000,4.2,9008500)



7-
SOLUCI�N1
CREATE TABLE EMPLEADOS
(
COD_EMPLE NUMBER(2) CONSTRAINT EMP_COD_PK PRIMARY KEY,
NOMBRE VARCHAR2(25) NOT NULL,
APELLIDO VARCHAR2(25),
SALARIO NUMBER(7,2)CONSTRAINT EMP_SAL_CK CHECK (SALARIO >0),
COD_PROVI NUMBER(2) CONSTRAINT EMP_CODP_FK REFERENCES PROVINCIAS ON DELETE CASCADE,
COD_EMPRE NUMBER(2) CONSTRAINT EMP_CODE_FK REFERENCES EMPRESAS
)
SOLUCI�N2
CREATE TABLE EMPLEADOS
(
COD_EMPLE NUMBER(2) CONSTRAINT EMP_COD_PK PRIMARY KEY,
NOMBRE VARCHAR2(25) NOT NULL,
APELLIDO VARCHAR2(25),
SALARIO NUMBER(7,2) CHECK (SALARIO >0),
COD_PROVI NUMBER(2),
COD_EMPRE NUMBER(2),
CONSTRAINT EMP_CODP_FK FOREIGN KEY COD_PROVI REFERENCES PROVINCIAS ON DELETE CASCADE,
CONSTRAINT EMP_CODE_FK FOREIGN KEY COD_EMPRE REFERENCES EMPRESAS(cod_empresa)
)

8-
ALTER TABLE EMPLEADOS ADD (HOBBY VARCHAR2(40),NHIJOS NUMBER(2))
9-
insert into empleados values(1,'Eider','Arbaiza',0,1,20)

10-
ALTER TABLE EMPLEADOS ADD (EDAD NUMBER(3) NOT NULL)
11-
ALTER TABLE EMPLEADOS ADD (EDAD NUMBER(3)) DEFAULT 5 NOT NULL
12-
ALTER TABLE EMPLEADOS DROP COLUMN NHIJOS;
ALTER TABLE EMPLEADOS DROP COLUMN EDAD;

13-
ALTER TABLE EMPLEADOS MODIFY HOBBY VARCHAR2(30)
14-
ALTER TABLE EMPLEADOS ADD CONSTRAINT EMP_SAL_CK SALARIO CHECK (SALARio
BETWEEN 1000 AND 4000)
ALTER TABLE EMPLEADOS
RENAME CONSTRAINT emp_sal_ck TO salariorango;

15-
CREATE TABLE industrias AS SELECT * FROM empresas


16-
DELETE FROM EMPLEADOS where NOMBRE='Eider'

17-

	1-
		update continentes
		set poblacion=poblacion+1000
		where densidad<30
		
	2-
		update continentes
		set densidad=(select densidad from continentes where nombre='Africa')
		where area<20000000
		
		
	3-
		update continentes
		set densidad=densidad+2
		where poblacion>(select poblacion from continentes where nombre='America')

18-
Delete from CONTINENTES
Truncate table CONTINENTES

drop ta


