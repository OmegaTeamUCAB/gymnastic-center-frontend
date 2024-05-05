import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/ui/brand_gradient.dart';

class CustomFloatingLightningButton extends StatelessWidget {
  final VoidCallback? onPressed;

  CustomFloatingLightningButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              gradient: brandGradient, borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                GymnasticCenter.lightning,
                size: 40,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
