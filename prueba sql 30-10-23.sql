--Inserte un registro de cliente (llene todos los campos).
SELECT MAX(CODIGOCLIENTE) FROM CLIENTES
Insert into CLIENTES (CODIGOCLIENTE,NOMBRECLIENTE,NOMBRECONTACTO,
APELLIDOCONTACTO,TELEFONO,FAX
,LINEADIRECCION1,LINEADIRECCION2,
CIUDAD,REGION,
PAIS,
CODIGOPOSTAL,
CODIGOEMPLEADOREPVENTAS,
LIMITECREDITO) 
values (39,'NOE','ALEX','CERON','675432926','916549264',
'C/Mar Caspio 43',null,'Getafe','Madrid','España','28904',30,8040);
SELECT * FROM CLIENTES WHERE CODIGOCLIENTE = 39; 


--Borre un registro de la tabla detallepedidos que contenga el nombre del producto ‘Bougamvillea roja, naranja’.
SELECT * FROM PRODUCTOS WHERE NOMBRE = 'Bougamvillea roja, naranja'
DELETE FROM detallepedidos
WHERE CODIGOPRODUCTO IN (
   SELECT CODIGOPRODUCTO FROM PRODUCTOS WHERE NOMBRE = 'Bougamvillea roja, naranja'
);

--En la tabla pedidos actualice el codigopedido = 19  en el estado ingrese ‘Entregado’ y en la fechaentrega ingrese la fecha actual. 
UPDATE PEDIDOS SET ESTADO = 'ENTREGADO', FECHAENTREGA = SYSDATE WHERE CODIGOPEDIDO = 19;
--Muestre todos los registros de los clientes que se encuentren en Madrid. 
SELECT * FROM CLIENTES WHERE CIUDAD = 'Madrid' ;
--Muestre todos los registros de los empleados que no tengan una extensión 2442. 
SELECT * FROM EMPLEADOS WHERE EXTENSION NOT IN (2442);
--Muestre todos los pagos que tengan una cantidad mayor a 1000.
SELECT * FROM PAGOS WHERE CANTIDAD > 1000.00;
--Muestre todos los productos que tengan un stock menor o igual a 140.
SELECT * FROM PRODUCTOS WHERE CANTIDADENSTOCK <= 140;
--Muestre el nombre completo del empleado en una columna y en la siguiente concatene el codigoempleado con el codigooficina.
SELECT (NOMBRE ||' ' || APELLIDO1 || ' ' || APELLIDO2) AS NOMBRE_COMPLETO, 
(CODIGOEMPLEADO || ' ' || CODIGOOFICINA) AS CODIGOS FROM EMPLEADOS;
--Muestre los nombres de los clientes con la primera letra en mayúscula.
SELECT INITCAP(NOMBRECLIENTE) AS NOMBRECLIENTE FROM CLIENTES;
--Muestre los apellidos de contacto de los clientes con letra minúscula.
SELECT LOWER(NOMBRECONTACTO) AS NOMBRE FROM CLIENTES;
--Muestre la región de las oficinas con letra mayúscula.
SELECT UPPER(REGION) AS REGION FROM OFICINAS;
--Muestre los datos de las oficinas y quite los espacios que se encuentran entre el campo teléfono.
SELECT CODIGOOFICINA, CIUDAD, PAIS, REGION, REPLACE(TELEFONO, ' ','') AS TEL FROM OFICINAS
--Muestre únicamente los primeros 12 caracteres del campo id transacción que se encuentra en la tabla pagos.
SELECT SUBSTR(IDTRANSACCION, 1, 12) AS DIGITOS_IDTRANSACCION 
FROM PAGOS;

--Redondee el siguiente número a dos decimales 123.4648974
SET SERVEROUTPUT ON

DECLARE
  NUMERO NUMBER := 123.4648974;
  NUMERO_REDONDEADO NUMBER;
