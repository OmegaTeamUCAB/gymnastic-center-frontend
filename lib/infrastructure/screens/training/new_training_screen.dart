import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class NewTrainingScreen extends StatelessWidget {
  const NewTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // PageView
          Positioned.fill(
            child: PageView(
              children: <Widget>[
                const Column(
                  children: [
                    // add title, subtitle and an image
                  ],
                ),
                Container(color: Colors.green), // replace with your page 2
                Container(color: Colors.blue), // replace with your page 3
              ],
            ),
          ),
          // Title
          const Positioned(
            top: 80, // adjust the value as needed
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Today\'s workout:',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          // Button
          Positioned(
            bottom: 70, // adjust the value as needed
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 330,
                height: 60,
                child: BrandButton(
                  onPressed: () {},
                  child: Text(
                    'Start!',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
