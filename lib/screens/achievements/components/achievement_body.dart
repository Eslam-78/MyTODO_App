import 'package:flutter/material.dart';
import 'package:mytodo_app/core/services/navigation_service.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/badge.dart' as my_badge;
import 'package:mytodo_app/providers/gamification_provider.dart';
import 'package:mytodo_app/screens/achievements/components/achievement_badge.dart';
import 'package:mytodo_app/screens/achievements/components/empty_badges_placeholder.dart';
import 'package:mytodo_app/screens/achievements/components/level_progress_bar.dart';
import 'package:mytodo_app/screens/achievements/components/stats_card.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:provider/provider.dart';

class AchievementBody extends StatefulWidget {
  const AchievementBody({super.key});

  @override
  State<AchievementBody> createState() => _AchievementBodyState();
}

class _AchievementBodyState extends State<AchievementBody> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translatedText = S.of(context);
    final provider = context.watch<GamificationProvider>();
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(height: getFixedHeight(16)),
        LevelProgressBar(level: provider.level, xp: provider.xp, nextLevelXp: provider.level * 1000),
        SizedBox(height: getFixedHeight(20)),
        _buildStatsRow(provider),
        SizedBox(height: getFixedHeight(20)),
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: translatedText.all),
            Tab(text: translatedText.completed),
            Tab(text: translatedText.incomplete),
          ],
          labelStyle: TextStyle(fontSize: getFixedWidth(14), fontWeight: FontWeight.bold),
          indicatorColor: Colors.amber,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildAllBadgesTab(provider, theme),
              _buildCompletedBadgesTab(provider, theme),
              _buildIncompleteBadgesTab(provider, theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllBadgesTab(GamificationProvider provider, ThemeData theme) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(getFixedWidth(16)),
      child: Column(children: [_buildBadgesGrid(provider.allBadges)]),
    );
  }

  Widget _buildCompletedBadgesTab(GamificationProvider provider, ThemeData theme) {
    return provider.unlockedBadges.isEmpty
        ? const EmptyBadgesPlaceholder()
        : SingleChildScrollView(
          padding: EdgeInsets.all(getFixedWidth(16)),
          child: _buildBadgesGrid(provider.unlockedBadges),
        );
  }

  Widget _buildIncompleteBadgesTab(GamificationProvider provider, ThemeData theme) {
    return provider.incompleteBadges.isEmpty
        ? EmptyBadgesPlaceholder()
        : SingleChildScrollView(
          padding: EdgeInsets.all(getFixedWidth(16)),
          child: _buildBadgesGrid(provider.incompleteBadges),
        );
  }

  Widget _buildStatsRow(GamificationProvider provider) {
    return SizedBox(
      height: getFixedHeight(160),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: getFixedWidth(8)),
          SizedBox(
            width: getFixedWidth(110),
            child: StatsCard(icon: Icons.star, value: provider.level.toString(), label: S.of(context).level),
          ),
          SizedBox(width: getFixedWidth(12)),
          SizedBox(
            width: getFixedWidth(110),
            child: StatsCard(
              icon: Icons.local_fire_department,
              value: provider.currentStreak.toString(),
              label: S.of(context).currentStreak,
            ),
          ),
          SizedBox(width: getFixedWidth(12)),
          SizedBox(
            width: getFixedWidth(110),
            child: StatsCard(
              icon: Icons.leaderboard,
              value: provider.longestStreak.toString(),
              label: S.of(context).bestStreak,
            ),
          ),
          // إضافة بطاقة جديدة للإحصائيات الأسبوعية
          SizedBox(width: getFixedWidth(12)),
          SizedBox(
            width: getFixedWidth(110),
            child: StatsCard(
              icon: Icons.calendar_today,
              value: _calculateWeeklyTotal(provider.weeklyStats).toString(),
              label: S.of(context).weeklyTasks,
            ),
          ),
          SizedBox(width: getFixedWidth(8)),
        ],
      ),
    );
  }

  // دالة مساعدة لحساب إجمالي المهام الأسبوعية
  int _calculateWeeklyTotal(Map<String, int> stats) {
    return stats.values.fold(0, (sum, count) => sum + count);
  }

  Widget _buildBadgesGrid(List<my_badge.Badge> badges) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: getFixedWidth(12),
        mainAxisSpacing: getFixedHeight(12),
        childAspectRatio: 0.8,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        return AchievementBadge(badge: badges[index], onTap: () => _showBadgeDetails(context, badges[index]));
      },
    );
  }

  void _showBadgeDetails(BuildContext context, my_badge.Badge badge) {
    final translatedText = S.of(context);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(badge.isUnlocked ? badge.getTranslatedName(context) : translatedText.lockedBadge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  badge.isUnlocked
                      ? ' ${translatedText.congratsBadge} ${badge.xpReward}'
                      : translatedText.unlockRequirement,
                ),
                if (!badge.isUnlocked) ...[
                  SizedBox(height: getFixedHeight(16)),
                  Text(
                    translatedText.unlockConditions,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: getFixedWidth(14)),
                  ),
                  Text(badge.getTranslatedDescription(context)), // هنا نعرض الوصف بدلاً من المستوى
                  if (badge.requiredLevel > 1) // نعرض المستوى فقط إذا كان أكبر من 1
                    Text('${translatedText.requiredLevel} ${badge.requiredLevel}'),
                ],
              ],
            ),
            actions: [TextButton(child: Text(translatedText.okay), onPressed: () => NavigationService.goBack())],
          ),
    );
  }
}
