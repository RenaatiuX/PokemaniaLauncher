import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';
import 'package:pokemania_launcher/core/services/storage_service.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        40,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.panelGlass,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              // 1. Avatar minecraft
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  'https://minotar.net/helm/TheRenatiuX/45.png', // mi nickname xD
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.face, color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),

              // 2. Datos del ugador
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  Text(
                    StorageService.nickname.isEmpty
                        ? 'Jugador'
                        : StorageService.nickname,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'CUENTA PREMIUM MICROSOFT',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
