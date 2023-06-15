/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' utilizando PigStorage y especificar el esquema de columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:datetime, color:chararray, number:INT);

-- Agrupar los registros por el año obtenido de la columna date
group_by = GROUP data BY GetYear(date);

-- Calcular el recuento de registros para cada grupo
count = FOREACH group_by GENERATE group AS year, COUNT(data) AS record_count;

-- Guardar el resultado en la carpeta 'output' utilizando PigStorage con ',' como delimitador
STORE count INTO 'output' USING PigStorage(',');

-- Fin del script

