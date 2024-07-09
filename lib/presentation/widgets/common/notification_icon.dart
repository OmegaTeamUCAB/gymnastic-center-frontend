import 'package:flutter/material.dart';

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
          Icons.notifications_none_rounded,
          size: size,
          color: color,
        ),
        if (notificationNumber != '0')
          Positioned(
            right: -1,
            top: -1,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                ),
              ),
              child: Center(
                child: Text(
                  notificationNumber,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
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
