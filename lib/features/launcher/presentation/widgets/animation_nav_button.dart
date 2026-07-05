import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';

class AnimatedNavButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const AnimatedNavButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  State<AnimatedNavButton> createState() => _AnimatedNavButtonState();
}

class _AnimatedNavButtonState extends State<AnimatedNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          height: 50,
          width: _isHovered ? 160 : 50,
          margin: const EdgeInsets.only(left: 10, bottom: 15),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primaryGreen.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: _isHovered
                ? Border.all(color: AppColors.primaryGreen.withOpacity(0.4), width: 1)
                : Border.all(color: Colors.transparent, width: 1),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                left: 12,
                child: Icon(
                  widget.icon, 
                  color: _isHovered ? AppColors.primaryGreen : Colors.white, 
                  size: 26,
                ),
              ),
              Positioned(
                left: 50,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: _isHovered ? AppColors.primaryGreen : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}