import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/screens/profile/edit_profile_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    BrandBackButton(),
                    Text(
                      'Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          title: Text('Edit Profile',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20)),
          leading: const CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 20,
            child: Icon(GymnasticCenter.pencil, size: 18, color: Colors.white),
          ),
          trailing: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.chevron_right_outlined,
                  color: Theme.of(context).colorScheme.onPrimary, size: 35)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UpdateUserScreen()),
            );
          },
        ),
      ),
    );
  }
}
