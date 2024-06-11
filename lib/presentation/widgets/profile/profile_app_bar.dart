import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/screens/auth/login_screen.dart';
import 'package:gymnastic_center/presentation/screens/profile/edit_profile_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    if (authBloc.state is! Authenticated && authBloc.state is! AuthLoading) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
    return CustomAppBar(
      content: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                const BrandBackButton(
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text('Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()),
                      );
                    },
                    icon: const Icon(
                      GymnasticCenter.pencil,
                      size: 20,
                      color: Colors.white,
                    ))
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: authBloc.state is Authenticated &&
                            (authBloc.state as Authenticated).user.image != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                              (authBloc.state as Authenticated).user.image!,
                            ),
                            radius: 35,
                          )
                        : CircleAvatar(
                            backgroundColor: const Color(0xFFe3dff1),
                            radius: 35,
                            child: Text(
                                (authBloc.state as Authenticated)
                                    .user
                                    .fullName
                                    .split(' ')
                                    .map((l) => l[0])
                                    .take(2)
                                    .join(),
                                style: const TextStyle(
                                    color: Color(0xFF4F14A0),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      authBloc.state is Authenticated
                          ? Text(
                              (authBloc.state as Authenticated).user.fullName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          : const CircularProgressIndicator(),
                      const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1750',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold)),
                              Text('followers',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                          SizedBox(width: 45),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '750',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'followings',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 11),
                      const Row(
                        children: [
                          Icon(
                            Icons.emoji_emotions,
                            color: Colors.white,
                          ),
                          SizedBox(width: 107),
                          Text('90',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text(' hrs',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                      const Spacer(),
                      const SizedBox(
                          width: 190,
                          height: 6,
                          child: LinearProgressIndicator(
                            value: 0.7,
                            color: Colors.green,
                            backgroundColor: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
