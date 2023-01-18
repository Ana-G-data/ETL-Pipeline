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


def copiar_valores(df,col_nulos,col_valores):
    """Función para rellenar valores nulos con información de otra columna"""
    """Para llamar la columna sp.copiar_valores(df,'columna_con_nulos','columna_valores')"""
    # Selecciona los valores nulos de la columna A
    nulos = df[col_nulos].isnull()
    # Copia los valores de la columna A a la columna B solo para los valores nulos de B
    df.loc[nulos, col_valores] = df.loc[nulos, col_nulos]
    return df


def dividir_serie(df): 
    """Función para dividir los nombres de los programas"""
    df_cursos = pd.DataFrame(columns=['Destino', 'Tipo', 'Duración', 'Comienzo', 'Final', 'Nombre_completo'])   
    # Recorrer cada elemento de la serie
    for i, elemento in df.iteritems():
        # Extraer las partes de la cadena usando expresiones regulares
        match = re.search(r'(.*) (TEENS|ADULTS)-VOLUNTEER (.*) from (.*) to (.*)', elemento)
        destino = match.group(1)
        tipo = match.group(2)
        duracion = match.group(3)
        comienzo = match.group(4)
        final = match.group(5)
        
        # Añadir las partes extraídas y el nombre completo al DataFrame
        df_cursos.loc[i] = [destino, tipo, duracion, comienzo, final, elemento]
    
    return df_cursos



def edad(df, birth_date_col, age_col): 
    """Función para calcular la edad teniendo la fecha de nacimiento. Para llamarla: sp.edad(dataframe,'columna_fecha', 'columna_edad')"""
    for i, elemento in df[birth_date_col].iteritems():
        # Comprobar si el elemento es nulo
        if not pd.isnull(elemento):
            Birth_Date = datetime.strptime(elemento, "%d/%m/%Y").date()
            age = date.today() - Birth_Date
            age_years = int(age.days / 365.2425)
            df.loc[i, age_col] = age_years
    return df


def year_nacimiento (df, age_col, birth_date_col ):
    """Función para calcular el año de nacimiento teniendo la edad. Para llamarla: sp.edad(dataframe,'columna_edad', 'columna_fecha')"""
    for i, elemento in df[age_col].iteritems():
        # Comprobar si el elemento es nulo
        if not pd.isnull(elemento):
            # Calcular el año de nacimiento restando la edad actual a la fecha actual
            birthyear = int(date.today().year - elemento)
            # Asignar el año de nacimiento a la columna "Birthyear"
            df.loc[i, birth_date_col] = birthyear
    return df


def graf_barras(mediana, graf_dcha_x, graf_dcha_y, graf_dcha_data,graf_dcha_labelx, graf_dcha_labely, graf_dcha_title):
    """1 Gráficos de barras mostrando la Mediana con una flecha"""
    """Para llamarla: sp.graf_barras('dcha_col_x','dcha_col_y', 'dcha_data', 'dcha_label_x, 'dcha_label_y', 'dcha_title'"""
    
    plt.figure(figsize=(25, 5))

    ax = sns.barplot(x=graf_dcha_x, y=graf_dcha_y, data=graf_dcha_data)
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    # Añadir etiquetas y título al gráfico
    plt.xlabel(graf_dcha_labelx)
    plt.ylabel(graf_dcha_labely)
    plt.title(graf_dcha_title)

    # Añadir mediana como cuadro de texto en la esquina del gráfico
    ax.annotate('Mediana: {:.0f}'.format(mediana), xy=(1.05, mediana), xytext=(1.45, mediana),
             arrowprops=dict(facecolor='black', edgecolor='black', alpha=1), color='Black', fontsize=15,rotation=90)

    



def graf_temporal_group_by(df, columnx,columny):
    fig, ax = plt.subplots(figsize=(10,5))
    for x in df[columnx].unique():
        x_df = df[df[columnx] == x]
        plt.plot(x_df[columny], x_df[columny], label=ax)
    ax.set_xlabel('Year')
    ax.set_ylabel('Total')
    ax.set_title('Histórico de voluntarios')
    plt.legend()
    plt.show()










        
def graf_lineal(df,colx,coly,labelx,labely,xnames,title,marcador_vertical):
    """Grafica líneal con marcador verical en punto a elegir"""
    """Con los valores que queramos en x"""
    """Para llamarla sp.graf_lineal((df,'colx','coly','labelx','labely','xnames','title',marcador_vertical)"""
    plt.figure(figsize=(15, 6))

    ax = plt.axes() 
    ax.set_facecolor("white") 

    ax.spines['bottom'].set_color('black') 
    ax.spines['top'].set_color('white')
    ax.spines['right'].set_color('white') 
    ax.spines['left'].set_color('black') 

    plt.plot(df[colx], 
            df[coly], 
            color = "green", 
            linewidth = 2, 
            marker = "o") 

    plt.xlabel(labelx,fontsize=15) 
    plt.ylabel(labely,fontsize=15) 
    plt.title(title,fontsize=20)
    plt.xticks(df[xnames],rotation=45)

    # Add the vertical red line at the year 2020
    plt.axvline(x=marcador_vertical, color='red', linewidth=2)

    plt.show()


def porcentaje(df,columna):
    return round(df[columna] /df[columna].sum()*100,2)

def porcentaje_nulos(df,columna):
    return round((df[columna].isnull().sum() / df.shape[0]) * 100, 2)
    



