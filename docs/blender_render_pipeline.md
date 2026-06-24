# Blender → Defold Sprite Pipeline

Renderiza modelos 3D animados desde 8 ángulos usando Blender y los importa como flipbook animations en Defold.

---

## Workflow general

```
Blender                         Defold
─────────────────────────       ─────────────────────────
1. Modelar personaje            6. Crear .atlas con los PNGs
2. Crear armature + acciones    7. Asignar atlas al .go del personaje
3. Configurar materiales        8. En script: sprite.play_flipbook()
4. Ejecutar batch_render.py ──►    según estado + dirección
5. Obtener ~N×8 PNGs
```

---

## Paso 1: Preparar el modelo en Blender

### Requisitos del .blend

| Requisito | Detalle |
|-----------|---------|
| Armature | Un solo rig con huesos |
| Acciones | Cada animación debe ser una **Action** independiente |
| Material | Un solo material para todo el personaje (o todos visibles en render) |
| Orientación | El modelo debe mirar hacia **+Y** en su pose de reposo |
| Escala | El modelo debe caber dentro de un cubo de ~4 unidades centrado en el origen |
| UVs | Debe tener UVs para la textura |
| Normales | Debe tener normales (necesarias para el sombreado) |

### Convención de nombres para las acciones

| Acción | Propósito |
|--------|-----------|
| `idle` | Quieto, respirando |
| `walk` | Caminando |
| `attack` | Atacando |
| `hurt` | Recibiendo daño |
| `death` | Muriendo |
| `special` | Ataque especial (opcional) |

> **Importante**: el nombre de la acción en Blender define el nombre del folder de sprites en Defold.
> Para el turtle boss, las acciones deben llamarse exactamente: `idle`, `walk`, `attack`, `hurt`, `death`.

### Render engine recomendado

| Engine | Velocidad | Calidad | Cuándo usarlo |
|--------|-----------|---------|---------------|
| **EEVEE** | ⚡ Rápido | ✅ Buena | Prototipado, iteración rápida |
| **Cycles** | 🐢 Lento | 🌟 Excelente | Release final |

Ambos producen PNGs con transparencia (alpha background). Empieza con EEVEE para
iterar rápido, cambia a Cycles para el build final.

### Toon shading en Blender

Para el estilo toon (sombreado cartoon):

**Opción A — EEVEE + Shader to RGB** (más rápido):
```
Material Output ← Shader ← Diffuse BSDF ← Shader to RGB ← ColorRamp
                                              ↑                  ↑
                                           Normal           Light path
```
Usa un nodo `ColorRamp` para cuantizar la luz en 2-3 bandas (toon steps).

**Opción B — Freestyle outlines** (contornos):
- Enable: Render Properties → Freestyle
- Line Set: Edge Type = External contours + Crease
- Thickness: 1-2px

**Opción C — Material simple** (para pruebas):
- Un solo Diffuse BSDF color sólido
- Sin textura (el color se asigna desde Defold)

---

## Paso 2: Configurar batch_render.py

### Archivos

| Archivo | Propósito |
|---------|-----------|
| `tools/batch_render.py` | Script de Python para Blender |
| `tools/config.turtle.json` | Config para el turtle boss |

### Config (`config.json`)

```json
{
    "character": "turtle",
    "output_dir": "/ruta/a/hamster-madness/Hamster Madness/main/enemies/bosses/turtle/sprites",
    "render_engine": "BLENDER_EEVEE",
    "resolution_x": 192,
    "resolution_y": 192,
    "camera_distance": 8,
    "camera_height": 6,
    "ortho_scale": 4.0,
    "fps": 12,
    "actions": [
        {"name": "idle",   "frames": "all"},
        {"name": "walk",   "frames": "all"},
        {"name": "attack", "frames": "all"},
        {"name": "hurt",   "frames": "all"},
        {"name": "death",  "frames": "all"}
    ]
}
```

### Parámetros de cámara

| Parámetro | Qué controla | Valor típico |
|-----------|-------------|--------------|
| `camera_distance` | Distancia del centro al modelo (radio del círculo de cámaras) | 6-10 |
| `camera_height` | Altura de la cámara sobre el plano XY | 4-8 |
| `ortho_scale` | Tamaño del viewport ortográfico (zoom) | 3.0-5.0 |
| `resolution_x/y` | Tamaño del PNG de salida | 96-256 |

