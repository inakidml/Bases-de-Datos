/*Ejercicio 1*/


CREATE TABLE Alum_ud7(
	DNI 	VARCHAR2(10) CONSTRAINT ALU_DNI_PK 	PRIMARY KEY,	
	NOMBRE 	VARCHAR2(30) NOT NULL  CONSTRAINT 	ALU_NOM_CK  CHECK (NOMBRE=UPPER(NOMBRE)), 
	EDAD 	NUMBER(2)    CONSTRAINT ALU_EDA_CK 	CHECK (EDAD BETWEEN 5 AND 20),
	CURSO 	NUMBER       CONSTRAINT 	ALU_CUR_CK  CHECK (CURSO IN(1,2,3)));
  
  desc ALUM_UD7;
  
INSERT INTO Alum_ud7 values('123456A','ANA', 20,3);
INSERT INTO Alum_ud7 values('987654S','IKER', 16,3);
INSERT INTO Alum_ud7 (DNI,NOMBRE,CURSO) values('654321c','ION',3);
SELECT * FROM ALUM_UD7;
INSERT INTO Alum_ud7 values('890890W','LEIRE', 14,2);
INSERT INTO Alum_ud7 (DNI,NOMBRE,EDAD) values('765765T','MIREN',12);
INSERT INTO Alum_ud7 (DNI,NOMBRE) values('345678V','ASIER');
INSERT INTO Alum_ud7 values('213141','AIORA', 5,1);

/*Ejercicio 2*/

UPDATE ALUM_UD7 SET EDAD = 17 WHERE DNI = '654321c';
UPDATE ALUM_UD7 SET EDAD = 8, CURSO = 1 WHERE NOMBRE = 'ASIER';
UPDATE ALUM_UD7 SET EDAD = EDAD + 1 WHERE CURSO = 1;
UPDATE ALUM_UD7 SET CURSO = 2 WHERE CURSO is null; /* Con igual no funciona, no se puede igualar a nulo, tiene que ser "is" o "is not" */

/*Ejercicio 3*/

DELETE FROM ALUM_UD7 WHERE CURSO = 1;
RENAME ALUM_UD7 TO ALUM_UD6;
/*Ejercicio 4*/

DESC EMPLE;
SELECT * FROM DEPART;
INSERT INTO DEPART VALUES(11, 'Calidad', 'SANTANDER');
SELECT * FROM EMPLE;
INSERT INTO EMPLE (EMP_NO,APELLIDO,OFICIO,DEPT_NO) VALUES(7230, 'AGUIRRE', 'EMPLEADO', 11);

UPDATE EMPLE SET SALARIO = SALARIO - SALARIO/10;
UPDATE EMPLE SET DEPT_NO = 40 WHERE DEPT_NO = 10;
UPDATE EMPLE SET DIR =(SELECT DIR FROM EMPLE WHERE APELLIDO = 'TOVAR') WHERE DIR = 7566;
UPDATE EMPLE SET SALARIO = 169000 WHERE APELLIDO = 'MUÑOZ';
UPDATE EMPLE SET SALARIO = (SELECT SALARIO FROM EMPLE WHERE APELLIDO = 'MUÑOZ') WHERE OFICIO = 'EMPLEADO';
UPDATE EMPLE SET COMISION = 300 WHERE DEPT_NO = (SELECT DEPT_NO FROM DEPART WHERE LOC = 'SANTANDER');
DELETE FROM EMPLE WHERE DEPT_NO = 30;
UPDATE EMPLE SET APELLIDO='MU�OZ' WHERE APELLIDO = 'MUÑOZ';

/*EJERCICIO COMPLETO*/
DROP TABLE tiendas CASCADE CONSTRAINTS; 
CREATE TABLE FABRICANTES(
	COD_FABRICANTE 	VARCHAR2(10) CONSTRAINT FAB_COD_PK PRIMARY KEY ,	
	NOMBRE 	VARCHAR2(15)  CONSTRAINT 	FAB_NOM_CK  CHECK (NOMBRE=UPPER(NOMBRE)),
	PAIS VARCHAR2(15) CONSTRAINT 	FAB_PAI_CK  CHECK (PAIS=UPPER(PAIS)));
  
