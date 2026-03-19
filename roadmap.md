# ROADMAP - Hamster Madness
## 🎯 Visión del Proyecto
Roguelike top-down inspirado en The Binding of Isaac con mecánica de disparo único 
estilo Titan Souls, sistema de relevos de personajes y progresión de habilidades 
compartidas.

---

## 📅 FASE 0: Fundamentos (Semana 1-2)
> Objetivo: Tener un jugador moviéndose en una sala vacía con cámara funcional

### 0.1 Configuración del Proyecto
- [ ] Crear proyecto Defold vacío
- [ ] Configurar game.project (resolución, input bindings)
- [ ] Establecer estructura de carpetas
- [ ] Configurar render script básico
- [ ] Crear main.collection

### 0.2 Sistema de Cámara
- [ ] Implementar cámara con seguimiento suave (lerp)
- [ ] Implementar clamping a límites de sala
- [ ] Sistema de mensajes para actualizar límites
- [ ] Testear con sala de prueba

### 0.3 Jugador Base
- [ ] Game Object del jugador con sprite placeholder
- [ ] Movimiento 8 direcciones
- [ ] Colisiones con paredes
- [ ] Sistema de estados básico (idle, walk)

### 0.4 Sala de Prueba
- [ ] Crear tilemap básico
- [ ] Definir colisiones de paredes
- [ ] Spawn point del jugador

**✅ Entregable F0:** Jugador se mueve en una sala, cámara lo sigue correctamente.

---

## 📅 FASE 1: Mecánica Core de Disparo (Semana 3-4)
> Objetivo: Disparo único con recuperación manual y escudo funcional

### 1.1 Sistema de Proyectil
- [ ] Crear projectile.go con física
- [ ] Disparo en 8 direcciones (o hacia cursor)
- [ ] Rebote en paredes (reflexión de vector)
- [ ] Límite de rebotes o tiempo de vida
- [ ] Proyectil se detiene y queda en el mundo

### 1.2 Recuperación del Proyectil
- [ ] Colisión jugador-proyectil para recuperar
- [ ] Indicador visual de proyectil disponible/en mundo
- [ ] Feedback visual/sonoro al recuperar

### 1.3 Sistema de Escudo
- [ ] Estado "armado" cuando tiene proyectil
- [ ] Hitbox de escudo frontal
- [ ] Escudo absorbe UN impacto
- [ ] Cooldown tras absorber golpe
- [ ] Feedback visual de escudo activo/roto

### 1.4 Estados del Jugador Expandidos
- [ ] Estado: armed (tiene proyectil + escudo)
- [ ] Estado: unarmed (disparó, sin escudo)
- [ ] Estado: recovering (recogiendo proyectil)
- [ ] Estado: stunned (recibió golpe con escudo)
- [ ] Estado: dead

**✅ Entregable F1:** Loop completo de disparo → recuperar → escudo funciona.

---

## 📅 FASE 2: Sistema de Salas (Semana 5-6)
> Objetivo: Navegación entre salas con transiciones

### 2.1 Arquitectura de Salas
- [ ] Definir room_data.lua con metadatos
- [ ] Crear room templates (pequeña, mediana, grande)
- [ ] Sistema de puertas (N, S, E, W)
- [ ] Puertas bloqueadas hasta limpiar sala

### 2.2 Level Manager
- [ ] Collection factories para cada tipo de sala
- [ ] Spawn/despawn de salas
- [ ] Preservar estado de salas visitadas
- [ ] Tracking de sala actual

### 2.3 Transiciones
- [ ] Detección de colisión con puerta
- [ ] Fade out/in entre salas
- [ ] Reposicionar jugador en nueva sala
- [ ] Actualizar límites de cámara

### 2.4 Generación Procedural Básica
- [ ] Grafo de conexiones entre salas
- [ ] Algoritmo para generar layout de nivel
- [ ] Garantizar camino a sala de jefe
- [ ] Colocar salas especiales (tesoro, sub-jefe)

### 2.5 Teleports (Salas Secretas)
- [ ] Tiles de teleport ocultos
- [ ] Revelar con condición (bomba, disparo, etc.)
- [ ] Salas secretas fuera del grafo principal

