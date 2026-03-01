# Game Design Document — Hamster Madness

---

## 1. Información General

### Nombre del Juego
Hamster Madness

### Género
Aventura de Acción / Mundo Persistente (No lineal)
*Nota: Evolución desde Roguelite hacia una estructura de exploración y rescate.*

### Inspiraciones
- **Titan Souls**: Riesgo de recurso único y mecánica de recuperación.
- **Hollow Knight**: Mundo interconectado, atmósfera y penalización por muerte.
- **Mega Man X**: Progresión basada en habilidades obtenidas de jefes.
- **Dark Souls**: Recuperación de "cuerpo" y tensión tras la derrota.

---

## 2. Descripción Narrativa (Lore)

El hámster no es un avatar virtual, sino un organismo biológico real aumentado quirúrgicamente, dirigido por un operador remoto (el jugador). Las misiones ocurren en complejos de laboratorio físicos, sectores de prueba y almacenes abandonados.

### Los Predecesores
El mundo contiene **Campamentos de Expediciones Previas**. Estos son lugares donde equipos anteriores fallaron. Funcionan como puntos de control (Bases) y contienen fragmentos de historia que revelan qué ocurrió en el laboratorio antes de tu llegada.

---

## 3. Concepto Core
> 1 bola = escudo + proyectil + vida.
> Lanzarla = quedar expuesto.
> Recuperarla = supervivencia.

---

## 4. Mecánicas de la Bola

### El Disparo y el Rebote Cargado
| Propiedad | Comportamiento |
|-----------|----------------|
| **Dirección** | 8 direcciones (incluye diagonales perfectas). |
| **Velocidad** | Rápida (~2x la del jugador). |
| **Rebotes** | La bola rebota en paredes físicas. |
| **Carga Cinética** | **NUEVO**: Cada rebote en una pared antes de tocar el suelo aumenta el brillo de la bola y su daño. Algunos enemigos con armadura solo pueden ser dañados tras 2 o más rebotes. |

### Recuperación
- **Manual**: Contacto físico directo con la bola en el suelo.
- **Silk Tether (Cuerda de Seda)**: Habilidad para tirar de la bola y traerla de vuelta al hámster, permitiendo recuperarla a distancia o activar interruptores lejanos.

---

## 5. Sistema de "Muerte" y Rescate

El juego elimina el concepto de "Game Over" instantáneo por un sistema de **Misión de Recuperación**:

1.  **Estado Herido**: Al recibir daño sin el escudo, el hámster actual queda incapacitado en la habitación.
2.  **El Reemplazo**: El jugador toma el control de un nuevo espécimen desde el último **Nido de Viruta** (Base) activado.
3.  **Vulnerabilidad**: El reemplazo debe viajar hasta el lugar del incidente **sin la bola**.
4.  **Rescate**:
    * **Éxito (Llegar a tiempo)**: Se recupera la bola y al hámster herido. El hámster rescatado vuelve a la "reserva" (vidas).
    * **Fallo (Timer agotado)**: El hámster herido muere. Solo se recupera la bola. Se pierde una unidad biológica permanentemente.
    
### 5.1 Gestión de Unidades (Vidas)
El jugador selecciona su nivel de riesgo al iniciar la expedición:
- **Modo Alpha (1 Vida)**: No hay rescate posible. La pérdida de la unidad termina la simulación.
- **Modo Beta (3 Vidas)**: El estándar. Permite hasta 2 misiones de rescate simultáneas.
- **Modo Gamma (5 Vidas)**: Enfoque en exploración.

### 5.2 La "Regla de la Bola Única"
Independientemente de cuántos hámsters haya en la reserva, **solo existe una Bola de Combate** en el sector. 
- Si un hámster muere (timer agotado), la bola permanece en el suelo.
- Si un hámster es rescatado, se reintegra a la reserva en la Base.
---

## 6. Estructura del Mundo

### Hub Central
La simulación comienza en una **Base Central** con **4 puertas** abiertas hacia distintos biomas (Norte, Sur, Este, Oeste). El jugador elige su ruta, aunque el progreso en ciertas áreas requiere habilidades de otras.

### Puntos de Interés
- **Nidos de Viruta (Bases)**: Zonas de descanso donde el hámster marca territorio. Sirven para guardar progreso y como punto de reaparición.
- **Túneles del Topo**: Sistema de viaje rápido entre Bases descubiertas.

---

## 7. Jefes y Habilidades Permanentes

Cada jefe derrotado otorga una mejora biotecnológica que expande las capacidades de combate y exploración:

| Jefe | Habilidad | Utilidad de Exploración |
|------|-----------|-------------------------|
| **Tortuga** | **Parry** | Refleja ataques para activar mecanismos de presión. |
| **Araña** | **Silk Tether** | Tirar de objetos o activar interruptores a distancia. |
| **Murciélago**| **Sonar / Mapa** | Revela habitaciones adyacentes y secretos en el mapa. |
| **Puercoespín**| **Spike Shield** | Romper paredes agrietadas o vegetación densa. |
| **Cobra** | **Penetración** | Golpear interruptores alineados tras obstáculos. |
| **Topo** | **Excavación** | Acceso al sistema de viaje rápido (Fast Travel). |

---

## 8. Enemigos MVP

- **Chaser**: Persecución directa. Peligrosos si acorralan al jugador sin bola.
- **Shooter**: Dispara proyectiles. Requiere uso táctico del rebote o parry.
- **Spiderling**: Lento, pero puede atrapar la bola en una red, obligando al jugador a rescatarla manualmente.

---

## 9. Principios de Diseño

1.  **Vulnerabilidad Sagrada**: Ninguna mejora elimina el riesgo de estar desprotegido.
2.  **Precisión sobre Spam**: El sistema de rebote cargado premia el conocimiento del entorno.
3.  **Persistencia Física**: La bola y el hámster herido siempre existen en coordenadas reales del mundo; nunca desaparecen mágicamente.
4.  **Información como Progreso**: El mapa se completa activamente mediante el uso de habilidades (Sonar).
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