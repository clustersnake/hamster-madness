# Roadmap: Hamster Madness — Implementación Técnica

Este documento detalla la evolución técnica desde el concepto "Snake-like" hacia la mecánica de **Vínculo Vital (Bola Única)** y la estructura narrativa de la **Pirámide Invertida**.

---

## 1. El Vínculo: Hámster y Bola Única
Sustituimos la lista de nodos del antiguo "Snake" por un sistema de dos entidades con estados de dependencia mutua.

* **Estado: Unido (Escudo Activo)**
    * La bola se posiciona mediante `go.set_parent()` o siguiendo al hámster en cada `update`.
    * **Colisión**: Grupo `heavy_shield`. El hámster es invulnerable a impactos frontales y puede arrollar enemigos menores.
* **Estado: Lanzado (Vulnerabilidad)**
    * La bola se desprende y se convierte en un proyectil independiente con `collision_type.DYNAMIC`.
    * **Colisión**: El hámster cambia su máscara a `fragile_flesh`. Un solo impacto de enemigo o trampa resulta en estado "Herido".

---

## 2. El Rebote Cargado (Física Cinética)
La bola no es un proyectil estático; su efectividad depende de la geometría y los rebotes.

* **Lógica de Carga**: En el script de la bola, detectamos `collision_response`. Si el grupo impactado es `wall`, incrementamos `self.bounce_count`.
* **Fórmula de Daño**: 
    $$Daño = Base + (Rebotes \times Multiplicador)$$
* **Feedback Visual**: A mayor carga, aumentamos la intensidad del brillo (*tint*) y la escala del sprite mediante `go.animate`. El hámster percibe esta energía como una vibración neuronal.

---

## 3. Sistema de Misión de Recuperación
Implementación del bucle de "muerte" sin recurrir al Game Over tradicional, reforzando la persistencia del mundo.

1.  **Incapacitación**: Al recibir daño, el script del hámster desactiva el control del usuario y emite una señal de auxilio al `game_manager`.
2.  **Persistencia**: El hámster herido y la bola permanecen en sus coordenadas `x, y` actuales. No desaparecen.
3.  **Spawn de Reemplazo**:
    * Se utiliza un `factory` en el **Nido de Viruta** (Base) más cercano.
    * El nuevo hámster nace **sin bola**, totalmente indefenso.
    * **Objetivo**: Navegar el mapa para rescatar al compañero herido y recuperar el equipo.

---

## 4. Arquitectura: La Pirámide Invertida
El mundo se gestiona mediante **Collection Proxies** para representar el ascenso desde la profundidad.

* **Nivel -50 (La Sima)**: Colección persistente que actúa como Hub Central y refugio del Dr. Aris.
* **Las 4 Espirales de Fuga**: Colecciones de biomas (Tortuga, Araña, Murciélago, Cobra).
* **Progreso Global**: Un módulo Lua (`global_state.lua`) rastrea los jefes derrotados para abrir las 5 puertas de la Sima.

---

## 5. Lógica del Meta-Final
Implementación de los dos estados finales del juego en el sistema de archivos de Defold.

* **Final B (Control - Ciclo)**: Escribe un flag en `sys.save` que habilita el acceso a los modos *Boss Rush* y *Time Attack*.
* **Final A (Trascendencia - Salida)**: 
    * Muestra la cinemática de la bola abierta frente al lago/río.
    * **Acción Final**: Ejecuta `os.remove(sys.get_save_file("HamsterMadness", "savegame"))`. 
    * *El jugador debe soltar físicamente su progreso para otorgar la libertad real.*

---

## Plan de Sprints Inmediatos

### Sprint 1: Movimiento y Vínculo (MVP)
- [ ] Configurar hámster (Kinematic) y Bola (Dynamic) en una colección básica.
- [ ] Implementar recogida de bola por contacto físico.
- [ ] Programar lanzamiento en 8 direcciones basado en el input del jugador.

### Sprint 2: El Rebote Cinético
- [ ] Detectar colisiones con muros y aumentar el contador de carga.
- [ ] Crear efectos de partículas de "estática" al alcanzar cargas altas.
- [ ] Aplicar el daño multiplicado a un enemigo de prueba.

### Sprint 3: El Hub y la Reserva Biológica
- [ ] Diseñar el Tilemap de la Sima con las puertas alineadas geométricamente.
- [ ] Implementar la reserva inicial de **2 hámsters**.
- [ ] Lógica de reaparición del reemplazo tras la caída del hámster activo.