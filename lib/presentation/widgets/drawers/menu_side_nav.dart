import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/config/menu/menu_items.dart';
import 'package:gymnastic_center/infrastructure/screens/auth/welcome_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class MenuSideNav extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MenuSideNav({
    super.key,
    required this.scaffoldKey,
  });

  @override
  State<MenuSideNav> createState() => _MenuSideNavState();
}

class _MenuSideNavState extends State<MenuSideNav> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

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
              // Cerrar menu lateral
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ), //Usemos .map para estas situaciones. Ej: appMenus.map((menuItem) => )

              // Lista de opciones
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
                        widget.scaffoldKey.currentState?.closeDrawer();
                      }),
                ),
              ),

              // Cerrar sesión
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 100, 15, 10),
                title: const Text('Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                leading: const Icon(Icons.logout, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
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
