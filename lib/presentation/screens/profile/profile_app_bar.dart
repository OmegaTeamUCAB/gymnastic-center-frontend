import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/screens/profile/update_profile_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_followings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return CustomAppBar(
      content: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                Text(AppLocalizations.of(context)!.profile,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateProfileScreen()),
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
            if (authBloc.state is Authenticated)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: ProfileAvatar(
                          image: (authBloc.state as Authenticated).user.image,
                          fullName:
                              (authBloc.state as Authenticated).user.fullName,
                        )),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          authBloc.state is Authenticated
                              ? Text(
                                  (authBloc.state as Authenticated)
                                      .user
                                      .fullName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              : const CircularProgressIndicator(),
                          const ProfileFollowings(),
                        ],
                      ),
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
