import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key, required this.label, required this.hintText, required this.icon}) : super(key: key);

  final String label;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefixIcon: Icon(icon, color: Colors.black, size: 18, ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

}