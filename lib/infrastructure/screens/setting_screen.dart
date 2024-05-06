import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/drawers/menu_side_nav.dart';
// import 'package:gymnastic_center/infrastructure/screens/side_menu_dart';

class PruebaScreen extends StatelessWidget {
  static const String name = 'prueba_screen';

  const PruebaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('prueba_screen'),
        titleTextStyle: const TextStyle(fontSize: 20),
        backgroundColor: ThemeData().primaryColor,
      ),

      drawer: MenuSideNav(scaffoldKey: scaffoldKey),
      // drawer: const SideMenu()
    );
  }
}
