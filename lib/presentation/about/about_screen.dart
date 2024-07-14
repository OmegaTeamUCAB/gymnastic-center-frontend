import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/about/developer_avatar.dart';
import 'package:gymnastic_center/presentation/about/team_members.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_footer.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const BrandBackButton(
                      color: Colors.white,
                    ),
                    Text(
                      AppLocalizations.of(context)!.about,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [
              const Text(
                'En omega estamos comprometidos al desarrollo de soluciones de software de calidad. Siguiendo las mejores practicas y enfocados a fortalecer la experiencia del usuario.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Nuestro equipo:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: teamMembers
                    .map((member) => DeveloperAvatar(
                          name: member.name,
                          role: member.role,
                          image: member.imageUrl,
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const BrandFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
