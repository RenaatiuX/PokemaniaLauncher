import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';
import 'package:pokemania_launcher/core/services/storage_service.dart';

class JavaSettingsPanel extends StatefulWidget {
  const JavaSettingsPanel({super.key});

  @override
  State<JavaSettingsPanel> createState() => _JavaSettingsPanelState();
}

class _JavaSettingsPanelState extends State<JavaSettingsPanel> {
  double _currentRam = StorageService.maxRam;
  double _systemTotalRam = 8192; // esto es por si ocurre algun error
  bool _isLoadingHardware = true;

  @override
  void initState() {
    super.initState();
    _detectSystemRam();
  }

  // Detectar el hardware
  Future<void> _detectSystemRam() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      final windowsInfo = await deviceInfo.windowsInfo;
      
      setState(() {
        _systemTotalRam = windowsInfo.systemMemoryInMegabytes.toDouble();
        
        if (_currentRam > _systemTotalRam) {
          _currentRam = _systemTotalRam / 2;
          StorageService.maxRam = _currentRam;
        }
        _isLoadingHardware = false;
      });
    } catch (e) {
      setState(() => _isLoadingHardware = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Configuración de Java',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Ajustes de memoria. Java se descarga automáticamente según la versión del modpack.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
        ),
        const SizedBox(height: 40),

        // 1. ram maxima
        if (_isLoadingHardware)
          const CircularProgressIndicator(color: AppColors.primaryGreen)
        else
          _buildRamSlider(
            title: 'Memoria RAM Asignada',
            description: 'Límite actual: ${(_systemTotalRam / 1024).toStringAsFixed(1)} GB totales en tu PC.',
            value: _currentRam,
            maxRamLimit: _systemTotalRam, 
            onChanged: (val) {
              setState(() => _currentRam = val);
              StorageService.maxRam = val;
            },
          ),
      ],
    );
  }

  Widget _buildRamSlider({
    required String title, 
    required String description, 
    required double value, 
    required double maxRamLimit,
    required Function(double) onChanged
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title (${value.toInt()} MB)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 5),
        Text(description, style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppColors.primaryGreen,
                  inactiveTrackColor: AppColors.borderLight,
                  thumbColor: Colors.white,
                ),
                child: Slider(
                  value: value,
                  min: 1024,
                  max: maxRamLimit,
                  divisions: (maxRamLimit / 512).floor(),
                  onChanged: onChanged,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text('${(value / 1024).toStringAsFixed(1)} GB', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
            ),
          ],
        ),
      ],
    );
  }
}