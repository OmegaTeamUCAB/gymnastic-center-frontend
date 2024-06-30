import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewChip extends StatelessWidget {
  const NewChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xFF4F14A0).withOpacity(0.8),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
            child: Text(
              AppLocalizations.of(context)!.newItem,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )));
  }
}
