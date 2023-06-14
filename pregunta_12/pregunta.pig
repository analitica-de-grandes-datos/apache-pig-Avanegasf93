/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' utilizando PigStorage y especificar el esquema de columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Filtrar los apellidos que comienzan con las letras entre 'd' y 'k' utilizando REGEX_EXTRACT
column = FOREACH data GENERATE REGEX_EXTRACT(UserLastName, '([D-K].*)', 1) AS C1;

-- Filtrar registros que no tengan el valor nulo en el apellido
filtered = FILTER column BY C1 IS NOT NULL;

-- Proyectar el apellido
result = FOREACH filtered GENERATE C1;

-- Almacenar el resultado en la carpeta 'output' utilizando PigStorage
STORE result INTO 'output' USING PigStorage(',');

-- Fin del script


