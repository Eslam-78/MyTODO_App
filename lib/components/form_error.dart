import 'package:flutter/material.dart';
import 'package:mytodo_app/core/utils/screen_config.dart';

class FormError extends StatelessWidget {
  const FormError({super.key, required this.errorsList});

  final List<String> errorsList;

  @override
  Widget build(BuildContext context) {
    return Column(children: List.generate(errorsList.length, (index) => formErrorText(errorsList[index])));
  }

  //the content of Error Message and its Icon
  Row formErrorText(String errorText) {
    return Row(
      children: [
        Icon(Icons.error_outline, size: getFixedWidth(14), color: Colors.redAccent),
        SizedBox(width: getFixedWidth(10)),
        Text(errorText),
      ],
    );
  }
}
