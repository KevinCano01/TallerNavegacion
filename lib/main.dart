import 'package:flutter/material.dart';
import 'package:hola_mundo/routes/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura la inicialización antes de async
  await dotenv.load(); // Carga las variables desde el archivo .env

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      title: 'Flutter - UCEVA',
      routerConfig: appRouter,
    );
  }
}
