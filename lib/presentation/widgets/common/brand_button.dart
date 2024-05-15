import 'package:flutter/material.dart';

class BrandButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double? width;
  final bool isDarkMode;

  const BrandButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.width = double.infinity,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    const LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
    );

    if (Theme.of(context).brightness == Brightness.dark || isDarkMode) {
      return SizedBox(
        width: width,
        child: TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
            ),
            onPressed: onPressed,
            child: child),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(114, 79, 227, 0.17),
            blurRadius: 22.0,
            spreadRadius: 0.0,
            offset: Offset(0, 14.0),
          ),
        ],
        gradient: gradient,
      ),
      width: width,
      child: TextButton(onPressed: onPressed, child: child),
    );
  }
}
