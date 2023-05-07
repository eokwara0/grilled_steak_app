import 'package:flutter/material.dart';

class EditTextField extends StatefulWidget {
  const EditTextField({
    super.key,
    required this.label,
    required this.hint,
    this.maxLines,
    this.padding,
    this.maxLength,
    this.height,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onEditingComplete,
    this.onTapOutside,
  });
  final String label;
  final String hint;
  final EdgeInsets? padding;
  final int? maxLength;
  final int? maxLines;
  final double? height;

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final Function(PointerDownEvent)? onTapOutside;

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            onTapOutside: widget.onTapOutside,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: widget.validator,
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            initialValue: widget.hint,
            cursorColor: Colors.amber.shade400,
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: UnderlineInputBorder(),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
          )
        ],
      ),
    );
  }
}
