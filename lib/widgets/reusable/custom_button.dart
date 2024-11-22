import 'package:flutter/material.dart';
import 'package:socially/utils/constants/colors.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback onPressed;
  const ReusableButton({
    super.key,
    required this.text,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        gradient: gradientColor1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: mainWhiteColor,
          ),
        ),
      ),
    );
  }
}
