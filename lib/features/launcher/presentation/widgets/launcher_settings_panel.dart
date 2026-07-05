import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';

class LauncherSettingsPanel extends StatelessWidget {
  const LauncherSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Configuración del Launcher',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Ajustes directos del comportamiento del launcher y rutas de instalación.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
        ),
        const SizedBox(height: 40),

        // 1. Directorio del juego
        const Text('Directorio del Juego', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        Text(
          'Ruta donde se descargarán y guardarán los archivos de Minecraft. (Requiere reiniciar el launcher si se cambia)',
          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 15),
        
        Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white, fontSize: 14),
                controller: TextEditingController(text: '%appdata%/.pokemania'), // texto estatico
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.panelDark,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
                // aqui pondre un file Picker más adelante
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.panelDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: AppColors.borderLight),
                ),
              ),
              child: const Text('Explorar...'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: AppColors.borderLight),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text('Restaurar por defecto'),
        ),
        const SizedBox(height: 40),
        const Divider(color: AppColors.borderLight),
        const SizedBox(height: 30),

        // 2. Updates
        const Text('Actualizaciones', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        Text('Busca actualizaciones del launcher.', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
        const SizedBox(height: 15),
        
        ElevatedButton(
          onPressed: () {
            // Lógica de update 
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: const Text('Buscar Actualización', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}