import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokemania_launcher/core/constants/app_colors.dart';
import 'package:pokemania_launcher/features/launcher/data/models/reward_model.dart';

class BattlePassCard extends StatelessWidget {
  const BattlePassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 550,
          height: 350,
          decoration: BoxDecoration(
            color: AppColors.panelGlass,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  border: const Border(bottom: BorderSide(color: AppColors.borderLight)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PASE ATLANTE', 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2),
                    ),
                    Text(
                      'TEMPORADA 1', 
                      style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: Row(
                  children: [
                    _buildRewardColumn('GRATUITO', monthlyRewards.where((r) => !r.isPremium).toList()),
                    const VerticalDivider(color: AppColors.borderLight, width: 1),
                    _buildRewardColumn('PREMIUM', monthlyRewards.where((r) => r.isPremium).toList(), isPremium: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardColumn(String title, List<Reward> items, {bool isPremium = false}) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title, 
              style: TextStyle(
                color: isPremium ? AppColors.primaryGreen : AppColors.textMuted, 
                fontWeight: FontWeight.bold, 
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(
                leading: Text(items[index].icon, style: const TextStyle(fontSize: 20)),
                title: Text(items[index].name, style: const TextStyle(color: Colors.white, fontSize: 13)),
                dense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}