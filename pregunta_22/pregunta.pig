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
       color REGEXP '.n';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' utilizando PigStorage y especificar el esquema de columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Proyectar el UserName y el color en la variable column y aplicar REGEX_EXTRACT en el color
column = FOREACH data GENERATE UserName, REGEX_EXTRACT(color, '.n', 0) AS extracted_color;

-- Filtrar los registros donde el color extraído coincide con el patrón '.n'
filtered_by = FILTER column BY extracted_color IS NOT NULL;

-- Guardar el resultado en la carpeta 'output' utilizando PigStorage con ',' como delimitador
STORE filtered_by INTO 'output' USING PigStorage(',');

-- Fin del script

