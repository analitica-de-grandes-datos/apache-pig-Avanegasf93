/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargamos los datos desde el archivo 'data.csv'
data = LOAD 'data.csv' USING PigStorage(',') AS (ColId:INT, UserName:chararray, UserLastName:chararray, date:datetime, color:chararray, number:INT); 

-- Generamos nuevas columnas a partir de la fecha en formato DateTime, incluyendo la fecha en formato 'yyyy-MM-dd', el día del mes en formato 'dd,d',
-- el nombre corto del día de la semana en formato 'EEE' y el nombre completo del día de la semana en formato 'EEEE'
column = FOREACH data GENERATE ToString(date, 'yyyy-MM-dd') AS date, ToString(date, 'dd,d') AS day, ToString(date, 'EEE') AS name_day1, ToString(date, 'EEEE') AS name_day;

-- Asignamos el nombre corto del día de la semana en función del nombre completo del día de la semana utilizando una condición anidada
result = FOREACH column GENERATE date, day, 
    (name_day1 == 'Mon'? 'lun':(name_day1 == 'Tue'? 'mar':(name_day1 == 'Wed'? 'mie': 
    (name_day1 == 'Thu'? 'jue':(name_day1 == 'Fri'? 'vie':(name_day1 == 'Sat'? 'sab':(name_day1 == 'Sun'? 'dom':'falso'))))))) AS short_day,  
    (name_day == 'Monday'? 'lunes':(name_day == 'Tuesday'? 'martes':(name_day == 'Wednesday'? 'miercoles': 
    (name_day == 'Thursday'? 'jueves':(name_day == 'Friday'? 'viernes':(name_day == 'Saturday'? 'sabado':(name_day == 'Sunday'? 'domingo':'falso'))))))) AS complete_day; 

-- Guardamos los resultados en el archivo 'output' utilizando el formato PigStorage(',')
STORE result INTO 'output' USING PigStorage(','); 

-- Fin del script