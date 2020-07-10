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

Ahora sí, con base en el código anterior veamos cómo implementar funciones que hagan la labor de `txtProgressBar` pero con mensajitos motivacionales y un sonido que nos avise cuando acabe el ciclo. *Nota importante: las siguientes funciones no son robustos y es bien fácil romperlas.* Primero inicializaremos la barra de progreso.

{% highlight r %}
progreso <- function(
    min = 0, max = 1, initial = 0, char = "#", title = "Una barra de progreso",
    mensajes = c(
        "Vamos bien",
        "No existen los acentos",
        "Sigue jalando",
        "Saleivale sin problemas"
    )
){
    cat(sprintf('\n%s:\n', title))
    valor.actual <- initial
    max.mensaje <- max(nchar(mensajes))
    ancho.barra <- 80 - 9 - max.mensaje
    cat(
        sprintf(
            paste0('\r[%-', ancho.barra,'s] %3d%%. %', max.mensaje, 's'),
            paste(
                rep(char, ancho.barra * (valor.actual - min) / (max - min)),
                collapse = ''
            ),
            floor(100 * (valor.actual - min) / (max - min)),
            sample(mensajes, 1)
        )
    )
    return(
        list(
            min = min, max = max, mensajes = mensajes,
            valor.actual = valor.actual, max.mensaje = max.mensaje,
            ancho.barra = ancho.barra, char = char
        )
    )
}
{% endhighlight %}

La siguiente función actualiza la barra de progreso.

{% highlight r %}
actprogreso <- function(bpb, valor){
    bpb$valor.actual <- valor
    cat(
        sprintf(
            paste0(
                '\r[%-', bpb$ancho.barra,'s] %3d%%. %',
                bpb$max.mensaje, 's'
            ),
            paste(
                rep(
                    bpb$char,
                    bpb$ancho.barra *
                        (bpb$valor.actual - bpb$min)
                    / (bpb$max - bpb$min)
                ),
                collapse = ''
            ),
            floor(100 * (bpb$valor.actual - bpb$min) / (bpb$max - bpb$min)),
            sample(bpb$mensajes, 1)
        )
    )
    return(bpb)
}
{% endhighlight %}

La siguiente función sirve para señalizar que el ciclo terminó.

{% highlight r %}
fprogreso <- function(bpb, sound = 8, title = "Hemos triunfado"){
    rm(list = as.character(substitute(bpb)), pos = sys.frame(1))
    cat(sprintf("\n%s\n", title))
    beepr::beep(sound = sound)
}
{% endhighlight %}

Ahora hay que probar nuestras funciones. Para esto es el siguiente bloque de código.

{% highlight r %}
pruebaciclo <- function(n){
    bp1 <- progreso(max = n, char = "=")
    for(i in 1:n){
        bp1 <- actprogreso(bpb = bp1, valor = i)
        Sys.sleep(0.5)
    }
    fprogreso(bp1)
}
pruebaciclo(20)
{% endhighlight %}

Para cerrar con todo, les dejo una pequeña animación.

<canvas data-src="/sketches/prueba/prueba.pde"></canvas>