CREATE TABLE ARTICULOS(
	ARTICULO 	VARCHAR2(20) ,	
	COD_FABRICANTE 	VARCHAR2(3) NOT NULL CONSTRAINT ART_COD_FK REFERENCES FABRICANTES, 
	PESO NUMBER(4) CONSTRAINT ART_PES_CK CHECK (PESO >0), 
	CATEGORIA 	VARCHAR2(20)  CONSTRAINT ART_CAT_CK  CHECK (CATEGORIA IN('PRIMERA','SEGUNDA','TERCERA')),
   	PRECIO_VENTA 	NUMBER(4)   CONSTRAINT ART_pre_CK CHECK (PRECIO_VENTA >0),  
	EXISTENCIAS NUMBER(5),
	CONSTRAINT ART_ACPC_PK PRIMARY KEY(articulo, cod_fabricante, peso, categoria));
  
  CREATE TABLE TIENDAS(
	NIF 	VARCHAR2(10) CONSTRAINT TIE_NIF_PK PRIMARY KEY ,	
	NOMBRE 	VARCHAR2(20)  CONSTRAINT 	TIE_NOM_CK  CHECK (NOMBRE=UPPER(NOMBRE)),
	DIRECCION VARCHAR2(20), 
	POBLACION VARCHAR2(20),
	PROVINCIA VARCHAR2(20),
	CODPOSTAL VARCHAR2(5));

CREATE TABLE PEDIDOS(
	NIF VARCHAR2(10) ,
	ARTICULO 	VARCHAR2(20) ,	
	COD_FABRICANTE 	VARCHAR2(3) NOT NULL  CONSTRAINT PED_COD2_FK REFErENCES FABRICANTES, 
	PESO NUMBER(4) CONSTRAINT PED_PES_CK CHECK (PESO >0) , 
	CATEGORIA 	VARCHAR2(20)  CONSTRAINT PED_CAT_CK  CHECK (CATEGORIA IN('PRIMERA','SEGUNDA','TERCERA')),
   	FECHA_PEDIDO DATE NOT NULL,  
	UNIDADES_PEDIDAS NUMBER(4) CONSTRAINT ART_UNI_CK CHECK (UNIDADES_PEDIDAS >0) ,
	CONSTRAINT ART_NACPCf_PK PRIMARY KEY(nif,articulo, cod_fabricante, peso, categoria,fecha_pedido));
  
alter table pedidos
add constraint ped_for_ref foreign key(articulo,cod_fabricante,peso,categoria) references articulos(articulo,cod_fabricante,peso,categoria);

INSERT INTO ARTICULOS VALUES('Pantalla LCD','010',750,'PRIMERA',342,48);
INSERT INTO ARTICULOS VALUES('Raton','015',230,'SEGUNDA',15,32);
INSERT INTO ARTICULOS VALUES ('Altavoces','010',400,'PRIMERA',70,8);
INSERT INTO ARTICULOS VALUES ('Impresora','015',2750,'PRIMERA',110,13);

INSERT INTO TIENDAS VALUES('C-340','BEEP','Gran Via,32','madrid','MADRID',08010);
INSERT INTO TIENDAS VALUES('C-545','FNAC','Avda. Reyes,45','Bilbao','BIZKAIA',48080);
INSERT INTO TIENDAS VALUES('C-841','ALGITECH','Rios Bravos 51','Logro�o','LA RIOJA',41030);

INSERT INTO FABRICANTES VALUES('010','TOSHIBA','JAPON');
INSERT INTO FABRICANTES VALUES('015','HP','ALEMANIA');

INSERT INTO PEDIDOS VALUES('C-545','Impresora','015',2750,'PRIMERA','2/1/2013',10);
INSERT INTO PEDIDOS VALUES('C-841','Impresora','015',2750,'PRIMERA','4/3/2013',5);
INSERT INTO PEDIDOS VALUES('C-340','Raton','015',230,'SEGUNDA','5/1/2013',23);
select * from articulos;
select * from tiendas;
select * from fabricantes;
select * from pedidos;

