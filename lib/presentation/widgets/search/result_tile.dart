import 'package:flutter/material.dart';

class ResultTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final String image;
  final String category;
  final bool? isFirst;
  const ResultTile(
      {super.key,
      required this.title,
      this.isFirst = false,
      required this.description,
      required this.category,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: isFirst!
            ? Border.all(color: Theme.of(context).colorScheme.primary)
            : Border.all(color: Theme.of(context).colorScheme.surface),
        color: isFirst!
            ? Theme.of(context).colorScheme.surfaceTint
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        title: Text(title),
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: isFirst!
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          description,
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 12,
          color: isFirst!
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          overflow: TextOverflow.ellipsis,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(image, width: 60, height: 60, fit: BoxFit.cover),
        ),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            isFirst!
                ? Icon(
                    Icons.subdirectory_arrow_left_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const SizedBox.shrink(),
            Text(category,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
