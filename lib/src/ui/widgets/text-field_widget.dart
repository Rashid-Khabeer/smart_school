import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/src/utility/constants.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final TextInputType textInputType;
  final IconData iconData;
  final Function(String) onSaved;
  final Function(String) validator;
  final int maxLines;
  final String initialValue;

  AppTextField({
    this.iconData,
    this.textInputType = TextInputType.text,
    @required this.onSaved,
    @required this.labelText,
    @required this.validator,
    this.maxLines = 1,
    this.initialValue = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: textInputType,
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines,
      decoration: kInputDecoration.copyWith(
        labelText: labelText,
        hintText: labelText,
        prefixIcon: Icon(iconData),
      ),
    );
  }
}

class AppPasswordField extends StatefulWidget {
  final String labelText;
  final Function(String) onSaved;
  final Function(String) validator;
  final Function(String) onChanged;

  AppPasswordField({
    @required this.onSaved,
    @required this.labelText,
    @required this.validator,
    this.onChanged,
  });

  @override
  _AppPasswordFieldState createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscure,
      keyboardType: TextInputType.text,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onChanged: (widget?.onChanged == null) ? (value) {} : widget.onChanged,
      decoration: kInputDecoration.copyWith(
        labelText: widget.labelText,
        hintText: widget.labelText,
        prefixIcon: Icon(CupertinoIcons.lock),
        suffixIcon: InkWell(
          onTap: () => setState(() => _obscure = !_obscure),
          child:
              Icon(_obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
        ),
      ),
    );
  }
}
