USE [Fast Food BD]

--Pregunta: ¿Cuál es el total de ventas (TotalCompra) a nivel global?--

SELECT SUM (TotalCompra) AS Totalventas FROM Ordenes;

--Pregunta: ¿Cuál es el precio promedio de los productos dentro de cada categoría?--
SELECT * FROM Productos;

SELECT CategoriaID,

AVG (Precio) AS PrecioPromedio

FROM Productos

GROUP BY CategoriaID;

--Pregunta: ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?--

SELECT SucursalID,-- Dimension

       MIN(TotalCompra) AS OrdenMinima, -- Metrica 1

       MAX(TotalCompra) AS OrdenMaxima -- Metrica 2

FROM Ordenes

GROUP BY SucursalID;

--Pregunta: ¿Cuál es el mayor número de kilómetros recorridos para una entrega?--

SELECT MAX(KilometrosRecorrer) AS MaxKilometrosRecorridos FROM Ordenes;

--Pregunta: ¿Cuál es la cantidad promedio de productos por orden?--

SELECT OrdenID,
    AVG(Cantidad) AS PromediodeProductos

    FROM DetalleOrden

    GROUP BY OrdenID

-- Pregunta: ¿Cómo se distribuye la Facturación Total del Negocio de acuerdo a los métodos de pago?--

SELECT TipoPagoID,

   SUM(TotalCompra) AS FacturacionTotal -- Metrica

FROM Ordenes

GROUP BY TipoPagoID;

-- Pregunta: ¿Cual Sucursal tiene el ingreso promedio más alto?

SELECT TOP 1 SucursalID,

    AVG(TotalCompra) AS IngresoPromedio -- Metrica

FROM Ordenes

GROUP BY SucursalID

ORDER BY IngresoPromedio DESC;

-- Pregunta: ¿Cuáles son las sucursales que han generado ventas totales por encima de $ 1000?
SELECT SucursalID,
    SUM(TotalCompra) AS VentasTotales

    FROM Ordenes

    GROUP BY SucursalID

	HAVING SUM(TotalCompra) > 1000

	ORDER BY 
	    VentasTotales DESC;

-- Pregunta: ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?

	-- Calcular el promedio de ventas ANTES del 1 de julio de 2023
	SELECT 
		AVG(TotalCompra) AS PromedioVentasAntes
	FROM 
		Ordenes
	WHERE 
		FechaOrdenTomada < '2023-07-01';

	-- Calcular el promedio de ventas DESPUES del 1 de julio de 2023
	SELECT 
		AVG(TotalCompra) AS PromedioVentasDespues
	FROM 
		Ordenes
	WHERE 
		FechaOrdenTomada >= '2023-07-01';

-- Combinar resultados
SELECT
(SELECT AVG(TotalCompra) 
FROM Ordenes 
WHERE FechaOrdenTomada < '2023-07-01') AS PromedioVentasAntes,
    
(SELECT AVG(TotalCompra) 
FROM Ordenes 
		WHERE FechaOrdenTomada >= '2023-07-01') AS PromedioVentasDespues;

/*Pregunta: ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas,
cuál es el ingreso promedio de estas ventas, y cuál ha sido el importe máximo alcanzado por una orden en dicha jornada?
*/
SELECT
    HorarioVenta, --Dimension cualitativa
    COUNT(OrdenID) AS CantidadVentas, -- Metrica 1
    AVG(TotalCompra) AS IngresoPromedio, -- Metrica 2
    MAX(TotalCompra) AS ImporteMaximo -- Metrica 3
FROM 
    Ordenes
GROUP BY 
    HorarioVenta
ORDER BY 
    CantidadVentas DESC;