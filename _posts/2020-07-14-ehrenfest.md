---
layout: post
title:  "Cadena de Ehrenfest"
date:   2020-07-14 12:00:00 -0500
categories: probabilidad
---

La cadena de Eherenfest es uno de los ejemplos básicos de cadenas de Markov. Supongamos que tenemos $N$ moléculas distribuidas en dos contenedores, $A$ y $B$, y que realizaremos experimentos sucesivos sobre las partículas.

En cada experimento se escoge una partícula al azar y se cambia de contenedor. El valor de la cadena en un tiempo es el número de partículas en el contenedor $A$. Si en un momento dado la cadena está en el estado $k$, entonces el sistema pasará al estado $k+1$ con probabilidad $k/N$ al estado $k-1$ y con probabilidad $1 - k/N$ al estado $k+1$, dependiendo de si es escoge una partícula del contenedor $A$ o del contenedor $B$.

En la siguiente animación se presenta una instancia de esta cadena comenzando con una partícula, es decir $N = 1$. Para agregar partículas, hay que hacer clic sobre la animación. La partícula roja es la que cambia de contenedor.

<canvas data-src="/sketches/ehren/ehrenfest.pde"></canvas>
