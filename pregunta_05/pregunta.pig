/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.tsv y asigna los nombres de columna letter, date y number a cada columna respectiva
data = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, number:INT);

-- Extrae solo la columna date de la relación data
dates = FOREACH data GENERATE date;

-- Genera una relación con las letras minúsculas encontradas en la columna date
lowercase_letters = FOREACH dates GENERATE FLATTEN(TOKENIZE(REPLACE(date, '[^a-z]', ' '))) AS letter;
lowercase_letters = FILTER lowercase_letters BY letter != '';

-- Agrupa los registros por la letra y cuenta la cantidad de registros en cada grupo
grouped = GROUP lowercase_letters BY letter;
counter = FOREACH grouped GENERATE group, COUNT(lowercase_letters);

-- Almacena el resultado en la carpeta output utilizando PigStorage y separando los valores por comas
STORE counter INTO 'output' USING PigStorage(',');

-- Fin del script
