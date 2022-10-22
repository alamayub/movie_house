import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final IconData? iconData;
  final String title;
  final Function() onPressed;
  final bool? dense;
  final Color? color;
  const CustomMaterialButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.iconData,
    this.dense = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: dense == true ? 32 : 40,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: color ?? Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconData != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: dense == true ? 16 : 20,
                  ),
                )
              : const SizedBox(),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: dense == true ? 13 : 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: .75,
                ),
          )
        ],
      ),
    );
  }
}
