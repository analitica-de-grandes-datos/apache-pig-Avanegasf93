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

-- Carga el archivo data.tsv y asigna los nombres de columna letter, date y number a cada columna respectiva
data = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, number:INT);

-- Agrupa los registros por la clave de la columna 3 (eventKey) y cuenta la cantidad de registros en cada grupo
grouped = GROUP data BY eventKey;
counter = FOREACH grouped GENERATE group, COUNT(data);

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por comas
STORE counter INTO 'output' USING PigStorage(',');

-- Fin del script

