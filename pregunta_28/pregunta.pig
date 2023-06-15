/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       birthday, 
       DATE_FORMAT(birthday, "yyyy"),
       DATE_FORMAT(birthday, "yy"),
   FROM 
       persons
   LIMIT
       5;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' en Pig
lines = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Proyectar el campo date como d1
dates = FOREACH lines GENERATE date AS d1;

-- Convertir la cadena de fecha a un tipo DateTime
parsed_dates = FOREACH dates GENERATE ToDate(d1, 'yyyy-MM-dd') AS date_time;

-- Extraer el año de la fecha en el formato deseado
year_data = FOREACH parsed_dates GENERATE ToString(date_time, 'yyyy') AS year_full, ToString(date_time, 'yy') AS year_short;

-- Guardar el resultado en la carpeta 'output' utilizando PigStorage
STORE year_data INTO 'output' USING PigStorage(',');

-- Fin del script

