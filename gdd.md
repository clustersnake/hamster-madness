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



Sistema de Progresión de Habilidades (Inspirado en Life Force)
Cada personaje activa estas capacidades únicas a medida que derrota enemigos y sube de nivel durante la partida.

Speedy (Velocidad - Rojo)
Nivel 1: Turbo Inicial – Aumento de velocidad base en un 10%.

Nivel 2: Derrape de Energía – Al realizar giros cerrados, deja un rastro de chispas que daña o ralentiza a los enemigos.

Nivel 3: Recogida Magnética – El rango de atracción para recuperar el proyectil/escudo aumenta significativamente.

Nivel 4: Tiempo Bala – Habilidad activa que ralentiza el tiempo para todo el entorno excepto para Speedy.

Dasher (Agilidad - Cian)
Nivel 1: Dash Básico – Desplazamiento rápido con marcos de invencibilidad (i-frames).

Nivel 2: Corte Fugaz – El hámster inflige daño por contacto si realiza un dash a través de un enemigo mientras tiene el escudo.

Nivel 3: Salto de Sombra – El dash permite atravesar paredes delgadas o ciertos obstáculos sólidos.

Nivel 4: Multi-Dash – Capacidad de encadenar hasta 3 dashes seguidos sin tiempo de recarga.

Tank (Fuerza - Verde)
Nivel 1: Blindaje Pesado – Permite resistir un golpe adicional sin soltar el proyectil (reseteable tras cooldown).

Nivel 2: Onda de Choque – Genera una explosión radial que empuja a los enemigos cercanos al recuperar el proyectil.

Nivel 3: Escudo Ampliado – El tamaño físico de la bola/escudo aumenta un 30%, facilitando la defensa activa.

Nivel 4: Fortaleza Móvil – Invulnerabilidad total temporal; permite arrollar a cualquier enemigo, a costa de reducir la velocidad.

Lucky (Suerte - Amarillo)
Nivel 1: Instinto – 10% de probabilidad de que cualquier impacto recibido sea ignorado automáticamente.

Nivel 2: Rebote Fortuito – Al ser lanzado, el proyectil tiene una probabilidad de buscar y rebotar hacia un segundo enemigo cercano.

Nivel 3: Botín Extra – Aumenta la probabilidad de que los enemigos derrotados suelten ítems de mejora.

Nivel 4: Siete de la Suerte – Durante un breve periodo, todos los golpes son críticos y la recuperación del proyectil es instantánea.

Trapper (Inteligencia - Púrpura)
Nivel 1: Mina de Proyectil – Al quedar clavado, el proyectil detecta enemigos y detona en área antes de volver al jugador.

Nivel 2: Red de Contención – La mina genera un campo de ralentización del 40% antes de la explosión.

Nivel 3: Carga Dual – Permite la detonación manual a distancia del proyectil clavado, aturdiendo a los enemigos en pantalla.

Nivel 4: Agujero Negro – La mina succiona a los enemigos hacia su centro durante 3 segundos antes de la explosión masiva.

Trickshot (Destreza - Naranja)
Nivel 1: Rebote Predictivo – Muestra una línea de trayectoria; el proyectil no se detiene al primer choque con un muro.

Nivel 2: Impacto en Cadena – Tras golpear a un enemigo, el proyectil rebota automáticamente hacia el siguiente objetivo más cercano.

Nivel 3: Proyectil Perforante – Atraviesa enemigos menores (sin detenerse) y recoge automáticamente los power-ups a su paso.

Nivel 4: División de Fragmentos – Al impactar, libera 3 fragmentos rebotantes temporales mientras el proyectil principal regresa.
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

