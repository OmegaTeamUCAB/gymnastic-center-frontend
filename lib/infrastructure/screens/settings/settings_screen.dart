import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/config/menu/menu_items.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const name = 'language_screen';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> circleColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.yellow,
      Colors.lightBlue,
      Colors.blueAccent,
      Colors.orange,
      // Agrega más colores aquí
    ];
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
      body: ListView.builder(
        itemCount: appMenuItems.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 0, 10),
          child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
              title: Text(appMenuItems[i].title,
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              leading: CircleAvatar(
                backgroundColor: circleColors[i % circleColors.length],
                radius: 30,
                child: Icon(appMenuItems[i].icon, color: Colors.white),
              ),
              trailing: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.chevron_right,
                      color: Colors.black54, size: 40)),
              onTap: () {
                appMenuItems[i].redirect(context);
              }),
        ),
      ),
    );
  }
}
