import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';
import 'package:pokemania_launcher/features/launcher/presentation/screens/settings_screen.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/battle_pass_card.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/bottom_info_bar.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/custom_title_bar.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/play_action_panel.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/player_card.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/side_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _translateX = 0.0;
  double _translateY = 0.0;

  bool _showSettings = false;

  void _toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final centerX = screenSize.width / 2;
    final centerY = screenSize.height / 2;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MouseRegion(
        onHover: (event) {
          // Parallax solo funcionara si no esta abierto ajustes
          if (!_showSettings) {
            setState(() {
              _translateX = (event.localPosition.dx - centerX) * -0.04;
              _translateY = (event.localPosition.dy - centerY) * -0.04;
            });
          }
        },
        child: Stack(
          children: [
            // 1. Efecto parallax
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

            // 2. Contraste oscuro
            Container(color: AppColors.background.withOpacity(0.15)),

            // 3. Top bar
            const Align(
              alignment: Alignment.topCenter,
              child: CustomTitleBar(),
            ),

            // 4. Gui central
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'POKÉMANIA',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 10,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const BattlePassCard(),
                ],
              ),
            ),

            // 5. Tarjeta del jugador
            const Positioned(bottom: 30, left: 30, child: PlayerCard()),

            // 6. Info del centro
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 35),
                child: BottomInfoBar(),
              ),
            ),

            // 7. Panel que tiene algunas cosas jaja
            const Positioned(bottom: 30, right: 40, child: PlayActionPanel()),

            //8. Side bar
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: SideNavigationBar(
                onOpenSettings: _toggleSettings, 
              ),
            ),

            //9. El overlay de ajustes
            if (_showSettings) ...[
              GestureDetector(
                onTap: _toggleSettings,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: Colors.black.withOpacity(0.5)),
                ),
              ),

              //10. Container de ajustes
              Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _showSettings ? 1.0 : 0.0,
                  child: Container(
                    width: 1050,
                    height: 650,
                    decoration: BoxDecoration(
                      color: AppColors.panelDark,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: SettingsScreen(
                      onClose: _toggleSettings, 
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
