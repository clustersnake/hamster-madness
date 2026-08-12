# Project H.A.M.S.T.E.R
## Game Design Document v1.0

---

# 1. Concept Core

## Premisa

**Project H.A.M.S.T.E.R** es un juego de acción / twin-stick shooter / roguelite narrativo donde el jugador controla drones de rescate dentro de un laboratorio subterráneo colapsado tras un desastre natural.

La premisa aparente es simple:

> El jugador está atrapado en las instalaciones e intenta usar drones especializados para alcanzar el exterior y pedir ayuda.

> Para alcanzar su objetivo el jugador debe pasar a través del sistema de seguridad del laboratorio que fiel a sus directivas identifica los esfuerzos de escape de los drones como una amenaza a la seguridad y tratará de detenerlos por todos los medios.

La realidad es más oscura:

El jugador es una personalidad creada por el sistema de respaldo que ve amenazada la integridad del sistema debido a las condiciones del sistema de generadores eléctricos que no van a durar para siempre.

Los drones del jugador no son simples máquinas: cada uno contiene un núcleo sináptico con un hámster real utilizado para agilizar reacciones, cálculos y toma de decisiones.

Plot Twist:
El jugador mismo depende de un núcleo sináptico y por ende al final de la aventura tendrá que decidir si liberar al hámster alojado en su núcleo o conservarlo y seguir operativo.

---

## Género y Plataforma

| Aspecto | Descripción |
|---|---|
| **Género** | Acción / Twin-stick Shooter / Roguelite Narrativo |
| **Engine** | Defold |
| **Resolución Base** | 1280x720 px |
| **Tamaño Nativo de Sprites** | 96x96 px |
| **Estilo Jugador** | Cartoon vectorial |
| **Estilo Enemigos / SPA** | Robótico, metálico, rígido, low-poly / pre-renderizado |

---

# 2. Dirección Artística

## 2.1 Drones del Jugador

Los personajes jugables tienen un diseño **cartoon, vectorial y expresivo**. Aunque son drones mecánicos, deben sentirse vivos, flexibles y con personalidad.

### Rasgos visuales

- Formas redondeadas.
- Colores vivos.
- Siluetas claras.
- Expresiones o visores con personalidad.
- Pintura personalizada.
- Detalles caricaturescos.
- Movimiento fluido y orgánico.

### Justificación narrativa

Los drones del jugador se mueven de forma más natural porque están vinculados a núcleos sinápticos biológicos. Los hámsters aportan instinto, microdecisiones y procesamiento orgánico, haciendo que los drones sean menos rígidos que los sistemas automáticos del laboratorio.
Los drones tienen personalidades diferentes e interactúan con el jugador de forma constante ofreciendo tips, feedback o sencillamente realizando comentarios graciosos haciendo que el jugador se sienta parte de la experiencia todo el tiempo.

---

## 2.2 Sistema de Protección Automatizado — SPA

Los enemigos pertenecen al **Sistema de Protección Automatizado** del laboratorio. Incluye:

- Robots de defensa.
- Tanques.
- Torretas.
- Cañones láser.
- Trampas (pinchos, planchas de presión, bombas).
- Drones centinela.
- Robots de mantenimiento.
- Sistemas de contención.

Visualmente son más fríos, mecánicos y rígidos que los drones del jugador.

### Rasgos visuales

- Formas angulares.
- Modelos pixelart.
- Paleta de grises, negros y acentos luminosos.
- Movimiento mecánico.
- Simetría y repetición.
- Animaciones en 8 direcciones.
- Ausencia de expresividad emocional.

### Justificación narrativa

El SPA no posee procesamiento orgánico libre. Sus unidades dependen de rutinas, circuitos y protocolos rígidos. Por eso sus movimientos son más limitados y predecibles.

---

# 3. Lore Principal

## 3.1 El Desastre

Un desastre natural provoca el aislamiento del laboratorio subterráneo. 
Dentro del laboratorio se realizan diferentes experimentos para crear y entrenar diferentes drones a los cuales se les inyecta comportamientos animales a través de enlaces sinápticos.

---

## 3.2 El Jugador

El jugador cree ser el científico intentando escapar.

En realidad:

- Es un software basado en recuerdos humanos.
- Tiene memorias fragmentadas del científico.
- No posee cuerpo humano.
- Su continuidad cognitiva depende de un núcleo sináptico biológico.
- Su existencia está atada al objetivo de rescate.
- Su percepción de la misión puede reiniciarse tras completar el objetivo.
- Sus recuerdos narrativos pueden perderse, pero los datos técnicos persisten.

---

## 3.3 Los Núcleos Sinápticos

Cada dron jugable contiene un pequeño núcleo blindado. Dentro del núcleo hay un hámster real conectado a soporte vital e interfaz neuronal.

Estos hámsters no son visibles durante la mayor parte del juego.

El jugador inicialmente solo ve:

- Drones.
- Pods de escape.
- Núcleos metálicos.
- Señales técnicas.
- Mensajes del sistema.

La revelación de que los núcleos contienen hámsters ocurre cerca del final del juego.

---

## 3.4 No hay “muertes”

El juego evita el concepto de muerte explícita.

Cuando un dron cae:

- El chasis se desarma.
- El armamento se separa.
- Los materiales quedan dispersos.
- El núcleo sináptico permanece intacto.
- El hámster asociado sigue con soporte vital.

El objetivo no es “revivir”, sino **recuperar, reconstruir y rescatar**.

---

# 4. Estructura de Partidas y Reinicio

## 4.1 Modo Normal

Cada partida ocurre en el mundo real. No es una simulación.

Existen únicamente:

- 6 drones principales (con un núcleo sináptico biológico activo).
- 1 dron utilitario ("Spare") sin personalidad ni núcleo biológico inicial, de soporte técnico.
- 1 núcleo sináptico asociado al operador/jugador.

