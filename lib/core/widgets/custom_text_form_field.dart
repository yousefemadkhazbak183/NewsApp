import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.maxLines = 1,
    required this.hintText,
    required this.controller,
    this.validator,
    required this.title,
    this.suffix,
    this.obscureText = false,
  });
  final TextEditingController controller;
  final String title;
  final int? maxLines;
  final String hintText;
  final Function(String?)? validator;
  final Widget? suffix;
  final bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).inputDecorationTheme.hintStyle,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          cursorRadius: const Radius.circular(3),
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
          ),
          validator: widget.validator != null
              ? (String? value) => widget.validator!(value)
              : null,

          maxLines: widget.maxLines,
          obscureText: widget.obscureText && !isVisible,
        ),
      ],
    );
  }
}
