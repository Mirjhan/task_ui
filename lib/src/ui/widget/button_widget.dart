import 'package:flutter/material.dart';
import 'package:tasks/src/ui/core/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const ButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(color: Colors.white);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          //height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: darkPrimaryColor,
          ),
          child: Text(
            title,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
