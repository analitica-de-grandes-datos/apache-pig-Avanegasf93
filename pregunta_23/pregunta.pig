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
   WHERE 
       color REGEXP '[aeiou]$';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' utilizando PigStorage y especificar el esquema de columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Proyectar el UserName y aplicar la condición REGEXP en la columna color
column = FOREACH data GENERATE UserName, REGEX_EXTRACT(color,'(.*[aeiou]$)',1) AS color_regex;

-- Filtrar los registros donde la columna color coincide con la expresión regular
filtered_by = FILTER column BY color_regex is not null;

-- Guardar el resultado en la carpeta 'output' utilizando PigStorage con ',' como delimitador
STORE filtered_by INTO 'output' USING PigStorage(',');

-- Fin del script
