import 'package:diary_mood/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isActive;

  CustomButton({
    required this.onPressed,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive ? Colors.orange : Colors.grey,
          minimumSize: const Size(380, 40),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(69),
          ),
        ),
        clipBehavior: Clip.none,
        child: Text(
          label,
          style: AppTextStyles.titleLarge.copyWith(
            color: isActive ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
