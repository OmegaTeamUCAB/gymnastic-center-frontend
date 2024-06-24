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
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Row(
          children: [
                    _CustomNavButton(
              iconData: GymnasticCenter.home, 
              isSelected: tabIndex == 0, 
              activeColor: activeColor, 
              unactiveColor: Colors.grey,  
              onPressed: () {
                onTap(0);
              },),
            const SizedBox(
              width: 30,
            ),
            _CustomNavButton(
              iconData: GymnasticCenter.wheelchair, 
              isSelected: tabIndex == 1, 
              activeColor: activeColor, 
              unactiveColor: Colors.grey,  
              onPressed: () {
                onTap(1);
              },),
                    
            const Spacer(),
                        _CustomNavButton(
              iconData: GymnasticCenter.settings, 
              isSelected: tabIndex == 2, 
              activeColor: activeColor, 
              unactiveColor: Colors.grey,  
              onPressed: () {
                onTap(2);
              },),
            const SizedBox(
              width: 32,
            ),
            _CustomNavButton(
              iconData: Icons.notifications_outlined, 
              isSelected: tabIndex == 3, 
              activeColor: activeColor, 
              unactiveColor: Colors.grey,  
              onPressed: () {
                onTap(3);
              },)
          ],
        ),
      ),
    );
  }
}

class _CustomNavButton extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final Color activeColor;
  final Color unactiveColor;
  final void Function()? onPressed;
  final double size;

  const _CustomNavButton({
      required this.iconData,
      required this.isSelected,
      required this.activeColor,
      required this.unactiveColor,
      this.size = 32,
      required this.onPressed
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: IconButton(
            icon: Icon(
              iconData,
              color: (isSelected) ? activeColor : unactiveColor,
              size: size,
            ),
            onPressed: onPressed,
            splashColor: Colors.white,
          ),
        ),
         if (isSelected)
               if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
      ],
    );
  }
}

