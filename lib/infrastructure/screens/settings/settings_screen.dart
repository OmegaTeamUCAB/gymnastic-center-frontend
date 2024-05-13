import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/config/menu/menu_items.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> circleColors = [
      Colors.red,
      const Color(0xFF219653),
      Colors.blue,
      Colors.purple,
      const Color(0xFFF2C94C),
      const Color(0xFF56CCF2),
      Colors.blueAccent,
      Colors.orange,
    ];
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
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
        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              title: Text(appMenuItems[i].title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20)),
              leading: CircleAvatar(
                backgroundColor: circleColors[i % circleColors.length],
                radius: 20,
                child:
                    Icon(appMenuItems[i].icon, size: 18, color: Colors.white),
              ),
              trailing: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.chevron_right_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 35)),
              onTap: () {
                appMenuItems[i].redirect(context);
              }),
        ),
      ),
    );
  }
}
