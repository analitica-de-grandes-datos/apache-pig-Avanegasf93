/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' en Pig
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Proyectar el campo UserName y renombrarlo como Name
column = FOREACH data GENERATE UserName AS Name;

-- Filtrar los registros donde el primer carácter de Name sea mayor o igual a 'M'
filtered_by = FILTER column BY SUBSTRING(Name, 0, 1) >= 'M';

-- Guardar el resultado en la carpeta 'output' utilizando PigStorage
STORE filtered_by INTO 'output' USING PigStorage(',');

-- Fin del script