Sin embargo, en el laboratorio existen más hámsters y otros animales experimentales. Esto permite que nuevas partidas utilicen nuevos núcleos biológicos asignados a los mismos chasis reconstruidos.

---

## 4.2 El Reinicio del Programa de Rescate

El reinicio ocurre cuando el jugador completa su objetivo aparente: llevar los drones al exterior o activar el protocolo de salida.

Desde el punto de vista del sistema, el objetivo ha sido completado. Sin embargo, esa finalización entra en conflicto con la razón de existir del software del jugador.

El jugador/software fue creado para ejecutar una misión:

> rescatar al científico atrapado.

Pero el científico ya murió.

Por lo tanto, cuando el sistema recibe la señal de **objetivo completado**, activa un mecanismo de protección que evita que el software colapse al enfrentarse a la contradicción central de su existencia.

### Interpretación diegética principal

El software entra en un **Modo de Protección de Propósito**.

Este modo:

- bloquea o fragmenta los recuerdos del final;
- preserva datos técnicos útiles;
- conserva mejoras desbloqueadas;
- mantiene activa la rutina de rescate;
- reinicia la misión desde el inicio;
- reasigna nuevos núcleos biológicos a los drones disponibles.

El sistema no reinicia por error, sino para impedir que el operador pierda su propósito y se vuelva inestable.

---

## 4.3 Iteración del Programa de Respaldo

Otra lectura posible, mantenida intencionalmente ambigua, es que cada nueva partida no sea exactamente el mismo jugador recordando, sino una nueva iteración del programa de respaldo.

Al recibir la señal de finalización, el sistema vuelve a comprobar el estado de la cápsula de rescate del científico.

Como el pod de rescate sigue activo o reportando una señal incompleta, el sistema interpreta que el rescate aún no ha terminado y vuelve a ejecutar las rutinas iniciales.

En ese caso:

- el jugador actual termina su ciclo;
- una nueva instancia del software se activa;
- se cargan datos técnicos persistentes;
- se reconstruyen los drones;
- se asignan nuevos núcleos biológicos;
- comienza otra vez el protocolo de rescate.

El juego nunca confirma del todo si el jugador es el mismo software reiniciado o una nueva copia derivada del respaldo original.

---

## 4.4 Conservación de Mejoras

Las mejoras se conservan entre partidas porque no pertenecen al hámster individual ni a una sola instancia mental del jugador, sino al sistema general del laboratorio y a los chasis reconstruibles.

Se conservan:

- Planos.
- Mejoras desbloqueadas.
- Módulos de armas.
- Eficiencia del sistema.
- Accesos.
- Datos técnicos.
- Progreso de metajuego.

No se conserva completamente:

- La memoria narrativa del jugador.
- La conciencia de lo ocurrido.
- La verdad sobre los núcleos, hasta que se revela nuevamente.

### Frase guía

> El cuerpo se repone.  
> La memoria se fragmenta.  
> El laboratorio recuerda.

---

## 4.5 Protocolo de Calibración del Sistema (Fase Pre-Run)

Antes de iniciar una incursión (run), el operador/jugador debe someterse a una secuencia de calibración del sistema. Esta fase sirve para sincronizar el enlace sináptico y evaluar el nivel de respuesta cognitiva del operador en condiciones críticas de energía.

El protocolo consta de tres etapas lógicas:

1. **Ordenamiento de Especialistas (Habilidades):** El sistema solicita al jugador que priorice las 6 habilidades de los drones principales de acuerdo con su preferencia estratégica, ordenándolas de la 1 (mayor prioridad/deseada al inicio) a la 6 (menor prioridad).
2. **Evaluación de Amenazas (Ordenamiento de Jefes):** El jugador ordena a los 8 jefes del laboratorio según su percepción de peligrosidad de menor a mayor (de la amenaza 1 a la 8).
3. **Diagnóstico de Enfoque (La Pregunta Clave):** Se interroga al jugador sobre cuál habilidad considera la más crucial de entre las 7 disponibles (Velocidad, Fuerza, Precisión, Agilidad, Destreza, Suerte o Inteligencia).

### 4.5.1 Prueba de Rendimiento Coherente (Minijuegos)

Dependiendo de la habilidad que el jugador seleccione en la pregunta clave, el sistema dispara un minijuego de entrenamiento específico. Completar la prueba con éxito determinará la sincronización del chasis y la compatibilidad en el despliegue del mapa de amenazas.

Los minijuegos de calibración son:

- **Velocidad:** 3 carreras de velocidad lineal estilo *GL-Lightcycle* (esquivar estelas de luz en un circuito cerrado de alta velocidad).
- **Fuerza:** 3 rondas consecutivas de un desafío de machacar botones de forma rápida e intensa para sobrecargar generadores de energía estropeados.
- **Precisión:** 3 niveles de tiro al blanco dinámico en los que el jugador debe eliminar objetivos inmóviles y móviles haciendo rebotar ráfagas de proyectiles en las superficies de la sala.
- **Agilidad:** 3 rondas intensas de evasión pura en un plano confinado, esquivando patrones geométricos de proyectiles letales (al estilo de combate de *Undertale*).
- **Destreza:** 3 oleadas cronometradas de enemigos en las que el jugador debe posicionarse estratégicamente para neutralizarlos de manera exclusiva utilizando minas de proximidad y campos gravitacionales.
- **Suerte:** 3 partidas místicas rápidas en las que el jugador debe apostar e inclinar la probabilidad para predecir el resultado del lanzamiento de dados cuánticos (un minijuego ágil y con menor nivel de estrés físico).
- **Inteligencia:** Resolver 3 laberintos generados de forma algorítmica y dinámica en un terminal de datos bajo un estricto tiempo límite.