**Ajuste fino**: Renderiza UNA dirección de prueba, mide cuánto espacio ocupa el
modelo, y ajusta `ortho_scale` para que ocupe ~80-90% del frame.

### Mapas de direcciones

El script coloca 8 cámaras ortográficas en un círculo alrededor del origen.
Cada cámara apunta al centro (0,0,0). El sufijo del archivo indica la dirección
que el modelo parece estar mirando:

```
Cámara en (+X, 0, H) → sprite "e"  (modelo enfrenta al este)
Cámara en (-X, 0, H) → sprite "w"  (modelo enfrenta al oeste)
Cámara en (0, +Y, H) → sprite "s"  (modelo enfrenta al sur)
Cámara en (0, -Y, H) → sprite "n"  (modelo enfrenta al norte)
Cámara en (+X, +Y, H) → sprite "se"
Cámara en (-X, +Y, H) → sprite "sw"
Cámara en (-X, -Y, H) → sprite "nw"
Cámara en (+X, -Y, H) → sprite "ne"
```

Esto asume que el modelo en Blender mira hacia **+Y** por defecto.

### Ejecución

```bash
# Desde terminal:
blender --background modelo.blend --python tools/batch_render.py -- --config tools/config.turtle.json
```

Esto genera archivos como:
```
sprites/
  idle_s_0001.png
  idle_s_0002.png
  ...
  idle_se_0001.png
  idle_se_0002.png
  ...
  walk_s_0001.png
  walk_s_0002.png
  ...
  attack_s_0001.png
  ...
```

---

## Paso 3: Importar a Defold

### Estructura de archivos

Para el turtle boss:
```
main/enemies/bosses/turtle/
  turtle.go
  turtle.script
  turtle_states.lua
  layer.go
  turtle.atlas
  sprites/
    idle_s_0001.png
    idle_s_0002.png
    ...
    idle_se_0001.png
    ...
    walk_s_0001.png
    ...
```

Para nuevos personajes/enemigos, replicar la misma estructura:
```
main/enemies/bosses/{boss_name}/
  {boss_name}.go
  {boss_name}.script
  {boss_name}_states.lua
  {boss_name}.atlas
  sprites/
    ...
```

### Crear el .atlas

Ejemplo `turtle.atlas` con animaciones:
```protobuf
images {
  image: "/main/enemies/bosses/turtle/sprites/idle_s_0001.png"
  sprite_trim_mode: SPRITE_TRIM_MODE_4
}
images {
  image: "/main/enemies/bosses/turtle/sprites/idle_s_0002.png"
  sprite_trim_mode: SPRITE_TRIM_MODE_4
}
-- ... todos los PNGs individuales ...

animations {
  id: "idle_s"
  images { image: "/main/enemies/bosses/turtle/sprites/idle_s_0001.png" }
  images { image: "/main/enemies/bosses/turtle/sprites/idle_s_0002.png" }
  -- (tantos frames como tenga la animación)
  playback: PLAYBACK_LOOP_FORWARD
  fps: 12
}
animations {
  id: "idle_se"
  -- ... mismos frames con direccion se ...
}
-- ... repetir para idle_n, idle_nw, idle_w, idle_sw, idle_e, idle_ne
-- ... repetir para walk_*, attack_*, hurt_*, death_*
```

**Total de animaciones por personaje**: 5 acciones × 8 direcciones = 40 animaciones.

Puedes generar el .atlas automáticamente con un script — ver sección "Scripts útiles".

### Modificar el script

En `turtle.script`, el `update_direction_sprite` cambia a:

```lua
function update_direction_sprite(self)
  local adjusted_angle = self.current_angle + (math.pi / 4)
  local direction_map = {"e", "ne", "n", "nw", "w", "sw", "s", "se"}
  local index = math.floor((adjusted_angle / (math.pi / 4)) % 8) + 1
  local new_direction = direction_map[index]

  if new_direction ~= self.current_direction then
    self.current_direction = new_direction
    local anim_name = self.current_state .. "_" .. new_direction
    sprite.play_flipbook("#sprite", hash(anim_name))
  end
end
```

Donde `self.current_state` es "idle", "walk", "attack", "hurt" o "death".

En `turtle_states.lua`, al cambiar de estado, se actualiza `self.current_state`:

