import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';

class PlayActionPanel extends StatefulWidget {
  const PlayActionPanel({super.key});

  @override
  State<PlayActionPanel> createState() => _PlayActionPanelState();
}

class _PlayActionPanelState extends State<PlayActionPanel> {
  bool _isHovered = false;
  
  // esta variable cambiará según lo que esté haciendo el launcher, aun no se implementa
  // (ejmplo "up_to_date", "updating", "checking")
  final String _launcherState = "up_to_date"; 

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 1. eSTADO DEL modpack
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.panelDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _launcherState == "up_to_date" ? Icons.check_circle : Icons.sync,
                color: _launcherState == "up_to_date" ? AppColors.successGreen : Colors.orangeAccent,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                _launcherState == "up_to_date" ? 'MODPACK UP TO DATE' : 'SYNCING MODS...',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 12),
              // Versión actual
              Text(
                'v1.2.5',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // 2. Boton jugar
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {

              print("¡Iniciando Minecraft!");
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: _isHovered ? 75 : 70,
                vertical: _isHovered ? 22 : 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _isHovered ? AppColors.hoverGreen : AppColors.primaryGreen,
                    AppColors.successGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppColors.primaryGreen.withOpacity(0.6),
                          blurRadius: 25,
                          spreadRadius: 2,
                        )
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.panelGlass,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
              ),
              child: const Text(
                'JUGAR',
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}