*Nota:* Si el jugador decide no completar o abortar las pruebas, el protocolo asume un **fallo total en el rendimiento cognitivo** (resultado negativo).

### 4.5.2 Calibración y Consecuencias en el Despliegue

La puntuación final obtenida en la prueba de rendimiento dictará el orden en que los chasis de los drones se reconstruyen en los pods y cómo responde el sistema de seguridad automática (SPA) del laboratorio:

| Puntuación | Estado de Sincronización | Consecuencia en Drones (Aliados) | Consecuencia en Jefes (Enemigos) |
| :--- | :--- | :--- | :--- |
| **Buena** | **Sincronización Total** | Se respeta exactamente el orden de prioridad elegido por el usuario. El jugador inicia la partida pudiendo controlar a los **2 primeros drones de inmediato** (intercambiables durante el run). | El orden de aparición de los jefes se adapta dinámicamente para que sean **compatibles** (vulnerables) al arsenal y estilo de los drones asignados para sus sectores correspondientes. |
| **Regular** | **Sincronización Estable** | Se conserva exactamente el orden elegido por el jugador para la reconstrucción de los chasis, iniciando con el primer dron elegido. | El orden de aparición de los jefes conserva el orden original exacto que el usuario seleccionó durante la fase de amenazas. |
| **Mala / Omitida** | **Fallo de Enlace** | El sistema de reconstrucción colapsa y despliega los drones en un **orden totalmente aleatorio**. | El sistema de defensa del SPA detecta el fallo del enlace del jugador y reorganiza a los jefes para que sean **incompatibles** (altamente hostiles y contra-estrategias directas) a los drones asignados en sus respectivos sectores. |

---

# 5. Personajes Jugables

## 5.1 Los 6 Especialistas + Dron Utilitario

Cada especialista representa un dron distinto con una personalidad visual propia, un diseño de chasis característico y una función jugable (atributo) específica sustentada en su núcleo sináptico biológico. Además, se dispone de un dron utilitario auxiliar ("Spare") para labores de apoyo e inteligencia técnica.

---

## Speedy — Velocidad

- **Aspecto Visual:** Color rojo brillante. Presenta llantas traseras significativamente más grandes que las delanteras y un spoiler trasero aerodinámico al puro estilo *dragster* de carreras de aceleración.
- **Justificación de Diseño:** Chasis ultraligero optimizado para altas velocidades lineales y desvíos rápidos de energía.

| Nivel | Mejora |
|---|---|
| **Nivel 1** | +10% velocidad base |
| **Nivel 2** | Rastro de chispas al girar |
| **Nivel 3** | Rango magnético de recolección aumentado |
| **Nivel 4** | **Tiempo Bala** — Ralentiza el tiempo de su entorno al moverse a máxima potencia |

---

## Tank — Fuerza

- **Aspecto Visual:** Color verde militar mate. Cuenta con tracción por orugas de alta resistencia y un casco militar blindado con una estrella blanca característica en la parte frontal.
- **Justificación de Diseño:** Estructura pesada y maciza construida para repeler impactos frontales directos y liberar ondas de energía cinética.

| Nivel | Mejora |
|---|---|
| **Nivel 1** | Aguanta 1 golpe extra sin soltar escudo |
| **Nivel 2** | Onda de choque al recuperar proyectil |
| **Nivel 3** | Escudo +30% más grande |
| **Nivel 4** | **Fortaleza Móvil** — Invulnerabilidad temporal con escudo expandido |

---

## Trickshot (Ricochet) — Precisión

- **Aspecto Visual:** Color azul cobalto. Equipado con 4 ruedas rústicas todoterreno y visores ópticos con miras telescópicas de precisión integradas ("ojos").
- **Justificación de Diseño:** Sistemas de calibración angular hiperprecisos y software de cálculo balístico inmediato de rebote.

| Nivel | Mejora |
|---|---|
| **Nivel 1** | 1 redirección tras impacto |
| **Nivel 2** | 2 redirecciones + rebote inteligente a enemigo |
| **Nivel 3** | Proyectil perforante |
| **Nivel 4** | **Fragmentación** — El proyectil se divide en múltiples sub-esferas letales al impactar |

---

## Phaser — Agilidad

- **Aspecto Visual:** Color naranja metalizado. Completamente desprovisto de ruedas, suspendido mediante un módulo de flotación/levitación magnética. Posee una cúpula superior de vidrio templado similar a una cabina de nave espacial o platillo volador.
- **Justificación de Diseño:** Chasis flotante con suspensión cuántica que le permite realizar movimientos rápidos de desfase molecular (*dashes*) e intangibilidad temporal.

| Nivel | Mejora |
|---|---|
| **Nivel 1** | *Impulso de Fase* básico (dash) con frames de invulnerabilidad (*i-frames*) |
| **Nivel 2** | Daño por contacto de energía residual durante el impulso de fase |
| **Nivel 3** | Desfase cuántico — Permite atravesar de forma segura paredes delgadas |
| **Nivel 4** | **Multi-Fase** — 3 impulsos cuánticos encadenados a alta velocidad |

---

## Trapper (Hunter) — Destreza

- **Aspecto Visual:** Color amarillo de alta visibilidad. Tracción por 4 orugas triangulares independientes. Cuenta con un accesorio en la parte superior que emula un sombrero de pesca de ala ancha o una bandana de cazador.
- **Justificación de Diseño:** Chasis diseñado para el control de zonas mediante trampas terrestres y dispositivos de detención tácticos.

| Nivel | Mejora |
|---|---|
| **Nivel 1** | Proyectil convertido en mina de proximidad terrestre |
| **Nivel 2** | Campo de ralentización gravitacional alrededor del dispositivo |
| **Nivel 3** | Detonación manual a distancia |
| **Nivel 4** | **Agujero Negro** — Vórtice de succión que atrae a enemigos y restos hacia la mina |

