import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final bool isSelected;
  final String label;
  final void Function(bool) onTap;
  const CustomChip(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!isSelected),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.deepPurple : Colors.white),
          ),
        ),
      ),
    );
  }
}
