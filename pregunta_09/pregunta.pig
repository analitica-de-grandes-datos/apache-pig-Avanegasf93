/*
Pregunta
===========================================================================

Para el archivo `data.csv` escriba una consulta en Pig que genere la 
siguiente salida:

  Vivian@Hamilton
  Karen@Holcomb
  Cody@Garrett
  Roth@Fry
  Zoe@Conway
  Gretchen@Kinney
  Driscoll@Klein
  Karyn@Diaz
  Merritt@Guy
  Kylan@Sexton
  Jordan@Estes
  Hope@Coffey
  Vivian@Crane
  Clio@Noel
  Hope@Silva
  Ayanna@Jarvis
  Chanda@Boyer
  Chadwick@Knight

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Carga el archivo data.csv y asigna los nombres de columna a cada columna respectiva
data = LOAD 'data.csv' USING PigStorage(',') AS (col1:CHARARRAY, col2:CHARARRAY, col3:CHARARRAY);

-- Filtra los registros que cumplan con la condición
filtered_data = FILTER data BY col1 matches '.*@.*';

-- Proyecta la columna col2 concatenada con el símbolo '@' y la columna col3
result = FOREACH filtered_data GENERATE CONCAT(col2, '@', col3);

-- Ordena los resultados en orden ascendente
sorted_result = ORDER result BY $0;

-- Almacena el resultado en la carpeta output utilizando PigStorage
STORE sorted_result INTO 'output' USING PigStorage(',');

-- Fin del script