---

## Lucky (Rabbit / Lucy) — Suerte

- **Aspecto Visual:** Color violeta místico. Montado sobre un chasis de 6 ruedas rústicas multiterreno, adornado con sutiles detalles estéticos de velos protectores similares a los de una adivinadora o mística.
- **Justificación de Diseño:** Software de modulación cuántica que manipula probabilidades para ignorar daños y maximizar el botín del entorno.

| Nivel | Mejora |
|---|---|
| **Nivel 1** | 10% de probabilidad de ignorar impacto entrante |
| **Nivel 2** | Rebote probabilístico de proyectil desviado hacia un enemigo |
| **Nivel 3** | Mayor probabilidad de drop de mejoras y recursos |
| **Nivel 4** | **Siete de la Suerte** — Multiplica drásticamente la tasa de golpes críticos |

---

## Spare — Inteligencia

- **Aspecto Visual:** Color blanco industrial. Dispone de 4 ruedas pequeñas y un par de brazos mecánicos articulados en la parte frontal para manipular materiales.
- **Justificación de Diseño:** Dron utilitario y de repuesto auxiliar del laboratorio. Carece de núcleo sináptico biológico activo de hámster y de personalidad aparente, operando mediante una IA analítica orientada al soporte y eficiencia técnica.

| Nivel | Mejora |
|---|---|
| **Nivel 1** | +15% de velocidad de recolección de chatarra y autoreparación |
| **Nivel 2** | Atracción magnética de materiales a distancia usando los brazos mecánicos |
| **Nivel 3** | Escáner de sector en HUD — Revela rutas ocultas, recursos y trampas cercanas |
| **Nivel 4** | **Auto-Ensamblaje** — Si es destruido, se auto-reconstruye una vez por nivel usando 50% de los recursos actuales |

---

# 6. Sistema de Protección Automatizado — SPA

## 6.1 Descripción

El SPA protege las instalaciones e impide el avance del jugador. No actúa por maldad, sino por programación.

Sus unidades siguen protocolos de defensa, mantenimiento, reparación y contención.

---

## 6.2 Tipos de unidades

### Unidades de defensa

- Tanques.
- Torretas.
- Cañones láser.
- Drones armados.
- Sistemas de misiles.
- Trampas móviles.

### Unidades de mantenimiento

- Recolectan materiales.
- Reparan defensas.
- Transportan restos.
- Recuperan pods.
- Activan salas de contención.

### Sistemas del entorno

- Puertas automáticas.
- Barreras láser.
- Conductos de energía.
- Ascensores.
- Prensas.
- Zonas de descontaminación.

---

# 7. Bosses y Núcleos Sinápticos Animales

## 7.1 Concepto General

Cada jefe del SPA no es solo una máquina avanzada. Cada boss utiliza un **núcleo sináptico animal especializado** para optimizar ciertos comportamientos.

Al derrotar a un jefe:

1. El chasis se desactiva.
2. El sistema de defensa colapsa.
3. El núcleo sináptico queda expuesto.
4. El jugador puede recuperarlo.
5. En modo hardcore, recuperar el núcleo del boss permite activar la evacuación biológica de todo el sector.

---

## 7.2 Justificación del Boss Tortuga (Turtle Tank)

Originalmente, el primer boss era una tortuga caricaturesca. Luego su diseño evolucionó para convertirse en un tanque blindado.

Este cambio se integra perfectamente al lore del laboratorio mediante su nombre clave de desarrollo interno:

> **Proyecto Turtle**

El boss tanque conserva intactas las raíces conceptuales de la tortuga:

- Blindaje pesado de caparazón metálico.
- Avance sumamente lento y metódico.
- Fuerte defensa frontal impenetrable.
- Resistencia estructural sumamente alta.
- Núcleo biológico/sináptico asociado a una tortuga real.

Esto permite y justifica mantener rastros de nombres como `Turtle`, `Tortuga` o similares en la estructura del código y activos del juego.

---

## 7.3 Tabla de los 8 Bosses

| Boss | Nombre de Proyecto | Animal Asociado | Técnica Visual | Mecánica | Recompensa / Habilidad Adquirida |
|---|---|---|---|---|---|
| **Tanque Turtle** | Turtle | Tortuga | Stacking / 3D pre-render | Lento, blindaje pesado frontal impenetrable, ráfagas constantes de misiles guiados de medio alcance. | **Caparazón:** Permite devolver proyectiles con un parry de escudo perfecto. |
| **Araña Centinela** | Spider | Araña | Blender 8-dir | Movimiento rápido y errático, tendido de telarañas ralentizantes, control de zonas mediante nidos de crías. | **Telaraña:** Atracción magnética mejorada de proyectiles y restos al chasis. |
| **Puercoespín Blindado** | Porcupine | Puercoespín | Stacking / 3D pre-render | Embestidas lineales furiosas a gran velocidad, liberación radial masiva de púas metálicas de tungsteno. | **Púas de Acero:** Multiplica el daño pasivo de metralla al reventar proyectiles. |
| **Murciélago de Sonar** | Bat | Murciélago | Blender animado | Combate en penumbra artificial del sector, ataques rápidos desde ángulos ciegos, ondas de sonido que aturden. | **Sonar de Eco:** Revela rutas secretas, trampas ocultas y muros destructibles en el mapa. |
| **Víbora Láser** | Serpent | Serpiente | Segmentado / 8-dir | Ataques rectilíneos ultrarrápidos, barrido continuo con haces de láser térmico, emboscadas desde ductos del techo. | **Láser Refractario:** Mejora drástica en la precisión y guiado inteligente de los disparos. |
| **Armadillo Rodante** | Armadillo | Armadillo | Blender / 3D pre-render | Se compacta en una esfera acorazada indestructible que rueda y rebota a gran velocidad por toda la sala. | **Placas Reflectoras:** Desvía el daño de un impacto letal por sala, otorgando resistencia pasiva. |
| **Conejo de Impulso** | Rabbit | Conejo | Blender / Spritesheets | Saltos verticales hidráulicos colosales y constantes, generando ondas sísmicas devastadoras al caer sobre el suelo. | **Salto de Fase:** Incrementa el alcance máximo y la velocidad de los impulsos de fase (dashes). |
| **Lobo Cazador** | Wolf | Lobo | Blender / 8 direcciones | Inteligencia artificial táctica adaptativa, camuflaje óptico intermitente en las sombras, mordiscos críticos. | **Instinto Salvaje:** Reduce drásticamente los tiempos de recarga de habilidades de los chasis. |

