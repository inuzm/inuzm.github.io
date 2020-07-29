---
layout: post
title:  "Variables aleatorias geométricas"
date:   2020-07-10 13:00:00 -0500
categories: probabilidad
---

Supongamos que $\\{ X_n \\}_{n \geq 1}$ es una sucesión de variables aleatorias independientes e idénticamente distribuidas tales que $X_1 \sim \mathrm{Ber}(p)$ con $p \in (0,1)$. Si definimos $T = \min \\{ n \geq 1 : X_n = 1 \\}$, entonces $T \sim \mathrm{Geo}(p)$. Es decir que para cada $n \geq 1$ entero,

$$ \mathbb{P}(T = n) = (1-p)^{n-1} p. $$

Intuitivamente podemos pensar en que la variable aleatoria $T$ cuenta el número de experimentos que se deben realizar para obtener un éxito. En la siguiente animación se ilustra esta idea, donde los círculos rojos representan experimentos fallidos, es decir $X_i = 0$, y el círculo verde representa el éxito, dado por $X_i = 1$.
- Si se ve desde la computadora: Para modificar el valor de $p$, con valores en $\\{ 0.1, 0.2, \ldots, 0.9 \\}$, hay que hacer clic sobre la animación. Asimismo para realizar una nueva simulación hay que apretar la tecla Enter.
- Si se ve desde el celular: apretar la imagen cambia el valor de $p$ y hace la simulación pertinente.

<canvas data-src="/sketches/geometric/geometric.pde"></canvas>

Conservando la idea de contar el número de experimentos a realizar hasta obtener un éxito, nos podemos preguntar ¿cuántos experimentos es necesario realizar para obtener $r$ éxitos? Formalmente, si $\\{ X_n \\}\_{n \geq 1}$ es una sucesión de variables aleatorias independientes e idénticamente distribuidas con $X_1 \sim \mathrm{Ber}(p)$ y $p \in (0,1)$, entonces queremos $T^r$, el menor entero positivo para el cual $\sum_{n = 1}^{T^r} X_n = r$, es decir

$$
T^r = \min \left\{ n \geq 1 : \sum_{i = 1}^n X_i = r \right\}.
$$

Observemos que para $n \geq r$, $T^r = n$ si y sólo si hubo $r-1$ éxitos en los primeros $n-1$ experimentos y el $n$-ésimo experimento es un éxito, de donde se sigue que

$$
\mathbb{P}(T^r = n) = \binom{n-1}{r-1} (1-p)^{(n-1)-(r-1)} p^{r-1} \times p = \binom{n-1}{r-1} (1-p)^{n-r} p^r.
$$

Se dice que la variable aleatoria $T^r$ tiene distribución binomial negativa con parámetros $r$ y $p$ y se denota por $T^r \sim \mathrm{BinNeg}(r, p)$. En la siguiente animación se pueden ver simulaciones de variables aleatorias con distribución $\mathrm{BinNeg}(r, 0.5)$ comenzando con $r = 1$, para modificar el valor de $r$ basta hacer clic sobre la animación.

<canvas data-src="/sketches/binneg2/binneg2.pde"></canvas>

Observemos que para el caso particular $r = 1$, $T^r \sim \mathrm{Geo}(p)$, por lo que podemos decir que la distribución binomial negativa generaliza a la distribución geométrica. Por otra parte, para $n_1, n_2, \ldots, n_k \geq 1$ enteros es fácil ver que

$$
\mathbb{P}(T^1 = n_1, T^2 - T^1 = n_2, \ldots,  T^k - T^{k-1} = n_k) = \prod_{i = 1}^{k} \big( (1-p)^{n_i - 1} p \big).
$$

Procederemos por inducción para ver que la expresión (4) es, en efecto, verdadera. El caso $k = 1$ es trivial. Así pues, supongamos que la expresión (4) es válida para alguna $k \geq 1$ y notemos que el conjunto $A = \\{T^1 = n_1, T^2-T^2 = n_2, \ldots, T^k-T^{k-1} = n_k\\}$ queda determinado por $\\{X_1, \ldots, X_{n_1+\cdots+n_k}\\}$. Asimismo, en el conjunto $A$, $T^{k+1} - T^k$ depende de $\\{Y_i\\}\_{i \geq 1}$, donde $Y_i = X_{n_1+\cdots+n_k+i}$. Por lo tanto,

$$
\begin{array}{rl}
\mathbb{P}(T^{k+1}-T^k = n_{k+1}, A) & = \mathbb{P}(T^{k+1}-T^k = n_{k+1} \,\vert\, A) \,\mathbb{P}(A) \\
& = \mathbb{P}( Y_1 = 0, \ldots, Y_{n_{k+1}-1} = 0, Y_{n_{k+1}} = 1 \,\vert\, A) \,\mathbb{P}(A) \\
& = \mathbb{P}( Y_1 = 0, \ldots, Y_{n_{k+1}-1} = 0, Y_{n_{k+1}} = 1) \, \mathbb{P}(A) \\
& = \mathbb{P}( Y_1 = 0, \ldots, Y_{n_{k+1}-1} = 0, Y_{n_{k+1}} = 1) \times \prod_{i = 1}^{k} \big( (1-p)^{n_i - 1} p \big) \\
& = (1-p)^{n_{k+1}-1} p \times \prod_{i = 1}^{k} \big( (1-p)^{n_i - 1} p \big) \\
& = \prod_{i = 1}^{k+1} \big( (1-p)^{n_i - 1} p \big),
\end{array} \nonumber
$$

donde la tercera igualdad se da por la independencia de $\\{ X_n \\}\_{n \geq 1}$, la cuarta por hipótesis de inducción y la quinta nuevamente por las propiedades de $\\{ X_n \\}\_{n \geq 1}$. Esto demuestra que la expresión (4) es válida para toda $k \geq 1$, lo que en particular implica que $\\{T^k - T^{k-1}\\}\_{k \geq 1}$, donde $T^0 = 0$, es una sucesión de variables aleatorias independientes e idénticamente distribuidas $\mathrm{Geo}(p)$. Más aún, nos da una nueva manera de definir a las variables $\\{T^r\\}_{r \geq 1}$, mediante la recursión

$$
T^r = \min \{n > T^{r-1} : X_n = 1\}.
$$

Otra consecuencia de la expresión (4) es que $T^r \sim \mathrm{BinNeg}(r,p)$ se puede descomponer como la suma de $r$ variables aleatorias $\mathrm{Geo}(p)$ independientes. Efectivamente, es claro que

$$
T^r = \sum_{i = 1}^r (T^i - T^{i-1}).
$$

Esto último se aprovecha en la siguiente animación, en la que se visualiza la variable aleatoria $T^r \sim \mathrm{BinNeg}(r,0.5)$ de la siguiente manera: aparecerán $T^r$ círculos, $r$ verdes (los éxitos) y $T^r-r$ rojos (los fracasos) en $r$ renglones, representando la cantidad de experimentos realizados para que suceda cada uno de los $r$ éxitos. El parámetro inicial es $r = 1$ que se puede modificar al hacer clic sobre la animación.

<canvas data-src="/sketches/binneg/binneg.pde"></canvas>
