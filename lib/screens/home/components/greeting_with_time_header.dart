import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/date_helper.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class GreetingWithTimeHeader extends StatelessWidget {
  const GreetingWithTimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final translatedText = S.of(context);
    final greeting = DateHelper.getTimePeriod(
      morning: translatedText.goodMorning,
      evening: translatedText.goodEvening,
    );

    return Padding(
      padding: EdgeInsets.all(getFixedWidth(16)),
      child: Column(
        children: [
          Text(
            greeting,
            style: TextStyle(
              fontSize: getFixedWidth(28),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getFixedHeight(4)),
          Text(
            DateHelper.formatDate(DateTime.now(), pattern: 'EEEE, MMMM d'),
            style: TextStyle(
              fontSize: getFixedWidth(16),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: getFixedHeight(16)),
          SizedBox(
            height: getFixedHeight(8),
            width: getFixedWidth(150),
            child: Divider(color: Colors.grey[300], thickness: 1),
          ),
        ],
      ),
    );
  }
}
