# Red neuronal

**Las redes neuronales artificiales** (ANN) o los sistemas conexionistas son sistemas inform�ticos vagamente inspirados en las redes neuronales biol�gicas que constituyen los cerebros de los animales. La red neuronal en s� no es un algoritmo, sino un marco para que muchos algoritmos de aprendizaje autom�tico trabajen juntos y procesen entradas de datos complejos. Tales sistemas "aprenden" a realizar tareas considerando ejemplos, generalmente sin ser programados con ninguna regla espec�fica de tareas.


![Neuron](https://upload.wikimedia.org/wikipedia/commons/1/10/Blausen_0657_MultipolarNeuron.png)

Por ejemplo, en el **reconocimiento de im�genes**, pueden aprender a identificar im�genes que contienen gatos analizando im�genes de ejemplo que se han etiquetado manualmente como "gato" o "no gato" y usar los resultados para identificar gatos en otras im�genes. Lo hacen sin ning�n conocimiento previo sobre los gatos, por ejemplo, que tienen pelaje, colas, bigotes y caras de gato. En su lugar, generan autom�ticamente caracter�sticas de identificaci�n a partir del material de aprendizaje que procesan.

Una ANN se basa en una colecci�n de unidades conectadas o nodos llamados **neuronas artificiales**, que modelan libremente las neuronas en un cerebro biol�gico. Cada conexi�n, como las sinapsis en un cerebro biol�gico, puede transmitir una se�al de una neurona artificial a otra. Una neurona artificial que recibe una se�al puede procesarla y luego se�alar neuronas artificiales adicionales conectadas a ella.

![Artificial Neuron](https://insights.sei.cmu.edu/sei_blog/sestilli_deeplearning_artificialneuron3.png)

En implementaciones de ANN comunes, la se�al en una conexi�n entre neuronas artificiales es un n�mero real, y la salida de cada neurona artificial se calcula mediante alguna funci�n no lineal de la suma de sus entradas. Las conexiones entre las neuronas artificiales se llaman **aristas**. Las neuronas y los bordes artificiales suelen tener un **peso** que se ajusta a medida que avanza el aprendizaje. El peso aumenta o disminuye la intensidad de la se�al en una conexi�n. Las neuronas artificiales pueden tener un umbral tal que la se�al solo se env�a si la se�al agregada cruza ese umbral. T�picamente, las neuronas artificiales se agregan en capas. Diferentes capas pueden realizar diferentes tipos de transformaciones en sus entradas. Las se�ales viajan desde la primera capa (**la capa de entrada**), a la �ltima capa (**la capa de salida**), posiblemente despu�s de atravesar las **capas internas** varias veces.

![Neural Network](https://upload.wikimedia.org/wikipedia/commons/4/46/Colored_neural_network.svg)

## Modelo Neuron (Unidad Log�stica)

Aqu� hay un modelo de una unidad de neurona.

![neuron](./formulas/neuron.drawio.svg)

![x-0](./formulas/x-0.svg)

![neuron x](./formulas/neuron-x.svg)

Pesos:

![neuron weights](./formulas/neuron-weights.svg)

## Modelo de red (Conjunto de neuronas)

La red neuronal consiste en las unidades neuronales descritas en la secci�n anterior.

Echemos un vistazo al modelo de ejemplo simple con una capa oculta.

![network model](./formulas/neuron-network.drawio.svg)

![a-i-j](./formulas/a-i-j.svg) - "activaci�n" de la unidad _i_ en la capa _j_.

![Theta-j](./formulas/big-theta-j.svg) - matriz de pesos que controla la funci�n de mapeo de la capa _j_ a la capa _j + 1_. Por ejemplo para la primera capa: ![Theta-1](./formulas/big-theta-1.svg).

![Theta-j](./formulas/L.svg) - N�mero total de capas en la red (3 en nuestro ejemplo).

![s-l](./formulas/s-l.svg) - N�mero de unidades (sin contar la unidad de polarizaci�n) en la capa _l_.

![K](./formulas/K.svg) - n�mero de unidades de salida (1 en nuestro ejemplo, pero podr�a ser cualquier n�mero real para la clasificaci�n de varias clases).

## Clasificaci�n Multi-clase

Con el fin de hacer que la red neuronal funcione con notificaciones de m�ltiples clases, podemos utilizar el enfoque de **uno contra todos**.

Let's say we want our network to distinguish if there is a _pedestrian_ or _car_ of _motorcycle_ or _truck_ is on the image.

Digamos que queremos que nuestra red distinga si hay un _peat�n_ o un _autom�vil_ de _motocicleta_ o _cami�n_ en la imagen.

En este caso, la capa de salida de nuestra red tendr� 4 unidades (la capa de entrada ser� mucho m�s grande y tendr� todos los p�xeles de la imagen. Digamos que si todas nuestras im�genes ser�n 20x20 p�xeles, entonces la capa de entrada tendr� 400 unidades cada una de los cuales contendr� el color blanco y negro de la imagen correspondiente).

![multi-class-network](./formulas/multi-class-network.drawio.svg)

![h-Theta-multi-class](./formulas/multi-class-h.svg)

En este caso, esperar�amos que nuestra hip�tesis final tuviera los siguientes valores:

![h-pedestrian](./formulas/h-pedestrian.svg)

![h-car](./formulas/h-car.svg)

![h-motorcycle](./formulas/h-motorcycle.svg)

En este caso para el conjunto de entrenamiento:

![training-set](./formulas/training-set.svg)

Tendr�amos:

![y-i-multi](./formulas/y-i-multi.svg)

## Propagaci�n hacia adelante (o avance)

La propagaci�n hacia adelante es un proceso interactivo de c�lculo de activaciones para cada capa que comienza en la capa de entrada y va a la capa de salida.

Para la red simple mencionada en una secci�n anterior de arriba, podemos calcular las activaciones para la segunda capa seg�n la capa de entrada y nuestros par�metros de red:

![a-1-2](./formulas/a-1-2.svg)

![a-2-2](./formulas/a-2-2.svg)

![a-3-2](./formulas/a-3-2.svg)

La activaci�n de la capa de salida se calcular� en funci�n de las activaciones de la capa oculta:

![h-Theta-example](./formulas/h-Theta-example.svg)

Donde la funci�n _g()_ puede ser un sigmoide:

![sigmoid](./formulas/sigmoid.svg)

![Sigmoid](https://upload.wikimedia.org/wikipedia/commons/8/88/Logistic-curve.svg)

### Implementaci�n vectorizada de propagaci�n hacia adelante

Ahora vamos a convertir los c�lculos anteriores en una forma vectorizada m�s concisa.

![neuron x](./formulas/neuron-x.svg)

Para simplificar las ecuaciones de activaci�n anteriores, introduzcamos una variable _z_:

![z-1](./formulas/z-1.svg)

![z-2](./formulas/z-2.svg)

![z-3](./formulas/z-3.svg)

![z-matrix](./formulas/z-matrix.svg)

> No olvide agregar unidades de polarizaci�n (activaciones) antes de propagar a la siguiente capa. 
> ![a-bias](./formulas/a-bias.svg)

![z-3-vectorize](./formulas/z-3-vectorized.svg)

![h-Theta-vectorized](./formulas/h-Theta-vectorized.svg)

### Ejemplo de propagaci�n hacia adelante

Tomemos como ejemplo la siguiente arquitectura de red con 4 capas (capa de entrada, 2 capas ocultas y capa de salida):

![multi-class-network](./formulas/multi-class-network.drawio.svg)

En este caso, los pasos de propagaci�n hacia adelante se ver�an como los siguientes:

![forward-propagation-example](./formulas/forward-propagation-example.svg)

## Funci�n de costo

La funci�n de costo para la red neuronal es bastante similar a la funci�n de costo de regresi�n log�stica.

![cost-function](./formulas/cost-function.svg)

![h-Theta](./formulas/h-Theta.svg)

![h-Theta-i](./formulas/h-Theta-i.svg)

## Propagaci�n Hacia Atr�s

### Computaci�n gradiente

El algoritmo de propagaci�n hacia atr�s tiene el mismo prop�sito que el descenso de gradiente para regresi�n lineal o log�stica: corrige los valores de thetas para minimizar una funci�n de costo.

En otras palabras, necesitamos poder calcular la derivada parcial de la funci�n de costo para cada theta.

![J-partial](./formulas/J-partial.svg)

![multi-class-network](./formulas/multi-class-network.drawio.svg)

Supongamos que:

![delta-j-l](./formulas/delta-j-l.svg) - "error" del nodo _j_ en la capa _l_.

Para cada unidad de salida (capa _L = 4_):

![delta-4](./formulas/delta-4.svg)

O en forma vectorizada:

![delta-4-vectorized](./formulas/delta-4-vectorized.svg)

![delta-3-2](./formulas/delta-3-2.svg)

![sigmoid-gradient](./formulas/sigmoid-gradient.svg) - gradiente sigmoideo.

![sigmoid-gradient-2](./formulas/sigmoid-gradient-2.svg)

Ahora podemos calcular el paso del gradiente:

![J-partial-detailed](./formulas/J-partial-detailed.svg)

### Algoritmo de contrapropagaci�n

Para conjunto de entrenamiento

![training-set](./formulas/training-set.svg)

Necesitamos establecer:

![Delta](./formulas/Delta.svg)

![backpropagation](./formulas/backpropagation.svg)

## Inicializaci�n Aleatoria

Antes de comenzar la propagaci�n hacia adelante, necesitamos inicializar los par�metros de Theta. No podemos asignar cero a todos los thetas, ya que esto har�a que nuestra red fuera in�til porque cada neurona de la capa aprender� lo mismo que sus hermanos. En otras palabras, tenemos que **romper la simetr�a**. Para hacerlo necesitamos inicializar thetas a algunos valores iniciales aleatorios peque�os:

![theta-init](./formulas/theta-init.svg)

## Archivos

- [demo.m](./demo.m) - archivo de demostraci�n que debe ejecutar para iniciar el entrenamiento de redes neuronales y para ver c�mo la red reconocer� los d�gitos escritos a mano en consola. 
- [neural_network_train.m](./neural_network_train.m) - funci�n que inicializa la red neuronal y comienza su entrenamiento.
- [neural_network_predict.m](./neural_network_predict.m) - realiza la predicci�n de los datos de entrada utilizando par�metros de red capacitados.
- [debug_initialize_weights.m](./debug_initialize_weights.m) - funci�n que inicializa las redes de red no aleatoriamente para fines de depuraci�n.
- [debug_nn_gradients.m](./debug_nn_gradients.m) - funci�n que ayuda a depurar gradientes de propagaci�n hacia atr�s compar�ndolos con gradientes calculados num�ricamente.
- [debug_numerical_gradient.m](./debug_numerical_gradient.m) - calcula el gradiente num�ricamente (usando el paso epsilon peque�o en cierto punto).
- [digits.mat](./digits.mat) - conjunto de entrenamiento de d�gitos etiquetados a mano.
- [display_data.m](./display_data.m) - funci�n auxiliar que procesa d�gitos seleccionados al azar del conjunto de entrenamiento.
- [fmincg.m](./fmincg.m) - funci�n que realiza pendiente de gradiente (alternativa a `fminunc()`).
- [nn_backpropagation.m](./nn_backpropagation.m) - funci�n que realiza la propagaci�n hacia atr�s para la red neuronal.
- [nn_cost_function.m](./nn_cost_function.m) - funci�n que calcula el costo de la red neuronal para par�metros espec�ficos del modelo.
- [nn_feedforward_propagation.m](./nn_feedforward_propagation.m) - funci�n que realiza la propagaci�n de pasos hacia atras para la red neuronal.
- [nn_gradient_step.m](./nn_gradient_step.m) - funci�n que realiza un paso de gradiente.
- [nn_params_init.m](./nn_params_init.m) - inicializa aleatoriamente los par�metros de la red neuronal para frenar la simetr�a.
- [nn_params_roll.m](./nn_params_roll.m) - funci�n que transforma el vector plano de thetas en matrices de thetas para cada capa NN.
- [sigmoid_gradient.m](./sigmoid_gradient.m) - calcula el gradiente de la funci�n sigmoide.
- [sigmoid.m](./sigmoid.m) - funci�n sigmoidea.
- [unroll.m](./unroll.m) - transforma matrices de theta para cada capa en un vector plano.
- [RedNeuronal.m](./RedNeuronal.m) - archivo principal que debe ejecutar desde Octave/MatLab para usar el algoritmo desde el entorno grafico.
- [RedNeuronal.fig](./RedNeuronal.fig) - archivo que almacena los gr�ficos, que se utilizan para visualizar los datos.


### Visualizaciones de demostraci�n

![Demo visualization](./formulas/demo.png)

## Referencias

- [Machine Learning en Coursera](https://www.coursera.org/learn/machine-learning)
- [Pero, �qu� es una red neuronal? Por 3Blue1Brown (Ingles, subtitulos espa�ol)](https://www.youtube.com/watch?v=aircAruvnKk)
- [Red neuronal en Wikipedia](https://es.wikipedia.org/wiki/Red_neuronal_artificial)
- [TensorFlow Neural Network Playground](https://playground.tensorflow.org/)
- [Aprendizaje profundo por la Universidad Carnegie Mellon (Ingles)](https://insights.sei.cmu.edu/sei_blog/2018/02/deep-learning-going-deeper-toward-meaningful-patterns-in-complex-data.html)
