import 'package:flutter/material.dart' hide Badge;
import 'package:mytodo_app/core/services/storage_service.dart';
import 'package:mytodo_app/models/badge.dart' as my_badge;
import 'package:mytodo_app/core/utils/streak_helper.dart';
import 'package:mytodo_app/models/todo_item.dart';

class GamificationProvider with ChangeNotifier {
  final StorageService _storage;

  GamificationProvider(this._storage) {
    _init();
  }

  Future<void> _init() async {
    await _loadData();
  }

  // إضافة متغير للإحصائيات الأسبوعية
  Map<String, int> _weeklyStats = {};

  int _xp = 0;
  int _level = 1;
  int _currentStreak = 0;
  int _longestStreak = 0;
  List<my_badge.Badge> _unlockedBadges = [];

  // Counters to satisfy badge requirements
  int _deletedOldTasksCount = 0;
  int _addedTasksThisWeek = 0;
  int _focusModeCount = 0;
  int _shareCount = 0;
  int _completedTasksToday = 0;
  Duration _dndDurationToday = Duration.zero;
  int _totalCompletedTasks = 0;
  int _calendarUsageDays = 0;
  int _diverseCategoriesToday = 0;

  // getters

  // Getter للإحصائيات الأسبوعية
  Map<String, int> get weeklyStats => _weeklyStats;
  int get xp => _xp;
  int get level => _level;
  int get currentStreak => _currentStreak;
  int get longestStreak => _longestStreak;
  List<my_badge.Badge> get unlockedBadges => _unlockedBadges;
  int get weeklyTotal =>
      _weeklyStats.values.fold(0, (sum, count) => sum + count);

  List<my_badge.Badge> get incompleteBadges =>
      my_badge.allBadges.where((b) => !_hasBadge(b.id)).toList();

  List<my_badge.Badge> get allBadges =>
      my_badge.allBadges.map((badge) {
        return _hasBadge(badge.id)
            ? _unlockedBadges.firstWhere((b) => b.id == badge.id)
            : badge;
      }).toList();

  List<my_badge.Badge> get lockedBadges =>
      my_badge.allBadges.where((b) => !_hasBadge(b.id)).toList();

  List<my_badge.Badge> get availableBadges =>
      my_badge.allBadges.where((badge) {
        final unlocked = _hasBadge(badge.id);
        final levelOK = _level >= badge.requiredLevel;
        return !unlocked && levelOK;
      }).toList();

  /// يحسب XP ويراجع فتح البادجات مع تمرير السياق لعرض Snackbar
  void calculateDynamicXp(TodoItem task, BuildContext context) {
    final baseXp = task.priority.index * 20;
    final timeBonus = _calculateTimeBonus(task);
    final streakBonus = _currentStreak * 5;
    final complexityBonus = _calculateComplexityBonus(task);
    final totalXp = baseXp + timeBonus + streakBonus + complexityBonus;

    addXp(totalXp);

    // تحقق من البادجات بناءً على XP والمستوى
    _checkForNewBadges(context);
    // تحقق من بادج المستيقظ المبكر عندما تُنجز مهمة قبل 9 صباحًا
    if (_completedTaskBefore9AM()) {
      _checkTimeBasedBadges(context);
    }
    // عدّ المهام المكتملة اليوم
    _completedTasksToday++;
    _totalCompletedTasks++;
  }

  /// تحديث الإحصائيات الأسبوعية
  void updateWeeklyStats(List<TodoItem> tasks) {
    _weeklyStats = StreakHelper.getWeeklyCompletionStats(tasks);
    notifyListeners();
  }

  /// يحسب مكافأة الوقت (إذا اكتملت المهمة خلال ساعة)
  int _calculateTimeBonus(TodoItem task) {
    if (task.dueDate == null) return 0;
    final completion = task.completedAt?.difference(task.createdAt);
    return (completion != null && completion.inHours < 1) ? 30 : 0;
  }

  /// يحسب مكافأة التعقيد (أكثر من 10 كلمات في العنوان)
  int _calculateComplexityBonus(TodoItem task) {
    final words = task.title.split(' ').length;
    return words > 10 ? 15 : 0;
  }

  /// يضيف XP ويتحقق من الترقية
  void addXp(int points) {
    _xp += points;
    _checkLevelUp();
    _saveData();
    notifyListeners();
  }

  /// يرفع المستوى عند بلوغ XP المطلوب
  void _checkLevelUp() {
    const xpPerLevel = 1000;
    if (_xp >= level * xpPerLevel) {
      _level++;
      _unlockLevelBadges();
      notifyListeners();
    }
  }

