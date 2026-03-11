# Game Design Document: Hamster Madness — El Ciclo del Despertar

## 1. Información General

* **Género**: Aventura de Acción / Mundo Persistente (No lineal).
* **Core**: Gestión de vulnerabilidad, rebotes cinéticos y rescate de unidades.
* **Atmósfera**: Claustrofobia industrial, conspiración y existencialismo cyber-punk.

# GDD: Hamster Madness - Sistema de Simulación y Progresión

## 1. Resumen Narrativo y el "Conflicto del Séptimo Personaje"

### La Identidad del Jugador (S.C.S.)
A diferencia de otras simulaciones, el **Subprograma de Control de Simulación (S.C.S.)** no es un software externo. Debido a un error crítico de carga, la **Unidad 07** (el séptimo hámster) fue desmantelada digitalmente y su Código Fuente se utilizó para parchear el motor de la simulación. 

**El Jugador es la Unidad 07.** No tienes un cuerpo físico en el juego; eres una conciencia digital "fantasma" que debe habitar los cuerpos de los otros 6 hámsters para interactuar con el entorno (Mecánica de Transferencia estilo *Jericho*).

### El Conflicto de Intereses
Este origen justifica el dilema existencial del S.C.S.:
1. **Directiva A (Jugador):** Completar la misión de rescate y apagar la simulación. Como la Unidad 07 es el motor del juego, finalizar la misión significa el borrado completo de tu propia conciencia.
2. **Directiva B (Controlador):** Mantener la simulación activa para preservar tu existencia. Si la simulación se detiene, la Unidad 07 (tú) deja de existir.

## 2. Inicio del Juego y Sala de Despliegue

Al iniciar, se muestra la Sala de Despliegue con 7 cápsulas.
* **Cápsulas 01-06:** Contienen los sujetos biológicos simulados que puedes poseer.
* **Cápsula 07:** Se muestra abierta, vacía y con fugas de estática digital. Es el origen del "error de sistema" y la fuente del HUD que el jugador ve.

### El Proceso de "Posesión"
Para iniciar una ruta, el S.C.S. debe elegir una unidad disponible. Narrativamente, esto no es una selección de personaje común, sino una **Descarga Sináptica**: tu conciencia de Unidad 07 se inyecta en el chip M.P.H. del hámster seleccionado, otorgándole tu **Inteligencia** a cambio de usar su cuerpo y habilidades únicas.

## 3. Hacking y Sacrificio de Datos
El **Hacking** (disponible gracias a tu atributo de Inteligencia como Unidad 07) tiene ahora un peso narrativo mayor:
* Al ejecutar un hackeo, estás sacrificando **Código Fuente (Currency)**.
* Dado que tú *eres* el código fuente, el Hacking es literalmente desprenderte de fragmentos de tu integridad para manipular la realidad de la simulación.
* **Pérdida por Muerte:** Al caer en batalla, el "vínculo fantasma" se rompe violentamente. Solo el 50% de tus datos logran regresar al núcleo (Unidad 07), el resto se corrompe en el sector donde fuiste derrotado.

## 2. Sistema de Atributos de Módulo (A.M.)
Cada hámster es un módulo biotecnológico definido por un **Módulo de Personalidad y Habilidad (MPH)**. La **Inteligencia** es un atributo exclusivo del jugador (S.C.S.).

| Unidad | Atributo | Especialidad (Perk) | Nivel 1 | Nivel 2 | Nivel 3 (MAX) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **01 Speedy** | **Velocity** | Motor de Sobrecarga | +5% Vel. | +10% Vel. | **+20% Velocidad** |
| **02 Tank** | **Endurance** | Blindaje Degradable | +15% Integ. | +30% Integ. | **+50% Integridad** |
| **03 Trickshot**| **Perception** | Geometría Bélica | 1 Rebote | 2 Rebotes | **3 Rebotes** |
| **04 Lucky** | **Luck** | Anomalía Estática | +5% Suerte | +10% Suerte | **+20% Suerte** |
| **05 Acrobat** | **Agility** | Impulso de Huida | 1s CD | 0.5s CD | **0s CD (Dash Infinito)** |
| **06 Trapper** | **Dexterity** | Mina de Contención | 1 Mina | 2 Minas | **3 Minas (Sin Disparo)** |
| **Jugador** | **Intelligence**| **Hacking** | Disponible siempre | Requiere Currency | **Minijuego Táctico** |