BEGIN
  NUMERO_REDONDEADO := ROUND(NUMERO, 2);
  DBMS_OUTPUT.PUT_LINE('NÚMERO ORIGINAL: ' || NUMERO);
  DBMS_OUTPUT.PUT_LINE('NÚMERO REDONDEADO: ' || NUMERO_REDONDEADO);
END;


--Muestre los meses transcurridos entre la fecha de entrega y la fecha pedido de un pedido.
SELECT
  CODIGOPEDIDO,
  FECHAPEDIDO,
  FECHAENTREGA,
  ROUND ( MONTHS_BETWEEN(FECHAENTREGA, FECHAPEDIDO),2) AS MESESTRANSCURRDIO
FROM PEDIDOS WHERE CODIGOPEDIDO = 99;

--Extraiga el año en el que fueron entregados los pedidos.
SELECT
  CODIGOPEDIDO,
  FECHAENTREGA,
  EXTRACT(YEAR FROM FECHAENTREGA) AS ANIOENTREGA
FROM PEDIDOS;

--Muestre los días transcurridos entre la fecha de entrega de un pedido y la fecha esperada.
SELECT
  CODIGOPEDIDO,
  FECHAPEDIDO,
  FECHAESPERADA,
  ROUND ( TRUNC(FECHAENTREGA) - TRUNC( FECHAESPERADA),2) AS DIAS
FROM PEDIDOS;
--Seleccione todos los datos de la tabla clientes, cuando el campo lineadireccion2 sea nulo escriba 'Desconocido'.
SELECT 
  CASE
    WHEN lineadireccion2 IS NULL THEN 'Desconocido'
    ELSE lineadireccion2
  END AS direc2,  CLIENTES.*
FROM CLIENTES;
--Seleccione todos los datos de la tabla clientes, cuando el campo lineadireccion2 sea nulo escriba 'Desconocido' sino es nulo escriba 'Conocido'.
SELECT 
  CASE
    WHEN lineadireccion2 IS NULL THEN 'Desconocido'
    ELSE  'Conocido'
  END AS direc2,  CLIENTES.*
FROM CLIENTES;

--Muestre los pedidos entregados entre las fechas de entrega entre 25/07/08 y 10/04/09
SELECT *
FROM PEDIDOS
WHERE FECHAENTREGA BETWEEN TO_DATE('25/07/08', 'DD/MM/YY') AND TO_DATE('10/04/09', 'DD/MM/YY') and estado = 'Entregado';

--Seleccione los datos de la tabla de clientes cuando se encuentre en las regiones Nueva Gales del Sur, Fuenlabrada, London.
select * from clientes where region in ('Nueva Gales del Sur', 'Fuenlabrada', 'London')
--Seleccione los datos de la tabla de clientes cuando NO se encuentre en las regiones Nueva Gales del Sur, Fuenlabrada, London.
select * from clientes where region not in ('Nueva Gales del Sur', 'Fuenlabrada', 'London')
--Muestre los datos de los clientes con los datos de sus pedidos.
select * from CLIENTES a inner join PEDIDOS b on a.codigocliente = b.codigocliente
--Muestre los nombres de los clientes y los nombres de los empleados que tienen asignados.
SELECT A.NOMBRECLIENTE, B.NOMBRE FROM CLIENTES A INNER JOIN EMPLEADOS B ON A.CODIGOEMPLEADOREPVENTAS = B.CODIGOEMPLEADO;
--Utilice subconsultas para seleccionar a los empleados que se encuentren en Inglaterra y Francia
SELECT * FROM EMPLEADOS 
WHERE CODIGOOFICINA
IN (SELECT CODIGOOFICINA 
FROM OFICINAS WHERE PAIS
IN ('Inglaterra',  'Francia') )
--Muestra el código, nombre y gama de los productos que nunca se han pedido (detalle pedidos).
SELECT CODIGOPRODUCTO, NOMBRE , GAMA FROM PRODUCTOS WHERE CODIGOPRODUCTO NOT IN (
SELECT CODIGOPRODUCTO FROM DETALLEPEDIDOS)
--Ordene los pedidos de forma descendente respecto al codigopedido y respecto a la fecha de pedido de forma ascendente.
SELECT * FROM PEDIDOS ORDER BY CODIGOPEDIDO DESC, FECHAPEDIDO ASC 
-- Muestre los empleados que tengan una letra ‘o’ en cualquier parte de su nombre.
SELECT *
FROM EMPLEADOS
WHERE (NOMBRE LIKE '%O%' OR APELLIDO1 LIKE '%O%' OR APELLIDO2 LIKE '%O%');