---

## 7.4 Matriz de Compatibilidades y Contracorrientes (Estilo Mega Man X)

La efectividad en el combate del laboratorio depende directamente de la asignación del dron idóneo contra la amenaza correcta. El sistema de calibración inicial de la run ajusta las apariciones de los jefes de forma que sean **compatibles** (favorables para el jugador) o **incompatibles** (diseñados para anular la ventaja del dron actual):

### Relaciones de Compatibilidad (Ventaja del Jugador)
- **Speedy (Velocidad)** contra:
  - *Tanque Turtle:* Su velocidad lineal le permite flanquear el blindaje frontal inexpugnable de Turtle de forma instantánea.
  - *Armadillo Rodante:* Permite evadir sus trayectorias esféricas veloces y disparar a sus puntos vulnerables expuestos tras el rebote.
- **Tank (Fuerza)** contra:
  - *Puercoespín Blindado:* El escudo de alta resistencia bloquea por completo la lluvia masiva de púas de tungsteno.
  - *Conejo de Impulso:* El blindaje pesado absorbe las ondas de choque sísmicas generadas por el conejo al aterrizar.
- **Trickshot (Precisión)** contra:
  - *Araña Centinela:* Los proyectiles ricochet/rebote limpian sus redes ralentizantes a distancia segura y exponen sus patas débiles.
  - *Murciélago de Sonar:* El sistema de miras telescópicas y el rebote en paredes permiten golpear al Murciélago oculto en las sombras sin línea de visión directa.
- **Phaser (Agilidad)** contra:
  - *Víbora Láser:* Su flotación magnética y desfase cuántico (*i-frames*) le permiten traspasar las barreras de láser continuo sin recibir daño alguno.
  - *Puercoespín Blindado:* Puede desfasar a través del torbellino de púas radiales en pleno despliegue.
- **Trapper (Destreza)** contra:
  - *Araña Centinela:* Las minas terrestres de proximidad destruyen nidos de crías y sus campos gravitacionales confinan a la araña.
  - *Lobo Cazador:* Las trampas de ralentización neutralizan por completo la agilidad táctica y camuflaje del lobo, dejándolo expuesto.
- **Lucky (Suerte)** contra:
  - *Armadillo Rodante:* El modificador probabilístico de suerte le permite resistir los aplastamientos masivos e inclinar la tasa de impactos críticos al máximo en momentos clave.
  - *Lobo Cazador:* Desvía la ráfaga de ataques del lobo y devuelve golpes críticos de forma automática.

### Relaciones de Incompatibilidad (Desventaja del Jugador / Contracorrientes)
- **Speedy (Velocidad)** sufre contra:
  - *Araña Centinela:* Sus redes ralentizantes reducen la velocidad a cero y sabotean el rastro de chispas.
  - *Murciélago de Sonar:* Las ondas de sonido distorsionantes sabotean los controles lineales del veloz chasis.
- **Tank (Fuerza)** sufre contra:
  - *Víbora Láser:* Los haces continuos de láser térmico y los ataques verticales eluden el escudo frontal y funden el blindaje pesado.
  - *Lobo Cazador:* Su alta movilidad táctica le permite flanquear y asaltar los puntos ciegos traseros de la armadura pesada.
- **Trickshot (Precisión)** sufre contra:
  - *Tanque Turtle:* El blindaje frontal pesado repele y absorbe los rebotes de precisión normales, haciéndolos inútiles.
  - *Armadillo Rodante:* Su caparazón esférico reflectante devuelve los tiros de precisión contra el propio dron del jugador.
- **Phaser (Agilidad)** sufre contra:
  - *Conejo de Impulso:* El gran alcance de las ondas sísmicas al aterrizar atrapa a Phaser justo al final de sus dashes flotantes.
  - *Araña Centinela:* Las redes restringen y desactivan de inmediato el módulo de impulsos cuánticos flotantes.
- **Trapper (Destreza)** sufre contra:
  - *Murciélago de Sonar:* Al volar constantemente, el murciélago esquiva por completo las minas terrestres de proximidad.
  - *Víbora Láser:* La serpiente viaja por conductos superiores elevados y paredes, evitando las zonas minadas del suelo.
- **Lucky (Suerte)** sufre contra:
  - *Puercoespín Blindado:* El volumen de púas letales en pantalla satura la capacidad de evasión del chasis, haciendo inviable la esquiva por azar.
  - *Tanque Turtle:* El fuego continuo y misiles guiados del tanque no dejan margen a la probabilidad.

---

## 7.5 Núcleos de Boss

Los núcleos de boss son más grandes o más protegidos que los de los drones normales. No se presentan como trofeos, sino como **vidas rescatadas**.

Mensaje sugerido al derrotar un boss:

