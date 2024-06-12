import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/auth/update_user_from.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class UpdateUserScreen extends StatelessWidget {
  const UpdateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    BackButton(),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
      body: UpdateUserForm(),
    );
  }
}
