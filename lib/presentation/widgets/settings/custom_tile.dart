import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  final String title;
  final String content;
  final void Function(bool) onTap;
  const CustomTile({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                isSelected = value;
              });
            },
            backgroundColor: Colors.transparent,
            title: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16.5,
                  fontWeight:
                      (isSelected) ? FontWeight.w900 : FontWeight.normal,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            trailing: Icon(
              (isSelected)
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).colorScheme.onPrimary : Colors.grey,
              size: 30,
            ),
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    textAlign: TextAlign.justify,
                    widget.content,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
