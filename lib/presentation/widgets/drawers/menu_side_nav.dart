import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/infrastructure/config/menu/menu_items.dart';
import 'package:gymnastic_center/presentation/screens/auth/auth_options_screen.dart';
import 'package:gymnastic_center/presentation/screens/profile/profile_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

class MenuSideNav extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MenuSideNav({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final authBloc = context.watch<AuthBloc>();
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            gradient: brandGradient), // Cambia esto a tu color deseado
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, hasNotch ? 70 : 50, 0, 10),
          child: Column(
            children: <Widget>[
              authBloc.state is! Authenticated
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          ProfileAvatar(
                            image: (authBloc.state as Authenticated).user.image,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()),
                              );
                            },
                            fullName:
                                (authBloc.state as Authenticated).user.fullName,
                            radius: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              Text(
                                (authBloc.state as Authenticated).user.fullName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                (authBloc.state as Authenticated).user.email,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: appMenuItems.length,
                  itemBuilder: (context, i) => ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                      title: Text(appMenuItems[i].title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      leading: Icon(appMenuItems[i].icon, color: Colors.white),
                      onTap: () {
                        appMenuItems[i].redirect(context);
                        scaffoldKey.currentState?.closeDrawer();
                      }),
                ),
              ),

              // Cerrar sesión
              ListTile(
                contentPadding: const EdgeInsets.only(bottom: 10, left: 15),
                title: const Text('Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                leading:
                    const Icon(GymnasticCenter.logout, color: Colors.white),
                onTap: () {
                  authBloc.add(const SignedOut());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthOptionsScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
