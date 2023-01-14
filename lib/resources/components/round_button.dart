import 'package:flutter/material.dart';

import '../colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  bool loading;
  final VoidCallback onPress;
  RoundButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                : Text(
                    title,
                    style: const TextStyle(
                        color: AppColors.whiteColor, fontSize: 18),
                  )),
      ),
    );
  }
}
