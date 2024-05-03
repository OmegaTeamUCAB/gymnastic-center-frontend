import 'package:flutter/material.dart';
import 'package:flutter_template/infrastructure/presentation/screens/home_screen.dart';
import 'package:flutter_template/presentation/widgets/ui/brand_button.dart';
import 'package:flutter_template/presentation/widgets/ui/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: CustomAppBar(
            content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Text(
                '0',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Inbox',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.white,
                  ))
            ],
          ),
        )),
      ),
      body: Padding(
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
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              })
        ]),
      ),
    );
  }
}
