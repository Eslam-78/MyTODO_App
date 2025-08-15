import 'package:flutter/material.dart';
import 'package:mytodo_app/core/constants/opacity_levels.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';
import 'package:mytodo_app/generated/l10n.dart';
import 'package:mytodo_app/screens/home/components/section_header.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories; //قائمة الاقسام المهام
  final String? selectedCategory; // الفئة المحددة حاليًا
  final Function(String?) onCategorySelected; // دالة تُنفذ عند اختيار فئة

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        SectionHeader(title: s.taskCategories),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: getFixedHeight(8),
              horizontal: getFixedWidth(12),
            ),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: OpacityLevels.apply(
                    Colors.black,
                    OpacityLevels.level5,
                  ),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                ...categories.map(
                  (cat) => Padding(
                    padding: EdgeInsets.only(right: getFixedWidth(8)),
                    child: _buildCategoryItem(cat, cat, context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String label, String? value, BuildContext context) {
    final isSelected = selectedCategory == value;
    final colorScheme = Theme.of(context).colorScheme;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: getFixedWidth(14),
          fontWeight: FontWeight.w500,
          color:
              isSelected
                  ? Colors.white
                  : OpacityLevels.apply(
                    colorScheme.onSurface,
                    OpacityLevels.level80,
                  ),
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onCategorySelected(value),
      selectedColor: colorScheme.primary,
      backgroundColor: Colors.grey[200],
      padding: EdgeInsets.symmetric(
        horizontal: getFixedWidth(16),
        vertical: getFixedHeight(6),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : Colors.grey[300]!,
          width: 1,
        ),
      ),
      elevation: isSelected ? 2 : 0,
      pressElevation: 2,
    );
  }
}
