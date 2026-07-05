import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';

class BottomInfoBar extends StatelessWidget {
  const BottomInfoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.panelGlass,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.public, color: AppColors.primaryGreen, size: 18),
              const SizedBox(width: 8),
              const Text(
                '142 Jugadores',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              
              // Separador
              const SizedBox(width: 20),
              Container(width: 1, height: 15, color: AppColors.borderLight),
              const SizedBox(width: 20),
              
              // 2. Tiempo de juego
              const Icon(Icons.schedule, color: AppColors.textMuted, size: 18),
              const SizedBox(width: 8),
              const Text(
                '124h 45m',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}