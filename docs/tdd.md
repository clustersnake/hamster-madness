# Documento de Diseño Técnico (TDD) — Project H.A.M.S.T.E.R.

## 1. Información General del Proyecto

- **Nombre del Proyecto:** Project H.A.M.S.T.E.R. (Hybrid Artificial Multitask Synaptic Tactical Experimental Rover).
- **Motor de Videojuego:** Defold.
- **Entorno de Desarrollo:** Linux (Debian), utilizando hardware optimizado.
- **Control de Versiones:** Git con repositorio remoto en GitHub (configurado mediante SSH a través del puerto 443 para evitar restricciones de red).

## 2. Configuración del Motor y Entorno (`game.project`)

- **Físicas:** Configuración del motor de físicas establecido en 3D (`Physics -> Type: 3D`) para habilitar el cálculo de colisiones espaciales y profundidad en el eje Z.
- **Estructura Inicial:** Proyecto iniciado desde cero (Empty Project) para mantener una jerarquía limpia de directorios sin dependencias heredadas.

## 3. Pipeline de Arte y Modelado 3D

- **Software de Modelado:** Blender.
- **Formato de Exportación:** Archivos `.glb` (GLTF binario autocontenido). Se prioriza este formato sobre `.gltf` dividido para mantener la geometría, nodos y texturas empaquetados en un único archivo limpio y fácil de gestionar en el control de versiones.
- **Integración en Defold:**
  - Los archivos `.glb` se importan dentro de la estructura de recursos (`/assets/models/`).
  - Se emplea un componente puente de tipo Model para enlazar la malla tridimensional (Mesh) y aplicar las texturas correspondientes (`Texture` / ranura `tex0`).

## 4. Arquitectura y Sistemas Principales

### Entidades y Componentes (Game Objects)
- Estructura modular basada en contenedores principales (Game Objects).
- Componentes visuales desacoplados de la lógica de movimiento y de los componentes de colisión tridimensional.

### Cámara y Perspectiva
- Configuración orientada a una perspectiva 2.5D con profundidad de cámara.
- Implementación de un sistema de seguimiento fluido (*smooth follow*) enfocado en el Rover principal.

### Estructura de Directorios

```
/
├── assets/                  # Recursos fuente (Blender, imágenes originales, audio)
│   ├── models/              # Archivos .glb exportados de Blender
│   ├── textures/            # Texturas crudas (albedo, normal, etc.)
│   └── audio/               # Efectos de sonido (wav/ogg)
│
├── game/                    # Recursos configurados de Defold
│   ├── characters/          # Todo lo relacionado con actores
│   │   ├── rover/           # Tu personaje principal (componentes, scripts)
│   │   ├── enemies/         # Carpeta contenedora de enemigos (ej: drones, patrullas)
│   │   └── bosses/          # Carpeta para jefes finales
│   │
│   ├── objects/             # Objetos de juego / Propiedades
│   │   ├── shield/          # Prefabs y scripts del escudo
│   │   └── bullet/          # Proyectiles
│   │
│   ├── world/               # Elementos del nivel
│   │   └── rooms/           # Colecciones (.collection) de cada habitación/sala
│   │
│   └── ui/                  # Interfaz y HUD
│       └── atlases/         # Tus archivos .atlas para sprites 2D/UI
│
├── materials/               # Shaders y materiales (render)
├── render/                  # Script de renderizado personalizado
└── scripts/                 # Scripts globales o reutilizables
```

### ¿Por qué esta estructura?

#### Separación de Assets vs. Recursos
- `assets/` es tu "caja de herramientas". Ahí es donde pones los `.glb` de Blender y los `.png` originales.
- `game/` es el "motor". Ahí es donde creas los componentes de Defold (`.model`, `.atlas`, `.go`, `.script`) que apuntan a los archivos en `assets/`.

#### Escalabilidad
- Al tener carpetas dedicadas para `enemies/` y `bosses/`, puedes crear fácilmente nuevos modelos o scripts sin ensuciar la raíz del proyecto.
- Las `rooms/` dentro de `world/` te permiten cargar y descargar niveles de forma independiente (usando Collection Proxies cuando tu juego crezca).

#### Orden lógico para Atlases y Sprites
- Los archivos `.atlas` son recursos pesados en memoria. Mantenerlos en `ui/atlases/` o una carpeta global dedicada te ayudará a organizar los Texture Profiles (configuración de atlas) más adelante cuando optimices el peso del juego para distintas plataformas.

> **Consejo PRO:** A medida que crees tus Game Objects (`.go`), intenta que cada carpeta de personaje (ej. `rover/`) contenga su propio archivo `.go`, su script de lógica (`.script`) y cualquier otro componente necesario. Esto hace que sea muy fácil copiar y pegar una carpeta entera si decides crear un tipo de enemigo variante en el futuro.
