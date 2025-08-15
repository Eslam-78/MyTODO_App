import 'package:flutter/material.dart';
import 'package:mytodo_app/generated/l10n.dart';

enum BadgeType { streak, speed, mastery, level, special, commitment, focus }

enum BadgeTier { bronze, silver, gold, epic, legendary }

class Badge {
  final String id;
  final String nameKey;
  final String descriptionKey;
  final String iconAsset;
  final BadgeType type;
  final BadgeTier tier;
  final bool isSecret;
  final int xpReward;
  final int requiredLevel;
  final DateTime? unlockedAt;

  Badge({
    required this.id,
    required this.nameKey,
    required this.descriptionKey,
    required this.iconAsset,
    required this.type,
    this.tier = BadgeTier.bronze,
    this.isSecret = false,
    this.xpReward = 10,
    this.requiredLevel = 1,
    this.unlockedAt,
  });

  bool get isUnlocked => unlockedAt != null;

  Color getTierColor() {
    switch (tier) {
      case BadgeTier.bronze:
        return const Color(0xFFCD7F32);
      case BadgeTier.silver:
        return const Color(0xFFC0C0C0);
      case BadgeTier.gold:
        return const Color(0xFFFFD700);
      case BadgeTier.epic:
        return const Color(0xFF9370DB);
      case BadgeTier.legendary:
        return const Color(0xFFFF4500);
    }
  }

  Color getTypeColor() {
    switch (type) {
      case BadgeType.streak:
        return Colors.orange;
      case BadgeType.speed:
        return Colors.green;
      case BadgeType.mastery:
        return Colors.purple;
      case BadgeType.special:
        return Colors.red;
      case BadgeType.level:
        return Colors.blue;
      case BadgeType.commitment:
        return Colors.teal;
      case BadgeType.focus:
        return Colors.pink;
    }
  }

  // دالة لترجمة النص عند الحاجة
  String getTranslatedName(BuildContext context) {
    try {
      return S.of(context).getTranslation(nameKey);
    } catch (e) {
      return nameKey; // fallback إذا فشلت الترجمة
    }
  }

  String getTranslatedDescription(BuildContext context) {
    try {
      return S.of(context).getTranslation(descriptionKey);
    } catch (e) {
      return descriptionKey;
    }
  }

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      id: json['id'],
      nameKey: json['name'],
      descriptionKey: json['description'],
      iconAsset: json['iconAsset'],
      type: BadgeType.values[json['type']],
      tier: BadgeTier.values[json['tier']],
      isSecret: json['isSecret'],
      xpReward: json['xpReward'],
      requiredLevel: json['requiredLevel'],
      unlockedAt: json['unlockedAt'] != null ? DateTime.parse(json['unlockedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nameKey,
      'description': descriptionKey,
      'iconAsset': iconAsset,
      'type': type.index,
      'tier': tier.index,
      'isSecret': isSecret,
      'xpReward': xpReward,
      'requiredLevel': requiredLevel,
      'unlockedAt': unlockedAt?.toIso8601String(),
    };
  }

