import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/ciclo_vida/ciclo_vida_screen.dart';
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/paso_parametros/detalle_screen.dart'
    as parametros;
import 'package:hola_mundo/views/paso_parametros/paso_parametros_screen.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/settings_view.dart';

// Importación de las nuevas pantallas del taller async (Future, Timer e Isolate)
import 'package:hola_mundo/views/taller_async/lista_estudiantes_screen.dart';
import 'package:hola_mundo/views/taller_async/contador_screen.dart';
import 'package:hola_mundo/views/taller_async/tarea_pesada_screen.dart';

// Importación de las nuevas pantallas del taller API
import 'package:hola_mundo/views/taller_api/listado_screen.dart';
import 'package:hola_mundo/views/taller_api/detalle_screen.dart' as api;
import 'package:hola_mundo/models/meal_model.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    // Ruta principal - Página de inicio
    GoRoute(path: '/', builder: (context, state) => const HomeView()),

    // Ruta para la configuración
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),

    // Ruta para el perfil
    GoRoute(path: '/profile', builder: (context, state) => const ProfileView()),

    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detalle/:parametro/:metodoNavegacion',
      builder: (context, state) {
        final parametro = state.pathParameters['parametro']!;
        final metodoNavegacion = state.pathParameters['metodoNavegacion']!;
        return parametros.DetalleScreen(
          parametro: parametro,
          metodoNavegacion: metodoNavegacion,
        );
      },
    ),

    //! Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),

    //! Rutas del taller async (Future, Timer e Isolate)
    GoRoute(
      path: '/lista_estudiantes',
      builder: (context, state) => const ListaEstudiantesScreen(),
    ),
    GoRoute(
      path: '/contador',
      builder: (context, state) => const ContadorScreen(),
    ),
    GoRoute(
      path: '/tarea_pesada',
      builder: (context, state) => const TareaPesadaScreen(),
    ),

    //! Rutas del taller de consumo de API
    GoRoute(
      path: '/listado',
      builder: (context, state) => const ListadoScreen(),
    ),
    GoRoute(
      path: '/detalle_comida',
      builder: (context, state) {
        final meal = state.extra as Meal;
        return api.DetalleScreen(meal: meal);
      },
    ),
  ],
);
