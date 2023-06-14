/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv y asigna los nombres de columna a cada columna respectiva
data = LOAD 'data.tsv' AS (col1:CHARARRAY, col2:CHARARRAY, col3:CHARARRAY);

-- Agrupa los registros por letra de la columna 2 y clave de la columna 3
grouped_data = GROUP data BY (col2, col3);

-- Calcula la cantidad de registros por cada grupo
count_data = FOREACH grouped_data GENERATE group, COUNT(data) AS count;

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por coma
STORE count_data INTO 'output' USING PigStorage(',');

-- Fin del script
