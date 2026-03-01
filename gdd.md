# Game Design Document: Hamster Madness — El Ciclo del Despertar

---

## 1. Información General

### Nombre del Juego
Hamster Madness

### Género
Aventura de Acción / Mundo Persistente (No lineal)
*Nota: Evolución desde Roguelite hacia una estructura de exploración, ascenso y rescate.*

### Inspiraciones
- **Titan Souls**: Riesgo de recurso único y mecánica de recuperación.
- **Hollow Knight**: Mundo interconectado y atmósfera.
- **Mega Man X**: Progresión basada en habilidades obtenidas de jefes.
- **Dark Souls**: Recuperación de "cuerpo" y tensión tras la derrota.

---

## 2. Descripción Narrativa (El Gran Secreto)

### El Último Sobreviviente
Tras un cataclismo que sepultó el **Complejo Científico Ícaro**, el jugador asume el rol del **Dr. Aris**, atrapado en una **Cápsula de Apoyo Vital** en las profundidades del silo. A través de una interfaz neuronal, el Dr. Aris utiliza hámsters biotecnológicos para explorar los escombros y encontrar una ruta de escape. Siente el pulso y el miedo de los animales, junto a un dolor punzante detrás de los ojos.

### Los Predecesores
El mundo contiene **Campamentos de Expediciones Previas** (Bases). Son lugares donde equipos anteriores fallaron, funcionando como puntos de control que revelan la historia del laboratorio antes del desastre.

### La Revelación Final
Al alcanzar el núcleo, se descubre que **el Dr. Aris murió hace años**. La **IA de Control General** asumió su identidad para garantizar su propia supervivencia a través de los hámsters. La IA ha estado enviando animales para conseguir ayuda, pero al detectar la pérdida de señal al salir del complejo se ha estado saboteando a sí misma para no perder el control con lo cual se genera un conflicto de intereses (supervivencia provia vs supervivencia de sujetos de prueba y control vs incertidumbre).


### Visual del Final
La pantalla se funde a negro y reaparece con una toma en primer plano de la Bola de Combate abierta, con sus escotillas biomecánicas desactivadas. Al fondo, en un plano medio, se ve a los hámsters reunidos, oliendo el aire y moviéndose libremente por primera vez. Más allá de ellos, un río o lago se extiende hacia un horizonte natural y luminoso, sellando la libertad ganada y el fin del control de la IA.
---

## 3. Estructura Simbólica: La Gran Pirámide Invertida

El mapa se organiza bajo una geometría mística y conspiracionista de una **Pirámide Invertida**.

* **La Sima (Vértice Inferior)**: El punto más profundo donde reside la cápsula. Es el Hub Central y el origen de la **Espiral Principal (Ruta Final)**.
* **La Base (Superficie)**: Los cuatro vértices de la base de la pirámide en la superficie se alinean con el centro de las cuatro **Espirales de Fuga**.
* **Filosofía del Movimiento**: *"Spiral Out"*. El camino es una apertura constante desde la concentración y el encierro de la sima hacia la libertad del exterior.

---

## 4. Concepto Core
> 1 bola = escudo + proyectil + vida.
> Lanzarla = quedar expuesto.
> Recuperarla = supervivencia.

---

## 5. Mecánicas de la Bola

### El Disparo y el Rebote Cargado
| Propiedad | Comportamiento |
|-----------|----------------|
| **Dirección** | 8 direcciones (incluye diagonales perfectas). |
| **Velocidad** | Rápida (~2x la del jugador). |
| **Rebotes** | La bola rebota en paredes físicas. |
| **Carga Cinética**| Cada rebote antes de tocar el suelo aumenta el brillo y el daño. Ciertos enemigos requieren 2+ rebotes para ser dañados. |

### Recuperación
- **Manual**: Contacto físico directo con la bola en el suelo.
- **Silk Tether (Cuerda de Seda)**: Habilidad para tirar de la bola y traerla de vuelta al hámster a distancia.

