EJERCICIOS REPASO UD7:
1. Sacar el código de oficina y la ciudad donde hay oficinas

SELECT CODIGOOFICINA,CIUDAD
FROM OFICINAS;
-----------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 2. Sacar cuantos empleados hay en la compañía

SELECT COUNT(CODIGOEMPLEADO)
FROM EMPLEADOS;
-----------------------------------------------------------------------------
EJERCICIO 3. Sacar cuantos clientes tiene cada país.

SELECT PAIS,COUNT(*) AS"Nº_CLIENTESXPAIS"
FROM CLIENTES
GROUP BY PAIS ;
------------------------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 4. Sacar cual fue el pago medio en 2009

SELECT ROUND(AVG(CANTIDAD),2)AS "PAGO MEDIO 2009"
FROM PAGOS
WHERE FECHAPAGO BETWEEN '01/01/2009' AND '31/12/2009';

SELECT ROUND(AVG(CANTIDAD),2)AS "PAGO MEDIO 2009"
FROM PAGOS
WHERE EXTRACT(Year FROM Fechapago)=2009;
----------------------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 5. Sacar cuantos pedidos están en cada estado ordenado descendente por el numero de pedidos.

SELECT ESTADO,COUNT(*)AS"Nº PEDIDOXESTADO"
FROM PEDIDO
GROUP BY ESTADO
ORDER BY  COUNT(*)DESC;
/*¿POR QUE EN LA CONSULTA SALE VARIOS ENTREGADOS,PENDIENTES,ETC....?*/
Porque hay estados como entregado y otro ENTREGADO y a efectos son estados difesrentes al estar uno en mayusculas y otro en minusculas.

-------------------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 6. Sacar el precio del producto mas caro y del mas barato.

SELECT MAX(PRECIOVENTA),MIN(PRECIOVENTA)
FROM PRODUCTOS;


-----------------------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 7. Obtener el nombre del cliente con mayor limite de crédito.

SELECT NOMBRECLIENTE,LIMITECREDITO
FROM CLIENTES WHERE LIMITECREDITO=(SELECT MAX(LIMITECREDITO) FROM CLIENTES);
------------------------------------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 8. Obtener el nombre, apellido y cargo de los empleados que no representan a ningún cliente.

SELECT NOMBRE,APELLIDO1,APELLIDO2,PUESTO
FROM EMPLEADOS E
WHERE NOT EXISTS(SELECT 'X' FROM CLIENTES C WHERE CODIGOEMPLEADO=CODIGOEMPLEADOREPVENTAS  );

-----------------------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 9. Sacar un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

SELECT C.NOMBRECLIENTE AS CLIENTE,E.NOMBRE AS EMPLEADO,E.APELLIDO1
FROM CLIENTES C , EMPLEADOS E
WHERE E.CODIGOEMPLEADO=C.CODIGOEMPLEADOREPVENTAS;

------------------------------------------------------------------------------------------------------------------------------------------------
EJERCICIO 10. Mostrar el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT CODIGOCLIENTE,C.NOMBRECLIENTE AS CLIENTE,E.NOMBRE AS REPRESENTANTE
FROM CLIENTES C, EMPLEADOS E
WHERE E.CODIGOEMPLEADO=C.CODIGOEMPLEADOREPVENTAS  AND NOT EXISTS(
SELECT CODIGOCLIENTE
FROM PAGOS P
WHERE C.CODIGOCLIENTE=P.CODIGOCLIENTE);

-----------------------------------------------------------------------------------------------------------------------------------------------






















