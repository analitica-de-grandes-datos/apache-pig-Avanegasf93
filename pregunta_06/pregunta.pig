/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv y asigna los nombres de columna col1, col2 y col3 a cada columna respectiva
data = LOAD 'data.tsv' AS (col1:CHARARRAY, col2:BAG{A:tuple(a1:CHARARRAY)}, col3:MAP[]);

-- Expande la columna col3 para obtener las palabras individuales
expanded_col3 = FOREACH data GENERATE FLATTEN(col3) AS word;

-- Agrupa los registros por la columna 3
grouped = GROUP expanded_col3 BY word;

-- Calcula la cantidad de registros por cada palabra
count = FOREACH grouped GENERATE group AS word, COUNT(expanded_col3) AS count;

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por comas
STORE count INTO 'output' USING PigStorage(',');

-- Fin del script


