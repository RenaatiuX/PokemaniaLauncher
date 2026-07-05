import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';
import 'package:pokemania_launcher/core/constants/app_routes.dart';
import 'package:pokemania_launcher/core/services/storage_service.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/custom_title_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _translateX = 0.0;
  double _translateY = 0.0;
  final TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _translateX = (event.localPosition.dx - centerX) * -0.04;
            _translateY = (event.localPosition.dy - centerY) * -0.04;
          });
        },
        child: Stack(
          children: [
            // 1. Parallax
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(_translateX, _translateY, 0),
              child: Transform.scale(
                scale: 1.12,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/walltest.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Capa oscura contraste
            Container(color: AppColors.background.withOpacity(0.3)),

            // 2. lOgin
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: 700,
                    height: 400,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: AppColors.panelGlass,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'BIENVENIDO A POKÉMANIA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Elige cómo quieres acceder al servidor',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),

                        // Opciones ee login
                        Row(
                          children: [
                            // premium
                            Expanded(child: _buildPremiumCard()),

                            const SizedBox(width: 30),
                            Container(
                              width: 1,
                              height: 150,
                              color: AppColors.borderLight,
                            ),
                            const SizedBox(width: 30),

                            // offline
                            Expanded(child: _buildOfflineCard()),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 3. topbar
            const Align(
              alignment: Alignment.topCenter,
              child: CustomTitleBar(),
            ),
          ],
        ),
      ),
    );
  }

  //Tarjeta premium
  Widget _buildPremiumCard() {
    return Column(
      children: [
        const Icon(
          Icons.gamepad,
          color: AppColors.primaryGreen,
          size: 40,
        ), 
        const SizedBox(height: 15),
        const Text(
          'CUENTA PREMIUM',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF107C10),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text(
            'Entrar con Microsoft',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

    //Tarjeta offline
  Widget _buildOfflineCard() {
    return Column(
      children: [
        const Icon(Icons.person_outline, color: Colors.white70, size: 40),
        const SizedBox(height: 15),
        const Text(
          'CUENTA OFFLINE',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nicknameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Tu Nickname',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                if (_nicknameController.text.trim().isNotEmpty) {
                  StorageService.nickname = _nicknameController.text.trim();
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, introduce un Nickname válido.'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }
}
