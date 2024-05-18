
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void TextChanged(String text);

// Helper widget to track caret position.
class EditField extends StatefulWidget {
  EditField(
      {Key? key,
      this.onTextChanged,
      this.hint,
      this.label,
      this.validator,
      this.icon,
      this.val,
      this.isObscured = false})
      : super(key: key);
  final String? val;
  final TextChanged? onTextChanged;
  final String? hint;
  final String? label;
  final bool isObscured;
  final Icon? icon;
  final String? Function(String?)? validator;
  @override
  _EditFieldState createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        onChanged: widget.onTextChanged,
        initialValue:widget.val??null,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            hintText: widget.hint,
            labelText: widget.label,
          ),
          obscureText: widget.isObscured,
          validator: widget.validator),
    );
  }
}
