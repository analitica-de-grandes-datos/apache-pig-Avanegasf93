/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/

-- Cargar el archivo 'data.csv' utilizando PigStorage y especificar el esquema de columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Filtrar los registros donde el color no comienza con 'b' utilizando la expresión regular
filtered = FILTER data BY NOT (color MATCHES '.*^[bB].*');

-- Proyectar la columna color
result = FOREACH filtered GENERATE color;

-- Almacenar el resultado en la carpeta 'output' utilizando PigStorage
STORE result INTO 'output' USING PigStorage(',');

-- Fin del script

