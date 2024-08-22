import 'package:flutter/material.dart';

class AppDialogs {
  static bool isDialogOpen = false;

  static void showLoading(BuildContext context) {
    isDialogOpen = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    if (isDialogOpen) {
      isDialogOpen = false;
      Navigator.pop(context);
    }
  }
}
