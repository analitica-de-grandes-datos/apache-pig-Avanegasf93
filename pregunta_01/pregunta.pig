/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv y asigna los nombres de columna letter, date y number a cada columna respectiva
data = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, number:INT);

-- Selecciona solo la columna letter de la relación data
letters = FOREACH data GENERATE letter;

-- Agrupa los registros de la relación letters por el valor de la columna letter
grouped = GROUP letters BY letter;

-- Para cada grupo en grouped, genera una tupla que contiene la letra del grupo y la cuenta de registros en ese grupo
counter = FOREACH grouped GENERATE group, COUNT(letters);

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por comas
STORE counter INTO 'output' USING PigStorage(',');

-- Fin del script