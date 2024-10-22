import 'package:flutter/material.dart';
import 'package:gymnastic_center/main.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Español',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: currentLocale.languageCode == 'es'
                ? Text(AppLocalizations.of(context)!.selected)
                : null,
            onTap: () {
              MainApp.setLocale(context, const Locale('es', ''));
            },
          ),
          ListTile(
            title: Text(
              'English',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: currentLocale.languageCode == 'en'
                ? Text(AppLocalizations.of(context)!.selected)
                : null,
            onTap: () {
              MainApp.setLocale(context, const Locale('en', ''));
            },
          ),
        ],
      ),
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const BrandBackButton(),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
    );
  }
}