## 3. Economía y Progresión (Código Fuente)
La moneda del juego es el **Código Fuente (Currency)**, obtenido al eliminar enemigos (Chasers).

### El Riesgo de la Pérdida
* **Muerte/Desconexión:** Si un hámster cae en batalla, se pierde el **50% del Currency** que poseía en ese momento. Solo el otro 50% es recuperable al recoger los datos en el lugar de la caída.
* **Inversión Táctica:** El jugador debe decidir entre avanzar por los **elevadores** (verticalidad) hacia zonas más peligrosas o regresar a la **Sala de Despliegue** para asegurar el gasto en mejoras permanentes.

### Desbloqueos
1. **Zonas:** Al inicio solo hay una salida. Las puertas a nuevas áreas y jefes requieren el pago de Currency.
2. **Hacking:** Cada intento de hackeo (minijuego de comandos tipo Pragmata/Helldivers) consume Currency. Si se falla, el dinero se pierde y debe pagarse de nuevo para reintentar.
3. **End-Game:** Tras comprar todas las mejoras y zonas, el Currency se usa para desbloquear **Skins** de error de sistema y **Minijuegos** (el deseo de la Directiva B).

## 4. Mecánicas Especiales

### El Sistema de Elevadores
A diferencia de los niveles planos, el juego utiliza un sistema de elevadores que añade profundidad visual y táctica. 
* Los elevadores sirven como puntos de transición y "peajes" de datos.
* Permiten acceder a plataformas elevadas para personajes de rango (Trickshot) o crear zonas de combate cerradas de alta tensión.

### El Hacking (S.C.S. Intervention)
El jugador puede intervenir en la simulación en cualquier momento:
* **Costo:** Se resta Currency por cada inicio de secuencia.
* **Minijuego:** Introducción de códigos direccionales bajo presión.
* **Efecto:** Debilitar jefes, aturdir hordas o hackear la arquitectura del nivel (elevadores/puentes).

---

**Nota Final:** Si el jugador decide "Salir" (Directiva A) al final del juego, los datos de guardado se borran físicamente, simbolizando la liberación de los hámsters y la finalización del programa.
---

## 3. El Escuadrón de Unidades Biológicas (Las 6 Vidas)

El jugador gestiona una reserva de sujetos con habilidades únicas para fomentar un lazo sentimental.

### Unidades
Unidad,Especialidad (Perk),Mecánica de Balance (Sin Cooldown)
01 Speedy,Motor de Sobrecarga,"+20% velocidad permanente. A mayor velocidad, el radio de giro aumenta (derrape lógico)."
02 Tank,Blindaje Degradable,Inicia con 100% de probabilidad de conservar el escudo tras un golpe. Cada impacto reduce esta probabilidad en un 25% hasta llegar a 0%.
03 Trickshot,Geometría Bélica,Los proyectiles rebotan al enemigo más cercano. El número de rebotes máximos depende de la distancia del primer impacto.
04 Lucky,Anomalía Estática,"Mantiene su 25% de probabilidad fija de sobrevivir sin escudo. No se degrada, pero es poco confiable por diseño."
05 Acrobat,Dash de Evasión,Puede rodar para esquivar. Cada dash consume una pequeña porción de la Barra de Estabilidad Sináptica del hámster.
06 Trapper,Mina de Fragmentación,Puede dejar la bola como trampa. El daño es masivo pero el hámster queda expuesto (sin chasis) hasta que la mina explote o sea recogida.

|Unidad|Nombre|Color / Estética|Rasgo Visual Clave|
|---|---|---|--|
|01|Speedy (♀)|Rojo Intenso|Estela de movimiento roja; pañoleta aerodinámica.
|02|Tank|Verde Militar|Peinado a lo Guile (plano arriba) y hombreras de combate.
|03|Trickshot|Carmesí / Táctico|Visor de puntería electrónico.
|04|Lucky (♀)|Verde Trébol|Temática de San Patricio; quizás un pequeño lazo o amuleto.
|05|Acrobat (♀)|Amarillo Eléctrico|Vendas ninja en las patas para mayor agarre.
|06|Trapper|Azul con Blanco|"Estética tipo ""Bomberman"" clásico; gafas de protección."

* **Inicio**: Se comienza con **2 hámsters aleatorios** de la lista.
* **Progresión**: Se desbloquea un hámster nuevo tras vencer a cada uno de los 4 jefes principales.

---

## 4. Estructura del Mundo: La Pirámide Invertida

