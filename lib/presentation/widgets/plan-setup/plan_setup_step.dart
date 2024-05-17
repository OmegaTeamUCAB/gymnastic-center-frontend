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
        return widget.isRadio
            ? RadioListTile<int>(
                title: Text(option['title']),
                value: option['value'],
                groupValue: _selectedRadioTile,
                onChanged: (int? value) {
                  setState(() {
                    _selectedRadioTile = value!;
                  });
                },
              )
            : CheckboxListTile(
                title: Text(option['title']),
                value: _checkboxValues[option['value']] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _checkboxValues[option['value']] = value!;
                  });
                },
              );
      }).toList(),
    );
  }
}
