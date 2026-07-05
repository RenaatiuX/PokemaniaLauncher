import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';
import 'package:pokemania_launcher/core/services/storage_service.dart';

class AccountSettingsPanel extends StatelessWidget {
  const AccountSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Esto es para leer el nickname del offline
    final String currentNickname = StorageService.nickname.isEmpty ? 'Jugador' : StorageService.nickname;
    
    // 2. Esto es temporal hasta incluir la logica del offline
    final bool isOfflineAccount = true; 

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Configuración de Cuenta', 
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Administra tus cuentas de Minecraft.', 
          style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
        const SizedBox(height: 40),

        //cuenta actual
        const Text('Cuentas Guardadas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B), // Azul muy oscuro
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              // para el avatar estoy usando esta api, se puede quitar
              Container(
                width: 40, height: 40, 
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  'https://minotar.net/helm/$currentNickname/40.png',
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white54),
                ),
              ),
              const SizedBox(width: 15),
              
              // Datos Dinámicos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentNickname, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(isOfflineAccount ? 'Cuenta Offline' : 'Cuenta Microsoft', //lo arreglare pornto
                      style: TextStyle(color: isOfflineAccount ? Colors.orangeAccent : Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              
              // Botones de la tarjeta
              const Text('Seleccionada', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
              const SizedBox(width: 15),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.redAccent),
                tooltip: 'Cerrar sesión',
                onPressed: () async {
                  // cerrar sesion actual
                  await StorageService.clearAuth();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  }
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
        const Divider(color: AppColors.borderLight),
        const SizedBox(height: 30),

        // Cuenta offline
        const Text('Cambiar Cuenta Offline', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Nuevo nombre de usuario',
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.5),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {
              }, 
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), padding: const EdgeInsets.all(20)),
              child: const Text('Cambiar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),

        const SizedBox(height: 40),

        //a futuro se conectará con micrsoft
        if (isOfflineAccount) ...[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF107C10).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF107C10).withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Añadir Cuenta Microsoft', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                const Text('Inicia sesión con tu cuenta de Microsoft (Premium) para acceder a servidores oficiales y mantener tu skin.', 
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text('Iniciar Sesión con Microsoft', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF107C10),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }
}