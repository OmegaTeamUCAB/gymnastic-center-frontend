import 'package:flutter/material.dart';

class CustomCallToActionButton extends StatelessWidget {
  final String content;
  final Icon icon;
  final void Function()? onTap;
  
  const CustomCallToActionButton({
    super.key,
    required this.onTap,
    required this.content,
    required this.icon,
  });


  @override
  Widget build(BuildContext context) {
      const LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
    );
    
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 8.0,
        shadowColor: Colors.black54,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 13,
            ),
          ),
        ],
      ),
    );
  }
}