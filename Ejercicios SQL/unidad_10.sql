create or replace type profesor AS object(DNI VARCHAR2(10), nombre VARCHAR2(20), DEPARTAMENTO_prof ref departamento);
create or replace type departamento as object(nombre varchar2(20), telefono number(9));

create or replace type telefonos_alumno as varray(4) of number(9);
create or replace type direccion as object(calle varchar2(20), portal number(3), ciudad varchar2(20));
create or replace type persona_contacto as object(nombre varchar2(20), telefono number(9), direccion_persona direccion);
create or replace type asignatura as object(nombre varchar2(20), dept departamento, creditos number(2));

create or replace asignatura_matriculada as object(

);

create or replace type alumno as object(nombre varchar2(20), telefonos telefonos_alumno, direccion_alumno direccion,contacto persona_contacto,  tutor ref profesor,  );