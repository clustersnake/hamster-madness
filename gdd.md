# Hamster Madness: Rescue Protocol
## Game Design Document v5.4 (Lore & Technical Final)

---

# 1. Concepto Core

## Premisa
Un científico atrapado tras un accidente de laboratorio intenta escapar usando robots de rescate pilotados por hámsters. La realidad: el científico murió; el jugador es una copia de seguridad de sus memorias vinculada biológicamente a un hámster mediante una interfaz sináptica.

## Género y Plataforma
| Aspecto | Descripción |
|---------|-------------|
| **Género** | Acción / Twin-stick shooter / Roguelite Narrativo |
| **Género** | Acción / Twin-stick shooter / Roguelite Narrativo |
| **Engine** | Defold |
| **Resolución** | 1280x720px (Objetos nativos en 96x96px) |

---

# 2. Lore y Finales

## La Revelación
El jugador cree ser humano, pero sus sentimientos y signos vitales provienen del hámster. Al final, descubre que liberar a los hámsters terminará con su propia "existencia" digital.

### Endings
*   **Final Verdadero (7 Hámsters):** Requiere coleccionar a los 6 pilotos. Todos escapan. Borrado de partida y visual de hámsters en la hierba.
*   **Final Melancólico:** Si faltan personajes, los restantes duermen mientras suena el monitor de signos vitales.
*   **Final de Control:** El jugador se queda. Se desbloquean minijuegos.
*   **Modo Difícil:** Si no se libera a nadie, se activa un límite de tiempo por fallo de energía eléctrica.
# 2. Lore y Narrativa

## El Enlace Sináptico
El movimiento fluido de los drones del jugador se debe al enlace neuronal con los hámsters. Al proporcionar instinto y capacidad de procesamiento biológico, el consumo de energía es menor y la respuesta es más orgánica.

## El Sistema de Control (SPA)
A diferencia de los hámsters, los robots del sistema están regidos por circuitos y procesadores rígidos. Por ello, sus movimientos son mecánicos y limitados a 8 direcciones, justificando el uso de animaciones tipo *flipbook*.

## Finales (Endings)
*   **Final Verdadero (7 Hámsters):** Requiere coleccionar a los 6 pilotos. Todos escapan. Borrado de partida y visual de hámsters en la hierba.
*   **Final Melancólico:** Si faltan personajes, los restantes duermen mientras suena el monitor de signos vitales.
*   **Final de Control:** El jugador se queda y se desbloquean minijuegos.
*   **Modo Difícil:** Si no se libera a nadie, se activa un límite de tiempo por fallo de energía eléctrica.

---

# 3. Personajes y Progresión

### 3.1 Los 6 Especialistas

#### **Speedy (Velocidad)**
*   **Nivel 1:** +10% velocidad base.
*   **Nivel 2:** Rastro de chispas al girar.
*   **Nivel 3:** Rango magnético aumentado.
*   **Nivel 4:** **Tiempo Bala**.

#### **Tank (Blindaje)**
*   **Nivel 1:** Aguanta 1 golpe extra sin soltar escudo.
*   **Nivel 2:** Onda de choque al recuperar proyectil.
*   **Nivel 3:** Escudo +30% más grande.
*   **Nivel 4:** **Fortaleza Móvil** (Invulnerabilidad).

#### **Trickshot (Geometría)**
*   **Nivel 1:** 1 redirección tras impacto.
*   **Nivel 2:** 2 redirecciones + rebote a enemigo.
*   **Nivel 3:** Proyectil perforante.
*   **Nivel 4:** **Fragmentación**.

#### **Lucky (Anomalía)**
*   **Nivel 1:** 10% ignorar impacto.
*   **Nivel 2:** Proyectil rebota (probabilidad).
*   **Nivel 3:** Mayor drop de mejoras.
*   **Nivel 4:** **Siete de la Suerte** (Críticos).

#### **Dasher (Agilidad)**
*   **Nivel 1:** Dash básico con i-frames.
*   **Nivel 2:** Daño por contacto durante dash.
*   **Nivel 3:** Atraviesa paredes delgadas.
*   **Nivel 4:** **Multi-Dash** (3 encadenados).

#### **Trapper (Táctica)**
*   **Nivel 1:** Proyectil como mina de proximidad.
*   **Nivel 2:** Campo de ralentización.
*   **Nivel 3:** Detonación manual.
*   **Nivel 4:** **Agujero Negro**.

---

# 4. Bosses: Sistema de Protección Automatizado (SPA)

Utilizan movimientos rígidos en 8 direcciones y volumen mediante pre-renderizado 3D.

| Boss | Técnica Visual | Mecánica | Recompensa |
| :--- | :--- | :--- | :--- |
| **Tortuga (Turtle)** | Stacking (39 capas) | Lenta, ráfagas de misiles. Inmune por delante. | **Parry:** Refleja proyectiles. |
| **Araña (Spider)** | Blender (8 dir) | Movimiento errático. Lanza redes. | **Telaraña:** Recupera proyectil. |
| **Puercoespín** | Stacking | Carga veloz y explosión de espinas. | **Púas:** Daño aumentado. |
| **Murciélago** | Blender (Animada) | Ataca desde la oscuridad con ondas de choque. | **Sonar:** Revela rutas ocultas. |

---

# 5. Mecánicas Core

## 5.1 Escudo Cinético
*   **Carga Activa:** Se carga mediante movimiento o impacto.
*   **Carga Manual:** Botón dedicado para generar energía estática.
*   **Degradación:** El escudo se descarga al cesar la actividad cinética.

## 5.2 Sistema de Muerte y Rescate
Al caer, quedan el **Pod de escape**, el **Escudo** y el **Contenedor de recursos**.
1.  **Timer de Recursos:** Robots de mantenimiento consumen recursos gradualmente.
2.  **Captura:** Si los recursos se agotan, el Pod es llevado a una sala especial.
3.  **Rescate:** Requiere pagar recursos y vencer a los bots de defensa.

## 5.3 Hackeo vs Sacrificio
*   **Hackeo:** Minijuego para recuperar personajes perdidos.
*   **Sacrificio:** Opción de sacrificar mejoras permanentemente para saltarse el minijuego de hackeo y ahorrar tiempo.

---

# 6. Pilares Técnicos
*   **Flipbooks 8-Dir:** Usados exclusivamente para el SPA (Enemigos) por coherencia con el lore.
*   **Batching:** Material único de sprite para optimizar GPU.
*   **Resolución:** Diseño nativo en 96x96px para personajes identificables.

---
**Versión GDD:** 5.4 | **Engine:** Defold | **Jam:** Gamedev.js Jam 2026