**✅ Entregable F2:** Navegar entre múltiples salas, incluyendo secretas.

---

## 📅 FASE 3: Enemigos Básicos (Semana 7-8)
> Objetivo: Enemigos con IA simple que el jugador puede eliminar

### 3.1 Sistema de Enemigos Base
- [ ] enemy_base.script con comportamientos comunes
- [ ] Sistema de vida (HP)
- [ ] Sistema de daño (recibir impacto de proyectil)
- [ ] Estados: idle, chase, attack, hurt, dead
- [ ] Drops básicos

### 3.2 Tipos de Enemigos Iniciales
- [ ] **Chaser:** Persigue al jugador directamente
- [ ] **Shooter:** Dispara proyectiles simples
- [ ] **Wanderer:** Movimiento aleatorio, daño por contacto
- [ ] **Charger:** Carga en línea recta

### 3.3 Spawner de Enemigos
- [ ] Definir spawn points en salas
- [ ] Wave system básico
- [ ] Condición de "sala limpia"
- [ ] Desbloquear puertas al limpiar

### 3.4 Interacción Proyectil-Enemigo
- [ ] Proyectil mata enemigos de 1 golpe (estilo Titan Souls)
- [ ] Proyectil atraviesa o se detiene (configurable)
- [ ] Feedback de muerte de enemigo

**✅ Entregable F3:** Salas con enemigos que el jugador elimina para progresar.

---

## 📅 FASE 4: Sistema de Personajes/Relevos (Semana 9-11)
> Objetivo: 6 personajes con mecánica de relevo funcional

### 4.1 Sistema de Avatares
- [ ] avatar_data.lua con stats de cada personaje
- [ ] Avatar Manager (tracking de vivos/muertos)
- [ ] UI de avatares disponibles
- [ ] Sistema de selección inicial

### 4.2 Los 6 Avatares (Habilidades Únicas)
Avatar 1 - "Scout" : Movimiento rápido, dash
Avatar 2 - "Tank" : Lento, escudo dura 2 golpes
Avatar 3 - "Bouncer" : Proyectil rebota más veces
Avatar 4 - "Piercer" : Proyectil atraviesa 1 enemigo
Avatar 5 - "Trapper" : Puede dejar minas/trampas
Avatar 6 - "Ghost" : Puede atravesar paredes brevemente

text
- [ ] Implementar habilidad Avatar 1
- [ ] Implementar habilidad Avatar 2
- [ ] Implementar habilidad Avatar 3
- [ ] Implementar habilidad Avatar 4
- [ ] Implementar habilidad Avatar 5
- [ ] Implementar habilidad Avatar 6

### 4.3 Mecánica de Muerte y Relevo
- [ ] Al morir: marcar posición + estado del mundo
- [ ] Spawn nuevo avatar en inicio del nivel
- [ ] Nuevo avatar sin escudo ni disparo
- [ ] Llegar a posición del caído = recuperar poderes
- [ ] UI/feedback del proceso de relevo

### 4.4 Variante: Restauración de Enemigos
- [ ] Opción al recuperar equipo
- [ ] Si acepta: enemigos de ruta reaparecen
- [ ] Balance: ¿qué gana el jugador? (¿vida extra?)
- [ ] Indicador visual de la decisión

### 4.5 Game Over
- [ ] 6 avatares muertos = game over
- [ ] Pantalla de game over con stats
- [ ] Opción de reiniciar

**✅ Entregable F4:** Ciclo completo de muerte → relevo → recuperación.

---

## 📅 FASE 5: Jefes y Sub-jefes (Semana 12-14)
> Objetivo: Encuentros de jefe con patrones y recompensas

### 5.1 Sistema de Jefes Base
- [ ] boss_base.script
- [ ] Sistema de fases (cambio de patrón por HP)
- [ ] HP pool grande (múltiples hits)
- [ ] Arena de jefe (sala especial)
- [ ] Puerta sellada durante combate

### 5.2 Sub-jefes (3 tipos)
- [ ] **Sub-boss A:** Patrón de carga + vulnerabilidad
- [ ] **Sub-boss B:** Invoca minions
- [ ] **Sub-boss C:** Proyectiles en patrón