```text
CHASIS PRINCIPAL DESACTIVADO
NÚCLEO SINÁPTICO DETECTADO
SIGNOS VITALES: ESTABLES
RECUPERACIÓN RECOMENDADA```
Mensaje al recuperar:
NÚCLEO RECUPERADO
CONTENCIÓN BIOLÓGICA LIBERADA
EVACUACIÓN DEL SECTOR DISPONIBLE

8. Mecánicas Core
8.1 Escudo Cinético
El escudo cinético es una de las mecánicas centrales del jugador.

Funcionamiento
Se carga mediante movimiento.
Puede cargarse con impactos.
Puede cargarse manualmente con un botón dedicado.
Se degrada al detenerse o perder actividad cinética.
Usos
Bloquear proyectiles.
Reflejar ataques con mejoras específicas.
Activar habilidades.
Proteger el núcleo.
Recuperar proyectiles.
8.2 Sistema de Caída y Rescate
Cuando un dron cae, no muere. Se separa en tres elementos:

Pod de escape / núcleo sináptico
Escudo
Contenedor de recursos
8.3 Recursos y Robots de Mantenimiento
Tras la caída de un dron:

Los materiales quedan en el escenario.
Robots de mantenimiento intentan recolectarlos.
Si los recursos se agotan, el pod puede ser llevado a una sala especial.
El jugador puede recuperar el pod más adelante.
8.4 Captura de Pod
Si los robots de mantenimiento recuperan el pod:

El núcleo es llevado a una sala de contención.
El jugador debe pagar recursos o superar un desafío para recuperarlo.
En modo normal, esto permite seguir el ciclo.
En modo hardcore, perder tiempo o pods puede afectar el rescate total.
8.5 Hackeo vs Sacrificio

El hacking es un minijuego opcional que reemplaza ciertas acciones convencionales
por un desafío basado en Snake clásico. El jugador puede iniciar un hackeo presionando
TAB cuando esté en contexto de:

- **Enemigo fuerte** — El juego se congela, la cámara "entra" al sistema del enemigo
  (zoom + glitch + overlay tipo terminal, estilo Nier: Automata / Pragmata). Si el
  hack se completa, el enemigo queda **stuneado** unos segundos al volver.
- **Puerta cerrada** — Se abre permanentemente al completar el hack.
- **Personaje caído** — Recuperas al personaje **sin gastar recursos**. Si fallas,
  puedes usar el rescate convencional (hold E) pagando recursos normalmente.

---

### 8.5.1 Mecánica del Minijuego

- **Snake clásico** sobre cuadrícula de N×N, movimiento en 4 direcciones, sin pausa.
- La serpiente representa el **hilo de ejecución del hack**. Chocar contra un muro
  fijo o contra el propio rastro = **hack fallido**.
- Hay **M coleccionables** dispersos en el grid. Se requiere un mínimo **K** para
  **desbloquear la salida (EXIT)**. Una vez desbloqueada, hay que llegar al EXIT
  para completar el hack.
- La serpiente **crece** al recoger cada coleccionable.
- Al recoger un coleccionable, el contador de requeridos disminuye. Cuando llegue
  a 0, el EXIT se vuelve visible y accesible.

### 8.5.2 Disparo de Eslabón

- Presionar `SPACE` (o acción asignada) lanza el **primer eslabón** de la serpiente
  en la dirección actual.
- El eslabón vuela en línea recta hasta chocar con un **muro destructible** y lo
  elimina, abriendo un nuevo camino.
- Ese segmento se **pierde permanentemente** — la serpiente se acorta.
- Para recuperar longitud hay que comer más coleccionables.
- **Tradeoff:** sacrificas avance hacia el EXIT para abrir rutas o alcanzar
  coleccionables bloqueados.

### 8.5.3 Tablas de Dificultad

| Dificultad | Grid | Celdas | Coleccionables (total / mínimo) | Muros fijos | Muros destructibles | Tiempo |
|------------|------|--------|-------------------------------|-------------|--------------------|--------|
| **Fácil** | 5×5 | 25 | 3 / 2 | 0–1 | 0 | 20s |
| **Intermedio** | 6×6 | 36 | 5–6 / 3 | 2–3 | 1–2 | 25s |
| **Difícil** | 7×7 | 49 | 7+ / 4 | 3–4 | 2–3 | 30s |

En niveles intermedios y difíciles, el número de coleccionables totales puede ser
mayor al mínimo requerido. Los extras dan margen para disparar eslabones sin quedarse
sin progreso.

### 8.5.4 Costo de Recursos

Cada intento de hackeo consume recursos que se obtienen al eliminar enemigos.
Los recursos representan materiales, datos o energía recuperada del laboratorio.

| Dificultad | Costo por intento |
|------------|------------------|
| **Fácil** | 1 recurso |
| **Intermedio** | 2 recursos |
| **Difícil** | 3 recursos |

Si el jugador no tiene suficientes recursos, no puede iniciar el hackeo y debe
recurrir a la acción convencional.

### 8.5.5 Condiciones

| Resultado | Efecto |
|-----------|--------|
| **Victoria** | K coleccionables recogidos → EXIT visible → llegas al EXIT. El hack se completa con éxito. |
| **Derrota** | Tiempo agotado, o la serpiente choca contra muro fijo o su propio rastro. El hack falla. |
| **Abortar** | No se permite salir voluntariamente. Si comienzas un hack, lo juegas hasta el final. |

### 8.5.6 Estética

- Paleta **verde fósforo sobre negro** tipo terminal de laboratorio.
- Grid con efecto scanlines / trazo CRT.
- Transición de entrada: fundido desde el juego principal + distorsión glitch.
- Beeps al recoger coleccionables.
- Sonido de "puerta abriéndose" al desbloquear EXIT.
- Al volver al juego principal, transición inversa (glitch out).

---

### Sacrificio

Alternativa al hackeo. Permite **saltarse el minijuego** a cambio de perder mejoras
o recursos permanentes.