  /// يحدّث الستريك ويحقق بادجات الستريك مع عرض Snackbar
  void updateStreaks(List<TodoItem> completedTasks, BuildContext context) {
    _currentStreak = StreakHelper.calculateCurrentStreak(completedTasks);
    _longestStreak = StreakHelper.calculateLongestStreak(completedTasks);
    _checkForStreakBadges(context);
    notifyListeners();
  }

  /// تحقق من بادجات بناءً على XP أو مستوى أو شروط عامة
  void _checkForNewBadges(BuildContext context) {
    // badge_1: أكمل أول مهمة
    if (!_hasBadge('badge_1') && _xp > 0) {
      _unlockBadgeById('badge_1', context);
    }

    //تحقق جميع البادجات المتاحة حسب المستوى والشروط
    for (final badge in availableBadges) {
      if (_meetsBadgeRequirements(badge)) {
        _unlockBadge(badge, context);
      }
    }
  }

  /// تحقق بادجات الستريك (badge_4,6,12,14,19)
  void _checkForStreakBadges(BuildContext context) {
    final map = {
      2: 'badge_4',
      5: 'badge_6',
      7: 'badge_12',
      14: 'badge_14',
      17: 'badge_19',
    };
    map.forEach((days, id) {
      if (_currentStreak >= days && !_hasBadge(id)) {
        _unlockBadgeById(id, context);
      }
    });
  }

  /// تحقق بادجات الوقت (المستيقظ المبكر badge_2)
  void _checkTimeBasedBadges(BuildContext context) {
    if (!_hasBadge('badge_2')) {
      _unlockBadgeById('badge_2', context);
    }
  }

  /// تحقق من شروط كل بادج حسب ID
  bool _meetsBadgeRequirements(my_badge.Badge badge) {
    switch (badge.id) {
      case 'badge_1':
        return false; // لا تفتح تلقائيًا
      case 'badge_2':
        return _completedTaskBefore9AM();
      case 'badge_4':
        return _currentStreak >= 2;
      case 'badge_5': // المنظف الرقمي: حذف 3 مهام منتهية
        return _deletedOldTasksCount >= 3;
      case 'badge_7': // مكتمل: أكمل كل مهامك في يوم
        return _completedTasksToday == totalTasksAssignedToday();
      case 'badge_8': // المخطط: أضف 10 مهام في أسبوع
        return _addedTasksThisWeek >= 10;
      case 'badge_9': // المركز: استخدم وضع التركيز 3 مرات
        return _focusModeCount >= 3;
      case 'badge_10': // القائد: شارك إنجازاتك 3 مرات
        return _shareCount >= 3;
      case 'badge_11': // العشاري: أنجز 10 مهام في يوم
        return _completedTasksToday >= 10;
      case 'badge_13': // المقاوم: وضع عدم الإزعاج 4 ساعات
        return _dndDurationToday.inHours >= 4;
      case 'badge_15': // متقن الوقت: إكمال مهمة بالتوقيت المحدد
        return tasksOnScheduleCount() >= 1;
      case 'badge_16': // المتقن: أكمل 100 مهمة
        return _totalCompletedTasks >= 100;
      case 'badge_17': // المخطط السنوي: استخدم التقويم لـ30 يوم
        return _calendarUsageDays >= 30;
      case 'badge_18': // المتزن: أكمل مهام متنوعة في يوم
        return _diverseCategoriesToday >= 3;
      case 'badge_20': // الأسطورة الذهبية: اجمع 10000 XP
        return _xp >= 10000;
      default:
        return false; // بادج غير معروف
    }
  }

  /// تحقق إذا كانت المهمة قبل 9 صباحًا
  bool _completedTaskBefore9AM() {
    final now = DateTime.now();
    return now.hour < 9; // قبل الساعة 9 صباحًا
  }

  /// يفتح بادج حسب ID ويعرض Snackbar
  void _unlockBadgeById(String badgeId, BuildContext context) {
    final badge = my_badge.allBadges.firstWhere((b) => b.id == badgeId);
    _unlockBadge(
      badge.copyWith(unlockedAt: DateTime.now(), isSecret: false),
      context,
    );
  }

