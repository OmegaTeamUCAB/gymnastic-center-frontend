import 'package:flutter/material.dart';

class BrandButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final bool isVariant;

  const BrandButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.isVariant = false,
  });

  @override
  Widget build(BuildContext context) {
    const LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
    );

    if (isVariant) {
      return SizedBox(
        width: width,
        child: TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Color(0xFF4F14A0)),
            )),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? const [
                BoxShadow(
                  color: Color.fromRGBO(114, 79, 227, 0.17),
                  blurRadius: 22.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, 14.0),
                ),
              ]
            : null, // no boxShadow in dark theme
        gradient: gradient,
      ),
      width: width,
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }
}
