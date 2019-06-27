# Detecci�n de anomal�as mediante distribuci�n gaussiana
## Distribuci�n Gaussiana (Normal)

La **distribuci�n normal** (o **Gaussiana** ) es una distribuci�n de probabilidad continua muy com�n. Las distribuciones normales son importantes en las estad�sticas y a menudo se usan en las ciencias naturales y sociales para representar variables aleatorias de valor real cuyas distribuciones no se conocen. Una variable aleatoria con una distribuci�n gaussiana se dice que se distribuye normalmente y se llama desviaci�n normal.

Digamos:

![x-in-R](./formulas/x-in-R.svg)

Si _x_ se distribuye normalmente, puede mostrarse de la siguiente manera.

![Gaussian Distribution](https://upload.wikimedia.org/wikipedia/commons/7/74/Normal_Distribution_PDF.svg)

![mu](./formulas/mu.svg) - valor medio,

![sigma-2](./formulas/sigma-2.svg) - varianza.

![x-normal](./formulas/x-normal.svg) - "~" significa que _"x se distribuye como ..."_

Luego, la distribuci�n gaussiana (la probabilidad de que alguna _x_ sea ??parte de la distribuci�n con cierta media y varianza) viene dada por:

![Gaussian Distribution](./formulas/p.svg)

## Estimando par�metros para un Gaussiano

We may use the following formulas to estimate Gaussian parameters (mean and variation) for _i<sup>th</sup>_ feature:

Podemos utilizar las siguientes f�rmulas para calcular los par�metros de Gauss (media y variaci�n) para _i<sup>�simo<sup>_ caracter�stica:

![mu-i](./formulas/mu-i.svg)

![sigma-i](./formulas/sigma-i.svg)

![i](./formulas/i.svg)

![m](./formulas/m.svg) - N�mero de ejemplos de entrenamiento.

![n](./formulas/n.svg) - N�mero de caracter�sticas.

## Estimaci�n de densidad

As� que tenemos un conjunto de entrenamiento:

![Training Set](./formulas/training-set.svg)

![x-in-R](./formulas/x-in-R.svg)

Suponemos que cada caracter�stica del conjunto de entrenamiento se distribuye normalmente:

![x-1](./formulas/x-1.svg)

![x-2](./formulas/x-2.svg)

![x-n](./formulas/x-n.svg)

Entonces:

![p-x](./formulas/p-x.svg)

![p-x-2](./formulas/p-x-2.svg)

## Anomaly Detection Algorithm

1. Elija las caracter�sticas ![x-i](./formulas/x-i.svg) que puedan ser indicativas de ejemplos an�malos (![Training Set](./formulas/training-set.svg)).
2. Ajustar los parametros ![params](./formulas/params.svg) utilizando las siguientes f�rmulas:

![mu-i](./formulas/mu-i.svg)

![sigma-i](./formulas/sigma-i.svg)

3. Dado el nuevo ejemplo _x_, calcular _p(x)_:

![p-x-2](./formulas/p-x-2.svg)

Anomal�a si ![anomaly](./formulas/anomaly.svg)

![epsilon](./formulas/epsilon.svg) - umbral de probabilidad.

## Evaluaci�n de algoritmos

El algoritmo puede ser evaluado usando el puntaje de F1 .

El puntaje de F1 es el promedio arm�nico de la precisi�n y el recuerdo, donde un puntaje de F1 alcanza su mejor valor en 1 (precisi�n perfecta y recordatorio) y el peor en 0.

![F1 Score](https://upload.wikimedia.org/wikipedia/commons/2/26/Precisionrecall.svg)

![f1](./formulas/f1.svg)

D�nde:

![precision](./formulas/precision.svg)

![recall](./formulas/recall.svg)

_tp_ - n�mero de verdaderos positivos.

_fp_ - n�mero de falsos positivos.

_fn_ - n�mero de falsos negativos.

## Archivos

- [demo.m](./demo.m) -  archivo principal que debe ejecutar desde la consola de Octave/MatLab para ver la demostraci�n desde la consola.
- [server_params.mat](./server_params.mat) - conjunto de datos de entrenamiento.
- [estimate_gaussian.m](./estimate_gaussian.m) - esta funci�n estima los par�metros de una distribuci�n gaussiana usando los datos en X.
- [multivariate_gaussian.m](./multivariate_gaussian.m) - funci�n que calcula la funci�n de densidad de probabilidad de la distribuci�n gaussiana multivariada.
- [select_threshold.m](./select_threshold.m) - funci�n que encuentra el mejor umbral (�psilon) que se usar� para seleccionar valores at�picos.
- [visualize_fit.m](./visualize_fit.m) - Funci�n que visualiza el conjunto de datos y su distribuci�n estimada.
- [anomalydetection.m](./anomalydetection.m) - archivo principal que debe ejecutar desde Octave/MatLab para usar el algoritmo desde el entorno grafico.
- [anomalydetection.fig](./anomalydetection.fig) - archivo que almacena los gr�ficos, que se utilizan para visualizar los datos.
- [printAD.fig](./printAD.fig) - archivo que contiene el formato de los resultados que imprime en los archivos .doc y .pdf.

### Visualizaciones de los resultados

![Demo visualization](./formulas/demo.png)

## Referencias

- [Machine Learning en Coursera](https://www.coursera.org/learn/machine-learning)
- [Distribuci�n normal en Wikipedia](https://es.wikipedia.org/wiki/Distribuci�n_normal)
- [Valor F1 en Wikipedia](https://es.wikipedia.org/wiki/Valor-F)
  