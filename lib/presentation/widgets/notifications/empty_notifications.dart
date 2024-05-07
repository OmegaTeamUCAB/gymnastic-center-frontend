import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/screens/home/main_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/bell_light.png',
          width: 156,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'Cant find notifications',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Lets explore more content for you.',
          style: TextStyle(
              fontSize: 15, color: Theme.of(context).colorScheme.onSecondary),
        ),
        const SizedBox(
          height: 30,
        ),
        BrandButton(
            width: double.infinity,
            buttonText: 'Back to Feed',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            })
      ]),
    );
  }
}
