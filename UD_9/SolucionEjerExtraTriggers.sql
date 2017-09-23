CREATE TABLE socio (
codsoc NUMBER constraint cp_socio PRIMARY KEY ,
nombre varchar(40) NOT NULL,
dir varchar(60),
tel varchar(15),
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


1.
CREATE TRIGGER ControlSocio
AFTER INSERT ON Prestamo
FOR EACH ROW
BEGIN
IF :new.fechadev IS NULL THEN
UPDATE socio SET totalpres = totalpres +1
WHERE codsoc = :new.codsoc;
END IF;
END;

2.
CREATE TRIGGER ModiSocio
AFTER UPDATE OF codsoc ON Prestamo
FOR EACH ROW
BEGIN

UPDATE socio SET totalpres = totalpres +1 WHERE codsoc = :new.codsoc;
UPDATE socio SET totalpres = totalpres -1 WHERE codsoc = :old.codsoc;

END;


3.
CREATE TRIGGER NumPrestamos
AFTER INSERT ON Socio
FOR EACH ROW
BEGIN
IF :new.totalpres <> 0 then
:new.totalpres=0;
RAISE_APPLICATION_ERROR(-20000,'Cuando se inserta un socio,
su numero de presstamos ha de ser 0');
END IF;
END;

4.
CREATE TRIGGER Devoluciones
AFTER UPDATE OF fechadev ON Prestamo
FOR EACH ROW
BEGIN
IF :new.fechadev IS NULL AND :old.fechadev IS NOT NULL THEN
UPDATE socio SET totalpres = totalpres +1 WHERE codsoc = :new.codsoc;
ELSE IF :new.fechadev IS NOT NULL AND :old.fechadev IS NULL THEN
UPDATE socio SET totalpres = totalpres -1 WHERE codsoc = :new.codsoc;
END IF;
END IF;
END;

5.
create or replace trigger Borrado_pres
after delete on Prestamo
for each row when (old.fechadev is null)
begin
update socio set totalpres = totalpres -1 WHERE codsoc = :old.codsoc;
end;

6.

CREATE TABLE Ctrl_P(
Tabla varchar2(25),
Usuario varchar2(20),
fecha date,
op varchar2(20)
)
CREATE OR REPLACE TRIGGER Control_Pres
AFTER INSERT OR DELETE OR UPDATE ON Prestamo
BEGIN
IF INSERTING THEN
INSERT INTO Ctrl_P (Tabla,Usuario,Fecha,Oper)
VALUES ('Prestamo', USER, SYSDATE,'INSERT');
ELSIF DELETING THEN
INSERT INTO Ctrl_P (Tabla,Usuario,Fecha,Oper)
VALUES ('Prestamo', USER, SYSDATE,'DELETE');
ELSE
INSERT INTO Ctrl_P (Tabla,Usuario,Fecha,Oper)
VALUES ('Prestamo', USER, SYSDATE,'UPDATE');
end If;
END Control_Pres;



7.

CREATE OR REPLACE TRIGGER Libro_area
 BEFORE INSERT on Libro
 FOR EACH ROW
 WHEN (NEW.area ='Arte'9
  BEGIN 
 :new.area='Literatura';
   --raise_application_error('No puede insertar mas libros de arte.');

  end;
  
  
  
  8.
  
  CREATE TABLE mailing(
email varchar2(100),
fechapres date,
titulo varchar2(50)
)
  
  CREATE OR REPLACE TRIGGER SalidaSistema
  BEFORE LOGOff
  on schema
  declare
  
  Cursor cpres is select * from prestamo;
  rpres cpres%rowtype;
  diferencia number;
  tit varchar2(50);
  dir varchar2(100);
  Begin
  OPEN Cpres;
	loop
		FETCH Cpres INTO rpres;
		SELECT TRUNC(SYSDATE)-TO_DATE(rpres.fechapres, 'DD/MM/aaaa') into DIFERENCIA FROM DUAL;
		if diferencia>15 then
		select titulo into tit from libro where codlib= rpres.codlib;
		select mail into dir from socio where codsoc=rpres.codsoc;
		insert into mailing values(dir,rpres.fechapres,tit);
		end if;
		
		EXIT WHEN Cpres%NOTFOUND;
	END LOOP;
close CPRES;
end;
  SELECT TRUNC(SYSDATE) - TO_DATE(fechapres, 'DD/MM/RRRR') AS DIFERENCIA FROM DUAL;
  
9.

CREATE OR REPLACE TRIGGER borrado_libro
before delete on libro
for each row
declare
  
  Cursor cpres is select * from prestamo where codlib=:old.codlib;
  rpres cpres%rowtype;
  
  
begin
OPEN Cpres;
	loop
		FETCH Cpres INTO rpres;
		UPDATE socio SET totalpres = totalpres -1 WHERE codsoc = rpres.codsoc;
		delete from prestamo where codlib=rpres.codlib and codsoc = rpres.codsoc and fechapres=rpres.fechapres;
		
EXIT WHEN Cpres%NOTFOUND;
	END LOOP;
close CPRES;
end;
