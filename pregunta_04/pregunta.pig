/*
Pregunta
===========================================================================

El archivo `data.csv` tiene la siguiente estructura:

  driverId       INT
  truckId        INT
  eventTime      STRING
  eventType      STRING
  longitude      DOUBLE
  latitude       DOUBLE
  eventKey       STRING
  correlationId  STRING
  driverName     STRING
  routeId        BIGINT
  routeName      STRING
  eventDate      STRING

Escriba un script en Pig que carge los datos y obtenga los primeros 10 
registros del archivo para las primeras tres columnas, y luego, ordenados 
por driverId, truckId, y eventTime. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.csv y define el esquema de las columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (
    driverId: INT,
    truckId: INT,
    eventTime: chararray,
    eventType: chararray,
    longitude: DOUBLE,
    latitude: DOUBLE,
    eventKey: chararray,
    correlationId: chararray,
    driverName: chararray,
    routeId: BIGINTEGER,
    routeName: chararray,
    eventDate: chararray
);

-- Obtiene los primeros 10 registros para las primeras tres columnas
limited_data = LIMIT data 10;
limited_data_subset = FOREACH limited_data GENERATE driverId, truckId, eventTime;

-- Ordena los registros por driverId, truckId y eventTime en orden ascendente
sorted_data = ORDER limited_data_subset BY driverId, truckId, eventTime;

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por comas
STORE sorted_data INTO 'output' USING PigStorage(',');

-- Fin del script