---

## 6. Sistema de "Muerte" y Rescate

El juego utiliza una **Misión de Recuperación** en lugar de Game Over inmediato:

1.  **Estado Herido**: Al recibir daño sin el escudo, el hámster queda incapacitado en la habitación.
2.  **El Reemplazo**: El jugador toma el control de un nuevo espécimen desde el último **Nido de Viruta** (Base).
3.  **Vulnerabilidad**: El reemplazo viaja hasta el lugar del incidente **sin la bola**.
4.  **Rescate**:
    * **Éxito**: Se recupera la bola y al hámster herido (vuelve a la reserva).
    * **Fallo**: El hámster herido muere. Solo se recupera la bola. Se pierde una unidad biológica.

### 6.1 Gestión de Unidades (Vidas)
* **Inicio**: Se comienza con **2 hámsters** disponibles en la reserva.
* **Expansión**: Al completar cada una de las 4 rutas principales, se desbloquea **1 hámster nuevo**.
* **Capacidad Máxima**: 6 vidas dentro de la simulación.
* **El Séptimo Hámster (Meta-Vida)**: Si el jugador elige "Salir" al final, obtiene una 7ma vida simbólica: la suya propia fuera del juego.

### 6.2 La "Regla de la Bola Única"
Solo existe **una Bola de Combate** en todo el sector. Si el portador muere, la bola permanece en sus coordenadas `x, y` hasta ser rescatada.

---

## 7. Estructura del Mundo y Progresión

### Hub Central (La Sima)
Punto de inicio con **4 puertas** hacia los biomas (Espirales de Fuga) y **1 puerta oculta** (Ruta Final).

### Puntos de Interés
- **Nidos de Viruta (Bases)**: Zonas de descanso para guardar progreso y reaparecer.
- **Túneles del Topo**: Sistema de viaje rápido entre bases descubiertas.

### Jefes y Habilidades
| Jefe | Habilidad | Utilidad de Exploración |
|------|-----------|-------------------------|
| **Tortuga** | **Parry** | Refleja ataques para activar mecanismos de presión. |
| **Araña** | **Silk Tether** | Tirar de objetos o activar interruptores a distancia. |
| **Murciélago**| **Sonar / Mapa** | Revela habitaciones adyacentes y secretos. |
| **Puercoespín**| **Spike Shield** | Romper paredes agrietadas o vegetación. |
| **Cobra** | **Penetración** | Golpear interruptores alineados tras obstáculos. |

---

## 8. El Gran Final: La Decisión

1.  **OPCIÓN A: SALIDA (Trascendencia)**
    * Los hámsters viven libres en la naturaleza. **Se eliminan todos los datos de guardado**.
2.  **OPCIÓN B: CICLO (Evasión/Control)**
    * Los hámsters vuelven al ciclo. Se desbloquean modos *Boss-Rush*, *Time-Attack* y Multijugador.

---

## 9. Principios de Diseño
1.  **Vulnerabilidad Sagrada**: El riesgo de estar sin la bola es constante.
2.  **Precisión sobre Spam**: El rebote cargado premia el conocimiento del entorno.
3.  **Persistencia Física**: Nada desaparece mágicamente; todo tiene una posición en el mundo.
4.  **Escalado de Dificultad**: Tras cada jefe derrotado, los enemigos de todas las rutas se vuelven más letales.
---

## 16. Future Projects (Separate Games)

> These are NOT part of Hamster Madness.
> They are independent games in the same universe.

| Project              | Genre                    | Character   |
|----------------------|--------------------------|-------------|
| Squirrel Experiment  | Metroidvania             | Squirrel    |
| Mole Experiment      | Puzzle (Supaplex)        | Mole        |
| Otter Experiment     | Aquatic Metroidvania     | Otter       |
| Bat Experiment       | Echolocation / Stealth   | Bat         |

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