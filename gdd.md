# GDD: Hamster Madness — Saving the Heap (v3.0)

## 1. Identidad y Atmósfera

* **Género:** Aventura de Acción / Gestión Sistémica.
* **Perspectiva:** El jugador es la **Unidad 07 (S.C.S.)**, una conciencia digital que opera desde el "Cuarto de Control" de la simulación.
* **Visual:** Estética inspirada en *Hollow Knight* pero con "glitches" industriales y cables de fibra óptica.

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

