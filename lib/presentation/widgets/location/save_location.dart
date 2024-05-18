import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class SaveLocation extends StatelessWidget {
  const SaveLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          Theme.of(context).brightness == Brightness.light
              ? 'assets/location/location_image_light.png'
              : 'assets/location/location_image_dark.png',
          width: 156,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'Hi! Make your location allow with us',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Set your location ot start find trainer around you',
          style: TextStyle(
              fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
        ),
        const SizedBox(
          height: 30,
        ),
        BrandButton(
            width: double.infinity,
            child: Text(
              'Use your location',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 20),
            ),
            onPressed: () {
              // TODO: Implement button functionality
            }),
        const SizedBox(
          height: 5,
        ),
        Center(
            child: Container(
          padding: const EdgeInsets.all(
              10.0), // Add some padding so the text doesn't touch the border
          child: Text(
            'We only access your location while you are using this location app',
            style: TextStyle(
                fontSize: 10, color: Theme.of(context).colorScheme.onSecondary),
          ),
        )),
        const SizedBox(
          height: 5,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Or',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  decoration: TextDecoration.none,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // TODO: Implement link functionality
                  },
              ),
              const TextSpan(text: ' set your location manually'),
            ],
          ),
        )
      ]),
    );
  }
}
