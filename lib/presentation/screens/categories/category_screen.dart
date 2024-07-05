import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/categories/blogs_by_category_view.dart';
import 'package:gymnastic_center/presentation/widgets/categories/courses_by_category_view.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_chip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  const CategoryScreen(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String selectedChip = 'Courses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 150),
        child: CustomAppBar(
          content: Column(
            children: [
              Row(
                children: [
                  const BrandBackButton(),
                  Text(
                    widget.categoryName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomChip(
                    label: AppLocalizations.of(context)!.courses,
                    isSelected: selectedChip == 'Courses',
                    onTap: (isSelected) {
                      setState(() {
                        selectedChip = 'Courses';
                      });
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomChip(
                    label: "Blogs",
                    isSelected: selectedChip == 'Blogs',
                    onTap: (isSelected) {
                      setState(() {
                        selectedChip = 'Blogs';
                      });
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: selectedChip == 'Blogs'
          ? BlogsByCategoryView(
              categoryId: widget.categoryId,
            )
          : CoursesByCategoryView(categoryId: widget.categoryId),
    );
  }
}
