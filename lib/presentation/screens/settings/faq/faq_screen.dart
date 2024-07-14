import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/models/search_filter.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:gymnastic_center/presentation/widgets/settings/custom_tile.dart';
import 'package:gymnastic_center/presentation/widgets/settings/faq/faq_info.dart';
import 'package:gymnastic_center/presentation/widgets/settings/faq/faq_items.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<FaqInfo> faqItems = FaqItems.items;
  final List<SearchFilter> filterChips = [];
  final List<String> searchFilters = [];

  @override
  void initState() {
    searchFilters.add(faqItems.first.value);
    filterChips.addAll(addFilterChips());
    faqFilter();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<SearchFilter> addFilterChips() {
    Set<String> values = {};
    final List<SearchFilter> searchFilterList = [];

    for (FaqInfo item in faqItems) {
      if (!values.contains(item.value)) {
        values.add(item.value);
        searchFilterList
            .add(SearchFilter(label: item.label, value: item.value));
      }
    }

    return searchFilterList;
  }

  void addFilter(String filterValue) {
    searchFilters.add(filterValue);
    faqFilter();
    setState(() {});
  }

  void removeFilter(String filterValue) {
    if (searchFilters.length == 1) return;
    searchFilters.remove(filterValue);
    faqFilter();
    setState(() {});
  }

  void faqFilter() {
    faqItems = FaqItems.items
        .where((item) => searchFilters.contains(item.value))
        .toList();
  }

  void seeAll() {
    searchFilters.clear();
    for (var element in filterChips) {
      searchFilters.add(element.value);
    }
    faqFilter();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 120),
        child: CustomAppBar(
            content: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const BrandBackButton(),
              Text(
                AppLocalizations.of(context)!.faq,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterChips.length,
                itemBuilder: (context, index) {
                  final filter = filterChips[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: FilterChip(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceTint,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: searchFilters.contains(filter.value)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.surfaceTint,
                            ),
                            borderRadius: BorderRadius.circular(60)),
                        label: Text(
                          filter.label,
                        ),
                        labelStyle: TextStyle(
                          color: searchFilters.contains(filter.value)
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.primary,
                        ),
                        selected: searchFilters.contains(filter.value),
                        onSelected: (bool selected) {
                          if (selected) {
                            addFilter(filter.value);
                          } else {
                            removeFilter(filter.value);
                          }
                        }),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                final faqInfo = faqItems[index];
                return CustomTile(
                  title: faqInfo.title,
                  content: faqInfo.content,
                  onTap: (p0) {},
                );
              },
            ),
          ),
          if (searchFilters.length != filterChips.length)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: BrandButton(
                text: 'See all',
                onPressed: seeAll,
              ),
            ),
        ],
      ),
    );
  }
}
