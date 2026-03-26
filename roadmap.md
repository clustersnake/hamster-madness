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


CONFIGURACIÓN DE INKSCAPE:
□ Canvas: 192 x 192 px
□ Área segura del personaje: ~160 x 180 px (centrado)
□ Exportar como PNG a 192x192

LÍNEAS DE CONTORNO:
□ Exterior: 3-4px, color #1a1a1a (o marrón oscuro para calidez)
□ Interior principal: 2-2.5px
□ Detalles: 1.5-2px
□ Detalles finos: 1px

COLORES:
□ Paleta limitada (5-8 colores por personaje)
□ Colores planos, sin muchos gradientes
□ Sombras simples con un tono más oscuro del color base

SOMBRA:
□ Elipse separada como su propio sprite
□ Color: #000000, Opacidad: 40%
□ Tamaño: ~60% del ancho del personaje
□ Posición: sprite separado, Z=-0.1

VISTA 3/4:
□ Ambos ojos visibles en vistas laterales
□ Cabeza casi frontal, cuerpo ligeramente desde arriba
□ Pies simplificados/acortados

ANIMACIONES NECESARIAS (por dirección):
□ idle_down, walk_down (mirando a cámara)
□ idle_up, walk_up (mirando away)  
□ idle_right, walk_right (perfil - se flippea para left)

# 📐 HAMSTER MADNESS - ESPECIFICACIONES DE ARTE Y MEDIDAS

## Configuración del Proyecto

- **Resolución de pantalla:** 1280 x 720 px
- **Filtrado de texturas:** Linear (para arte suave, NO pixel art)

---

## Sistema de Medidas

| Elemento | Tamaño en Pantalla | Sprite Source (archivo) | Scale en Defold |
|----------|-------------------|-------------------------|-----------------|
| **Tile base** | 64 x 64 px | 64 x 64 px | 1.0 |
| **Personaje jugable** | 96 x 96 px | 192 x 192 px | 0.5 |
| **Enemigo pequeño** | 48 x 48 px | 96 x 96 px | 0.5 |
| **Enemigo mediano** | 64 x 64 px | 128 x 128 px | 0.5 |
| **Enemigo grande** | 128 x 128 px | 256 x 256 px | 0.5 |
| **Boss** | 192 x 192 px | 384 x 384 px | 0.5 |
| **Proyectil/Bullet** | 32 x 32 px | 64 x 64 px | 0.5 |
| **Escudo (activo)** | 32 x 32 px | 64 x 64 px | 0.5 |
| **Items/Pickups** | 32 x 32 px | 64 x 64 px | 0.5 |
| **Sombra personaje** | ~60 x 30 px | 120 x 60 px | 0.5 |

---

## Tamaño de Habitaciones

| Tipo | Tiles | Píxeles | Notas |
|------|-------|---------|-------|
| **Pequeña (1 pantalla)** | 20 x 11 | 1280 x 704 px | Cabe exacto en pantalla |
| **Mediana** | 30 x 16 | 1920 x 1024 px | ~1.5 pantallas |
| **Grande** | 40 x 22 | 2560 x 1408 px | ~2 pantallas |

---

## Especificaciones de Arte (Estilo Hilda)

### Canvas en Inkscape

- **Personajes:** 192 x 192 px
- **Área segura:** 160 x 180 px (centrado, dejar margen)

### Grosor de Líneas (a 192px)

| Tipo | Grosor | Uso |
|------|--------|-----|
| Contorno exterior | 3-4 px | Silueta completa |
| Contorno interior | 2-2.5 px | Orejas, brazos, partes grandes |
| Detalles | 1.5-2 px | Ojos, boca, patrones |
| Detalles finos | 1 px | Pestañas, texturas sutiles |

### Color de Líneas

- **Opción simple:** #1a1a1a (negro suave)
- **Opción Hilda:** Versión oscura del color que bordea

### Sombra del Personaje

- **Tipo:** Sprite separado (elipse)
- **Color:** #000000
- **Opacidad:** 40%
- **Tamaño:** ~60% del ancho del personaje
- **Posición Z:** -0.1 (detrás del personaje)

---

## Frames de Animación

### FPS Recomendados

| Animación | FPS |
|-----------|-----|
| Idle | 4-6 |
| Walk | 8-10 |
| Run | 12-16 |

### Frames por Animación

| Animación | Mínimo | Recomendado |
|-----------|--------|-------------|
| Idle | 2 | 4 (+2 parpadeo) |
| Walk | 4 | 6 |
| Hurt | 2 | 3 |
| Death | 4 | 6 |

### Set Completo por Personaje

- **Direcciones:** down, up, right (left = flip de right)
- **Total mínimo:** 18-24 frames
- **Total recomendado:** 36-48 frames

