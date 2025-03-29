
# Taller: Navegación, Widgets y Ciclo de Vida en Flutter

## Descripción
Esta aplicación en Flutter demuestra el uso de navegación con `go_router`, widgets personalizados y el ciclo de vida de un `StatefulWidget`. El proyecto incluye un ejemplo con fotos de platos típicos colombianos de un restaurante. La aplicación permite navegar entre pantallas con una cuadrícula de imágenes y un listado de platos típicos.

## Funcionalidades
- Navegación entre pantallas con `go_router`.
- Paso de parámetros de una pantalla a otra.
- Uso de `GridView` para mostrar elementos en forma de cuadrícula.
- Uso de `ListView` para mostrar imágenes de comidas colombianas.
- Evidencia del ciclo de vida del `StatefulWidget` mediante mensajes en consola.

## Ejecución
1. Clona el repositorio:
   ```bash
   git clone https://github.com/KevinCano01/TallerNavegacion.git
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

---

# Taller: Future, Timer e Isolate en Flutter

## Descripción
Este taller tiene como objetivo explorar el manejo de operaciones asíncronas en Flutter mediante el uso de `Future`, temporizadores con `Timer` y procesamiento en segundo plano con `Isolate`. La aplicación se basa en el mismo proyecto del taller anterior, integrando nuevas pantallas con funcionalidades específicas.

## Funcionalidades
- Simulación de carga de datos con `Future.delayed()` y presentación en un `ListView`.
- Implementación de un contador automático utilizando `Timer.periodic`.
- Ejecución de una tarea computacional pesada en segundo plano con `Isolate`, mostrando el resultado en un `SnackBar`.
- Verificación del ciclo de vida del widget con el uso de `mounted` antes de llamar a `setState`.

## Pantallas implementadas

### 🔹 Lista de Estudiantes
- Simula una llamada a datos con `Future.delayed`.
- Muestra un `CircularProgressIndicator` mientras carga.
- Presenta una lista de nombres en un `ListView`.

### 🔹 Contador con Timer
- Incrementa un contador automáticamente cada segundo.
- Incluye botones de control: Iniciar, Pausar y **Reiniciar.
- El contador se reinicia a 0 al presionar el botón Reiniciar.

### 🔹 Tarea Pesada con Isolate
- Ejecuta la suma de los números del 1 al 2,000,000 en un `Isolate`.
- Muestra el resultado final usando un `SnackBar`.
- Usa `mounted` para evitar errores si el usuario cambia de pantalla durante la ejecución.

## Navegación
Las nuevas pantallas fueron integradas al proyecto mediante `go_router`, y se añadieron como opciones en el menú lateral (`Drawer`) de la aplicación:

- Lista de Estudiantes (`/lista_estudiantes`)
- Contador con Timer (`/contador`)
- Tarea Pesada (Isolate) (`/tarea_pesada`)

## Ejecución
1. Clona el repositorio:
   ```bash
   git clone https://github.com/KevinCano01/TallerNavegacion.git
   ```

2. Cambia a la rama del taller:
   ```bash
   git checkout feature/future_timer_isolate
   ```

3. Instala las dependencias:
   ```bash
   flutter pub get
   ```

4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

---

# Taller: Consumo de API Pública con Flutter

## Descripción
Este taller tiene como objetivo integrar el consumo de una API pública en la aplicación Flutter. Se trabaja con la API de The Meal DB, que proporciona datos sobre recetas de comidas. Se implementan pantallas para mostrar un listado de comidas y un detalle de la comida seleccionada, utilizando `go_router` para manejar la navegación.

## Funcionalidades
- Consumo de datos desde la API de The Meal DB.
- Muestra un listado de comidas con imágenes, categorías y áreas.
- Pantalla de detalle con información completa de la comida seleccionada.
- Navegación entre pantallas utilizando `go_router`.
- Manejo de errores con mensajes amigables en caso de fallos de la conexión.

## Pantallas implementadas

### 🔹 Listado de Comidas
- Realiza una petición HTTP GET a la API para obtener los datos de las comidas.
- Muestra un `ListView.builder` con las comidas obtenidas, incluyendo imágenes y categorías.
- Mientras los datos se están cargando, se muestra un `CircularProgressIndicator`.

### 🔹 Detalle de la Comida
- Al hacer clic en un plato del listado, se navega a la pantalla de detalles.
- Muestra el nombre, la categoría, la imagen, las instrucciones y los ingredientes de la comida seleccionada.

## Navegación
Las nuevas pantallas fueron integradas al proyecto mediante `go_router`, y se añadieron como opciones en el menú lateral (`Drawer`) de la aplicación:

- Listado de Comidas (`/listado`)
- Detalle de Comida (`/detalle_comida`)

## Ejecución
1. Clona el repositorio:
   ```bash
   git clone https://github.com/KevinCano01/TallerNavegacion.git
   ```

2. Cambia a la rama del taller:
   ```bash
   git checkout feature/consumo_api_publica
   ```

3. Instala las dependencias:
   ```bash
   flutter pub get
   ```

4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```
---
