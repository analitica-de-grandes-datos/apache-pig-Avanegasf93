/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo 'data.csv' utilizando PigStorage y especificar el esquema de columnas
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Generar una relación que contenga el apellido y su longitud
column = FOREACH data GENERATE UserLastName, SIZE(UserLastName) AS longitud;

-- Ordenar la relación por longitud en orden descendente y por apellido en orden ascendente
sorted_data = ORDER column BY longitud DESC, UserLastName ASC;

-- Limitar los resultados a los primeros 5 registros
limited_data = LIMIT sorted_data 5;

-- Almacenar el resultado en la carpeta 'output' utilizando PigStorage
STORE limited_data INTO 'output' USING PigStorage(',');

-- Fin del script