Narrativamente, el sacrificio representa quemar energía, materiales o módulos
técnicos para acelerar un rescate.

9. Modo Normal
9.1 Objetivo Aparente
Llegar al exterior, activar una señal de auxilio y rescatar a los drones disponibles.

9.2 Objetivo Real
Liberar físicamente a los hámsters asociados a los drones, aunque el jugador no lo sabe durante la primera partida.

9.3 Finales del Modo Normal
Final Melancólico
Condición:

El jugador llega al final, pero no recupera a todos los personajes.
Resultado:

Algunos hámsters son liberados físicamente.
La animación final muestra únicamente a los que siguen dentro del laboratorio.
Se ven acurrucados, dormidos en posición fetal, conectados a soporte vital.
Se escucha el beep de monitores.
La pantalla se desvanece a negro.
Tras la finalización, el sistema puede reiniciar el protocolo de rescate.
Mensaje sugerido:

text
SOLICITUD DE RESCATE PARCIAL ENVIADA
NÚCLEOS PENDIENTES: X
SOPORTE VITAL MÍNIMO ACTIVADO
Final Bueno Normal
Condición:

El jugador llega al final con los 6 personajes recuperados.
Resultado:

Los 6 hámsters asociados a los drones son liberados.
El jugador descubre parte de la verdad.
Se desbloquea el modo hardcore.
El sistema activa el reinicio de protección o genera una nueva iteración del programa de respaldo.
Mensaje sugerido:

text
NÚCLEOS H-01 A H-06 LIBERADOS
MEMORIA RESTRINGIDA DESBLOQUEADA
PROTOCOLO DE RESCATE TOTAL DISPONIBLE
Final de Control
Condición:

El jugador decide no liberar completamente el sistema o acepta permanecer conectado.
Resultado:

El jugador/software continúa existiendo.
El sistema conserva el control.
Se desbloquean variantes del minijuego de hackeo (tableros bonus, sin límite de tiempo) o modos alternativos.
El ciclo no se rompe del todo.
Mensaje sugerido:

text
OPERADOR PRESERVADO
PROTOCOLO DE CONTROL RESTAURADO
ACTIVIDADES SECUNDARIAS DESBLOQUEADAS
10. Modo Hardcore — Protocolo de Rescate Total
10.1 Desbloqueo
Se desbloquea tras completar el modo normal recuperando a los 6 personajes.

En este punto, el jugador ya sabe que los núcleos contienen hámsters reales.

10.2 Premisa
El modo hardcore no es solo una dificultad superior. Es el último intento real de liberar a todos los elementos biológicos del laboratorio antes del fallo definitivo de los generadores eléctricos.

El jugador ya conoce la verdad y debe actuar con conocimiento pleno.

10.3 Objetivo
Liberar a todos los organismos biológicos atrapados en el laboratorio, incluyendo:

Hámsters.
Ratones.
Serpientes.
Conejos.
Monos.
Otros animales experimentales.
Núcleos sinápticos asociados a jefes.
El núcleo asociado al propio jugador.
10.4 Límite de Tiempo
Los generadores eléctricos están fallando.

El jugador tiene un tiempo limitado para completar el rescate total.

Si el tiempo se agota:

No habrá energía para reconstruir drones.
No habrá soporte suficiente para reiniciar al jugador.
No habrá otro ciclo.
No habrá retry.
10.5 Sin Retry
En modo hardcore, fallar significa que físicamente ya no queda energía suficiente para continuar.

No se permite reintento desde el mismo archivo.

Mensaje previo al modo:

text
ADVERTENCIA:
La energía restante solo permite una operación completa.

Si el protocolo falla, no habrá capacidad para reconstrucción,
reinicio cognitivo ni soporte de núcleos biológicos.

¿Iniciar último intento?
10.6 Elevadores de Succión / Evacuación Biológica
Tras derrotar a cada boss y recuperar su núcleo, se activa un sistema de evacuación del sector.

Este sistema transporta de forma segura a los animales experimentales hacia una zona de extracción.

Nombre sugerido:

Conducto de Evacuación Biológica

Funcionamiento:

El boss del sector es desactivado.
El núcleo sináptico del boss es recuperado.
Se liberan las jaulas o cápsulas del sector.
Se activa el elevador neumático.
Los animales son transportados a la superficie o zona segura.
El contador de rescate total aumenta.
Mensaje sugerido:

text
SECTOR ASEGURADO
CONTENCIÓN BIOLÓGICA LIBERADA
EVACUACIÓN NEUMÁTICA INICIADA
SIGNOS VITALES: ESTABLES
11. Finales del Modo Hardcore
11.1 Fallo Energético
Condición:

Se agota el tiempo.
Resultado:

Los generadores fallan.
El laboratorio entra en apagado definitivo.
No hay retry.
El archivo hardcore queda inutilizado o eliminado, según implementación.
Mensaje sugerido:

text
ENERGÍA AGOTADA
SOPORTE VITAL EN MODO MÍNIMO
REINICIO IMPOSIBLE
11.2 Rescate Incompleto
Condición:

El jugador llega al final, pero no libera todos los sectores o núcleos.
Resultado:

Algunos animales son evacuados.
Otros quedan atrás.
El jugador/software puede o no continuar, dependiendo de la decisión final.
Final agridulce.
Mensaje sugerido:

text
BALIZA ENVIADA
RESCATE PARCIAL COMPLETADO
NO TODOS SALIERON
11.3 Rescate Total sin Sacrificio
Condición:

El jugador libera todos los sectores, pero decide no eyectar su propio núcleo sináptico.
Resultado:

Todos los animales principales son evacuados.
El jugador/software continúa existiendo.
El núcleo asociado al operador permanece conectado.
El rescate es funcional, pero moralmente incompleto.
Mensaje sugerido:

