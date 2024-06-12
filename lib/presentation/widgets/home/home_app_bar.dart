import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/screens/profile/profile_screen.dart';
import 'package:gymnastic_center/presentation/screens/search_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return CustomAppBar(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    authBloc.state is Authenticated
                        ? Text(
                            'Hello, ${(authBloc.state as Authenticated).user.fullName}!',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )
                        : const CircularProgressIndicator(),
                    const Text(
                      'What\'s your plan for today?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  },
                  icon: authBloc.state is Authenticated &&
                          (authBloc.state as Authenticated).user.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            (authBloc.state as Authenticated).user.image!,
                          ),
                          radius: 25,
                        )
                      : CircleAvatar(
                          backgroundColor: const Color(0xFFe3dff1),
                          radius: 25,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                )
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Container(
                height: 44,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Search',
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF677294)),
                      ),
                      Spacer(),
                      Icon(
                        GymnasticCenter.search,
                        size: 15,
                        color: Color(0xFF677294),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
