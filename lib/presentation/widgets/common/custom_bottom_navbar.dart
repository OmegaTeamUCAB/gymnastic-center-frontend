import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class CustomNavigationBar extends StatelessWidget {
  final int tabIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({
    required this.tabIndex,
    required this.onTap,
    super.key,
  });

  //todo: add conditionally rendered border
  @override
  Widget build(BuildContext context) {
    final colorAppBar = Theme.of(context).colorScheme.tertiaryContainer;
    final activeColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return BottomAppBar(
      surfaceTintColor: colorAppBar,
      color: colorAppBar,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.zero,
      shadowColor: Colors.grey,
      elevation: 25,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  onTap(0);
                },
                icon: Icon(GymnasticCenter.home,
                    size: 32,
                    color: tabIndex == 0 ? activeColor : Colors.grey)),
            const SizedBox(
              width: 30,
            ),
            IconButton(
                onPressed: () {
                  onTap(1);
                },
                icon: Icon(GymnasticCenter.wheelchair,
                    size: 32,
                    color: tabIndex == 1 ? activeColor : Colors.grey)),
            const Spacer(),
            IconButton(
                onPressed: () {
                  onTap(2);
                },
                icon: Icon(
                  GymnasticCenter.settings,
                  size: 32,
                  color: tabIndex == 2 ? activeColor : Colors.grey,
                )),
            const SizedBox(
              width: 32,
            ),
            IconButton(
                onPressed: () {
                  onTap(3);
                },
                icon: Icon(Icons.notifications_outlined,
                    size: 32,
                    color: tabIndex == 3 ? activeColor : Colors.grey)),
          ],
        ),
      ),
    );
  }
}
