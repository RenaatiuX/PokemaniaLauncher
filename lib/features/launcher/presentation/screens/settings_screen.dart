import 'package:flutter/material.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/account_settings_panel.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/java_settings_panel.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/launcher_settings_panel.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/minecraft_settings_panel.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/mods_settings_panel.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onClose; 
  
  const SettingsScreen({super.key, required this.onClose});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 1; 

  final List<String> _menuItems = [
    'Cuenta',
    'Minecraft',
    'Mods',
    'Resource Packs',
    'Java',
    'Launcher',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, 
      child: Row(
        children: [
          // side bar
          Container(
            width: 250,
            color: Colors.black.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Ajustes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                ...List.generate(_menuItems.length, (index) {
                  return _buildMenuButton(index, _menuItems[index]);
                }),

                const Spacer(),

                // Bton volver al inicio
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: widget.onClose, 
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, color: Colors.white, size: 18),
                          SizedBox(width: 10),
                          Text('Cerrar Ajustes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Panel
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: _buildCurrentPanel(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(int index, String title) {
    final isSelected = _selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () => setState(() => _selectedIndex = index),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPanel() {
    switch (_selectedIndex) {
      case 0:
        return const AccountSettingsPanel();
      case 1:
        return const MinecraftSettingsPanel();
      case 2:
        return const ModsSettingsPanel();
      case 4:
        return const JavaSettingsPanel(); 
      case 5:
        return const LauncherSettingsPanel(); 
      default:
        return Center(
          child: Text(
            'Panel de ${_menuItems[_selectedIndex]} en construcción...',
            style: const TextStyle(color: Colors.white54, fontSize: 20),
          ),
        );
    }
  }
}