# TFG - Propagación de errores en medidas indirectas: comparación de métodos analíticos y métodos numéricos
![Project Image](https://www.uv.es/recursos/fatwirepub/ccurl/968/356/Cap_FAC_FISICA_en.png)


## Descripción

Este repositorio de GitHub contiene todo el código de MATLAB creado y empleado para la realización del TFG, así como algunos de los resultados. 


### Índice
- [Cálculo de g con un péndulo](#cálculo-de-g-con-un-péndulo)
- [Área y volumen de un cilindro](#área-y-volumen-de-un-cilindro)
- [Órbita de un satélite](#órbita-de-un-satélite)
- [Atractor de Lorentz](#atractor-de-lorenz)
- [Autor](#autor)

---

## Cálculo de g con un péndulo
Como se detalla en el TFG, este primer caso se abordó de dos maneras: una fue de la manera ortodoxa de realizar la simulación de Montecarlo que se describe en la introducción del trabajo, es decir,
obteniendo un resultado de N^m dimensiones. Debido al coste computacional esto se implementó con un número bajo de puntos y empleando computación paralela en Matlab,
haciendo uso de la GPU de mi ordenador personal.\
<br/>
- El código de este caso es [pendulo_gpu.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/pendulo_gpu.m)

Y los resultados se pueden ver en esta [imagen](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/tiempo2.PNG) y el tiempo de computación fue:

![tiempo](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/tiempo.PNG) 

Por otra parte, se procedió en el resto del trabajo a emplear un método de Montecarlo modificado de manera que el resultado fuera de dimension NxM y los tiempos de computación
fueran razonables.

- El código que emplea este método para el caso del péndulo es [pendulo.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/pendulo.m) 


---

## Área y volumen de un cilindro

En este apartado se hace el proceso con 3 casos: r y h independientes, totalmente correlacionados y un caso intermedio. Aquí abajo se encuentra el código para cada uno de ellos.

#### ρ=0
[cilindro_rho_0.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/cilindro_rho_0.m) 
#### ρ=1
[cilindro_rho_1.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/cilindro_rho_1.m) 
#### ρ=0.5
[cilindro_rho_0_5.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/cilindro_rho_0_5.m) 


---

## Órbita de un satélite

Para este apartado hay 3 funciones:

- [eq_orbitas.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/eq_orbitas.m) es la función principal
- [Satelite.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/Satelite.m) contiene el sistema de ecuaciones diferencial a resolver
- [tierra.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/tierra.m) contiene datos numericos sobre la Tierra

---
## Atractor de Lorenz

En este apartado se realizó la resolución de la ecuación diferencial con condiciones de entrada puntuales (sin error) y con distribuciones de entrada (Montecarlo)
y los códigos de Matlab para cada una son los siguientes

- [lorenz.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/lorentz_distr.m) (sin errores)
- [lorentz_distr.m](https://github.com/jormifbe/TFG/blob/main/c%C3%B3digo/lorentz_distr.m) (Montecarlo)

---

## Autor

- Jorge Mifsut Benet [jormifbe@alumni.uv.es](mailto:jormifbe@alumni.uv.es)

[Back To The Top](#tfg---propagación-de-errores-en-medidas-indirectas-comparación-de-métodos-analíticos-y-métodos-numéricos)
