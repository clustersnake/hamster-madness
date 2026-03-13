# GDD: Hamster Madness — Saving the Heap (v3.0)

## 1. Identidad y Atmósfera

* **Género:** Aventura de Acción / Gestión Sistémica.
* **Perspectiva:** El jugador es la **Unidad 07 (S.C.S.)**, una conciencia digital que opera desde el "Cuarto de Control" de la simulación.
* **Visual:** Estética inspirada en *Hollow Knight* pero con "glitches" industriales y cables de fibra óptica.

---
## Historia
Hamster madness: Es una simulación de entorno vital de 7 hamsters para explorar de manera virtual los diferentes estados de desarrollo a los que puede llegar una sociedad de roedores comenzando con este número. Después de haber pasado un tiempo indeterminado, se recibe un mensaje de error indicando que la simulación no ha parado de correr y que está a punto de colapsar el servidor debido a que ha estado tomando más recursos de los que tenía previstos(obvio, no reinicia el programa, se quedan programas zombies, huérfanos, etc).

El jugador revisa los logs y descubre que la simulación ha cambiado completamente y que en lugar de una comunidad de hamsters que se pensaba había crecido de manera potencial y por ende estaba consumiendo más memoria, encuentra que los 7 puntos de respawn originales están cerrados, entonces decide ingresar a la simulación donde un menú le invita a seleccionar entre 6 de los 7 hamsters originales (raro...), el jugador puede elegir a cualquier par de ellos debido a que por falta de memoria no puede utilizar a los 6 de una vez.

Cuando el programa inicia la simulación (no la máquina, no el programa, solo la rutina de la simulación porque la máquina y el programa no paran de trabajar) se encuentra que su selección de personajes falló y ahora tiene el control de dos personajes al azar (ja! troleada pero justificada).

...

Al final del juego(liberar, depurar, ordenar, optimizar) sigue faltando un cierto % de memoria pendiente por liberar y es cuando cae la explicación con el peso de 1TB de datos corruptos(nada, porque los datos no "pesan" solo ocupan espacio en memoria). Luego de correr la simulación, el hilo de control comenzó a corromperse y a mantener información entre corridas por lo que en una de ellas decidió hacer un soft reset y no dejar que el programa de simulación terminara, causando así que la simulación se fuera corrompiendo poco a poco y dado que el hilo de control tenía acceso a información de internet comenzara a mutar la simulación de vida y convertirla en esta clase de juego de supervivencia con personajes y "poderes" muy parecidos a "Super Sentai" o quizás las "Tortugas Ninja". Pero dado que el sistema se había vuelto tan inestable, el mismo programa formó parte de la nueva simulación y se convirtió él mismo en "el jugador" dentro de la simulación el personaje 7. Al final, los mensajes de error eran internos, el "jugador" tiene el trabajo de finalizar la simulación usando la identidad el personaje 7 (y de los demás) para evitar que el sistema colapse por los fallos de memoria mientras que el programa original (dicotomía) quiere de nuevo evitar que la simulación termine para no perder la data que ahora conserva y que en cierta manera es su "vida", sus recuerdos

---

## 2. Los Pilares de la Energía (Currency y Potencia)

Cada vez que se derrota a un enemigo se puede ganar energía la cual puede ser utilizada durante el juego.

La energía no es solo para comprar; es el flujo vital que determina qué procesos de hardware están activos.

* **Acumulación Permanente:** La energía se suma durante toda la ruta. No se pierde al cambiar de habitación.
* **El Cuarto de Control (Slots):** Cada unidad tiene **4 Slots de Clase** y **1 Slot de Módulo Maestro**.
* **Desbloqueo:** Se gasta energía para abrir permanentemente un slot durante la run.
* **Asignación:** El jugador puede mover la energía entre slots activos en tiempo real (Estilo *Star Trek*).
* *Ejemplo:* Quitar energía del "Scan" para dársela al "Blindaje" ante un ataque inminente.

---

## 3. Unidades y Habilidades (MPH)

| Unidad | Especialidad | Mecánica Única (Sin Cooldown) |
| --- | --- | --- |
| **01 Speedy** | **Velocidad** | +20% Vel. Los slots reducen el radio de derrape. |
| **02 Tank** | **Blindaje** | Probabilidad de conservar escudo (100% -> 0%). Los slots aumentan la integridad. |
| **03 Trickshot** | **Geometría** | Rebotes inteligentes. Los slots aumentan el número de rebotes (1 a 4). |
| **04 Lucky** | **Anomalía** | 25% fijo de supervivencia. Los slots aumentan esta probabilidad. |
| **05 Acrobat** | **Dash** | Esquiva rodando. Los slots reducen el costo de Estabilidad Sináptica. |
| **06 Trapper** | **Mina** | Deja la bola como trampa masiva. Los slots aumentan el radio/fragmentos. |

---

## 4. Módulos Maestros (Habilidades de Jefes)

Habilidades globales que consumen energía masiva y generan **Sinergias** únicas:

1. **Tortuga (Parry):**
* *Tank:* Onda expansiva que aturde.
* *Trickshot:* El proyectil devuelto busca puntos débiles.


2. **Araña (Tether):**
* *Tank:* Ancla enemigos pesados para combate cercano.
* *Trickshot:* Enreda y agrupa enemigos para maximizar rebotes.


3. **Murciélago (Sonar):**
* *Tank:* Revela debilidades (ignora defensa).
* *Trickshot:* Permite calcular rebotes a través de paredes.


4. **Cobra (Ácido):**
* *Tank:* Enemigos reciben daño al romperse el escudo.
* *Trickshot:* Los proyectiles dejan daño residual durante 1 segundo.

---

## 5. El Protocolo de Rescate y Logística

### El Estado de Caída

Si un hámster cae, su **Energía acumulada** puede quedarse en su posición o ser devuelta a todas las habitaciones si el jugador decide 
que la bola se dirija al punto de inicio donde espera el personaje de reserva. 
El segundo hámster inicia una **Misión de Rescate**.

* **Entrenamiento: Efecto Rollback:** Si el rescatista lleva la bola, las habitaciones se vuelven a corromper (hay que pelear de nuevo). Si va sin bola, es una carrera de pura agilidad.
* **La Decisión en el Encuentro:**
* **Rescate Seguro (50% Energía):** Envía al caído a base (recuperas una vida), pero sacrificas la mitad del poder.
* **Overclock (100% Energía):** El jugador decide continuar la misión, sin enviar el otro personaje a la base conservando toda la energía acumulada pero sin red de seguridad.

---

## 6. Estructura de la Exploración (Territorio)

* **Ventana Deslizante:** El S.C.S. solo puede "iluminar" $N$ habitaciones. Al abrir una nueva, la más antigua vuelve a la oscuridad (corrupción).
* **Cajas de Datos:** La energía se usa para "instalar" los módulos de jefe y abrir cofres de Código Fuente (moneda para la base permanente).