--Muestre los empleados que tengan un apellido con una M al inicio
SELECT *
FROM EMPLEADOS
WHERE APELLIDO1 LIKE 'M%' OR APELLIDO2 LIKE 'M%';

--Nombre de los clientes que hayan hecho un pago en 2008

SELECT A.NOMBRECLIENTE FROM CLIENTES A INNER JOIN PAGOS B ON A.CODIGOCLIENTE = B.CODIGOCLIENTE WHERE EXTRACT(YEAR FROM FECHAPAGO) = 2008;
--Muestra el número de empleados que hay en la empresa.
SELECT COUNT(CODIGOEMPLEADO) FROM EMPLEADOS
--Mostrar el detalle de los clientes, los productos que han pedido y el detalle del pedido. 
SELECT
  C.NOMBRECLIENTE AS Cliente,
  P.CODIGOPEDIDO AS CodigoPedido,
  PR.NOMBRE AS Producto,
  DP.CANTIDAD AS Cantidad

FROM CLIENTES C
INNER JOIN PEDIDOS P ON C.CODIGOCLIENTE = P.CODIGOCLIENTE
INNER JOIN DETALLEPEDIDOS DP ON P.CODIGOPEDIDO = DP.CODIGOPEDIDO
INNER JOIN PRODUCTOS PR ON DP.CODIGOPRODUCTO = PR.CODIGOPRODUCTO;

--Muestre el código y la cantidad de veces que se ha pedido un producto al menos una vez.

SELECT A.CODIGOPRODUCTO, COUNT(*) AS CantidadPedidos
FROM DETALLEPEDIDOS A
GROUP BY A.CODIGOPRODUCTO


--Muestre el promedio de precio de compra por cliente.	
SELECT

  C.CODIGOCLIENTE AS CodigoCliente,
  C.NOMBRECLIENTE AS Cliente,
  AVG(DP.CANTIDAD * DP.PRECIOUNIDAD) AS PromedioPrecioCompra
FROM CLIENTES C
INNER JOIN PEDIDOS P ON C.CODIGOCLIENTE = P.CODIGOCLIENTE
INNER JOIN DETALLEPEDIDOS DP ON P.CODIGOPEDIDO = DP.CODIGOPEDIDO
GROUP BY  C.CODIGOCLIENTE, C.NOMBRECLIENTE;



--Muestre una vez los distintos puestos que tienen los empleados.
SELECT DISTINCT PUESTO
FROM EMPLEADOS;

--Mostrar el precio final de cada pedido.
SELECT
  P.CODIGOPEDIDO,
  C.CODIGOCLIENTE AS CodigoCliente,
  C.NOMBRECLIENTE AS Cliente,
  SUM(DP.CANTIDAD * DP.PRECIOUNIDAD) AS TotalPorPedido
FROM CLIENTES C
INNER JOIN PEDIDOS P ON C.CODIGOCLIENTE = P.CODIGOCLIENTE
INNER JOIN DETALLEPEDIDOS DP ON P.CODIGOPEDIDO = DP.CODIGOPEDIDO
GROUP BY P.CODIGOPEDIDO, C.CODIGOCLIENTE, C.NOMBRECLIENTE;

--
