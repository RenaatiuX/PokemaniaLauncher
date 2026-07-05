import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_routes.dart';
import 'package:pokemania_launcher/core/services/storage_service.dart';
import 'package:pokemania_launcher/core/utils/window_utils.dart';
import 'package:pokemania_launcher/features/launcher/presentation/screens/home_screen.dart';
import 'package:pokemania_launcher/features/launcher/presentation/screens/login_screen.dart';

void main() async {
  await WindowUtils.setupLauncherWindow();
await StorageService.init();
  runApp(const PokemaniaLauncherApp());
}

class PokemaniaLauncherApp extends StatelessWidget {
  const PokemaniaLauncherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = StorageService.nickname.isNotEmpty;

    return MaterialApp(
      title: 'Pokémania',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Urbanist",
      ),

      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },
    );
  }
}
