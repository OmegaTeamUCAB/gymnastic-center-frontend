import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc();
    print(authBloc.state.user);
    return CustomAppBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
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
                    onPressed: () {},
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
                  IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        backgroundImage: AssetImage('assets/test_user.jpeg'),
                        radius: 40,
                      )),
                  const SizedBox(width: 7),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jhon Doe',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
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
                      SizedBox(height: 18),
                      Row(
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
                      Spacer(),
                      SizedBox(
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
