/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
-- Cargar el archivo 'data.csv' utilizando PigStorage y especificar el esquema de columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Proyectar las columnas UserName y color en la variable column
column = FOREACH data GENERATE UserName, color;

-- Filtrar los registros donde color es 'blue' y UserName comienza con 'Z' (mayúscula o minúscula)
filtered_by = FILTER column BY color == 'blue' AND (UserName MATCHES '.*^[zZ].*');

-- Almacenar el resultado en la carpeta 'output' utilizando PigStorage
STORE filtered_by INTO 'output' USING PigStorage(',');

-- Fin del script

