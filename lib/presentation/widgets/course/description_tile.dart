import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comments_list.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_description_sheet.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_modal_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class DescriptionTile extends StatelessWidget {
  final String? description;
  final void Function()? onTap;
  const DescriptionTile({super.key, required this.description, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Description'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Theme.of(context).colorScheme.surfaceTint,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 18,
        ),
        trailing: Icon(Icons.description,
            color: Theme.of(context).colorScheme.onPrimary),
        onTap: () {
          if(onTap != null) onTap!();
          showModalBottomSheet(
            backgroundColor: Theme.of(context).colorScheme.background,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (BuildContext context) {
              return CustomDescriptionSheet(
                child: (description != null) ? SingleChildScrollView(child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(description!, style: TextStyle(fontSize: 16),),
                )) : NoResults(message: 'Description not found',),
              );
            },
          );
        });
  }
}
