import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';

class ModsSettingsPanel extends StatefulWidget {
  const ModsSettingsPanel({super.key});

  @override
  State<ModsSettingsPanel> createState() => _ModsSettingsPanelState();
}

class _ModsSettingsPanelState extends State<ModsSettingsPanel> {
  // Estado para determinar el modpack, luego se probará
  String _activeModpack = 'pokemania_plus';
  //todo esto es estatico, se reemplazará a futuro
  bool _nerbEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Configuración de Mods',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Activa o desactiva mods opcionales de tu cliente de Minecraft.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),
          const SizedBox(height: 40),

          // 1. modpack
          const Text('Modpack Activo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Text('Selecciona qué modpack usará el launcher al jugar.', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
          const SizedBox(height: 15),

          Row(
            children: [
              _buildModpackCard(
                id: 'pokemania_plus',
                title: 'Pokemania+',
                subtitle: 'Java 21',
                isNew: true,
              ),
              const SizedBox(width: 20),
              _buildModpackCard(
                id: 'pokemania_base',
                title: 'Pokemania',
                subtitle: 'Mods Base\nJava 21 • Recomendado',
                isNew: false,
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          const Divider(color: AppColors.borderLight),
          const SizedBox(height: 30),

          // 2. Mods opciones
          const Text('Mods Opcionales (1)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Text('Puedes desactivar estos mods si causan problemas de rendimiento.', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
          const SizedBox(height: 15),

          _buildOptionalModTile(
            title: 'Not Enough Recipe Book [NERB]',
            author: 'SSKirillSS',
            description: 'Completely removes recipe book from the game...',
            icon: Icons.menu_book,
            value: _nerbEnabled,
            onChanged: (val) => setState(() => _nerbEnabled = val),
          ),

          const SizedBox(height: 40),
          const Divider(color: AppColors.borderLight),
          const SizedBox(height: 30),

          // 3. Mods requeridos
          const Text('Mods Requeridos (134)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Text('Estos mods son obligatorios para entrar al servidor.', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
          const SizedBox(height: 15),
          
          // aqui pondre un gridview o listview para que se meestren los mods, por ahora un placeholder
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.panelDark,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: const Center(
              child: Text('Lista de 134 mods oculta para mejorar rendimiento visual.', style: TextStyle(color: Colors.white54)),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Tarjeta de Modpack
  Widget _buildModpackCard({required String id, required String title, required String subtitle, required bool isNew}) {
    final isSelected = _activeModpack == id;
    
    return GestureDetector(
      onTap: () => setState(() => _activeModpack = id),
      child: Container(
        width: 270,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.panelDark,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.orangeAccent : AppColors.borderLight, 
            width: isSelected ? 2 : 1
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                // Icono del Modpack
                Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.catching_pokemon, color: Colors.white54, size: 30),
                ),
                const SizedBox(width: 15),
                // Textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 5),
                      Text(subtitle, style: TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),

            if (isNew)
              Positioned(
                top: -25, right: -25,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(15 / 360),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.deepOrange, Colors.orangeAccent]),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 10)],
                    ),
                    child: const Text('¡NUEVO!', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Tarjeta de Mod ppcional
  Widget _buildOptionalModTile({required String title, required String author, required String description, required IconData icon, required bool value, required Function(bool) onChanged}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.panelDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
            ),
            child: Icon(icon, color: Colors.redAccent),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                Text('por $author', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                const SizedBox(height: 5),
                Text(description, style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF3B82F6),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}