### 5.3 Jefes Finales (3 tipos para 3 rutas)
- [ ] **Boss 1:** [Diseñar patrón único]
- [ ] **Boss 2:** [Diseñar patrón único]
- [ ] **Boss 3:** [Diseñar patrón único]

### 5.4 Sistema de Habilidades de Jefe
- [ ] ability_data.lua con habilidades desbloqueables
- [ ] UI de habilidades adquiridas
- [ ] Aplicar habilidades a TODOS los avatares
- [ ] Persistencia entre runs (o por run)

### 5.5 Habilidades de Jefe (Ejemplos)
Boss 1 → "Double Shot" : Dispara 2 proyectiles
Boss 2 → "Magnetism" : Proyectil regresa lento
Boss 3 → "Phase Walk" : Dash atraviesa enemigos

text

**✅ Entregable F5:** Combates de jefe funcionales con recompensas.

---

## 📅 FASE 6: Sinergias y Balanceo (Semana 15-16)
> Objetivo: Interacciones entre habilidades de avatar y de jefe

### 6.1 Sistema de Sinergias
- [ ] synergy_data.lua definiendo combinaciones
- [ ] Detector de sinergias activas
- [ ] UI indicando sinergias

### 6.2 Sinergias Específicas
Scout + Phase Walk = Dash más largo
Tank + Double Shot = Escudo refleja 1 proyectil
Bouncer + Magnetism = Proyectil orbita antes de volver
Piercer + Double Shot = Ambos proyectiles atraviesan
Trapper + Magnetism = Minas atraen enemigos
Ghost + Phase Walk = Atravesar paredes más tiempo

text
- [ ] Implementar sinergia 1
- [ ] Implementar sinergia 2
- [ ] Implementar sinergia 3
- [ ] Implementar sinergia 4
- [ ] Implementar sinergia 5
- [ ] Implementar sinergia 6

### 6.3 Balanceo
- [ ] Testear dificultad de enemigos
- [ ] Testear dificultad de jefes
- [ ] Ajustar velocidades/daños
- [ ] Testear progresión de habilidades

**✅ Entregable F6:** Sinergias funcionando, juego balanceado básicamente.

---

## 📅 FASE 7: UI y Feedback (Semana 17-18)
> Objetivo: Interfaz completa y juice

### 7.1 HUD
- [ ] Indicador de avatar actual
- [ ] Avatares restantes
- [ ] Estado del escudo
- [ ] Estado del proyectil (en mano/en mundo)
- [ ] Habilidades activas
- [ ] Minimapa

### 7.2 Menús
- [ ] Menú principal
- [ ] Selección de avatar inicial
- [ ] Pantalla de pausa
- [ ] Pantalla de game over
- [ ] Pantalla de victoria

### 7.3 Feedback Visual (Juice)
- [ ] Screen shake
- [ ] Hitstop en impactos
- [ ] Partículas de muerte
- [ ] Partículas de disparo
- [ ] Trail del proyectil
- [ ] Flash de daño

### 7.4 Audio
- [ ] Sistema de audio manager
- [ ] SFX: disparo, rebote, impacto, muerte
- [ ] SFX: pasos, puertas, pickups
- [ ] Música: exploración, combate, jefe

**✅ Entregable F7:** Juego con UI completa y buen game feel.

---

## 📅 FASE 8: Contenido y Polish (Semana 19-20)
> Objetivo: Juego completo y pulido

### 8.1 Contenido Adicional
- [ ] Más variantes de salas
- [ ] Más tipos de enemigos
- [ ] Items/pickups opcionales
- [ ] Easter eggs / secretos

### 8.2 Generación Procedural Avanzada
- [ ] Mejor algoritmo de generación
- [ ] Semillas para runs
- [ ] Dificultad escalable

### 8.3 Polish Final
- [ ] Optimización de rendimiento
- [ ] Bug fixing
- [ ] Playtesting externo
- [ ] Ajustes finales de balance

### 8.4 Build y Distribución
- [ ] Build para Windows
- [ ] Build para macOS
- [ ] Build para Linux
- [ ] Build para Web (HTML5)
- [ ] Página de itch.io

**✅ Entregable F8:** Juego listo para publicar.

