---
layout: post
title:  "Variables aleatorias geométricas"
date:   2020-07-10 13:00:00 -0500
categories: probabilidad
---

Supongamos que $\\{ X_n \\}_{n \geq 1}$ es una sucesión de variables aleatorias independientes e idénticamente distribuidas tales que $X_1 \sim \mathrm{Ber}(p)$ con $p \in (0,1)$. Si definimos $X = \min \\{ n \geq 1 : X_n = 1 \\}$, entonces $X \sim \mathrm{Geo}(p)$. Es decir que para cada $n \geq 1$ entero,
$$ \mathbb{P}(X = n) = (1-p) p^{n-1}. $$

Intuitivamente podemos pensar en que la variable aleatoria $X$ cuenta el número de experimentos que se deben realizar para obtener un éxito. En la siguiente animación se ilustra esta idea, donde los círculos rojos representan experimentos fallidos y el círculo verde representa el éxito. Para modificar el valor de $p$, con valores en $\\{ 0.1, 0.2, \ldots, 0.9 \\}$, hay que hacer clic sobre la animación. Asimismo para realizar una nueva simulación hay que apretar la tecla Enter. Disfruten.

<canvas data-src="/sketches/geometric/geometric.pde"></canvas>
