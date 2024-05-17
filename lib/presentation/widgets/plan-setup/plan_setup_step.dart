import 'package:flutter/material.dart';

class PlanSetupStep extends StatefulWidget {
  final dynamic options; //TODO: Change this to the actual type
  final dynamic isRadio; //TODO: Change this to the actual type
  const PlanSetupStep({super.key, this.options, this.isRadio});

  @override
  State<PlanSetupStep> createState() => _PlanSetupStepState();
}

class _PlanSetupStepState extends State<PlanSetupStep> {
  int _selectedRadioTile = 0;
  final Map<int, bool> _checkboxValues = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map<Widget>((option) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (widget.isRadio) {
                _selectedRadioTile = option['value'];
              } else {
                _checkboxValues[option['value']] =
                    !(_checkboxValues[option['value']] ?? false);
              }
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              color: widget.isRadio
                  ? (_selectedRadioTile == option['value']
                      ? Theme.of(context).colorScheme.surfaceTint
                      : Theme.of(context).colorScheme.background)
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                option['title'],
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(option['description']),
              trailing: IgnorePointer(
                child: widget.isRadio
                    ? Radio<int>(
                        activeColor: Theme.of(context).colorScheme.primary,
                        value: option['value'],
                        groupValue: _selectedRadioTile,
                        onChanged: (int? value) {},
                      )
                    : Checkbox(
                        checkColor: Theme.of(context).colorScheme.onSurface,
                        value: _checkboxValues[option['value']] ?? false,
                        onChanged: (bool? value) {},
                      ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
