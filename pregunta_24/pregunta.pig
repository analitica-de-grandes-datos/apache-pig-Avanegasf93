/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' en Pig
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Extraer la segunda parte de la fecha utilizando REGEX_EXTRACT y guardar el resultado en la variable column
column = FOREACH data GENERATE REGEX_EXTRACT(date, '(.*)-(.*)-(.*)', 2) AS extracted_date;

-- Filtrar los registros donde extracted_date no sea nulo
filtered_by = FILTER column BY extracted_date IS NOT NULL;

-- Guardar el resultado en la carpeta 'output' utilizando PigStorage
STORE filtered_by INTO 'output' USING PigStorage(',');

-- Fin del script


