import 'package:flutter/material.dart';

class CustomDescriptionSheet extends StatelessWidget {
  final Widget child;
  const CustomDescriptionSheet({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Description',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 30,
                      ))
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
              height: 0,
              thickness: 1,
            ),
            Expanded(child: child),
            const SizedBox(
              height: 80,
            )
          ],
        ),
    );
  }
}