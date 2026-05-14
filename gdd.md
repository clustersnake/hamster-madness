# Hamster Madness: Rescue Protocol
## Game Design Document v5.6 — Lore, Progression & Rescue Protocol Update

---

# 1. Concepto Core

## Premisa

**Hamster Madness: Rescue Protocol** es un juego de acción / twin-stick shooter / roguelite narrativo donde el jugador cree controlar drones de rescate dentro de un laboratorio subterráneo colapsado tras un desastre natural.

La premisa aparente es simple:

> Un científico atrapado intenta usar drones especializados para alcanzar el exterior y pedir ayuda.

La realidad es más oscura:

El científico murió durante un intento fallido de transferencia neurológica. El jugador no es el científico vivo, sino una **copia parcial de sus memorias**, sostenida por el sistema del laboratorio mediante una interfaz sináptica conectada a un núcleo biológico.

Los drones del jugador no son simples máquinas: cada uno contiene un núcleo sináptico con un hámster real utilizado para agilizar reacciones, cálculos y toma de decisiones.

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
| **Evento objetivo** | Gamedev.js Jam 2026 |

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

---

## 2.2 Sistema de Protección Automatizado — SPA

Los enemigos pertenecen al **Sistema de Protección Automatizado** del laboratorio. Incluye:

- Robots de defensa.
- Tanques.
- Torretas.
- Cañones láser.
- Trampas.
- Drones centinela.
- Robots de mantenimiento.
- Sistemas de contención.

Visualmente son más fríos, mecánicos y rígidos que los drones del jugador.

### Rasgos visuales

- Formas angulares.
- Materiales metálicos.
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

Un desastre natural provoca el aislamiento del laboratorio subterráneo. El científico principal queda atrapado y herido en los niveles más profundos.

Antes de morir, intenta usar una cápsula de rescate experimental basada en transferencia neurológica. Sin embargo, el proceso falla.

Durante la conexión, el científico fallece. El sistema, incapaz de completar correctamente la transferencia, crea una copia parcial de sus memorias y la sostiene mediante un núcleo sináptico biológico.

Esa copia es el jugador.

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

- 6 drones principales.
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

# 5. Personajes Jugables

## 5.1 Los 6 Especialistas

Cada personaje representa un dron distinto, con una personalidad visual y una función jugable específica.

Aunque el jugador los percibe como personajes o “vidas”, cada uno contiene un núcleo sináptico con un hámster asociado.

---

## Speedy — Velocidad

| Nivel | Mejora |
|---|---|
| **Nivel 1** | +10% velocidad base |
| **Nivel 2** | Rastro de chispas al girar |
| **Nivel 3** | Rango magnético aumentado |
| **Nivel 4** | **Tiempo Bala** |

---

## Tank — Blindaje

| Nivel | Mejora |
|---|---|
| **Nivel 1** | Aguanta 1 golpe extra sin soltar escudo |
| **Nivel 2** | Onda de choque al recuperar proyectil |
| **Nivel 3** | Escudo +30% más grande |
| **Nivel 4** | **Fortaleza Móvil** — invulnerabilidad temporal |

---

## Trickshot — Geometría

| Nivel | Mejora |
|---|---|
| **Nivel 1** | 1 redirección tras impacto |
| **Nivel 2** | 2 redirecciones + rebote a enemigo |
| **Nivel 3** | Proyectil perforante |
| **Nivel 4** | **Fragmentación** |

---

## Lucky — Anomalía

| Nivel | Mejora |
|---|---|
| **Nivel 1** | 10% de probabilidad de ignorar impacto |
| **Nivel 2** | Rebote probabilístico de proyectil |
| **Nivel 3** | Mayor drop de mejoras |
| **Nivel 4** | **Siete de la Suerte** — críticos mejorados |

---

## Dasher — Agilidad

| Nivel | Mejora |
|---|---|
| **Nivel 1** | Dash básico con i-frames |
| **Nivel 2** | Daño por contacto durante dash |
| **Nivel 3** | Atraviesa paredes delgadas |
| **Nivel 4** | **Multi-Dash** — 3 dashes encadenados |

---

## Trapper — Táctica

| Nivel | Mejora |
|---|---|
| **Nivel 1** | Proyectil convertido en mina de proximidad |
| **Nivel 2** | Campo de ralentización |
| **Nivel 3** | Detonación manual |
| **Nivel 4** | **Agujero Negro** |

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

## 7.2 Justificación del antiguo Boss Tortuga

Originalmente, el primer boss era una tortuga. Luego su diseño evolucionó hasta convertirse en un tanque.

Este cambio se integra al lore mediante el nombre clave:

> **Proyecto Testudo**

El boss tanque conserva el concepto de tortuga:

- Blindaje pesado.
- Avance lento.
- Defensa frontal.
- Resistencia alta.
- Caparazón mecánico.
- Núcleo biológico asociado a una tortuga.

Esto permite mantener rastros del nombre `Turtle`, `Tortuga` o similares en el código como referencia interna del proyecto.

---

## 7.3 Tabla de Bosses

| Boss | Nombre de Proyecto | Animal Asociado | Técnica Visual | Mecánica | Recompensa |
|---|---|---|---|---|---|
| **Tanque Testudo** | Tortuga / Turtle | Tortuga | Stacking / 3D pre-render | Lento, blindado, ráfagas de misiles, inmune por delante | **Parry:** refleja proyectiles |
| **Araña Centinela** | Spider | Araña | Blender 8-dir | Movimiento errático, redes, control de zonas | **Telaraña:** recuperación mejorada de proyectil |
| **Puercoespín Blindado** | Porcupine | Puercoespín | Stacking / 3D pre-render | Cargas veloces, explosión radial de púas | **Púas:** daño aumentado |
| **Murciélago de Sonar** | Bat | Murciélago | Blender animado | Oscuridad, ondas sónicas, ataques desde ángulos ciegos | **Sonar:** revela rutas ocultas |
| **Víbora Láser** | Serpent | Serpiente | Segmentado / 8-dir | Ataques lineales, láseres, emboscadas por conductos | **Rayo Guiado:** mejora de precisión |
| **Primate Cognitivo** | Primate | Mono | Blender / animación avanzada | Aprende patrones, cambia estrategias | **Predicción:** mejora de puntería o reacción |

---

## 7.4 Núcleos de Boss

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
Hackeo
Permite recuperar personajes o pods perdidos mediante un minijuego.

Sacrificio
Permite saltarse el minijuego a cambio de perder mejoras o recursos permanentes.

Narrativamente, el sacrificio representa quemar energía, materiales o módulos técnicos para acelerar un rescate.

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
Se desbloquean minijuegos o modos alternativos.
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