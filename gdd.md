# Hamster Madness: Rescue Protocol
## Game Design Document v4.0

---

# 1. Concepto Core

## Premisa

Un científico atrapado en el nivel más profundo de un laboratorio en crisis intenta escapar usando robots de rescate pilotados por hámsters mediante conexión sináptica. Lo que no sabe es que él ya murió, y lo que queda es una copia incompleta de su conciencia luchando contra el sistema de seguridad automatizado.

## Género y Plataforma

| Aspecto | Descripción |
|---------|-------------|
| **Género** | Acción / Twin-stick shooter / Roguelite |
| **Perspectiva** | Top-down |
| **Plataforma** | Web (HTML5) |
| **Engine** | Defold |
| **Tema Jam** | MACHINES (Gamedev.js Jam 2026) |

## Loop Principal
┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐
│ COMBATE │────►│ DROPS │────►│ ACTIVAR │────►│ AVANZAR │
│ │ │ ENERGÍA │ │ HABILID. │ │ │
└────┬─────┘ └──────────┘ └──────────┘ └────┬─────┘
│ │
│ ┌──────────┐ │
└──────────────┤ MUERTE │◄───────────────────────┘
└────┬─────┘
│
▼
┌──────────────┐
│ RESCATE │
│ (o pérdida) │
└──────────────┘

---

# 2. Lore

## Situación Inicial

Un desastre natural obliga a los científicos de un laboratorio subterráneo a refugiarse en cámaras de supervivencia. El jugador despierta en el nivel más profundo con acceso únicamente a los **robots de rescate MPH** (Modular Pilot Hamster) — máquinas esféricas diseñadas para espacios reducidos, pilotadas por hámsters reales mediante conexión sináptica.

## El Conflicto

Al intentar desmantelar equipos para obtener materiales de reparación, se activa el **Sistema de Protección Automatizado (SPA)** que interpreta las acciones como una amenaza a la integridad estructural.

### Fuerzas en Conflicto

| Entidad | Objetivo |
|---------|----------|
| **Programa de Control (Jugador)** | Escapar para preservar su existencia y salvar a los pilotos |
| **Sistema de Protección (SPA)** | Mantener las instalaciones intactas, eliminar amenazas |

### Enemigos

- Robots defensivos
- Torretas automáticas
- Drones de vigilancia
- Láseres de seguridad
- Minas de proximidad
- Terminales encriptados

## La Revelación (Final)

El científico descubre que murió durante el desastre. Lo que controla a los robots es una **copia incompleta de su conciencia** almacenada en el sistema.

## Conexión Emocional

Los hámsters son seres vivos reales dentro de cápsulas esféricas. Su "muerte" no es posible — quedan **dormidos/inconscientes** cuando su robot es destruido.

### Endings

| Condición | Escena Final |
|-----------|--------------|
| **Todos rescatados** | Los 6 hámsters salen juntos de las cápsulas |
| **Algunos perdidos** | Escena melancólica con cápsulas vacías/dormidas |
| **Solo 1 sobrevive** | Un único hámster saliendo solo — agridulce |

---

# 3. Personajes

## El 7mo Personaje (El Jugador)

La conciencia digitalizada del científico. No controla directamente a los robots sino que:

- Dirige estrategia
- Administra mejoras
- Hackea terminales
- Toma decisiones

## Los 6 Robots MPH

| # | Nombre | Color | Especialidad | Mecánica Única |
|---|--------|-------|--------------|----------------|
| 01 | **Speedy** | Rojo | Velocidad | Se mueve más rápido |
| 02 | **Tank** | Verde | Blindaje | Aguanta golpes extra con escudo |
| 03 | **Trickshot** | Naranja | Geometría | Redirige proyectil tras impacto |
| 04 | **Lucky** | Amarillo | Anomalía | Probabilidad de crítico/esquiva |
| 05 | **Dasher** | Cian | Agilidad | Dash con i-frames |
| 06 | **Trapper** | Púrpura | Táctica | Convierte proyectil en mina |

---

# 4. Sistema de Habilidades

Cada personaje tiene una habilidad única que mejora con **módulos de energía** (drops de enemigos).

## Speedy (Velocidad)

| Nivel | Efecto |
|-------|--------|
| 1 | +10% velocidad base |
| 2 | Rastro de chispas al girar (daña/ralentiza) |
| 3 | Rango magnético aumentado para recoger proyectil |
| 4 | **Tiempo Bala** — ralentiza todo excepto a Speedy |

## Tank (Blindaje)

| Nivel | Efecto |
|-------|--------|
| 1 | Aguanta 1 golpe extra sin soltar escudo |
| 2 | Onda de choque al recuperar proyectil |
| 3 | Escudo +30% más grande |
| 4 | **Fortaleza Móvil** — invulnerabilidad temporal |

## Trickshot (Geometría)

| Nivel | Efecto |
|-------|--------|
| 1 | 1 redirección tras impacto |
| 2 | 2 redirecciones + rebote a enemigo cercano |
| 3 | Proyectil perforante (atraviesa enemigos menores) |
| 4 | **Fragmentación** — 3 fragmentos rebotantes al impactar |

## Lucky (Anomalía)

| Nivel | Efecto |
|-------|--------|
| 1 | 10% ignorar impacto recibido |
| 2 | Proyectil rebota a segundo enemigo (probabilidad) |
| 3 | Mayor drop de mejoras |
| 4 | **Siete de la Suerte** — críticos garantizados temporalmente |

## Dasher (Agilidad)

