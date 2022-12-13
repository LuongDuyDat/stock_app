import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({Key? key, required this.label, required this.hintText, required this.icon, required this.type}) : super(key: key);

  final String label;
  final String hintText;
  final IconData icon;
  final int type;

  @override
  State<StatefulWidget> createState() => _InputFieldState();

}

class _InputFieldState extends State<InputField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? get _errorText {
    final text = _controller.value.text;
    if (widget.type == 0) {
      if (text.isEmpty) {
        return 'Can\'t be empty';
      }
      if (text.length < 6) {
        return 'Too short';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        errorText: _errorText,
        contentPadding: const EdgeInsets.all(0.0),
        labelText: widget.label,
        hintText: widget.hintText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefixIcon: Icon(widget.icon, color: Colors.black, size: 18, ),
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