---

## 📊 Resumen de Hitos

| Fase | Duración | Entregable Principal |
|------|----------|---------------------|
| F0 | 2 sem | Movimiento + Cámara |
| F1 | 2 sem | Disparo + Escudo |
| F2 | 2 sem | Sistema de Salas |
| F3 | 2 sem | Enemigos Básicos |
| F4 | 3 sem | Sistema de Relevos |
| F5 | 3 sem | Jefes + Habilidades |
| F6 | 2 sem | Sinergias |
| F7 | 2 sem | UI + Juice |
| F8 | 2 sem | Polish + Release |
| **Total** | **20 sem** | **~5 meses** |

---

## 🔄 Metodología

### Por cada feature:
1. **Diseñar** - Documentar comportamiento esperado
2. **Implementar** - Código mínimo funcional
3. **Testear** - Verificar que funciona
4. **Iterar** - Ajustar según feedback
5. **Documentar** - Comentar código, actualizar docs

### Prioridades:
- 🔴 **Crítico:** Sin esto no hay juego
- 🟡 **Importante:** Mejora significativamente la experiencia
- 🟢 **Nice-to-have:** Puede esperar o cortarse


📁 Hamster Madness/
│
├── 📄 game.project
├── 📄 ROADMAP.md
├── 📄 README.md
├── 📄 DESIGN.md                    ← Documento de diseño del juego
│
├── 📁 main/
│   │
│   ├── 📄 main.collection          ← Bootstrap collection
│   ├── 📄 main.script              ← Inicialización global
│   │
│   ├── 📁 render/
│   │   ├── 📄 game.render          ← Render file
│   │   └── 📄 game.render_script   ← Custom render script
│   │
│   ├── 📁 player/
│   │   ├── 📄 player.collection    ← Player + proyectil como unidad
│   │   ├── 📄 player.go
│   │   ├── 📄 player.script        ← Controlador principal del jugador
│   │   ├── 📄 player_states.lua    ← Máquina de estados
│   │   ├── 📄 player.atlas
│   │   └── 📁 sprites/
│   │       ├── 📄 scout.png
│   │       ├── 📄 tank.png
│   │       ├── 📄 bouncer.png
│   │       ├── 📄 piercer.png
│   │       ├── 📄 trapper.png
│   │       └── 📄 ghost.png
│   │
│   ├── 📁 projectile/
│   │   ├── 📄 projectile.go
│   │   ├── 📄 projectile.script
│   │   └── 📄 projectile.atlas
│   │
│   ├── 📁 shield/
│   │   ├── 📄 shield.go            ← Componente visual del escudo
│   │   └── 📄 shield.script
│   │
│   ├── 📁 camera/
│   │   ├── 📄 camera.go
│   │   └── 📄 camera.script
│   │
│   ├── 📁 enemies/
│   │   ├── 📄 enemy_base.script    ← Comportamiento común
│   │   ├── 📄 enemy_factory.go     ← Factory para spawning
│   │   │
│   │   ├── 📁 types/
│   │   │   ├── 📄 chaser.go
│   │   │   ├── 📄 chaser.script
│   │   │   ├── 📄 shooter.go
│   │   │   ├── 📄 shooter.script
│   │   │   ├── 📄 wanderer.go
│   │   │   ├── 📄 wanderer.script
│   │   │   ├── 📄 charger.go
│   │   │   └── 📄 charger.script
│   │   │
│   │   └── 📄 enemies.atlas
│   │
│   ├── 📁 bosses/
│   │   ├── 📄 boss_base.script
│   │   │
│   │   ├── 📁 sub_bosses/
│   │   │   ├── 📄 sub_boss_a.collection
│   │   │   ├── 📄 sub_boss_b.collection
│   │   │   └── 📄 sub_boss_c.collection
│   │   │
│   │   ├── 📁 final_bosses/
│   │   │   ├── 📄 boss_1.collection
│   │   │   ├── 📄 boss_2.collection
│   │   │   └── 📄 boss_3.collection
│   │   │
│   │   └── 📄 bosses.atlas
│   │
│   ├── 📁 rooms/
│   │   ├── 📁 templates/
│   │   │   ├── 📄 room_small.collection     ← 1x1
│   │   │   ├── 📄 room_medium.collection    ← 1.5x1
│   │   │   ├── 📄 room_large.collection     ← 2x1
│   │   │   ├── 📄 room_tall.collection      ← 1x2
│   │   │   ├── 📄 room_start.collection
│   │   │   ├── 📄 room_boss.collection
│   │   │   ├── 📄 room_treasure.collection
│   │   │   └── 📄 room_secret.collection
│   │   │
│   │   ├── 📁 tilesets/
│   │   │   ├── 📄 dungeon.tilesource
│   │   │   ├── 📄 dungeon.png
│   │   │   └── 📄 collision.tilesource
│   │   │
│   │   └── 📄 door.go                       ← Prefab de puerta
│   │
│   ├── 📁 managers/
│   │   ├── 📄 game_manager.go
│   │   ├── 📄 game_manager.script           ← Estado global del juego
│   │   │
│   │   ├── 📄 level_manager.go
│   │   ├── 📄 level_manager.script          ← Gestión de salas
│   │   │
│   │   ├── 📄 avatar_manager.go
│   │   ├── 📄 avatar_manager.script         ← Gestión de personajes
│   │   │
│   │   ├── 📄 ability_manager.go
│   │   ├── 📄 ability_manager.script        ← Habilidades desbloqueadas
│   │   │
│   │   ├── 📄 spawn_manager.go
│   │   ├── 📄 spawn_manager.script          ← Spawning de enemigos
│   │   │
│   │   └── 📄 audio_manager.go
│   │       └── 📄 audio_manager.script
│   │
│   ├── 📁 ui/
│   │   ├── 📄 hud.gui
│   │   ├── 📄 hud.gui_script
│   │   │
│   │   ├── 📄 main_menu.gui
│   │   ├── 📄 main_menu.gui_script
│   │   │
│   │   ├── 📄 pause_menu.gui
│   │   ├── 📄 pause_menu.gui_script
│   │   │
│   │   ├── 📄 game_over.gui
│   │   ├── 📄 game_over.gui_script
│   │   │
│   │   ├── 📄 avatar_select.gui
│   │   ├── 📄 avatar_select.gui_script
│   │   │
│   │   └── 📄 ui.atlas
│   │
│   ├── 📁 effects/
│   │   ├── 📄 particles.particlefx
│   │   ├── 📄 death_particles.particlefx
│   │   ├── 📄 hit_particles.particlefx
│   │   └── 📄 effects.atlas
│   │
│   └── 📁 data/
│       ├── 📄 avatar_data.lua              ← Stats de los 6 avatares
│       ├── 📄 room_data.lua                ← Metadatos de salas
│       ├── 📄 enemy_data.lua               ← Stats de enemigos
│       ├── 📄 boss_data.lua                ← Stats de jefes
│       ├── 📄 ability_data.lua             ← Habilidades de jefe
│       ├── 📄 synergy_data.lua             ← Definición de sinergias
│       └── 📄 level_layouts.lua            ← Layouts predefinidos
│
├── 📁 shared/
│   ├── 📄 constants.lua                    ← Constantes globales
│   ├── 📄 utils.lua                        ← Funciones utilitarias
│   ├── 📄 state_machine.lua                ← Sistema genérico de estados
│   ├── 📄 vector_utils.lua                 ← Operaciones con vectores
│   └── 📄 collision_groups.lua             ← Definición de grupos de colisión
│
├── 📁 input/
│   └── 📄 game.input_binding
│
└── 📁 assets/
    ├── 📁 audio/
    │   ├── 📁 sfx/
    │   │   ├── 📄 shoot.ogg
    │   │   ├── 📄 bounce.ogg
    │   │   ├── 📄 pickup.ogg
    │   │   ├── 📄 hit.ogg
    │   │   ├── 📄 death.ogg
    │   │   └── 📄 door.ogg
    │   │
    │   └── 📁 music/
    │       ├── 📄 exploration.ogg
    │       ├── 📄 combat.ogg
    │       ├── 📄 boss.ogg
    │       └── 📄 menu.ogg
    │
    └── 📁 fonts/
        └── 📄 main_font.font