---

## Vista 3/4 (Three-Quarter View)

- Ambos ojos visibles en todas las direcciones (excepto up)
- Cabeza casi frontal
- Cuerpo ligeramente visto desde arriba
- Pies simplificados/acortados

---

## Proporciones en Tiles

| Elemento | Tamaño en tiles |
|----------|-----------------|
| Personaje | 1.5 x 1.5 tiles |
| Enemigo pequeño | 0.75 x 0.75 tiles |
| Enemigo mediano | 1 x 1 tile |
| Proyectil | 0.5 x 0.5 tiles |

---

## Colisiones (Referencia)

| Elemento | Tipo | Radio/Tamaño |
|----------|------|--------------|
| Personaje | Sphere | 32 px (0.5 tiles) |
| Enemigo pequeño | Sphere | 20 px |
| Enemigo mediano | Sphere | 28 px |
| Proyectil | Sphere | 12 px |

---

*Última actualización: [fecha]*
*Estilo de arte: Hilda / The Plucky Squire (líneas suaves, no pixel art)*

ESTADOS DEL ROSTRO EN EL HUD:

┌─────────────────────────────────────────────────────────────────┐
│ ESTADO          │ EXPRESIÓN           │ CUÁNDO SE ACTIVA        │
├─────────────────┼─────────────────────┼─────────────────────────┤
│ normal          │ 😊 Tranquilo        │ Idle, todo bien         │
│ happy           │ 😄 Feliz/Peace sign │ Victoria, recoger item  │
│ shooting        │ 😤 Determinado      │ Al disparar             │
│ damaged         │ 😱 SCREAM           │ Recibe daño             │
│ critical        │ 😢 Sad hamster      │ 1 vida restante         │
│ dead            │ 💀 X_X              │ Al morir                │
│ shield_ready    │ 😏 Confiado         │ Tiene escudo            │
│ shield_lost     │ 😰 Preocupado       │ Pierde escudo           │
│ wave_complete   │ 🎉 Celebrando       │ Termina oleada          │
│ boss_appear     │ 😨 Terror           │ Aparece un boss         │
└─────────────────────────────────────────────────────────────────┘

NORMAL:              HAPPY (Peace):        SHOOTING:
   ┌───────┐           ┌───────┐            ┌───────┐
   │ ∩   ∩ │           │ ∩   ∩ │            │ ∩   ∩ │
   │ ●   ● │           │ ^   ^ │            │ ◉   ◉ │
   │   ◡   │           │   ◡   │            │   △   │
   │  ╰‿╯  │           │  ╰▽╯ ✌│            │  ╰○╯  │
   └───────┘           └───────┘            └───────┘

DAMAGED (SCREAM):    CRITICAL (Sad):       DEAD:
   ┌───────┐           ┌───────┐            ┌───────┐
   │ ∩   ∩ │           │ ∩   ∩ │            │ ∩   ∩ │
   │ ◉   ◉ │           │ ●̣   ●̣ │            │ ×   × │
   │   ◇   │   ←AAAA   │  ╥ ╥  │  ←llorando │       │
   │  ╰□╯  │           │  ╰︵╯ │            │  ───  │
   └───────┘           └───────┘            └───────┘
   (Boca abierta       (Ojos brillantes     
    gritando)           con lágrimas)        

    ========================================
    Plan de Implementación: Jefe Tortuga
Resumen
Implementar el primer jefe del juego: una tortuga con tres fases de combate que enseña mecánicas al jugador de forma orgánica.

Fase 0: Preparación
0.1 Assets necesarios
Asset	Descripción	Estado
turtle_idle	Tortuga caminando	⬜
turtle_shell	Tortuga en caparazón	⬜
turtle_belly	Tortuga panza arriba (vulnerable)	⬜
turtle_indicator	Indicador de ataque listo	⬜
shockwave	Onda expansiva del aplastón	⬜
wind_particles	Partículas de brisa para rodada	⬜
projectile_enemy	Proyectil reflejado (rojo/fuego)	⬜
0.2 Estructura de archivos
text
📁 main/
  📁 enemies/
    📁 bosses/
      📁 turtle/
        📁 sprites/
          🖼️ turtle_idle.png
          🖼️ turtle_shell.png
          🖼️ turtle_belly.png
          🖼️ shockwave.png
        📄 turtle.atlas
        📄 turtle.go
        📄 turtle.script
        📄 turtle_states.lua
      📁 effects/
        📄 shockwave.go
        📄 shockwave.script
        📄 wind.particlefx
Fase 1: Estructura Base
1.1 Crear Game Object de la tortuga
 Crear turtle.go con sprite y collisionobject
 Configurar grupos de colisión
 Agregar factories necesarias (shockwave, etc.)
