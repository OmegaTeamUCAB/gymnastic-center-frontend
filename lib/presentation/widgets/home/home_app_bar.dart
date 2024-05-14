import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/infrastructure/screens/auth/welcome_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/profile/profile_screen.dart';
import 'package:gymnastic_center/infrastructure/screens/search_screen.dart';
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
                  // should be aligned to the left
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${authBloc.state.user?.fullName ?? 'there'}!',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
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
                            builder: (context) => authBloc.state.user == null
                                ? const WelcomeScreen()
                                : const ProfileScreen()),
                      );
                    },
                    icon: const CircleAvatar(
                      backgroundImage: AssetImage('assets/test_user.jpeg'),
                      radius: 25,
                    ))
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
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
