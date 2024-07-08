import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextInput({
    super.key,
    this.labelText,
    this.initialValue,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.errorText,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        prefixIconColor: Theme.of(context).colorScheme.outline,
        prefixIcon: prefixIcon,
        suffixIconColor: Theme.of(context).colorScheme.primary,
        suffixIcon: suffixIcon,
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
