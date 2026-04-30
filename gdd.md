# Hamster Madness: Rescue Protocol
## Game Design Document v5.3 (Complete Edition)

---

# 1. Concepto Core

## Premisa
Un científico atrapado tras un accidente de laboratorio intenta escapar usando robots de rescate pilotados por hámsters. La realidad: el científico murió en el impacto; el jugador es una copia de seguridad de sus memorias vinculada biológicamente a un hámster mediante una interfaz sináptica defectuosa.

## Género y Plataforma
| Aspecto | Descripción |
|---------|-------------|
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

---

# 3. Personajes y Progresión

### 3.1 Los 6 Especialistas

#### **Speedy (Velocidad)**
*   **Nivel 1:** +10% velocidad base.
*   **Nivel 2:** Rastro de chispas al girar (daña/ralentiza).
*   **Nivel 3:** Rango magnético aumentado para recoger proyectil.
*   **Nivel 4:** **Tiempo Bala** — ralentiza todo excepto a Speedy.

#### **Tank (Blindaje)**
*   **Nivel 1:** Aguanta 1 golpe extra sin soltar escudo.
*   **Nivel 2:** Onda de choque al recuperar proyectil.
*   **Nivel 3:** Escudo +30% más grande.
*   **Nivel 4:** **Fortaleza Móvil** — invulnerabilidad temporal.

#### **Trickshot (Geometría)**
*   **Nivel 1:** 1 redirección tras impacto.
*   **Nivel 2:** 2 redirecciones + rebote a enemigo cercano.
*   **Nivel 3:** Proyectil perforante (atraviesa enemigos menores).
*   **Nivel 4:** **Fragmentación** — 3 fragmentos rebotantes al impactar.

#### **Lucky (Anomalía)**
*   **Nivel 1:** 10% ignorar impacto recibido.
*   **Nivel 2:** Proyectil rebota a segundo enemigo (probabilidad).
*   **Nivel 3:** Mayor drop de mejoras.
*   **Nivel 4:** **Siete de la Suerte** — críticos garantizados temporalmente.

#### **Dasher (Agilidad)**
*   **Nivel 1:** Dash básico con i-frames.
*   **Nivel 2:** Daño por contacto durante dash (con escudo).
*   **Nivel 3:** Atraviesa paredes delgadas.
*   **Nivel 4:** **Multi-Dash** — 3 dashes encadenados.

#### **Trapper (Táctica)**
*   **Nivel 1:** Proyectil como mina con detonación por proximidad.
*   **Nivel 2:** Campo de ralentización antes de explosión.
*   **Nivel 3:** Detonación manual a distancia.
*   **Nivel 4:** **Agujero Negro** — succiona enemigos antes de explotar.

### 3.2 Personaje de Respaldo
Un hámster sin habilidades especiales que posee **respawn infinito**. Sirve para recolectar recursos tras perder a los especialistas.

---

# 4. Bosses: Sistema de Protección Automatizado (SPA)

Los jefes utilizan técnicas de volumen (Sprite Stacking) y pre-renderizado 3D para diferenciarse visualmente del jugador.

| Boss | Técnica Visual | Mecánica de Combate | Recompensa (Habilidad) |
| :--- | :--- | :--- | :--- |
| **Tortuga (Turtle)** | Stacking (39 capas) | Unidad de asedio lenta con ráfagas de misiles. Inmune por delante. | **Parry:** Refleja proyectiles enemigos con el escudo. |
| **Araña (Spider)** | Blender (8 dir) | Movimiento errático en techos y paredes. Lanza redes ralentizadoras. | **Telaraña:** Recupera el proyectil desde cualquier distancia. |
| **Puercoespín** | Stacking (High res) | Carga veloz y explosión de espinas en 360 grados al recibir daño. | **Púas:** Proyectil con daño de espinas aumentado. |
| **Murciélago** | Blender (Animada) | Ataca desde la oscuridad. Utiliza ondas de choque que desorientan al jugador. | **Sonar:** Revela debilidades de enemigos y rutas ocultas. |

---

# 5. Mecánicas Core

## 5.1 Escudo Cinético
*   **Carga Activa:** Se carga mediante movimiento, atacando enemigos o disparando a paredes.
*   **Carga Manual:** Botón dedicado para generar energía estática (estilo Sonic).
*   **Degradación:** El escudo se descarga si el hámster deja de correr/moverse.

## 5.2 Sistema de Muerte y Rescate
Al caer un personaje, quedan en el campo el **Pod de escape**, el **Escudo** y el **Contenedor de recursos**.
1.  **Timer de Recursos:** Los robots de mantenimiento consumen los recursos del contenedor gradualmente.
2.  **Captura del Pod:** Si los recursos se agotan, el Pod es llevado a una sala especial.
3.  **Rescate:** Requiere pagar recursos para entrar a la sala, ganar la batalla y reactivar al piloto.

## 5.3 Hackeo vs Sacrificio
Si se pierden todos los personajes:
*   **Hackeo:** Minijuego para ganar recursos y reabrir la sala de rescate.
*   **Sacrificio:** El jugador puede sacrificar mejoras para saltarse el minijuego y ahorrar tiempo.

---

# 6. Pilares Técnicos
*   **Batching:** Uso de un material único de sprite para optimizar el rendimiento en la GPU.
*   **Resolución:** 96x96px nativo para maximizar la expresividad de los hámsters.

---
**Versión GDD:** 5.3 | **Engine:** Defold | **Jam:** Gamedev.js Jam 2026