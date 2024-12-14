USE [Fast Food BD]

--Pregunta: �Cu�l es el total de ventas (TotalCompra) a nivel global?--

SELECT SUM (TotalCompra) AS Totalventas FROM Ordenes;

--Pregunta: �Cu�l es el precio promedio de los productos dentro de cada categor�a?--
SELECT * FROM Productos;

SELECT CategoriaID,

AVG (Precio) AS PrecioPromedio

FROM Productos

GROUP BY CategoriaID;

--Pregunta: �Cu�l es el valor de la orden m�nima y m�xima por cada sucursal?--

SELECT SucursalID,-- Dimension

       MIN(TotalCompra) AS OrdenMinima, -- Metrica 1

       MAX(TotalCompra) AS OrdenMaxima -- Metrica 2

FROM Ordenes

GROUP BY SucursalID;

--Pregunta: �Cu�l es el mayor n�mero de kil�metros recorridos para una entrega?--

SELECT MAX(KilometrosRecorrer) AS MaxKilometrosRecorridos FROM Ordenes;

--Pregunta: �Cu�l es la cantidad promedio de productos por orden?--

SELECT OrdenID,
    AVG(Cantidad) AS PromediodeProductos

    FROM DetalleOrden

    GROUP BY OrdenID

-- Pregunta: �C�mo se distribuye la Facturaci�n Total del Negocio de acuerdo a los m�todos de pago?--

SELECT TipoPagoID,

   SUM(TotalCompra) AS FacturacionTotal -- Metrica

FROM Ordenes

GROUP BY TipoPagoID;

-- Pregunta: �Cual Sucursal tiene el ingreso promedio m�s alto?

SELECT TOP 1 SucursalID,

    AVG(TotalCompra) AS IngresoPromedio -- Metrica

FROM Ordenes

GROUP BY SucursalID

ORDER BY IngresoPromedio DESC;

-- Pregunta: �Cu�les son las sucursales que han generado ventas totales por encima de $ 1000?
SELECT SucursalID,
    SUM(TotalCompra) AS VentasTotales

    FROM Ordenes

    GROUP BY SucursalID

	HAVING SUM(TotalCompra) > 1000

	ORDER BY 
	    VentasTotales DESC;

-- Pregunta: �C�mo se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?

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

/*Pregunta: �Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor cantidad de ventas,
cu�l es el ingreso promedio de estas ventas, y cu�l ha sido el importe m�ximo alcanzado por una orden en dicha jornada?
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