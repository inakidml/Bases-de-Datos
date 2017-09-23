select * from USER_TABLES;/*Todas las tablas de usuario*/
desc USER_TABLES;/*descripcion de las tablas, muestra tmb las restricciones NOT NULL*/
desc ALL_tables;/**/
select * from USER_TAB_COLUMNS;/*Todas las columnas de las tablas de usuario*/
select * from ALL_TAB_COLUMNS;/*Todas las columnas de todas las tablas accesibles por este usuario*/
select * from user_constraints where table_name='EMP';/*Las restricciones de la tabla EMP,
tipo y las condiciones de los check... OJO con las mayusculas*/
select * from USER_CONS_COLUMNS;/*Con esto podemos ver incluso Claves primarias 
compuestas por varios campos, en position en orden */
SELECT * FROM ALL_CONSTRAINTS;
SELECT * FROM ALL_CONS_COLUMNS;
