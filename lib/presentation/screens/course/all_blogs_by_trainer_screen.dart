import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/utils/pagination_controller.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class AllBlogsByTrainerScreen extends StatefulWidget {
  final Map trainer;
  const AllBlogsByTrainerScreen({super.key, required this.trainer});

  @override
  State<AllBlogsByTrainerScreen> createState() =>
      _AllBlogsByTrainerScreenState();
}

class _AllBlogsByTrainerScreenState extends State<AllBlogsByTrainerScreen> {
  late final PaginationController paginationController;
  // final allBlogsBloc = GetIt.instance<AllBlogsBloc>();

  // @override
  // void initState() {
  //   super.initState();
  //   //! Buggy as hell
  //   paginationController = PaginationController(
  //     requestNextPage: (page) => allBlogsBloc.add(AllBlogsRequested(page)),
  //   );
  // }

  @override
  void dispose() {
    paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.trainer['id'];
    String name = widget.trainer['name'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: CustomAppBar(
          content: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  const BrandBackButton(),
                  Text(
                    'All Blogs by $name',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
