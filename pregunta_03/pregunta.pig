/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv y asigna los nombres de columna letter, date y number a cada columna respectiva
data = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, number:INT);

-- Extrae solo la columna number de la relación data
numbers = FOREACH data GENERATE number;

-- Ordena los valores de la columna number en orden ascendente
sorted_numbers = ORDER numbers BY number ASC;

-- Limita los registros a los cinco primeros (los valores más pequeños)
limited_numbers = LIMIT sorted_numbers 5;

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por comas
STORE limited_numbers INTO 'output' USING PigStorage(',');

-- Fin del script
