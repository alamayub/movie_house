import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog({
  required BuildContext context,
  required String title,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text('Are you sure, you want to ${title.toLowerCase()}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(title),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}