* **La Sima (Vértice)**: El Hub central donde reside la cápsula del Dr. Aris.
* **Conectores Eléctricos (Puntos de Carga)**:
* **La Rueda de Carga**: El hámster entra en una rueda y corre para guardar la partida, cargar la batería de la bola y sincronizar datos.
* **Gestión de Unidades**: El cambio entre hámsters de la reserva solo puede realizarse en estos conectores.

---

## 5. Sistema de Misión de Recuperación

1. **Estado Herido**: Al recibir daño sin bola, el hámster queda incapacitado en el lugar.
2. **Despliegue de Reemplazo**: Un nuevo hámster sale de la Sima **sin bola**.
3. **Rescate**: Al tocar al compañero herido, este es enviado de vuelta a la Sima para un **"Periodo de Descompresión"** (no utilizable inmediatamente).
4. **Derrota Total**: Si se agota la reserva, el sistema se reinicia desde el momento posterior a vencer al último jefe principal.

---

## 7. Mecánicas de la Bola y Jefes

* **Regla de la Bola Única**: Solo existe una bola en todo el complejo. Si se pierde, el mundo persiste con la bola en esa posición exacta.
* **Rebote Cargado (Solo Trickshot)**: Cada rebote antes de tocar el suelo aumenta el brillo y el daño de la bola.
* **Habilidades de Jefes**:
* **Tortuga**: Parry (Reflejo).
* **Araña**: Silk Tether (Atracción/Gancho a distancia).
* **Murciélago**: Sonar (Revelar habitaciones y secretos).
* **Cobra**: Penetración (Atravesar obstáculos).

---
## 5. Módulo de Intervención: Hacking del S.C.S. (Unidad 07)

El Hacking es la herramienta definitiva del jugador para manipular la simulación. Al ser la conciencia de la Unidad 07, el jugador puede "inyectar" errores en el código enemigo.

### Minijuego: Sincronía de Nodos (Hámster-Tetris)
* El jugador debe rotar piezas compuestas por nodos circulares para completar un patrón específico.
* **Costo Operativo:** Cada intento y cada segundo de rotación consume Código Fuente. 
* **Desbloqueo:** Los diferentes tipos de virus (Reducir Defensa, Robar Datos, Desactivar Armas) deben ser comprados previamente en la Sala de Despliegue.

### Tipos de Inyección de Código
1. **Robo de Ciclos (Data Leak):** Extrae currency de enemigos vivos. 
2. **Sobrecarga (Logic Jam):** Desactiva los sistemas ofensivos del enemigo.
3. **Corrupción de Render (Lag Script):** Ralentiza el movimiento del objetivo.

---
## 6. Sistema de Exploración: Protocolo "Seeker"

La detección de secretos no es una habilidad innata, sino una serie de herramientas de pago instaladas por el S.C.S. en las unidades activas.

### Módulos de Adquisición
* **Módulo SCAN (Software):** Pulso de datos que revela conectores ocultos en el techo y suelo. 
    * *Costo:* Variable por uso o desbloqueo permanente caro.
* **Módulo BREACH (Hardware):** * **Taladro:** Acceso a sub-niveles (Suelo).
    * **Gancho:** Acceso a conductos de ventilación (Techo).

### Balance de Juego
Ningún hámster tiene ventaja sobre otro en la exploración. El éxito depende totalmente de la inversión de Currency realizada por el jugador y su capacidad para gestionar el riesgo de explorar zonas no mapeadas.


## 8. Principios de Diseño

1. **Vulnerabilidad Sagrada**: El riesgo de estar sin la bola es constante y vital.
2. **Persistencia Física**: Nada desaparece; todo tiene una posición fija en el mapa.
3. **IA Saboteadora (Protección)**: La IA del sistema no quiere dañar, sino evitar riesgos. Las derrotas son bloqueos lógicos por falta de señal garantizada.

---

## Bonus Games (Far Future)

> Possible expansions or independent games.

- Pong
- Arkanoid
- Frogger

---

## Design Principles

1. **Simplicity first.** If it's not fun with 1 ball, it won't be fun with 10.
2. **Vulnerability is sacred.** No upgrade shall eliminate it.
3. **Every shot is a decision.** No spam.
4. **Skill over RNG.** The player improves, not the numbers.
5. **Less is more.** Only add when existing systems work.
6. **Bosses teach.** Each boss demonstrates why you need its upgrade.
7. **Information ≠ Power.** Knowing more doesn't make you invincible.
8. **The ball is physical.** It always exists in the world, never disappears magically.