1. Evitar Monotonía - Rotación Forzada ✅
text
┌─────────────────────────────────────────────────────────────────┐
│              ANTI-MONOTONÍA                                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PROBLEMA EN OTROS JUEGOS:                                      │
│  • Jugador encuentra su "main" favorito                        │
│  • Ignora otros personajes                                      │
│  • Experiencia repetitiva                                       │
│                                                                 │
│  TU SOLUCIÓN:                                                   │
│  • Muerte = cambio OBLIGATORIO de personaje                    │
│  • Para recuperar tu favorito, debes jugar con otro           │
│  • Fuerza al jugador a dominar todos los estilos              │
│  • Cada run se siente diferente                                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
2. Cascada de Muertes - Mi Recomendación: Opción C
text
┌─────────────────────────────────────────────────────────────────┐
│         OPCIÓN C: PÉRDIDA CON RECUPERACIÓN ESPECIAL            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ESCENARIO:                                                    │
│  • Speedy cae en Sala C                                        │
│  • Tank va a rescatarlo pero TAMBIÉN muere en Sala C          │
│                                                                 │
│  RESULTADO:                                                     │
│  • Speedy se PIERDE (desaparece)                              │
│  • Tank queda como caído (rescatable)                         │
│  • La bola queda donde Tank murió                             │
│                                                                 │
│  RECUPERACIÓN DE SPEEDY:                                       │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ 🌀 PORTAL ESPECIAL / RUTA DE RESCATE                   │   │
│  │                                                         │   │
│  │ Costo: Sacrificar X ranuras de energía                │   │
│  │ Desafío: Arena especial o mini-boss                   │   │
│  │ Recompensa: Recuperar personaje perdido               │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  VENTAJAS:                                                      │
│  ✅ Penaliza cascada de muertes (pierdes un personaje)        │
│  ✅ No es permanente (puedes recuperarlo)                     │
│  ✅ Tiene un costo estratégico (ranuras)                      │
│  ✅ Añade contenido opcional (rutas especiales)               │
│  ✅ Decisión táctica: ¿Vale la pena recuperarlo?              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
3. Sistema de Ranuras de Energía
text
┌─────────────────────────────────────────────────────────────────┐
│              SISTEMA DE PROGRESIÓN POR RANURAS                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  TIPOS DE HABILIDADES:                                         │
│                                                                 │
│  🔷 HABILIDAD PROPIA (única del personaje)                     │
│  🔶 HABILIDAD DE JEFE (compartida por todos)                   │
│                                                                 │
│  EJEMPLO UI - TANK:                                            │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ 🔷 Resistencia  [⚡][⚡][ ][ ]  (2/4 ranuras abiertas)   │   │
│  │ 🔶 Parry        [⚡][ ][ ][ ]  (1/4 ranuras abiertas)    │   │
│  │ 🔶 Hilo         [ ][ ][ ][ ]  (0/4 - bloqueada aún)     │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  EJEMPLO UI - LUCKY:                                           │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ 🔷 Criticals    [ ][ ][ ][ ]  (0/4 - sin energía)       │   │
│  │ 🔶 Parry        [⚡][⚡][ ][ ] (2/4 - más que Tank!)     │   │
│  │ 🔶 Hilo         [ ][ ][ ][ ]  (0/4)                      │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  [⚡] = Ranura abierta/energizada                              │
│  [ ] = Ranura vacía (esperando energía)                       │
│  [🔒] = Ranura bloqueada (requiere desbloquear jefe)          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
Flujo de Energía
text
┌─────────────────────────────────────────────────────────────────┐
│              CICLO DE ENERGÍA                                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. OBTENCIÓN:                                                 │
│     Enemigo muere → suelta energía                             │
│                                                                 │
│  2. DISTRIBUCIÓN (decisión del jugador):                       │
│     ┌─────────────────────────────────────┐                    │
│     │ Tienes 3 energías. ¿Dónde asignar?  │                    │
│     │                                      │                    │
│     │ > Resistencia  [⚡][⚡][+][ ]        │                    │
│     │   Parry        [⚡][+][+][ ]        │                    │
│     │                                      │                    │
│     │ [Confirmar distribución]            │                    │
│     └─────────────────────────────────────┘                    │
│                                                                 │
│  3. ACTIVACIÓN:                                                 │
│     Ranura energizada → habilidad mejora                       │
│                                                                 │
│  4. RECARGA (automática con el tiempo):                        │
│     • PASIVAS (Criticals): se activan solas                    │
│     • ACTIVAS (Parry): cooldown después de usar               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
Habilidades de Jefe (Ejemplos)
text
┌─────────────────────────────────────────────────────────────────┐
│              JEFES Y SUS RECOMPENSAS                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  🐢 TORTUGA → PARRY                                            │
│  • Nivel 1: Refleja proyectiles enemigos (10% prob)           │
│  • Nivel 2: 25% probabilidad                                   │
│  • Nivel 3: 40% probabilidad                                   │
│  • Nivel 4: 60% + knockback al enemigo                        │
│                                                                 │
│  🦔 PUERCO ESPÍN → BOLA DENTADA                               │
│  • Nivel 1: Proyectil hace +25% daño                          │
│  • Nivel 2: +50% daño                                          │
│  • Nivel 3: +75% daño + atraviesa 1 enemigo                  │
│  • Nivel 4: +100% daño + atraviesa 2 enemigos                │
│                                                                 │
│  🕷️ ARAÑA → HILO DE RETORNO                                   │
│  • Nivel 1: Proyectil regresa lento (como magnetismo)         │
│  • Nivel 2: Regresa más rápido                                │
│  • Nivel 3: Regresa al instante con [E]                       │
│  • Nivel 4: Regresa automático + arrastra enemigos pequeños   │
│                                                                 │
│  🦅 ÁGUILA → DISPARO AÉREO                                     │
│  • Nivel 1: Puede disparar mientras salta                     │
│  • Nivel 2: Doble salto                                        │
│  • Nivel 3: Planeo corto                                      │
│  • Nivel 4: Dash aéreo                                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
Sacrificio de Ranuras (Rescate Especial)
text
┌─────────────────────────────────────────────────────────────────┐
│              PORTAL DE RESCATE                                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Aparece después de perder un personaje permanentemente        │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ 🌀 Portal detectado - Rescate disponible                │   │
│  │                                                         │   │
│  │ Personaje perdido: Speedy                              │   │
│  │                                                         │   │
│  │ Costo: Sacrificar 3 ranuras energizadas               │   │
│  │                                                         │   │
│  │ Ranuras actuales:                                      │   │
│  │ • Resistencia [⚡][⚡][ ][ ] (perderías 2)             │   │
│  │ • Parry [⚡][ ][ ][ ] (perderías 1)                   │   │
│  │                                                         │   │
│  │ [Aceptar] [Rechazar]                                   │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  Si aceptas → Mini-boss o desafío especial                    │
│  Si ganas → Recuperas el personaje perdido                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