  Badge copyWith({
    String? id,
    String? nameKey,
    String? descriptionKey,
    String? iconAsset,
    BadgeType? type,
    BadgeTier? tier,
    bool? isSecret,
    int? xpReward,
    int? requiredLevel,
    DateTime? unlockedAt,
  }) {
    return Badge(
      id: id ?? this.id,
      nameKey: nameKey ?? this.nameKey,
      descriptionKey: descriptionKey ?? this.descriptionKey,
      iconAsset: iconAsset ?? this.iconAsset,
      type: type ?? this.type,
      tier: tier ?? this.tier,
      isSecret: isSecret ?? this.isSecret,
      xpReward: xpReward ?? this.xpReward,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}

List<Badge> allBadges = [
  Badge(
    id: "badge_1",
    nameKey: "badge_1_name",
    descriptionKey: "badge_1_description",
    iconAsset: "assets/badges/start.svg",
    type: BadgeType.level,
    tier: BadgeTier.bronze,
    xpReward: 25,
    isSecret: true,
  ),
  Badge(
    id: "badge_2",
    nameKey: "badge_2_name",
    descriptionKey: "badge_2_description",
    iconAsset: "assets/badges/morning.svg",
    type: BadgeType.speed,
    tier: BadgeTier.bronze,
    xpReward: 70,
    isSecret: true,
  ),
  Badge(
    id: "badge_3",
    nameKey: "badge_3_name",
    descriptionKey: "badge_3_description",
    iconAsset: "assets/badges/organize.svg",
    type: BadgeType.mastery,
    tier: BadgeTier.bronze,
    requiredLevel: 5,
    xpReward: 80,
    isSecret: true,
  ),
  Badge(
    id: "badge_4",
    nameKey: "badge_4_name",
    descriptionKey: "badge_4_description",
    iconAsset: "assets/badges/weekly.svg",
    type: BadgeType.commitment,
    tier: BadgeTier.bronze,
    xpReward: 90,
    isSecret: true,
  ),
  Badge(
    id: "badge_5",
    nameKey: "badge_5_name",
    descriptionKey: "badge_5_description",
    iconAsset: "assets/badges/focus.svg",
    type: BadgeType.focus,
    tier: BadgeTier.bronze,
    requiredLevel: 10,
    xpReward: 120,
    isSecret: true,
  ),
  Badge(
    id: "badge_6",
    nameKey: "badge_6_name",
    descriptionKey: "badge_6_description",
    iconAsset: "assets/badges/habit.svg",
    type: BadgeType.commitment,
    tier: BadgeTier.silver,
    requiredLevel: 15,
    xpReward: 160,
    isSecret: true,
  ),
  Badge(
    id: "badge_7",
    nameKey: "badge_7_name",
    descriptionKey: "badge_7_description",
    iconAsset: "assets/badges/progress.svg",
    type: BadgeType.level,
    tier: BadgeTier.silver,
    requiredLevel: 20,
    xpReward: 200,
    isSecret: true,
  ),
  Badge(
    id: "badge_8",
    nameKey: "badge_8_name",
    descriptionKey: "badge_8_description",
    iconAsset: "assets/badges/speed.svg",
    type: BadgeType.speed,
    tier: BadgeTier.silver,
    requiredLevel: 25,
    xpReward: 250,
    isSecret: true,
  ),
  Badge(
    id: "badge_9",
    nameKey: "badge_9_name",
    descriptionKey: "badge_9_description",
    iconAsset: "assets/badges/night.svg",
    type: BadgeType.focus,
    tier: BadgeTier.silver,
    requiredLevel: 30,
    xpReward: 300,
    isSecret: true,
  ),
  Badge(
    id: "badge_10",
    nameKey: "badge_10_name",
    descriptionKey: "badge_10_description",
    iconAsset: "assets/badges/productivity.svg",
    type: BadgeType.mastery,
    tier: BadgeTier.silver,
    requiredLevel: 35,
    xpReward: 350,
    isSecret: true,
  ),
  Badge(
    id: "badge_11",
    nameKey: "badge_11_name",
    descriptionKey: "badge_11_description",
    iconAsset: "assets/badges/expert.svg",
    type: BadgeType.level,
    tier: BadgeTier.gold,
    requiredLevel: 40,
    xpReward: 400,
    isSecret: true,
  ),
  Badge(
    id: "badge_12",
    nameKey: "badge_12_name",
    descriptionKey: "badge_12_description",
    iconAsset: "assets/badges/elite.svg",
    type: BadgeType.mastery,
    tier: BadgeTier.gold,
    requiredLevel: 45,
    xpReward: 500,
    isSecret: true,
  ),
  Badge(
    id: "badge_13",
    nameKey: "badge_13_name",
    descriptionKey: "badge_13_description",
    iconAsset: "assets/badges/unstoppable.svg",
    type: BadgeType.commitment,
    tier: BadgeTier.gold,
    requiredLevel: 50,
    xpReward: 600,
    isSecret: true,
  ),
  Badge(
    id: "badge_14",
    nameKey: "badge_14_name",
    descriptionKey: "badge_14_description",
    iconAsset: "assets/badges/final_boss.svg",
    type: BadgeType.mastery,
    tier: BadgeTier.gold,
    requiredLevel: 60,
    xpReward: 750,
    isSecret: true,
  ),
  Badge(
    id: "badge_15",
    nameKey: "badge_15_name",
    descriptionKey: "badge_15_description",
    iconAsset: "assets/badges/planner.svg",
    type: BadgeType.focus,
    tier: BadgeTier.silver,
    xpReward: 270,
    isSecret: true,
  ),
  Badge(
    id: "badge_16",
    nameKey: "badge_16_name",
    descriptionKey: "badge_16_description",
    iconAsset: "assets/badges/streak.svg",
    type: BadgeType.commitment,
    tier: BadgeTier.gold,
    requiredLevel: 55,
    xpReward: 680,
    isSecret: true,
  ),
  Badge(
    id: "badge_17",
    nameKey: "badge_17_name",
    descriptionKey: "badge_17_description",
    iconAsset: "assets/badges/dawn.svg",
    type: BadgeType.speed,
    tier: BadgeTier.bronze,
    xpReward: 60,
    isSecret: true,
  ),
  Badge(
    id: "badge_18",
    nameKey: "badge_18_name",
    descriptionKey: "badge_18_description",
    iconAsset: "assets/badges/task_master.svg",
    type: BadgeType.mastery,
    tier: BadgeTier.gold,
    requiredLevel: 70,
    xpReward: 850,
    isSecret: true,
  ),
  Badge(
    id: "badge_19",
    nameKey: "badge_19_name",
    descriptionKey: "badge_19_description",
    iconAsset: "assets/badges/zen.svg",
    type: BadgeType.focus,
    tier: BadgeTier.gold,
    requiredLevel: 75,
    xpReward: 900,
    isSecret: true,
  ),
  Badge(
    id: "badge_20",
    nameKey: "badge_20_name",
    descriptionKey: "badge_20_description",
    iconAsset: "assets/badges/balance.svg",
    type: BadgeType.mastery,
    tier: BadgeTier.gold,
    requiredLevel: 80,
    xpReward: 1000,
    isSecret: true,
  ),
  Badge(
    id: "badge_21",
    nameKey: "badge_21_name",
    descriptionKey: "badge_21_description",
    iconAsset: "assets/badges/legend.svg",
    type: BadgeType.level,
    tier: BadgeTier.gold,
    requiredLevel: 90,
    xpReward: 1200,
    isSecret: true,
  ),
];
