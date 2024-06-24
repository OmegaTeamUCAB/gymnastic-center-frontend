import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class NotificationIcon extends StatelessWidget {
  final String notificationNumber;
  final Color color;
  final double size;

  const NotificationIcon({
    super.key,
    required this.notificationNumber,
    this.size = 32,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          Ionicons.notifications_outline,
          size: size,
          color: color,
        ),
        Positioned(
          right: -3,
          top: -3,
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.2,
                color: color,
              ),
            ),
            child: Center(
              child: Text(
                notificationNumber,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
