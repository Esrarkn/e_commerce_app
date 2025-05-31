import 'package:flutter/material.dart';
import '../tools/appColors.dart';

Widget gradientButton({required VoidCallback onPressed, required String text}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [mainColor, linearColor]),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Icon(Icons.shopping_cart_outlined, color: textColor2, size: 22),
              SizedBox(width: 5),
              Text(
                text,
                style: TextStyle(
                  color: textColor2,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget gradientButton2({
  required VoidCallback onPressed,
  required String text,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [mainColor, linearColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 14),
          child: Text(
            text,
            style: TextStyle(
              color: textColor2,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter"
            ),
          ),
        ),
      ),
    ),
  );
}
