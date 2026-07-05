import 'package:flutter/material.dart';
import 'package:pokemania_launcher/features/launcher/presentation/widgets/animation_nav_button.dart';

class SideNavigationBar extends StatelessWidget {
  final VoidCallback? onOpenSettings;

  const SideNavigationBar({
    super.key,
    this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),

          AnimatedNavButton(
            icon: Icons.settings,
            text: 'Ajustes',
            onPressed: () {
              if (onOpenSettings != null) {
                onOpenSettings!();
              }
            },
          ),
          AnimatedNavButton(
            icon: Icons.discord,
            text: 'Discord',
            onPressed: () {},
          ),
          AnimatedNavButton(icon: Icons.public, text: 'Web', onPressed: () {}),
          AnimatedNavButton(
            icon: Icons.storefront,
            text: 'Tienda',
            onPressed: () {},
          ),
          AnimatedNavButton(
            icon: Icons.description,
            text: 'Wiki',
            onPressed: () {},
          ),
          AnimatedNavButton(
            icon: Icons.gavel,
            text: 'Normativa',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