1.2 Implementar máquina de estados
 Crear turtle_states.lua con estructura FSM
 Definir estados: IDLE, APLASTON, RODADA, PARRY, VULNERABLE
 Implementar transiciones entre estados
 Agregar sistema de cooldowns
1.3 Script principal
 Crear turtle.script con propiedades configurables
 Implementar init() con variables de fase y vida
 Implementar update() que delegue al estado actual
 Implementar on_message() para recibir daño
Fase 2: Ataque Aplastón
2.1 Comportamiento básico
 Caminar lento hacia el jugador
 Detectar distancia de activación
 Transición a caparazón
2.2 Onda expansiva
 Crear shockwave.go con animación de expansión
 Implementar detección de colisión circular
 Configurar área normal vs área 100% (tutorial)
2.3 Tutorial encubierto
 Enviar mensaje al jugador para desactivar controles
 Forzar escudo activo al inicio
 Ejecutar primer aplastón con área completa
 Devolver controles al jugador
Fase 3: Ataque Rodada
3.1 Movimiento
 Implementar transición a caparazón rodante
 Calcular velocidad y dirección inicial
 Implementar rebotes en paredes (5-7 aleatorios)
 Detectar fin de rebotes
3.2 Efectos visuales
 Crear sistema de partículas para brisa
 Orientar partículas en dirección contraria al movimiento
 Activar/desactivar según estado
3.3 Mecánica de counter
 Detectar impacto de proyectil durante rodada
 Transición a estado VULNERABLE (panza arriba)
 Temporizador de recuperación
Fase 4: Ataque Parry
4.1 Estado defensivo
 Implementar transición a caparazón defensivo
 Configurar inmunidad a daño durante parry
4.2 Reflejo de proyectil
 Detectar colisión con proyectil del jugador
 Cambiar sprite del proyectil a versión enemiga
 Invertir dirección con variación irregular
 Cambiar grupo de colisión a enemy_projectile
4.3 Modificar proyectil
 Agregar sprite alternativo (rojo/fuego) al atlas
 Implementar mensaje reflect en projectile.script
 Agregar lógica para dañar al jugador si es reflejado
Fase 5: Sistema de Fases del Jefe
5.1 Control de tiempo
 Implementar temporizador de fase
 Fase 1: Solo aplastón
 Fase 2: Aplastón + Rodada
 Fase 3: Aplastón + Rodada + Parry
5.2 Transiciones de fase
 Animación de transición Fase 1 → 2 (aplastón 100%)
 Animación de transición Fase 2 → 3 (rodada corta)
 Animación de transición Fase 3 activa (parry visual)
5.3 Indicadores visuales
 Mostrar indicador cuando el jefe está listo para atacar
 Ocultar indicador durante ataque
 Feedback visual de fase actual
Fase 6: Integración
6.1 Spawn del jefe
 Crear factory en wave_manager o boss_manager
 Definir condiciones de aparición (oleada específica)
 Configurar sala de jefe si es necesario
6.2 Condición de victoria
 Detectar muerte del jefe
 Enviar mensaje al game_manager
 Mostrar feedback de victoria
6.3 Balanceo
 Ajustar vida del jefe
 Ajustar cooldowns de ataques
 Ajustar velocidades (caminata, rodada)
 Ajustar áreas de daño
 Playtesting
Propiedades configurables
lua
-- turtle.script
go.property("max_health", 10)
go.property("walk_speed", 50)
go.property("roll_speed", 400)
go.property("aplaston_range", 150)
go.property("aplaston_cooldown", 3.0)
go.property("rodada_cooldown", 5.0)
go.property("parry_cooldown", 4.0)
go.property("vulnerable_duration", 2.0)
go.property("phase2_time", 30.0)
go.property("phase3_time", 60.0)
Dependencias
Sistema	Modificación necesaria
projectile.script	Agregar mensaje reflect y sprite enemigo
player.script	Agregar mensaje disable_input / enable_input
player.script	Detectar daño de enemy_projectile
wave_manager	Agregar soporte para spawn de jefes
hud	Mostrar barra de vida del jefe (opcional)
Estimación de tiempo
Fase	Estimación
Fase 0: Preparación	2-3 horas
Fase 1: Estructura Base	2-3 horas
Fase 2: Aplastón	3-4 horas
Fase 3: Rodada	3-4 horas
Fase 4: Parry	2-3 horas
Fase 5: Sistema de Fases	2-3 horas
Fase 6: Integración	2-3 horas
Total	16-23 horas
Notas adicionales
Priorizar mecánicas sobre animaciones pulidas inicialmente
Testear cada fase antes de pasar a la siguiente
El "tutorial encubierto" es crítico para la experiencia del jugador
Considerar agregar sonidos para cada ataque (feedback auditivo)
