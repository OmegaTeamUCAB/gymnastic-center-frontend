import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BrandFooter extends StatelessWidget {
  const BrandFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.footer,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
    );
  }
}
