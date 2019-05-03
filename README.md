# Bases
Archivos usados y notas de clase del curso Implementacion de Bases de Datos en el semestre 2019-1
helouda

# Pendiente:
Hacer indices para optimizar consultas
Para el crud:
1. hacer un proceso que llene el contrato -> venta de planes
2. Otro procedimiento que es el de registrar las llamadas: para esto tiene que validar que plan tiene, si tiene minutos o no, etc
3. Otras funciones
4. Hacer Data Warehouse

4. tener en cuenta planes con control o planes sin control. para estos debe summar los adicionales si es necesario

5. Hacer los procedimientos de las recargas

resumen: contratos, recargas, llamadas y facturas.

en facturacion: cuando se hace el corte tiene que resetear los datos del plan

consultas de clientes por cedula y nombre, saldo disponible, y otros asi

//////////////////////////////////////////////////////
# Tener en cuenta
set statistics io on
set statistics time on

SELECT NOMBRE, DIRECCION FROM tbClientes
WHERE TELEFONO BETWEEN 9865436 AND 10865433


//una forma sencilla para mejorarlo, seria generando un indice
//de la siguiente manera

CREATE INDEX ix_telefono ON tbClientes (TELEFONO)
DROP INDEX ix_telefono ON tbClientes (TELEFONO)

//Las foraneas deberian tener indices


//Para el crud. hacer un proceso que llene el contrato -> venta de planes
//Otro procedimiento que es el de registrar las llamadas: para esto tiene que validar que plan tiene, si tiene minutos o no, etc