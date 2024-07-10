import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/brand_notifications/brand_notifications_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/notification_icon.dart';
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
    final Size size = MediaQuery.of(context).size;

    return BottomAppBar(
      surfaceTintColor: colorAppBar,
      color: colorAppBar,
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.zero,
      shadowColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
      elevation: 25,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CustomNavButton(
              iconData: GymnasticCenter.home,
              isSelected: tabIndex == 0,
              size: 30,
              onPressed: () {
                onTap(0);
              },
            ),
            _CustomNavButton(
              iconData: Icons.groups_outlined,
              isSelected: tabIndex == 1,
              size: 40,
              onPressed: () {
                onTap(1);
              },
            ),
            Container(
              width: size.width * 0.19,
            ),
            BlocBuilder<BrandNotificationsBloc, BrandNotificationsState>(
              builder: (context, state) {
                final unreadNotificationsCount = state.notifications
                    .where((notification) => notification.isRead ?? false)
                    .length;
                return _CustomNavButton(
                  customWidget: NotificationIcon(
                      notificationNumber: unreadNotificationsCount.toString(),
                      size: 33,
                      color: tabIndex == 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5)),
                  isSelected: tabIndex == 2,
                  onPressed: () {
                    onTap(2);
                  },
                );
              },
            ),
            _CustomNavButton(
              iconData: Icons.account_circle_outlined,
              isSelected: tabIndex == 3,
              size: 35,
              onPressed: () {
                onTap(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomNavButton extends StatelessWidget {
  final IconData? iconData;
  final bool isSelected;
  final Widget? customWidget;
  final void Function()? onPressed;
  final double size;

  const _CustomNavButton({
    this.iconData,
    required this.isSelected,
    this.size = 32,
    required this.onPressed,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: IconButton(
            icon: (iconData == null)
                ? customWidget!
                : Icon(
                    iconData,
                    color: (isSelected)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.5),
                    size: size,
                  ),
            onPressed: onPressed,
            splashColor: Colors.white,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 3,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
      ],
    );
  }
}
