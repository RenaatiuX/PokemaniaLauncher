import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/services/storage_service.dart';

class MinecraftSettingsPanel extends StatefulWidget {
  const MinecraftSettingsPanel({super.key});

  @override
  State<MinecraftSettingsPanel> createState() => _MinecraftSettingsPanelState();
}

class _MinecraftSettingsPanelState extends State<MinecraftSettingsPanel> {
  
  bool _fullscreen = StorageService.fullscreen;
  bool _autoConnect = true;
  bool _allowCustomMods = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Configuración de Minecraft',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Opciones relacionadas con el lanzamiento del juego.',
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
        const SizedBox(height: 40),

        // 1. RESOLUCIÓN
        const Text('Resolución del Juego', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildResInput('1280'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text('X', style: TextStyle(color: Colors.white54)),
            ),
            _buildResInput('720'),
          ],
        ),
        const SizedBox(height: 30),
        const Divider(color: Colors.white10),

        // 2. Toogles
        _buildSettingRow(
          title: 'Abrir en pantalla completa.',
          value: _fullscreen,
          onChanged: (val) {
            setState(() => _fullscreen = val);
            StorageService.fullscreen = val; 
          },
        ),
        const Divider(color: Colors.white10),
        
        _buildSettingRow(
          title: 'Conectar automáticamente al servidor al lanzar.',
          subtitle: 'El juego entrará directamente a pokemania.network',
          value: _autoConnect,
          onChanged: (val) => setState(() => _autoConnect = val),
        ),
        const Divider(color: Colors.white10),
        
        _buildSettingRow(
          title: 'Permitir mods propios',
          subtitle: 'No eliminar mods añadidos manualmente al iniciar el juego.',
          value: _allowCustomMods,
          onChanged: (val) => setState(() => _allowCustomMods = val),
        ),
      ],
    );
  }

  Widget _buildResInput(String hint) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: Text(hint, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSettingRow({required String title, String? subtitle, required bool value, required Function(bool) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                if (subtitle != null) ...[
                  const SizedBox(height: 5),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                ]
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Colors.blueAccent,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}