import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double size;
  final double percent;
  final Color textColor;
  final Color? indicatorColor;
  final double strokeWidth;
  
  const CustomProgressIndicator({
    super.key,
    this.size = 30,
    required this.percent,
    this.textColor = Colors.black,
    this.indicatorColor,
    this.strokeWidth = 3.0
  });

  @override
  Widget build(BuildContext context) {
    String text = '${percent.toInt()}%';

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              color: indicatorColor,
              strokeWidth: strokeWidth,
              value: percent / 100,
            ),
          ),
        ),
        Center(child: Text(text, style: TextStyle(color: textColor),)),
      ],
    );
  }
}