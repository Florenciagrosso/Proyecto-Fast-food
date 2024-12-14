USE [Fast Food BD]
--�Cu�l es el tiempo promedio desde el despacho hasta la entrega de los pedidos gestionados por todo el equipo de mensajer�a?

SELECT AVG(DATEDIFF(MINUTE, FechaDespacho, FechaEntrega)) AS TiempoPromedioEntrega
FROM Ordenes
WHERE MensajeroID IS NOT NULL;

--An�lisis de Ventas por Origen de Orden: �Qu� canal de ventas genera m�s ingresos?
SELECT TOP 1
    T2.Descripcion AS Canal,
    SUM(T1.TotalCompra) AS Ingreso
FROM Ordenes AS T1
INNER JOIN OrigenesOrden AS T2 
ON T1.OrigenID = T2.OrigenID
GROUP BY T2.Descripcion
ORDER BY Ingreso DESC;

--�Cu�l es el nivel de ingreso generado por Empleado?

SELECT MONTH(FechaOrdenTomada)
FROM Ordenes;
SELECT 
    MONTH(FechaOrdenTomada) AS PeriodoMensual,
    SUM(TotalCompra) AS Ingresos
FROM Ordenes
GROUP BY MONTH(FechaOrdenTomada);

SELECT 
    ClienteID, 
    COUNT(OrdenID) AS CantidadOrdenes,
    CASE
        WHEN COUNT(OrdenID) = 1 THEN 'NUEVO'
        ELSE 'RECURRENTE'
    END AS TipoCliente
FROM Ordenes
GROUP BY ClienteID
ORDER BY CantidadOrdenes;