  /// يضيف البادج، يمنح XP إضافي، ويعرض Snackbar
  void _unlockBadge(my_badge.Badge badge, BuildContext context) {
    _unlockedBadges.add(badge);
    addXp(badge.xpReward);
    _saveData();
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 لقد فتحت الشارة: ${badge.nameKey}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// يفتح بادجات المستوى الجديد
  void _unlockLevelBadges() {
    for (final badge in my_badge.allBadges.where(
      (b) => b.requiredLevel == _level && b.type == my_badge.BadgeType.level,
    )) {
      if (!_hasBadge(badge.id)) {
        _unlockedBadges.add(badge.copyWith(unlockedAt: DateTime.now()));
        addXp(badge.xpReward);
      }
    }
  }

  bool _hasBadge(String id) => _unlockedBadges.any((b) => b.id == id);

  /// يعتمد على منطق التطبيق لحساب إجمالي المهام المخصصة اليوم
  int totalTasksAssignedToday() {
    // عوّض هذا بالمنطق الفعلي
    return 0;
  }

  /// يعتمد على منطق التطبيق لحساب المهام المُنجزة في الوقت المحدد
  int tasksOnScheduleCount() {
    // عوّض هذا بالمنطق الفعلي
    return 0;
  }

  /// تحديث عداد حذف المهام القديمة
  void incrementDeletedOldTasks() {
    _deletedOldTasksCount++;
    notifyListeners();
  }

  /// تحديث عداد إضافة المهام هذا الأسبوع
  void incrementAddedTasksThisWeek() {
    _addedTasksThisWeek++;
    notifyListeners();
  }

  /// تحديث عداد وضع التركيز
  void incrementFocusModeCount() {
    _focusModeCount++;
    notifyListeners();
  }

  /// تحديث عداد المشاركة
  void incrementShareCount() {
    _shareCount++;
    notifyListeners();
  }

  /// تحديث مدة عدم الإزعاج اليوم
  void addDndDuration(Duration duration) {
    _dndDurationToday += duration;
    notifyListeners();
  }

  /// تحديث استخدام التقويم
  void incrementCalendarUsageDays() {
    _calendarUsageDays++;
    notifyListeners();
  }

  /// تحديث تنوع الفئات اليومي
  void setDiverseCategoriesToday(int count) {
    _diverseCategoriesToday = count;
    notifyListeners();
  }

  /// إعادة الضبط الكاملة
  void reset() async {
    _xp = 0;
    _level = 1;
    _currentStreak = 0;
    _longestStreak = 0;
    _unlockedBadges.clear();
    _deletedOldTasksCount = 0;
    _addedTasksThisWeek = 0;
    _focusModeCount = 0;
    _shareCount = 0;
    _completedTasksToday = 0;
    _dndDurationToday = Duration.zero;
    _totalCompletedTasks = 0;
    _calendarUsageDays = 0;
    _diverseCategoriesToday = 0;

    await _storage.clearStorage();
    notifyListeners();

    notifyListeners();
  }

  Future<void> _loadData() async {
    final data = await _storage.loadGamificationData();
    final badges = await _storage.loadBadges();

    _xp = data['xp'] ?? 0;
    _level = data['level'] ?? 1;
    _currentStreak = data['currentStreak'] ?? 0;
    _longestStreak = data['longestStreak'] ?? 0;
    _deletedOldTasksCount = data['deletedOldTasksCount'] ?? 0;
    _addedTasksThisWeek = data['addedTasksThisWeek'] ?? 0;
    _focusModeCount = data['focusModeCount'] ?? 0;
    _shareCount = data['shareCount'] ?? 0;
    _completedTasksToday = data['completedTasksToday'] ?? 0;
    _dndDurationToday = Duration(seconds: data['dndDurationSeconds'] ?? 0);
    _totalCompletedTasks = data['totalCompletedTasks'] ?? 0;
    _calendarUsageDays = data['calendarUsageDays'] ?? 0;
    _diverseCategoriesToday = data['diverseCategoriesToday'] ?? 0;

    _unlockedBadges =
        badges.map((json) => my_badge.Badge.fromJson(json)).toList();

    notifyListeners();
  }

  Future<void> _saveData() async {
    final data = {
      'xp': _xp,
      'level': _level,
      'currentStreak': _currentStreak,
      'longestStreak': _longestStreak,
      'deletedOldTasksCount': _deletedOldTasksCount,
      'addedTasksThisWeek': _addedTasksThisWeek,
      'focusModeCount': _focusModeCount,
      'shareCount': _shareCount,
      'completedTasksToday': _completedTasksToday,
      'dndDurationSeconds': _dndDurationToday.inSeconds,
      'totalCompletedTasks': _totalCompletedTasks,
      'calendarUsageDays': _calendarUsageDays,
      'diverseCategoriesToday': _diverseCategoriesToday,
    };

    final badgesJson = _unlockedBadges.map((badge) => badge.toJson()).toList();

    await _storage.saveGamificationData(data);
    await _storage.saveBadges(badgesJson);
  }
}
