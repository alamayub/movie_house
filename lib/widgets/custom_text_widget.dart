import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final int? maxLines;
  final bool date;
  final bool isTitle;
  final Color? color;
  const CustomTextWidget({
    Key? key,
    required this.title,
    this.maxLines,
    this.date = false,
    this.isTitle = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: isTitle == true ? 16 : 12,
        letterSpacing: .5,
        color: color ?? (date == false ? Colors.black : Colors.black54),
        fontWeight: isTitle == true ? FontWeight.w500 : FontWeight.normal,
      ),
    );
  }
}
