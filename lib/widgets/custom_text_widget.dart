import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final int? maxLines;
  final bool date;
  final bool isTitle;
  final Color? color;
  final double? fontSize;
  final bool center;
  const CustomTextWidget({
    Key? key,
    required this.title,
    this.maxLines,
    this.date = false,
    this.isTitle = false,
    this.color,
    this.fontSize,
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: center == true ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        fontSize: isTitle == true ? 16 : (fontSize ?? 12),
        letterSpacing: .5,
        color: color ?? (date == false ? Colors.black : Colors.black54),
        fontWeight: isTitle == true ? FontWeight.w500 : FontWeight.normal,
      ),
    );
  }
}
