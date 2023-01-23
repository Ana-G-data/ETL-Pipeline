# ETL-project - English volunteers

![ingles](imagenes/English-as-a-global-language.jpg)
## CONTEXTO Y OBJETIVO DEL PROYECTO

Ofrecemos programas de voluntariado a personas de habla inglesa alrededor del mundo para que vengan a compartir su tiempo con personas interesadas en mejorar su nivel de inglés.
Los campamentos que se ofrecen pueden ser para adultos o para 'teens' y la duración varía entre 1 o 2 semanas.

Para el proyecto actual vamos a partir de una base de datos con información de todos los voluntarios que se han ido apuntando a diferentes programas a lo largo de los años.
Queremos probar las siguientes hipótesis:

- La mayoría de voluntarios/as son mujeres.
- La mediana de edad (analizando sólo aquellos mayores de 18 años) ronda los 60. Con los años, la mediana de edad de los asistentes a programas ha ido aumentando.
- El país del que vienen más voluntarios es EEUU. 
- Los voluntarios menores de 18 años tienen que ser recogidos en el aeropuerto, la mayoría de ellos llega por la mañana a la T4.
- A raíz del COVID el numero de solicitudes para hacer voluntariado bajó significativamente, pero el número de solicitudes recibidas tiene una tendencia al alza
- Más del 50% de los voluntarios que han participado en programas después del COVID son veteranos que han hecho más de 2 programas.

## APIS
### Vuelos:
[goflightlabs]'https://app.goflightlabs.com', [documentación]'https://app.goflightlabs.com/dashboard'. Es una API sencilla de usar, que te permite relizar busquedas de vuelos y aeropuertos. En este caso lo que me interesa es la fecha de llegada y la terminal.
 
### Continentes:
[listado paises y continentes]'https://statisticstimes.com/geography/countries-by-continents.php'. Lo escrapee para poder umirar luego de que continente nos llegan más aplicaciones.

## ESTRUCTURA CONTENIDO
Hemos creado 5 carpetas en el repositorio. 
    - datos: aquí encontraremos el csv original, así como todos los que hemos tenido que ir creando para el correcto funcionamiento del estudio.
    - imagenes: cualquier imagen usada en este readme se podrá encontrar en esta carpeta
    - notebook: todos los notebooks que hemos ido necesitando (limpieza, datos_SQL, api_call, etc)
    - SQL-model
    - src: hemos utilizado un archivo soporte.py que se enuentra en esta carpeta

## TECNOLOGÍAS
import sys
sys.path.append("../")
import warnings
import src.soporte as sp
from fuzzywuzzy import fuzz
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from datetime import datetime, date
from datetime import datetime, time, timedelta
import folium
import geopy
from functools import partial 
import re
import pandas as pd
import numpy as np
import re
pd.options.display.max_columns = None
from datetime import datetime, date
from datetime import datetime, time, timedelta
import warnings
import seaborn as sns
import matplotlib.pyplot as plt
from fuzzywuzzy import fuzz
import requests
import os 
from dotenv import load_dotenv
load_dotenv()

## PASOS QUE VAMOS A SEGUIR

### LIMPIEZA

A título informativo, la información privada que aparece en el dataframe ha sido generada con la libreria FAKER (from faker import Faker), pero se han mantenido reales el sexo y la nacionalidad para no distorsionar los datos obtenidos.

Lo primero que vamos a hacer es limpiar y analizar los datos que tenemos. Se puede apreciar que algunos nombres de voluntarios están repetidos. Esto se debe a que está base de datos recoge todas las aplicaciones de voluntariado. Crearemos un segundo dataframe para analizar los voluntarios 
