---
layout: post
title:  "Monitorear ciclos"
date:   2020-07-09 13:45:04 -0500
categories: rstats
---

Quién no ha corrido alguna vez un código en R que tiene un ciclo `for` que tarda mucho en correr y no se sabe el avance que se tiene. Qué horror, ¿no? Afortunadamente esto se puede resolver de forma sencilla. El siguiente código de `R` creará una función que corre un ciclo for, monitoreando el avance con una barra de progreso y mensajes motivacionales (vaya que son necesarios al programar).

{% highlight r %}
prueba <- function(n){
    mensajes <- c(
        "Vamos bien",
        "No existen los acentos",
        "Sigue jalando",
        "Saleivale sin problemas"
    )
    cat(sprintf('\nUna barra de progreso:\n'))
    for(i in 1:n){
        cat(
            sprintf(
                '\r[%-25s] %3d%%. %22s',
                paste(rep('=', 100*i/n/4), collapse = ''),
                floor(100*i/n),
                sample(mensajes, 1)
            )
        )
        Sys.sleep(1)
    }
    cat('\n')
}
prueba(10)
{% endhighlight %}

Queda pendiente implementarlo como una función tipo `txtProgressBar` y usar `beepr` para señalizar el fin de un ciclo. En lo que lo tengo, dejo una pequeña animación:

<canvas data-src="/sketches/prueba/prueba.pde"></canvas>
