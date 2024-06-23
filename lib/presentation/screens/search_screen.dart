import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/search/search_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/search/custom_search_bar.dart';
import 'package:gymnastic_center/presentation/widgets/search/search_chips.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = GetIt.instance<SearchBloc>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocProvider<SearchBloc>.value(
          value: searchBloc,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    //*makes searchBar clickable
                    height: 155,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Expanded(
                    child: SearchChips(),
                  ),
                ],
              ),
              const CustomAppBar(
                content: Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    children: [
                      BrandBackButton(),
                      Text(
                        'Popular Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const Positioned(
                  top: 110,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomSearchBar(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
