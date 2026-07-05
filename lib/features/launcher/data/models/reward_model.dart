class Reward {
  final String name;
  final String icon;
  final bool isPremium;

  Reward({
    required this.name, 
    required this.icon, 
    this.isPremium = false,
  });
}

// Lista estatica del battle pass
final List<Reward> monthlyRewards = [
  Reward(name: '5x Pokéballs', icon: '⚽', isPremium: false),
  Reward(name: '1x Masterball', icon: '⭐', isPremium: true),
  Reward(name: 'Poción Salud', icon: '🧪', isPremium: false),
  Reward(name: 'Skin Exclusiva', icon: '👕', isPremium: true),
  Reward(name: '100 PokéDólares', icon: '💰', isPremium: false),
];