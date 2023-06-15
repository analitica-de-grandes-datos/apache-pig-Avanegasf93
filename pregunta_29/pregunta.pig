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

-- Cargamos los datos desde el archivo 'data.csv'
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Extraemos la columna de fechas y la asignamos a la variable 'dates'
dates = FOREACH data GENERATE date AS d1;

-- Convertimos las fechas de formato chararray a DateTime y las asignamos a la variable 'd2'
d2 = FOREACH dates GENERATE ToDate(d1,'yyyy-MM-dd') AS (date_time: DateTime);

-- Generamos nuevas columnas a partir de la fecha en formato DateTime, incluyendo la fecha completa, el nombre del mes, el mes y el número del mes
column = FOREACH d2 GENERATE ToString(date_time, 'yyyy-MM-dd') AS (all_date:chararray), ToString(date_time, 'MMM') AS (name_month:chararray), ToString(date_time, 'MM') AS (mes:chararray), ToString(date_time, 'M') AS (month);

-- Reemplazamos el nombre del mes 'Jan' por 'ene' y conservamos las demás columnas
column = FOREACH column GENERATE all_date, REPLACE (name_month,'Jan','ene') AS name_month, mes, month;

-- Reemplazamos el nombre del mes 'Apr' por 'abr' y conservamos las demás columnas
column = FOREACH column GENERATE all_date, REPLACE (name_month,'Apr','abr') AS name_month, mes, month;

-- Reemplazamos el nombre del mes 'Aug' por 'ago' y conservamos las demás columnas
column = FOREACH column GENERATE all_date, REPLACE (name_month,'Aug','ago') AS name_month, mes, month;

-- Reemplazamos el nombre del mes 'Dec' por 'dic' y conservamos las demás columnas
column = FOREACH column GENERATE all_date, REPLACE (name_month,'Dec','dic') AS name_month, mes, month;

-- Convertimos el nombre del mes a minúsculas y conservamos las demás columnas
column = FOREACH column GENERATE all_date, LOWER(name_month), mes, month;

-- Guardamos los resultados en el archivo 'output' utilizando el formato PigStorage(',')
STORE column INTO 'output' USING PigStorage(',');

-- Fin del script