| Nivel | Efecto |
|-------|--------|
| 1 | Dash básico con i-frames |
| 2 | Daño por contacto durante dash (con escudo) |
| 3 | Atraviesa paredes delgadas |
| 4 | **Multi-Dash** — 3 dashes encadenados |

## Trapper (Táctica)

| Nivel | Efecto |
|-------|--------|
| 1 | Proyectil como mina con detonación por proximidad |
| 2 | Campo de ralentización antes de explosión |
| 3 | Detonación manual a distancia |
| 4 | **Agujero Negro** — succiona enemigos antes de explotar |

---

# 5. Mecánicas Core

## 5.1 Sistema Escudo/Proyectil
[ESCUDO] ◄─────────────────────────┐
(protegido) │
│ │
│ Dispara │ Recoge
▼ │
[EN VUELO] ─────────────────────────┤
│ │
│ Impacta/Distancia máx │
▼ │
[EN SUELO] ─────────────────────────┘
(vulnerable)

### Comportamiento

- **Con escudo:** El jugador está protegido
- **En vuelo:** El proyectil daña enemigos, rebota en paredes
- **En suelo:** Debe recogerse manualmente (vulnerable mientras tanto)

## 5.2 Sistema de Daño

| Personaje | Con Escudo | Sin Escudo |
|-----------|------------|------------|
| **Normal** | Pierde escudo → Invulnerabilidad temporal | Muere |
| **Tank** | Aguanta 1 golpe extra → Luego pierde escudo | Muere |
| **Lucky** | Pierde escudo | % de esquivar → Si falla, muere |

## 5.3 Sistema de Rescate

### Al Morir un Robot

En el campo quedan:
- 🔵 **Pod de escape** (cápsula con el hámster)
- 📦 **Contenedor de recursos** (se pierde gradualmente)

### Flujo de Rescate

1. Robots de mantenimiento recogen recursos gradualmente
2. Siguiente personaje entra en modo rescate
3. Completa oleadas de rescate (3 oleadas)
4. Llega al pod caído
5. Mantiene [E] por 3 segundos
6. Hámster recuperado → Vuelve a reserva (sin mejoras)

## 5.4 Sistema de Energía

### Flujo
Enemigo muere
│
▼
[Módulo de Energía] ──► Recogido automáticamente
│
▼
Llena barra de habilidad ████████░░ (80%)
│
│ Barra llena
▼
[Nivel de habilidad +1] (máx 4)

### Reglas

- Los niveles se **mantienen** al cambiar de personaje
- Los niveles se **pierden** si el personaje muere sin ser rescatado

---

# 6. Mecánicas Futuras (Post-Jam)

## 6.1 Sistema de Currency

| Recurso | Fuente | Uso |
|---------|--------|-----|
| **Metal** | Puertas, ascensores, escombros | Reparar puertas, reconstruir robots |
| **Cables** | Computadoras, paneles | Reparaciones eléctricas, mejoras básicas |
| **Circuitos** | Equipos, terminales | Mejoras avanzadas permanentes |

## 6.2 Navegación entre Salas

- Múltiples niveles del laboratorio
- Puertas/ascensores requieren reparación
- Rutas alternativas con diferentes costos

## 6.3 Habilidades de Boss

| Boss | Habilidad | Efecto |
|------|-----------|--------|
| 🐢 Tortuga | **Parry** | Refleja proyectiles enemigos |
| 🕷️ Araña | **Telaraña** | Recupera proyectil a distancia |
| 🦔 Puercoespín | **Púas** | Proyectil con daño aumentado |
| 🦇 Murciélago | **Sonar** | Revela debilidades/rutas ocultas |

## 6.4 Contenedor de Recursos

- Solo hay 1 contenedor compartido entre personajes
- Se pierde si no se recoge al morir
- Robots de mantenimiento lo recogen gradualmente

---

# 7. Estado del Proyecto

## Implementado ✅

| Sistema | Estado |
|---------|--------|
| 2 personajes (Tank, Speedy) | ✅ |
| Escudo/Proyectil funcional | ✅ |
| Sistema de rescate | ✅ |
| Cola aleatoria de personajes | ✅ |
| Sprites separados por personaje | ✅ |
| HUD con retratos dinámicos | ✅ |
| Sistema i18n (EN/ES) | ✅ |
| Habilidad Tank (aguante) | ✅ |
| Habilidad Speedy (velocidad) | ✅ |
| Boss Tortuga | ✅ |

## Pendiente para Jam 🔧

| Sistema | Prioridad |
|---------|-----------|
| Sistema de energía (drops → niveles) | Alta |
| Mejoras de habilidad nivel 2-4 | Media |
| Pulido visual/feedback | Media |
| Endings según rescates | Baja |

## Post-Jam 📋

| Sistema |
|---------|
| 4 personajes adicionales |
| Sistema de Currency |
| Navegación entre salas |
| Habilidades de Boss adicionales |
| Historia completa |

---

# 8. Referencias

| Elemento | Referencia |
|----------|------------|
| Estética general | Hollow Knight + Industrial/Laboratorio |
| Sistema de habilidades | Life Force / Gradius |
| Endings múltiples | Sonic 1 (esmeraldas) |
| Robots esféricos | Portal (torretas) + Hamster balls |
| Mecánica de rescate | Into the Breach |

---

# 9. Información del Proyecto

| Campo | Valor |
|-------|-------|
| **Versión GDD** | 4.0 |
| **Última actualización** | Enero 2025 |
| **Plataforma** | Web (HTML5) |
| **Engine** | Defold 1.12.3 |
| **Jam** | Gamedev.js Jam 2026 |
| **Tema** | MACHINES |
| **Publicado** | [itch.io](https://clustersnake.itch.io/hamster-madness) |
