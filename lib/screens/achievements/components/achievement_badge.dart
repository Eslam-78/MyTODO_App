import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/models/badge.dart' as my_badge;
import 'package:mytodo_app/core/utils/screen_config.dart';

class AchievementBadge extends StatelessWidget {
  final my_badge.Badge badge;
  final VoidCallback? onTap;

  const AchievementBadge({super.key, required this.badge, this.onTap});

  @override
  Widget build(BuildContext context) {
    final translatedText = S.of(context);
    final badgeColor = badge.isUnlocked ? badge.getTierColor() : Colors.grey;
    final iconColor = badge.isUnlocked ? badgeColor : Colors.grey[400];

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getFixedWidth(12))),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(getFixedWidth(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // أيقونة الشارة
                  Container(
                    width: getFixedWidth(60),
                    height: getFixedWidth(60),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [badgeColor.withOpacity(0.2), badgeColor.withOpacity(0.4)]),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: badgeColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                      ],
                    ),
                    child:
                        badge.isUnlocked
                            ? SvgPicture.asset(badge.iconAsset, width: getFixedWidth(30), color: iconColor)
                            : Icon(Icons.lock, size: getFixedWidth(30), color: iconColor),
                  ),

                  // معلومات الشارة
                  Column(
                    children: [
                      // أضف هذا الجزء لعرض اسم البادج
                      Text(
                        badge.getTranslatedName(context), // استخدم getName هنا لعرض الاسم المترجم
                        style: TextStyle(fontSize: getFixedWidth(12), fontWeight: FontWeight.bold, color: badgeColor),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: getFixedHeight(8)),
                      Text(
                        badge.getTranslatedDescription(context), // الوصف المترجم
                        style: TextStyle(fontSize: getFixedWidth(9), color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: getFixedHeight(3)),
                      Text(
                        badge.isUnlocked ? translatedText.opened : translatedText.closed,
                        style: TextStyle(fontSize: getFixedWidth(10), color: badgeColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // نقاط XP
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: getFixedWidth(8), vertical: getFixedHeight(4)),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(getFixedWidth(20)),
                      border: Border.all(color: badgeColor, width: 1),
                    ),
                    child: Text(
                      '${badge.xpReward} XP',
                      style: TextStyle(fontSize: getFixedWidth(12), color: badgeColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // مؤشر الشارة السرية
            if (badge.isSecret && !badge.isUnlocked)
              Positioned(top: 8, right: 8, child: Icon(Icons.vpn_key, size: getFixedWidth(16), color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}

/*class AchievementBadge extends StatelessWidget {
  final my_badge.Badge badge;
  final VoidCallback? onTap;

  const AchievementBadge({super.key, required this.badge, this.onTap});

  @override
  Widget build(BuildContext context) {
    final translatedText = S.of(context);
    final badgeColor = badge.isUnlocked ? badge.getTierColor() : Colors.grey;
    final iconColor = badge.isUnlocked ? badgeColor : Colors.grey[400];

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getFixedWidth(12)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(getFixedWidth(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // أيقونة الشارة
                  Container(
                    width: getFixedWidth(60),
                    height: getFixedWidth(60),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          badgeColor.withOpacity(0.2),
                          badgeColor.withOpacity(0.4),
                        ],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: badgeColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child:
                        badge.isUnlocked
                            ? SvgPicture.asset(
                              badge.iconAsset,
                              width: getFixedWidth(30),
                              color: iconColor,
                            )
                            : Icon(
                              Icons.lock,
                              size: getFixedWidth(30),
                              color: iconColor,
                            ),
                  ),

                  // معلومات الشارة
                  Column(
                    children: [
                      SizedBox(height: getFixedHeight(8)),
                      Text(
                        badge.isUnlocked
                            ? badge.getDescription(context)
                            : badge.getDescription(
                              context,
                            ), // يظهر الوصف الأصلي في جميع الحالات
                        style: TextStyle(
                          fontSize: getFixedWidth(9),
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: getFixedHeight(3)),
                      Text(
                        badge.isUnlocked
                            ? translatedText.opened
                            : translatedText
                                .closed, // يظهر حالة الشارة الأصلية في جميع الحالات
                        style: TextStyle(
                          fontSize: getFixedWidth(10),
                          color: badgeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // نقاط XP
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getFixedWidth(8),
                      vertical: getFixedHeight(4),
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(getFixedWidth(20)),
                      border: Border.all(color: badgeColor, width: 1),
                    ),
                    child: Text(
                      '${badge.xpReward} XP', // يظهر قيمة الـ XP الأصلية دائماً
                      style: TextStyle(
                        fontSize: getFixedWidth(12),
                        color: badgeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // مؤشر الشارة السرية
            if (badge.isSecret && !badge.isUnlocked)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.vpn_key,
                  size: getFixedWidth(16),
                  color: Colors.amber,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/
