/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' en Pig
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Proyectar el campo date y convertirlo en formato de fecha
dates = FOREACH data GENERATE date AS d1;
dates = FOREACH dates GENERATE ToDate(d1, 'yyyy-MM-dd') AS date_time;

-- Aplicar las transformaciones necesarias para obtener la salida requerida
column = FOREACH dates GENERATE
    ToString(date_time, 'yyyy-MM-dd') AS fecha_completa,
    LOWER(REPLACE(ToString(date_time, 'MMM'), 'Jan', 'ene')) AS nombre_mes,
    ToString(date_time, 'MM') AS mes,
    ToString(date_time, 'M') AS month;

-- Reemplazar los nombres de los meses abreviados
column = FOREACH column GENERATE
    fecha_completa,
    REPLACE(nombre_mes, 'Apr', 'abr') AS nombre_mes,
    mes,
    month;

-- Reemplazar otros nombres de meses abreviados
column = FOREACH column GENERATE
    fecha_completa,
    REPLACE(nombre_mes, 'Aug', 'ago') AS nombre_mes,
    mes,
    month;

-- Reemplazar más nombres de meses abreviados
column = FOREACH column GENERATE
    fecha_completa,
    REPLACE(nombre_mes, 'Dec', 'dic') AS nombre_mes,
    mes,
    month;

-- Guardar el resultado en la carpeta 'output' utilizando PigStorage
STORE column INTO 'output' USING PigStorage(',');

-- Fin del script