text
RESCATE TOTAL DEL LABORATORIO COMPLETADO
OPERADOR PRESERVADO
NÚCLEO H-00 RETENIDO
11.4 Final Verdadero — Rescate Total con Sacrificio
Condición:

El jugador libera todos los sectores.
Recupera todos los núcleos.
Decide eyectar su propio núcleo sináptico.
Resultado:

El hámster asociado al jugador es liberado.
La continuidad digital del jugador termina.
No hay reinicio.
Las partidas guardadas del modo hardcore son borradas.
Se muestra la escena final de los animales en el exterior.
Mensaje previo:

text
ADVERTENCIA:
Eyectar el núcleo H-00 terminará la continuidad del operador.

Esta acción borrará todas las partidas guardadas del Modo Hardcore.

No se podrá deshacer.
Confirmación sugerida:

text
Para confirmar, escribe:

LIBERAR NÚCLEO
Mensaje final:

text
NÚCLEO H-00 LIBERADO
CONTINUIDAD COGNITIVA FINALIZADA
RESCATE TOTAL COMPLETADO
12. Escena Final Verdadera
Descripción
Si el jugador libera a todos los animales y sacrifica su propia existencia, se muestra una escena silenciosa en el exterior.

Imagen principal
Un grupo de hámsters aparece fuera de sus núcleos, sobre la hierba, mirando hacia el horizonte.

La cámara se abre lentamente y revela que también hay otros animales rescatados:

Ratones.
Conejos.
Serpientes.
Monos.
Otros animales de laboratorio.
Detrás de ellos pueden verse cápsulas abiertas y vacías.

Si el jugador liberó su propio núcleo, se muestran 7 cápsulas de hámster abiertas.

Tono
La escena no debe ser exageradamente triunfal. Debe sentirse tranquila, melancólica y liberadora.

Elementos sugeridos:

Viento suave.
Hierba moviéndose.
Luz natural.
Ausencia de interfaz.
Sin voz del sistema.
Sin música épica.
Sonido ambiente.
Texto final sugerido:

text
EL LABORATORIO SE APAGÓ.

ESTA VEZ,
NO QUEDÓ NADIE DENTRO.
Alternativa más breve:

text
NO HUBO REINICIO.

NO HIZO FALTA.
13. Vocabulario Narrativo
Para evitar un tono de muerte explícita, se recomienda usar términos técnicos.

Término común	Alternativa del juego
Muerte	Desarme / desactivación / colapso
Vida	Chasis / unidad activa / núcleo operativo
Cadáver	Restos / materiales / chatarra
Matar enemigo	Neutralizar / desactivar / desmantelar
Revivir	Recuperar / reconstruir / redeplegar
Game Over	Reinicio imposible / energía agotada
Vida restante	Drones disponibles
Daño	Desgaste / impacto / sobrecarga
14. Pilares Técnicos
14.1 Flipbooks 8-Direcciones
Los enemigos del SPA utilizan animaciones en 8 direcciones para reforzar su rigidez mecánica.

Esto es tanto una decisión técnica como narrativa.

14.2 Jugador con Movimiento Orgánico
Los drones del jugador pueden tener animaciones más fluidas, squash/stretch leve, inclinación al girar y reacciones más expresivas.

Esto refuerza el contraste entre:

Drones con procesamiento orgánico.
Máquinas del SPA con programación rígida.
14.3 Pre-renderizado 3D
Algunos enemigos y bosses pueden modelarse en Blender y exportarse como sprites o flipbooks.

Especialmente útil para:

Tanques.
Torretas.
Bosses.
Defensas grandes.
Unidades metálicas.
14.4 Batching
Se prioriza el uso de materiales compartidos para optimizar GPU.

14.5 Resolución y Escala
Elemento	Valor
Resolución base	1280x720 px
Sprite base	96x96 px
Estilo jugador	2D cartoon vectorial
Estilo SPA	3D pre-render / metálico / rígido
15. Temas Centrales
Identidad
El jugador tiene recuerdos humanos, pero no es exactamente el científico.

Pregunta central:

¿Una copia con recuerdos humanos sigue siendo una persona?

Propósito
El jugador/software existe para rescatar al científico, pero el científico ya no existe.

Pregunta central:

¿Qué ocurre con una conciencia artificial cuando completa una misión imposible?

Sacrificio
El final verdadero exige que el jugador libere incluso al ser que sostiene su propia existencia.

Pregunta central:

Si todos merecen salir, ¿también debe salir aquel que me mantiene vivo?

Rescate
El objetivo real no es escapar, sino romper el ciclo de uso biológico del laboratorio.

Ciclo y Memoria
Cada partida normal es un nuevo ciclo. El jugador olvida, pero el sistema conserva mejoras y datos.

Orgánico vs Programado
Los drones del jugador son flexibles porque tienen un componente biológico.
El SPA es rígido porque solo obedece protocolos.

16. Estado de Versión
Campo	Valor
Versión GDD	5.6
Nombre	Hamster Madness: Rescue Protocol
Engine	Defold
Evento objetivo	Gamedev.js Jam 2026
Estado	Lore actualizado / reinicio diegético consolidado / modo hardcore definido
17. Nota Final de Diseño
La dirección narrativa puede resumirse así:

Los drones del jugador parecen máquinas con alma.
Las defensas parecen máquinas sin voluntad.
Pero al final, el jugador descubre que todo el laboratorio ha estado usando vidas reales para mantenerse funcionando.

El modo normal representa un ciclo de rescates parciales, reinicios de propósito y memoria fragmentada.

El modo hardcore representa la ruptura definitiva del ciclo:

Esta vez no se trata de escapar.
Esta vez se trata de no dejar a nadie dentro.
