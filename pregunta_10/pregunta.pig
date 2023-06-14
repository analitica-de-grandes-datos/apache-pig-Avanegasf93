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

-- Carga el archivo data.csv y asigna los nombres de columna a cada columna respectiva
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:chararray, color:chararray, number:INT);

-- Proyecta la columna UserLastName y su longitud
apellido_longitud = FOREACH data GENERATE UserLastName, SIZE(UserLastName) AS longitud;

-- Ordena los resultados por longitud en orden ascendente y UserLastName en orden descendente
ordenado = ORDER apellido_longitud BY longitud ASC, UserLastName DESC;

-- Almacena el resultado en la carpeta output utilizando PigStorage
STORE ordenado INTO 'output' USING PigStorage(',');

-- Fin del script



