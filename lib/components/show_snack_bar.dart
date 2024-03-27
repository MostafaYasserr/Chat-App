import 'package:flutter/material.dart';

void showSnackBar(
    BuildContext context, {
      required String message,
      required Color backgroundColor,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18),
      ),
    ),
  );
}