import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/utils/color.dart';

class TypeTextField extends StatefulWidget {
  const TypeTextField({
    Key? key,
    this.hintText,
    this.validator,
    this.iconData,
    this.keyboardType,
    required this.controller,
    this.autofillHints,
    this.hasObscureText,
    this.labelText,
    this.onEditingComplete,
    this.maxLength,
    this.enableInteractiveSelection = true,
    this.autocorrect = true,
    this.textInputAction,
    this.onTap,
    this.useOutlineBorder = false,
    this.autoFocus = false,
    this.cursorColor,
    this.cursorHeight,
    this.useDisabledBorder = false,
    this.enabled = true,
  }) : super(key: key);

  final String? hintText;
  final TextInputType? keyboardType;
  final IconData? iconData;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final Iterable<String>? autofillHints;
  final bool? hasObscureText;
  final String? labelText;
  final Function()? onEditingComplete;
  final int? maxLength;
  final bool enableInteractiveSelection;
  final bool autocorrect;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final bool useOutlineBorder;
  final bool autoFocus;
  final Color? cursorColor;
  final double? cursorHeight;
  final bool useDisabledBorder;
  final bool enabled;

  @override
  State<TypeTextField> createState() => _TypeTextFieldState();
}

class _TypeTextFieldState extends State<TypeTextField> {
  bool _secureText = false;

  bool obscureText() {
    if (widget.hasObscureText == null) {
      return false;
    } else {
      return !_secureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: widget.autofillHints,
      maxLength: widget.maxLength,
      autofocus: widget.autoFocus,
      cursorColor: widget.cursorColor,
      cursorHeight: widget.cursorHeight,
      enabled: widget.enabled,
      style: (widget.enabled)
          ? const TextStyle(color: Colors.white)
          : TextStyle(color: Colors.grey.shade700),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: (widget.enabled)
            ? const TextStyle(
                color: Colors.white,
              )
            : TextStyle(
                color: Colors.grey.shade700,
              ),
        hintText: widget.hintText ?? "",
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 2,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 2,
        ),
        enabledBorder: (widget.useOutlineBorder)
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
        disabledBorder: (widget.useDisabledBorder)
            ? OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade700, width: 2),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
        suffixIcon: widget.hasObscureText == null
            ? Icon(widget.iconData)
            : IconButton(
                onPressed: () {
                  setState(() {
                    _secureText = !_secureText;
                  });
                },
                icon: Icon(
                  _secureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black54,
                ),
              ),
      ),
      obscureText: obscureText(),
      keyboardType: widget.keyboardType ?? TextInputType.text,
      autocorrect: widget.autocorrect,
      enableSuggestions: true,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "សូមបំពេញវាលនេះ";
            } else {
              return null;
            }
          },
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
    );
  }
}
