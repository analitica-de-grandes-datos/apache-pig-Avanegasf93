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
data = LOAD 'data.tsv' AS (col1:CHARARRAY, col2:BAG{A:tuple(a1:CHARARRAY)}, col3:MAP[]);

-- Genera una relación con las columnas col2 y col3 aplanadas
col_23 = FOREACH data GENERATE FLATTEN(col2) AS C1, FLATTEN(col3) AS C2;

-- Agrupa los registros por la columna C1 y la columna C2
grouped_data = GROUP col_23 BY (C1, C2);

-- Calcula la cantidad de registros por cada grupo
count_data = FOREACH grouped_data GENERATE group, COUNT(col_23) AS count;

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por coma
STORE count_data INTO 'output' USING PigStorage(',');

-- Fin del script

