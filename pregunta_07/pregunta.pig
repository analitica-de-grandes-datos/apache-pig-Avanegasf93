/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv y asigna los nombres de columna col1, col2 y col3 a cada columna respectiva
data = LOAD 'data.tsv' AS (col1:CHARARRAY, col2:BAG{A:tuple(a1:CHARARRAY)}, col3:MAP[]);

-- Genera una tabla que contiene la primera columna, la cantidad de elementos en la columna 2 y la cantidad de elementos en la columna 3
col_123 = FOREACH data GENERATE col1, SIZE(col2) AS col2_count, SIZE(col3) AS col3_count;

-- Ordena la tabla por las columnas col1, col2_count y col3_count
sorted_data = ORDER col_123 BY col1, col2_count, col3_count;

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por coma
STORE sorted_data INTO 'output' USING PigStorage(',');

-- Fin del script

