# Roadmap de Desarrollo — Project H.A.M.S.T.E.R.

Este plan de ruta está diseñado bajo una filosofía de prototipado rápido vertical, asegurando que cada paso genere resultados visuales y jugables inmediatos para validar el motor Defold y las mecánicas centrales antes de pasar a sistemas más complejos.

## Fase 1: Los Cimientos (Core Loop Funcional)

### 1. Escena básica
**Objetivo:** Establecer la primera colección de juego (`main.collection`) y el entorno de pruebas inicial.

**Tareas:**
- Crear la colección principal del nivel.
- Configurar la iluminación ambiental y direccional básica para el espacio 3D.
- Verificar que el motor renderiza correctamente el espacio tridimensional.

### 2. Suelo y paredes
**Objetivo:** Construir los límites físicos del escenario usando modelos exportados desde Blender.

**Tareas:**
- Importar los primeros archivos `.glb` de suelo y muros a la carpeta `/assets/models/`.
- Crear un Game Object de entorno en Defold con su respectivo componente Model.
- Añadir un componente Collision Object de tipo Static con formas de colisión (Box shape o Mesh) para contener las físicas del rover.

### 3. Cámara
**Objetivo:** Configurar una perspectiva 3D estable que siga la acción de forma fluida.

**Tareas:**
- Posicionar la cámara a una distancia isométrica o cenital adecuada para el movimiento del rover.
- Implementar un script de seguimiento suave (smooth follow) o integrar un componente de cámara base para evitar saltos bruscos en pantalla.

### 4. Jugador y movimiento
**Objetivo:** Dar vida al rover principal con físicas tridimensionales responsivas.

**Tareas:**
- Importar el modelo 3D del Rover principal y asociarlo a un Game Object.
- Configurar el componente de colisión (dinámico o cinemático según el comportamiento de manejo deseado).
- Programar el script de control en Lua (`.script`) para la aceleración, frenado y rotación del chasis mediante el teclado o mando.

### 5. Escudo y proyectil
**Objetivo:** Implementar las mecánicas ofensivas y defensivas básicas del vehículo.

**Tareas:**
- Crear un Game Object independiente para el proyectil (bullet) con su script de desplazamiento lineal y detección de colisiones.
- Programar la lógica de disparo desde el rover al presionar una tecla.
- Diseñar la lógica del escudo (shield) como un componente secundario acoplado al rover capaz de absorber o desviar impactos.

### 6. Enemigos
**Objetivo:** Introducir unidades hostiles básicas para probar el combate y las interacciones físicas.

**Tareas:**
- Crear un prefab de enemigo básico (ej. una torreta o un dron móvil simple).
- Programar una rutina de IA básica (detección de distancia o disparo estático).
- Configurar las alertas de colisión para que los proyectiles dañen o destruyan al enemigo.

## Fase 2: Estructura, Sistemas y Pulido (Escalabilidad)

### 7. Salas (Rooms)
**Objetivo:** Modularizar el diseño de niveles para facilitar la creación de múltiples escenarios.

**Tareas:**
- Dividir los niveles en colecciones independientes (`.collection`).
- Implementar el uso de Collection Proxies para la carga y descarga dinámica de habitaciones sin sobrecargar la memoria.

### 8. Personajes múltiples para el jugador
**Objetivo:** Permitir la selección o alternancia entre diferentes variantes de rovers con estadísticas o habilidades únicas.

**Tareas:**
- Refactorizar la estructura de scripts del jugador para soportar un patrón de datos desacoplado (configuraciones de velocidad, vida y armadura por tipo de vehículo).

### 9. Menú
**Objetivo:** Diseñar la interfaz de usuario para la navegación inicial del juego.

**Tareas:**
- Construir el menú principal, pantalla de pausa y HUD en partida (temporizador, estado del escudo, vida).
- Configurar sistemas de UI responsivos mediante frameworks compatibles con Defold (como Druid).

### 10. Animaciones
**Objetivo:** Dotar de dinamismo visual a los modelos 3D y elementos de la interfaz.

**Tareas:**
- Importar animaciones esqueléticas o de transformación desde Blender (rotación de ruedas, suspensión, daño en paneles).
- Gestionar las transiciones de estados animados desde los scripts en Defold.

### 11. Sonidos
**Objetivo:** Enriquecer la atmósfera del juego con efectos de audio y musicalización.

**Tareas:**
- Importar recursos de audio (`.wav` / `.ogg`) a la estructura de assets.
- Programar los disparadores de sonido (Sound Components) para motores, explosiones, disparos y música de fondo en los menús y salas.
