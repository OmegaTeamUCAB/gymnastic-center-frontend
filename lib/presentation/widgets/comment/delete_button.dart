import 'package:flutter/material.dart';


class DeleteButton extends StatelessWidget {
  final String modalTitle;
  final String buttonLabel;
  final Function onPressed;
  const DeleteButton({
    super.key, required this.modalTitle, required this.buttonLabel, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (BuildContext context) {
              return SizedBox(
                height: 120,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Text(
                        modalTitle,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        onPressed;
                      },
                      icon: Icon(Icons.delete_outline_rounded,
                          size: 20,
                          color:
                              Theme.of(context).colorScheme.onPrimary),
                      label: Text(
                        buttonLabel,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary),
                      ),
                    )
                  ],
                ),
              );
            });
      },
      icon: const Icon(
        Icons.delete_outline_rounded,
        size: 20,
      ),
    );
  }
}
