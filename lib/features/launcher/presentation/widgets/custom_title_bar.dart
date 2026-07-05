import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatefulWidget {
  const CustomTitleBar({super.key});
  
  @override
  State<CustomTitleBar> createState() => _CustomTitleBarState();
}

class _CustomTitleBarState extends State<CustomTitleBar> {
  bool _isMaximized = false;
  
  void _toggleMax() async {
    if (await windowManager.isMaximized()) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
    setState(() => _isMaximized = !_isMaximized);
  }

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        height: 40, 
        color: AppColors.panelDark, 
        child: Row(
          children: [
            const SizedBox(width: 15),
            const Icon(Icons.catching_pokemon, color: Colors.white, size: 20),
            const Text(
              ' POKÉMANIA', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            
            _TitleBarButton(
              icon: Icons.minimize, 
              onTap: () => windowManager.minimize(),
            ),
            _TitleBarButton(
              icon: _isMaximized ? Icons.filter_none : Icons.crop_square, 
              onTap: _toggleMax,
            ),
            _TitleBarButton(
              icon: Icons.close, 
              onTap: () => windowManager.close(), 
              isClose: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleBarButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isClose;

  const _TitleBarButton({
    required this.icon,
    required this.onTap,
    this.isClose = false,
  });

  @override
  State<_TitleBarButton> createState() => _TitleBarButtonState();
}

class _TitleBarButtonState extends State<_TitleBarButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 45,
          height: 40,
          decoration: BoxDecoration(
            color: _isHovered 
                ? (widget.isClose ? Colors.red : AppColors.borderLight) 
                : Colors.transparent,
          ),
          child: Icon(
            widget.icon,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}