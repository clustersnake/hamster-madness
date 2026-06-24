# Guía Rápida: Pipeline de Sprites 3D para Noveles

## Convención del modelo en Blender

```
        +Y (norte / cabeza)
         ↑
         |
  -X —— (0,0) —— +X
         |
         ↓
        -Y (sur / cola)
        Z = arriba
```

### Reglas de oro al modelar

1. **El personaje mira hacia +Y** — la cara/cabeza apunta a +Y (norte)
2. **Centro del modelo en (0,0,0)** — usa `tools/center_model.py` si se desvía
3. **Escala**: el personaje debe caber dentro de las dimensiones que elijas para `ortho_scale`
4. **Orientación**: Z es arriba. El personaje se para en el plano XY

---

## Flujo para renderizar un personaje nuevo

### 1. Preparar el .blend

```bash
# Centrar el modelo si está desplazado
blender personaje.blend --python tools/center_model.py
```

### 2. Crear config.json

Copia `tools/config.turtle.json` y ajusta:

```json
{
    "character": "nombre_personaje",
    "output_dir": "/ruta/completa/a/sprites/",
    "render_engine": "BLENDER_EEVEE",
    "resolution_x": 192,
    "resolution_y": 192,
    "camera_distance": 35,
    "camera_height": 25,
    "ortho_scale": 19.0,
    "fps": 12,
    "actions": [
        {"name": "idle", "frames": "all"}
    ]
}
```

Ajusta `ortho_scale` más grande si el modelo es grande, más chico si es pequeño.

### 3. Render de prueba (1 frame)

```bash
blender personaje.blend --python tools/render_static.py -- --config config.json
```

Los sprites salen en `sprites/` como `personaje-e.png`, `personaje-n.png`, etc.

### 4. Si el tamaño no es correcto

- **Muy pequeño (mucho espacio vacío)**: `ortho_scale` muy grande → redúcelo
- **Muy grande (se corta)**: `ortho_scale` muy chico → agréndalo

Apunta a que el personaje ocupe ~80% del frame.

### 5. Subir los sprites al juego

```bash
# Los sprites ya están en la carpeta correcta si configuraste bien output_dir
# Solo abre Defold y verifica que se vean bien
```

---

## Mapeo de direcciones (CORREGIDO)

| Cámara en Blender | Sprite en juego |
|-------------------|-----------------|
| +X (este) | `e` (mira al este) |
| -X (oeste) | `w` (mira al oeste) |
| +Y (norte) | `s` (mira al sur) |
| -Y (sur) | `n` (mira al norte) |
| +X+Y | `se` |
| -X+Y | `sw` |
| -X-Y | `nw` |
| +X-Y | `ne` |

---

## Si el modelo se ve plano u oscuro

La escena debe tener al menos una luz tipo **Sun** (sol). Si no hay luces:

1. En Blender: `Add > Light > Sun`
2. Posición: desde arriba en diagonal (ej: rotación Z=45°, X=30°)
3. Energía: 5-10

No uses luces animadas o los frames no serán consistentes.

---

## Cómo agregar animaciones (a futuro)

### En Blender

1. Selecciona el modelo, agrega Armature (`Shift+A > Armature > Single Bone`)
2. En `Properties > Object Data`, crea bones para cada parte móvil
3. Ponle weights con Weight Paint o Automatic Weights
4. En `Action Editor`, crea acciones: `idle`, `walk`, `attack`, `hurt`, `death`

### En el pipeline

```bash
# Render animado
blender personaje.blend --python tools/batch_render.py -- --config config.json

# Generar .atlas
python tools/generate_atlas.py "ruta/al/personaje"
```

Esto genera archivos como:
```
sprites/
  idle_s_0001.png
  idle_s_0002.png
  ...
  walk_n_0001.png
  walk_n_0002.png
  ...
```

### En Defold

El `update_direction_sprite` en el script usará `STATE_TO_ANIM[estado] .. "_" .. direccion` para elegir la animación correcta.

---

## Comandos útiles

```bash
# Render estático (1 frame x 8 direcciones)
blender modelo.blend --background --python tools/render_static.py -- --config config.json

# Render animado (batch)
blender modelo.blend --background --python tools/batch_render.py -- --config config.json

# Generar .atlas desde PNGs
python tools/generate_atlas.py "ruta/del/personaje"

# Centrar modelo en origen
blender modelo.blend --background --python tools/center_model.py
```

## Error común: EEVEE no funciona en Blender 5.1+

Si ves errores como `AttributeError: 'SceneEEVEE' object has no attribute 'use_gtao'`,
es porque los scripts ya fueron actualizados para Blender 5.1. Si usas Blender 4.x,
avísame para ajustar.
