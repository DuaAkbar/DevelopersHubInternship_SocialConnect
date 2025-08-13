import 'package:flutter/material.dart';

class Textfields extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;
  const Textfields({
    super.key,
    required this.label,
    required this.textEditingController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.0,
            ),
          ),

          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
