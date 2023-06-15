/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/

-- Carga el archivo data.tsv y asigna los nombres de columna letter, date y number a cada columna respectiva
data = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, number:INT);

-- Ordena los registros de la relación data por la columna letter y la columna number en orden ascendente
sorted_data = ORDER data by letter, number asc;

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por comas
STORE sorted_data INTO 'output' USING PigStorage(',');

-- Fin del script