/*empezamoms*/
/*3.*/
SELECT TABLE_NAME, OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION 
FROM USER_CONSTRAINTS 
where TABLE_NAME = 'FABRICANTES' OR TABLE_NAME = 'TIENDAS' OR TABLE_NAME = 'PEDIDOS' OR TABLE_NAME = 'ARTICULOS'; 
/*4.*/
ALTER TABLE TIENDAS ADD CONSTRAINT TIE_PRO_CHK CHECK(PROVINCIA != 'TOLEDO');
/*5.*/

INSERT INTO ARTICULOS VALUES('PenDrive80','010',145,'SEGUNDA',NULL,NULL);
SELECT * FROM ARTICULOS;

/*6.*/
UPDATE ARTICULOS SET EXISTENCIAS = EXISTENCIAS + 5 WHERE EXISTENCIAS < 20 ;
UPDATE ARTICULOS SET EXISTENCIAS = 5 WHERE EXISTENCIAS IS NULL ;
/*7.*/

UPDATE ARTICULOS SET ARTICULO = 'Impresora laser' where ARTICULO ='Impresora';
UPDATE PEDIDOS SET ARTICULO = 'Impresora laser' where ARTICULO ='Impresora';/* NO ME DEJA*/
alter table pedidos disable constraint ped_for_ref;
alter table articulos disable constraint ART_ACPC_PK;
alter table articulos enable constraint ART_ACPC_PK;
alter table pedidos enable constraint ped_for_ref;
/*8.*/
SELECT TABLE_NAME, OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION 
FROM USER_CONSTRAINTS 
where TABLE_NAME = 'FABRICANTES'; 

INSERT INTO FABRICANTES VALUES('033', 'PHILIPS', null);
INSERT INTO FABRICANTES VALUES('055', 'LOGITECH', null);
SELECT * FROM FABRICANTES;

/*9.*/
SELECT TABLE_NAME, OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION 
FROM USER_CONSTRAINTS 
where TABLE_NAME = 'TIENDAS';

INSERT INTO TIENDAS VALUES('C-980','MEDIAMARKET', 'CCBILBONDO','BASAURI','BIZKAIA','41030');
INSERT INTO TIENDAS (NIF,NOMBRE) VALUES ('C-455', 'INFORMAS');

/*10.*/
SELECT * FROM ARTICULOS;

UPDATE ARTICULOS SET CATEGORIA = 'PRIMERA' where ARTICULO ='PenDrive80';
UPDATE ARTICULOS SET articulo  = 'Pendrive' where ARTICULO ='PenDrive80';

/*11.*/
UPDATE TIENDAS SET CODPOSTAL = (SELECT CODPOSTAL FROM TIENDAS WHERE POBLACION = 'Bilbao' ) WHERE PROVINCIA = 'BIZKAIA';
SELECT * FROM TIENDAS;

/*12.*/
UPDATE ARTICULOS SET PRECIO_VENTA = PRECIO_VENTA*1.10 WHERE COD_FABRICANTE = 010;
/*13.*/
INSERT INTO ARTICULOS VALUES('GORRO', '033', 400, 'SEGUNDA', 30, 10);
UPDATE ARTICULOS SET COD_FABRICANTE = 033 WHERE COD_FABRICANTE =033;

SELECT * FROM PEDIDOS;
INSERT INTO PEDIDOS VALUES ('C-340', 'GORRO','033', 1000, 'SEGUNDA', '17/12/15', 2);
INSERT INTO PEDIDOS VALUES ('C-340', 'TECLADO','033', 400, 'SEGUNDA', '17/12/15', 2);
SELECT TABLE_NAME, OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION 
FROM USER_CONSTRAINTS 
where TABLE_NAME = 'PEDIDOS'; 

/*14.*/

UPDATE ARTICULOS SET PRECIO_VENTA= PRECIO_VENTA -3 WHERE PRECIO_VENTA>250;
/*15.*/
UPDATE ARTICULOS SET PESO = PESO + 50 WHERE COD_FABRICANTE=(SELECT COD_FABRICANTE FROM FABRICANTES WHERE PAIS='ALEMANIA');
