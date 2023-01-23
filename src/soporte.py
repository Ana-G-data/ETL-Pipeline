import pandas as pd
import numpy as np
import re
pd.options.display.max_columns = None
from datetime import datetime, date
from datetime import datetime, time, timedelta
import warnings
import matplotlib.pyplot as plt
import requests
import os 
from dotenv import load_dotenv
load_dotenv()


"""devuelve el porcentaje de algo. Llamada sp.porcentaje(df,columna)"""
def porcentaje(df,columna): 
    return round(df[columna] /df[columna].sum()*100,2)

"""devuelve el porcentaje de nulos en una columna. sp.porcentaje_nulos(df,columna"""
def porcentaje_nulos(df,columna):
    return round((df[columna].isnull().sum() / df.shape[0]) * 100, 2)

"""dos gráficas lineales, una sobre la otra"""
"""sp.graf_historico1(df1,col1_sup,col2_sup,col3_sup,title_sup,df2,col1_inf,col2_inf,col3_inf,title_inf)"""
def graf_historico1(df1,col1_sup,col2_sup,col3_sup,title_sup,df2,col1_inf,col2_inf,col3_inf,title_inf):
    fig, axs = plt.subplots(1, 2, figsize=(20, 10))
    plt.subplot(2, 1, 1)
    for group in df1[col1_sup].unique():
        subset = df1[df1[col1_sup] == group]
        plt.plot(subset[col2_sup], subset[col3_sup], label=group)
    plt.xlabel(col2_sup)
    plt.ylabel(col3_sup)
    plt.legend()
    plt.title(title_sup)
    plt.gca().spines['top'].set_visible(False)
    plt.gca().spines['right'].set_visible(False)
    # Crear el segundo gráfico
    plt.subplot(2, 1, 2)
    for group in df2[col1_inf].unique():
        subset = df2[df2[col1_inf] == group]
        plt.plot(subset[col2_inf], subset[col3_inf], label=group)
    plt.xlabel(col2_inf)
    plt.ylabel(col3_inf)
    plt.legend()
    plt.title(title_inf)
    plt.gca().spines['top'].set_visible(False)
    plt.gca().spines['right'].set_visible(False)
    # Mostrar los gráficos
    plt.show()


"""dos gráficas de barras, una sobre la otra, mostrando los porcentajes encima de cada barra"""
"""sp.graf_barras1(sup_x,sup_y,df1,sup_xlabel,sup_ylabel,sup_title,sup_col,inf_x,inf_y,df2,inf_xlabel,inf_ylabel,inf_title,inf_col)"""
def graf_barras1(sup_x,sup_y,df1,sup_xlabel,sup_ylabel,sup_title,sup_col,inf_x,inf_y,df2,inf_xlabel,inf_ylabel,inf_title,inf_col):
    fig, axs = plt.subplots(2, 1, figsize=(20, 10))

    ax = sns.barplot(x=sup_x, y=sup_y, data=df1, ax=axs[0])
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    plt.xlabel(sup_xlabel)
    plt.ylabel(sup_ylabel)
    plt.title(sup_title)
    for i, v in enumerate(df1[sup_col]):
        ax.text(i-.25, v+0.25, str(round(v/df1[sup_col].sum()*100, 2)) + '%', color='black', fontweight='bold')

    ax = sns.barplot(x=inf_x, y=inf_y, data=df2, ax=axs[1])
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    plt.xlabel(inf_xlabel)
    plt.ylabel(inf_ylabel)
    plt.title(inf_title)

    for i, v in enumerate(df2[inf_col]):
        ax.text(i-.25, v+0.25, str(round(v/df2[inf_col].sum()*100, 2)) + '%', color='black', fontweight='bold')


"""gráfico de barras agrupado"""
"""sp.graf_barras2(x_,y_,hue_,df,xlabel,ylabel,title)"""
def graf_barras2(x_,y_,hue_,df,xlabel,ylabel,title):
    plt.figure(figsize=(20, 10))
    ax = sns.barplot(x=x_, y=y_, hue=hue_, data=df)
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    # Añadir etiquetas y título al gráfico
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.title(title)


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

    

def graf_quesitos(columna)

import matplotlib.pyplot as plt

manzanas = [20,10,25,30]
nombres = ["Ana","Juan","Diana","Catalina"]
plt.pie(manzanas, labels=nombres, autopct="%0.1f %%")
plt.axis("equal")
plt.show()


        