Diseño Final: Misión de Rescate
text
┌─────────────────────────────────────────────────────────────────┐
│              FLUJO COMPLETO DE MISIÓN DE RESCATE                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ══════════════════════════════════════════════════════════    │
│  OLEADAS NORMALES                                              │
│  ══════════════════════════════════════════════════════════    │
│  🐹 P1 + 🔵 Bola → Oleada 1, 2, 3...                          │
│           │                                                     │
│           │ [P1 MUERE]                                         │
│           ▼                                                     │
│  ══════════════════════════════════════════════════════════    │
│  TRANSICIÓN                                                    │
│  ══════════════════════════════════════════════════════════    │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │         🎬 STAGE ESPECIAL                              │   │
│  │         MISIÓN DE RESCATE                               │   │
│  │                                                         │   │
│  │    (fade dramático, música cambia?)                    │   │
│  └─────────────────────────────────────────────────────────┘   │
│           │                                                     │
│           ▼                                                     │
│  ══════════════════════════════════════════════════════════    │
│  PREPARACIÓN (P2 estático)                                     │
│  ══════════════════════════════════════════════════════════    │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  👻👻     💀P1      👻👻                               │   │
│  │       👻   ⚪bola   👻                                  │   │
│  │  👻                    👻                               │   │
│  │            🐹P2                                         │   │
│  │          (estático)                                     │   │
│  │                                                         │   │
│  │          ⏱️ 3...                                       │   │
│  │          ⏱️ 2...                                       │   │
│  │          ⏱️ 1...                                       │   │
│  │          🚀 ¡ADELANTE!                                 │   │
│  └─────────────────────────────────────────────────────────┘   │
│           │                                                     │
│           ▼                                                     │
│  ══════════════════════════════════════════════════════════    │
│  OLEADAS DE RESCATE (3 fijas, más enemigos)                   │
│  ══════════════════════════════════════════════════════════    │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  P2 puede moverse (SIN bola)                           │   │
│  │                                                         │   │
│  │  Objetivos:                                            │   │
│  │  □ Recoger la bola                                     │   │
│  │  □ Sobrevivir oleada de rescate 1/3                   │   │
│  │  □ Sobrevivir oleada de rescate 2/3                   │   │
│  │  □ Sobrevivir oleada de rescate 3/3                   │   │
│  │  □ Rescatar a P1 (Rueda de Hamster 🎡)                │   │
│  └─────────────────────────────────────────────────────────┘   │
│           │                                                     │
│           │ [3 OLEADAS COMPLETADAS]                            │
│           ▼                                                     │
│  ══════════════════════════════════════════════════════════    │
│  RESCATE (Momento cómico/recompensa)                          │
│  ══════════════════════════════════════════════════════════    │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                                                         │   │
│  │    P2 llega a P1, presiona [E]                        │   │
│  │                                                         │   │
│  │         🐹🔄  ← "Generando energía..."                 │   │
│  │         [████████░░] 80%                               │   │
│  │                                                         │   │
│  │    💀P1 → ✨ → 🐹 (rescatado)                         │   │
│  │                                                         │   │
│  │    Animación cómica: hamster corriendo en ruedita     │   │
│  │    Alivio de tensión = chiste visual                  │   │
│  └─────────────────────────────────────────────────────────┘   │
│           │                                                     │
│           ▼                                                     │
│  ══════════════════════════════════════════════════════════    │
│  MENSAJE DE ÉXITO                                              │
│  ══════════════════════════════════════════════════════════    │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │          ✅ ¡RESCATE EXITOSO!                         │   │
│  │                                                         │   │
│  │     Oleadas normales regresan...                       │   │
│  └─────────────────────────────────────────────────────────┘   │
│           │                                                     │
│           ▼                                                     │
│  ══════════════════════════════════════════════════════════    │
│  OLEADAS NORMALES (continúan)                                  │
│  ══════════════════════════════════════════════════════════    │
│  🐹 P2 (activo) + 🐹 P1 (respaldo)                            │
│  Oleada N+1, N+2...                                            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
Arquitectura de Managers
text
┌─────────────────────────────────────────────────────────────────┐
│              MANAGERS NECESARIOS                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  game_manager.script                                           │
│  ├── Estado global del juego                                   │
│  ├── lives = { "player1", "player2" }                         │
│  ├── current_player = 1                                        │
│  ├── game_mode = "normal" | "rescue"                          │
│  ├── Spawn del personaje                                       │
│  └── Mensajes: player_died, rescue_complete                   │
│                                                                 │
│  wave_manager.script                                           │
│  ├── current_wave = 1                                          │
│  ├── enemies_remaining = 0                                     │
│  ├── is_rescue_mode = false                                    │
│  ├── rescue_waves_completed = 0                                │
│  ├── wave_data (normal y rescate)                             │
│  └── Mensajes: enemy_died, wave_complete                      │
│                                                                 │
│  ui_manager.script (futuro)                                    │
│  ├── Mostrar mensajes                                          │
│  ├── Countdown                                                 │
│  ├── HUD (vidas, oleada, energía)                             │
│  └── Animaciones de transición                                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
Plan de Implementación (Actualizado)
text
┌─────────────────────────────────────────────────────────────────┐
│              FASES DE IMPLEMENTACIÓN                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  FASE 1: Managers Base                                         │
│  ├── 1.1 Crear game_manager.go/script                         │
│  ├── 1.2 Crear wave_manager.go/script                         │
│  ├── 1.3 Mover spawn de chaser al wave_manager                │
│  └── 1.4 Probar oleadas normales básicas                      │
│                                                                 │
│  FASE 2: Sistema de Vidas                                      │
│  ├── 2.1 Implementar 2 vidas en game_manager                  │
│  ├── 2.2 Crear fallen_player.go (marcador de P1 caído)        │
│  ├── 2.3 Modificar player.script (notificar muerte)           │
│  └── 2.4 Probar: P1 muere → P2 respawnea                      │
│                                                                 │
│  FASE 3: Misión de Rescate                                     │
│  ├── 3.1 Implementar game_mode "rescue"                       │
│  ├── 3.2 Oleadas de rescate (3 fijas, x2 enemigos)           │
│  ├── 3.3 Countdown antes de comenzar (3,2,1,¡Adelante!)      │
│  ├── 3.4 Mecánica de rescate (Rueda de Hamster)              │
│  └── 3.5 Transición de vuelta a modo normal                   │
│                                                                 │
│  FASE 4: UI Básica                                             │
│  ├── 4.1 Crear hud.gui/script                                 │
│  ├── 4.2 Mensajes en pantalla (rescue, success, etc.)        │
│  ├── 4.3 Contador de oleada                                   │
│  └── 4.4 Indicador de vidas                                   │
│                                                                 │
│  FASE 5: Sistema de Drops (puede ser después)                 │
│  ├── 5.1 Crear energy_drop.go/script                          │
│  ├── 5.2 Enemigos sueltan drops al morir                      │
│  └── 5.3 Contador de energía                                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