```lua
function change_state(self, new_state)
  self.current_state = new_state  -- "idle", "walk", etc.
  -- ... resto de la lógica de cambio de estado ...
end
```

---

## Paso 4: Proyección de archivos

### Por personaje/enemigo

| Tipo | Acciones | Direcciones | Frames prom. | PNGs por unidad |
|------|----------|-------------|--------------|-----------------|
| Personaje jugable | idle, walk, hurt (3) | 8 | 4-8 | ~96-192 |
| Boss | idle, walk, attack, hurt, death (5) | 8 | 6-12 | ~240-480 |
| Enemigo normal | idle/walk, hurt (2-3) | 4-8 | 2-6 | ~16-144 |

### Total proyectado

| Grupo | Unidades | PNGs por unidad | Total PNGs |
|-------|----------|----------------|------------|
| Personajes (7) | 7 | ~144 (prom.) | ~1008 |
| Bosses (8) | 8 | ~360 (prom.) | ~2880 |
| Enemigos (40) | 40 | ~48 (prom.) | ~1920 |
| **Total** | **55** | | **~5808** |

Cada PNG: ~10-30 KB con compresión PNG (dependiendo del detalle).
Total estimado: **~60-170 MB raw**, **~15-40 MB post-atlas**.

Si es demasiado, se puede reducir:
- Usar 4 direcciones en vez de 8 para enemigos pequeños
- Usar menos frames de animación (2-3 en vez de 6-12)
- Reducir resolución (96×96 en vez de 192×192)

---

## Scripts útiles

### Generar .atlas desde los PNGs

Guarda esto como `tools/generate_atlas.py` y ejecútalo después del render:

```python
import os
import glob

def generate_atlas(character_dir, actions, directions, fps=12):
    atlas_path = os.path.join(character_dir, f"{os.path.basename(character_dir)}.atlas")
    sprite_dir = os.path.join(character_dir, "sprites")

    with open(atlas_path, "w") as f:
        # Image entries
        for action in actions:
            for direction in directions:
                files = sorted(glob.glob(os.path.join(sprite_dir, f"{action}_{direction}_*.png")))
                for img_path in files:
                    rel = img_path.replace(sprite_dir, "")
                    f.write(f'images {{\n')
                    f.write(f'  image: "/main/enemies/bosses/{os.path.basename(character_dir)}/sprites/{os.path.basename(img_path)}"\n')
                    f.write(f'  sprite_trim_mode: SPRITE_TRIM_MODE_4\n')
                    f.write(f'}}\n')

        # Animation entries
        for action in actions:
            for direction in directions:
                files = sorted(glob.glob(os.path.join(sprite_dir, f"{action}_{direction}_*.png")))
                if not files:
                    continue
                f.write(f'animations {{\n')
                f.write(f'  id: "{action}_{direction}"\n')
                for img_path in files:
                    rel = os.path.basename(img_path)
                    f.write(f'  images {{ image: "/main/enemies/bosses/{os.path.basename(character_dir)}/sprites/{rel}" }}\n')
                f.write(f'  playback: PLAYBACK_LOOP_FORWARD\n')
                f.write(f'  fps: {fps}\n')
                f.write(f'}}\n')

    print(f"Generated: {atlas_path}")

if __name__ == "__main__":
    import sys
    char_dir = sys.argv[1]
    actions = ["idle", "walk", "attack", "hurt", "death"]
    directions = ["n", "ne", "e", "se", "s", "sw", "w", "nw"]
    generate_atlas(char_dir, actions, directions)
```

---

## Resumen de pasos para arrancar

```
1. Preparar el modelo 3D en Blender (armature, acciones, material)
   └── Exportar a .blend

2. Crear config.json para el personaje
   └── tools/config.turtle.json

3. Ejecutar batch_render.py
   └── blender --background modelo.blend --python tools/batch_render.py -- --config tools/config.turtle.json

4. Generar .atlas desde los PNGs
   └── python tools/generate_atlas.py main/enemies/bosses/turtle

5. Asignar atlas al .go del personaje
   └── turtle.go → textures { texture: "/main/enemies/bosses/turtle/turtle.atlas" }

6. Actualizar script para usar animaciones por estado+dirección
   └── sprite.play_flipbook("#sprite", hash(current_state .. "_" .. direction))

7. Build y probar en Defold
```
