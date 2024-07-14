import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/select_data_source/select_data_source_bloc.dart';
import 'package:gymnastic_center/presentation/screens/search_screen.dart';
import 'package:gymnastic_center/presentation/widgets/icons/gymnastic_center_icons.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function() openDrawer;
  const MainAppBar({super.key, required this.openDrawer});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final selectDataSourceBloc = GetIt.instance<SelectDataSourceBloc>();
    final dataSourceLetter = selectDataSourceBloc.state.dataSourceLetter;
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/particles.png'),
              alignment: Alignment.bottomLeft,
              fit: BoxFit.cover),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFF4F14A0), Color(0xFF8066FF)],
          ),
        ),
      ),
      leading: IconButton(
        onPressed: openDrawer,
        icon: const Icon(
          Icons.menu_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
          icon: const Icon(
            GymnasticCenter.search,
            size: 25,
            color: Colors.white,
          ),
        )
      ],
      centerTitle: true,
      title: Text(dataSourceLetter,
          style: const TextStyle(fontSize: 35, color: Colors.white)),
    );
  }
}
