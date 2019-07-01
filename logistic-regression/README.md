# Regresi�n log�stica

**La regresi�n log�stica** es el an�lisis de regresi�n apropiado para realizar cuando la variable dependiente es dicot�mica (binaria). Como todos los an�lisis de regresi�n, la regresi�n log�stica es un an�lisis predictivo. La regresi�n log�stica se utiliza para describir datos y para explicar la relaci�n entre una variable binaria dependiente y una o m�s variables independientes nominales, ordinales, de intervalo o de relaci�n.

La regresi�n log�stica se utiliza cuando la variable dependiente (objetivo) es categ�rica.

Por ejemplo:

- Para predecir si un correo electr�nico es spam (1) o (0).
- Si la transacci�n en l�nea es fraudulenta (1) o no (0).
- Si el tumor es maligno (1) o no (0).

En otras palabras, la variable dependiente (salida) para el modelo de regresi�n log�stica se puede describir como:

![Logistic Regression Output](./formulas/output.svg)

![Logistic Regression](https://cdn-images-1.medium.com/max/1600/1*4G0gsu92rPhN-co9pv1P5A@2x.png)

![Logistic Regression](https://cdn-images-1.medium.com/max/1200/1*KRhpHnucyX9Y5PMdjGvVFA.png)

## Conjunto de entrenamiento

El conjunto de capacitaci�n es un dato de entrada donde para cada conjunto predefinido de caracter�sticas _x_ tenemos una clasificaci�n correcta _y_.

![Training Set](./formulas/training-set-1.svg)

_m_ - n�mero de ejemplos de conjuntos de entrenamiento.

![Training Set](./formulas/training-set-2.svg)

Para mayor comodidad de la notaci�n, defina:

![x-zero](./formulas/x-0.svg)

![Logistic Regression Output](./formulas/output.svg)

## Hip�tesis (El Modelo)

La ecuaci�n que obtiene caracter�sticas y par�metros como una entrada y predice el valor como una salida (es decir, predice si el correo electr�nico es spam o no seg�n algunas caracter�sticas del correo electr�nico).

![Hypothesis](./formulas/hypothesis-1.svg)

Donde _g()_ es una **funci�n sigmoide**.

![Sigmoid](./formulas/sigmoid.svg)

![Sigmoid](https://upload.wikimedia.org/wikipedia/commons/8/88/Logistic-curve.svg)

Ahora nosotros escribimos la hip�tesis de la siguiente manera:

![Hypothesis](./formulas/hypothesis-2.svg)

![Predict 0](./formulas/predict-0.svg)

![Predict 1](./formulas/predict-1.svg)

## Funci�n de costo

Funci�n que muestra la precisi�n de las predicciones de la hip�tesis con el conjunto actual de par�metros.

![Cost Function](./formulas/cost-function-1.svg)

![Cost Function](./formulas/cost-function-4.svg)

![Cost Function](./formulas/cost-function-2.svg)

La funci�n de costo se puede simplificar a la siguiente l�nea:

![Cost Function](./formulas/cost-function-3.svg)

## Lote Gradiente Descenso

El descenso de gradiente es un algoritmo de optimizaci�n iterativo para encontrar el m�nimo de una funci�n de costo descrita anteriormente. Para encontrar el m�nimo local de una funci�n que utiliza el descenso de gradiente, uno toma pasos proporcionales al negativo del gradiente (o gradiente aproximado) de la funci�n en el punto actual.

La imagen de abajo ilustra los pasos que tomamos al bajar la colina para encontrar el m�nimo local.

![Gradient Descent](https://cdn-images-1.medium.com/max/1600/1*f9a162GhpMbiTVTAua_lLQ.png)

La direcci�n del paso se define por la derivada de la funci�n de costo en el punto actual.

![Gradient Descent](https://cdn-images-1.medium.com/max/1600/0*rBQI7uBhBKE8KT-X.png)

Una vez que decidimos qu� direcci�n debemos seguir, debemos decidir cu�l es el tama�o del paso que debemos tomar.

![Gradient Descent](https://cdn-images-1.medium.com/max/1600/0*QwE8M4MupSdqA3M4.png)

Necesitamos actualizar simult�neamente ![Theta](./formulas/theta-j.svg) para _j = 0, 1, ..., n_

![Gradient Descent](./formulas/gradient-descent-1.svg)

![Gradient Descent](./formulas/gradient-descent-2.svg)

![alpha](./formulas/alpha.svg) - la velocidad de aprendizaje, la constante que define el tama�o del paso de descenso del degradado

![x-i-j](./formulas/x-i-j.svg) - _j<sup>�simo</sup>_ valor de la caracter�stica del _i<sup>�simo</sup>_ ejemplo de entrenamiento

![x-i](./formulas/x-i.svg) - entrada (caracter�sticas) de _i<sup>�simo</sup>_ ejemplo de entrenamiento

_y<sup>i</sup>_ - salida del _i<sup>�simo</sup>_ ejemplo de entrenamiento

_m_ - n�mero de ejemplos de entrenamiento

_n_ - n�mero de caracter�sticas

> Cuando usamos el t�rmino "lote" para el descenso de gradiente, significa que cada paso del descenso de gradiente usa **todos** los ejemplos de entrenamiento (como se puede ver en la f�rmula anterior).

## Clasificaci�n Multi-clase (Uno-contra-Todos)

Muy a menudo tenemos que hacer no solo la clasificaci�n binaria (0/1), sino m�s bien las clases m�ltiples, como:

- Clima: Soleado, Nublado, Lluvia, Nieve.
- Etiquetado de correo electr�nico: Trabajo, Amigos, Familia

Para manejar este tipo de problemas, podemos entrenar un clasificador de regresi�n log�stica ![Multi-class classifier](./formulas/multi-class-classifier.svg) varias veces para cada clase _i_ para predecir la probabilidad de que _y = i_.

![One-vs-All](https://i.stack.imgur.com/zKpJy.jpg)

## Regularizaci�n

### Problema de sobreajuste

Si tenemos demasiadas caracter�sticas, la hip�tesis aprendida puede encajar muy bien con el conjunto de **entrenamiento**:

![overfitting](./formulas/overfitting-1.svg)

**Pero** puede fallar en generalizar a **nuevos** ejemplos (digamos, predecir los precios en un nuevo ejemplo de detecci�n si los nuevos mensajes son spam).

![overfitting](https://cdncontribute.geeksforgeeks.org/wp-content/uploads/fittings.jpg)

### Soluci�n a sobreajuste

Aqu� hay un par de opciones que pueden abordarse:

- Reducir el n�mero de caracter�sticas
    - Seleccionar manualmente qu� caracter�sticas mantener
    - Algoritmo de selecci�n de modelo
- Regularizaci�n
    - Mantenga todas las caracter�sticas, pero reduzca la magnitud / valores de los par�metros del modelo (thetas).
    - Funciona bien cuando tenemos muchas caracter�sticas, cada una de las cuales contribuye un poco a la predicci�n de _y_.

La regularizaci�n funciona agregando un par�metro de regularizaci�n a la **funci�n de costo**:

![Cost Function](./formulas/cost-function-with-regularization.svg)

![regularization parameter](./formulas/lambda.svg) - par�metro de regularizaci�n

> Tenga en cuenta que no debe regularizar el par�metro ![theta zero](./formulas/theta-0.svg).

En este caso, la f�rmula de **descenso de gradiente** tendr� el siguiente aspecto:

![Gradient Descent](./formulas/gradient-descent-3.svg)

## Archivos

- [demo.m](./demo.m) - secuencia de comandos de regresi�n log�stica que carga datos de prueba y grafica predicciones de decisi�n en consola.
- [logistic_regression_train.m](./logistic_regression_train.m) - algoritmo de regresi�n log�stica.
- [hypothesis.m](./hypothesis.m) - funci�n de hip�tesis de regresi�n log�stica.
- [cost_function.m](./cost_function.m) - funci�n de costo de regresi�n log�stica.
- [gradient_descent.m](./gradient_descent.m) - funci�n que realiza el descenso de gradiente.
- [gradient_step.m](./gradient_step.m) - funci�n que realiza solo un paso de descenso de gradiente.
- [gradient_callback.m](./gradient_callback.m) - funci�n que agrega valores de funci�n de costo y paso de gradiente para `fminunc`.
- [microchips_tests.csv](./microchips_tests.csv) - conjunto de datos de entrenamiento de par�metros de microchip y su validez.
- [digits.mat](./digits.mat) - conjunto de entrenamiento de d�gitos etiquetados a mano.
- [add_polynomial_features.m](./add_polynomial_features.m) - funci�n que genera nuevas caracter�sticas polinomiales para el conjunto de entrenamiento para que los l�mites de decisi�n tengan una forma compleja.
- [one_vs_all.m](./one_vs_all.m) - entrena 10 modelos de regresi�n log�stica, cada uno de los cuales reconoce un n�mero espec�fico que comienza de 0 a 9.
- [one_vs_all_predict.m](./one_vs_all_predict.m) - predice qu� se escribe el d�gito seg�n el m�todo de regresi�n log�stica de uno contra todo.
- [fmincg.m](./fmincg.m) - funci�n que realiza una pendiente de gradiente como una alternativa a `fminunc()`.
- [display_data.m](./display_data.m) - funci�n que muestra los d�gitos escritos a mano del conjunto de entrenamiento.
- [sigmoid.m](./sigmoid.m) - funci�n sigmoidea.
- [seleccionalgoritmo.m](./seleccionalgoritmo.m) - archivo principal que debe ejecutar desde Octave/MatLab para decidir que aplicaci�n del algoritmo desea utilizar desde el entorno grafico 
- [seleccionalgoritmo.fig](./seleccionalgoritmo.fig) - archivo que almacena los gr�ficos de configuraci�n de la ventana 
- [printLR1.m](./printLR1.m) - archivo que contiene el formato de los resultados que imprime en los archivos .doc y .pdf.
- [regresionlogistica.m](./regresionlogistica.m) - archivo principal que debe ejecutar desde Octave/MatLab para usar el algoritmo desde el entorno grafico.
- [regresionlogistica.fig](./regresionlogistica.fig) - archivo que almacena los gr�ficos, que se utilizan para visualizar los datos.
- [regresionlogistica2.m](./regresionlogistica.m) - archivo principal que debe ejecutar desde Octave/MatLab para usar el algoritmo desde el entorno grafico.
- [regresionlogistica2.fig](./regresionlogistica.fig) - archivo que almacena los gr�ficos, que se utilizan para visualizar los datos.



### Visualizaciones de demostraci�n

![Demo visualization](./formulas/demo.png)

## References

- [Machine Learning en Coursera](https://www.coursera.org/learn/machine-learning)
- [Funci�n sigmoide en Wikipedia](https://es.wikipedia.org/wiki/Funci�n_sigmoide)
- [Pendiente de descenso en Wikipedia (en ingles)](https://en.wikipedia.org/wiki/Gradient_descent)
- [Pendiente de descenso por Suryansh S. (en ingles)](https://hackernoon.com/gradient-descent-aynk-7cbe95a778da)
- [Uno contra Todos en Stackexchange (en ingles)](https://stats.stackexchange.com/questions/318520/many-binary-classifiers-vs-single-multiclass-classifier)
- [Regresi�n log�stica por Rohan Kapur (en ingles)](https://ayearofai.com/rohan-1-when-would-i-even-use-a-quadratic-equation-in-the-real-world-13f379edab3b)
- [Sobreajuste on GeeksForGeeks (en ingles)](https://www.geeksforgeeks.org/underfitting-and-overfitting-in-machine-learning/)
