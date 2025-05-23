import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/home_view.dart';
import 'package:hola_mundo/views/settings_view.dart';
import 'package:hola_mundo/views/profile_view.dart';
import 'package:hola_mundo/views/ciclo_vida/ciclo_vida_screen.dart';

import 'package:hola_mundo/views/paso_parametros/detalle_screen.dart'
    as parametros;
import 'package:hola_mundo/views/paso_parametros/paso_parametros_screen.dart';

// Taller Async
import 'package:hola_mundo/views/taller_async/lista_estudiantes_screen.dart';
import 'package:hola_mundo/views/taller_async/contador_screen.dart';
import 'package:hola_mundo/views/taller_async/tarea_pesada_screen.dart';

// Taller API
import 'package:hola_mundo/views/taller_api/listado_screen.dart';
import 'package:hola_mundo/views/taller_api/detalle_screen.dart' as api;
import 'package:hola_mundo/models/meal_model.dart';

// Establecimientos
import 'package:hola_mundo/views/establecimientos/establecimiento_list_view.dart';
import 'package:hola_mundo/views/establecimientos/establecimiento_edit_view.dart';
import 'package:hola_mundo/views/establecimientos/establecimiento_create_views.dart';

// Autenticación
import 'package:hola_mundo/views/auth/login_page.dart';
import 'package:hola_mundo/views/auth/register_page.dart';
import 'package:hola_mundo/services/auth_service.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) async {
    final token = await AuthService().getToken();

    // Si no hay token y no está en login/register, lo manda a login
    if (token == null &&
        state.matchedLocation != '/login' &&
        state.matchedLocation != '/register') {
      return '/login';
    }

    // Si ya hay token y está en login, lo redirige al home
    if (token != null && state.matchedLocation == '/login') {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeView()),

    // Configuración
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),

    // Perfil
    GoRoute(path: '/profile', builder: (context, state) => const ProfileView()),

    // Paso de parámetros
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

    // Ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),

    // Taller async
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

    // Taller API
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

    // Establecimientos
    GoRoute(
      path: '/establecimientos',
      name: 'establecimientos',
      builder: (context, state) => const EstablecimientosListView(),
    ),
    GoRoute(
      path: '/establecimientos/edit/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return EstablecimientoEditView(id: id);
      },
    ),
    GoRoute(
      path: '/establecimientos/create',
      builder: (context, state) => const EstablecimientoCreateView(),
    ),

    //! Autenticación
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);
