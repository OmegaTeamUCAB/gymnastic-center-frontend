import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType; // Added keyboardType parameter
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;

  const CustomTextInput({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.errorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        prefixIconColor: const Color.fromRGBO(200, 204, 217, 1),
        prefixIcon: prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      style: TextStyle(
          fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
    );
  }
}
