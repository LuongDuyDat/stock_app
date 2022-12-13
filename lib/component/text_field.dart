import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/screen/login/bloc/login_bloc.dart';
import 'package:stock_app/screen/login/bloc/login_event.dart';
import 'package:stock_app/screen/register/bloc/register_bloc.dart';
import 'package:stock_app/screen/register/bloc/register_event.dart';

import '../util/string.dart';

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
    if (widget.type == 0 || widget.type == 2) {
      if (text.isEmpty) {
        return 'Can\'t be empty';
      }
      if (text.length < 6 || (text.length <= 10 && widget.label == emailString)) {
        return 'Too short';
      }
      if (widget.type == 2 && text.length > 10 && widget.label == emailString && text.substring(text.length - 10) != "@gmail.com") {
        return 'Format of email is not true';
      }
    } else {
      print(1);
      print(text);
      if (text.isEmpty) {
        return 'Can\'t be empty';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: Colors.black,
      obscureText: widget.label == passwordString ? true : false,
      onChanged: (text) {
        if (widget.type == 0) {
          if (widget.label == emailString) {
            context.read<LoginBloc>().add(LoginUserNameChange(username: text));
          } else {
            context.read<LoginBloc>().add(LoginPasswordChange(password: text));
          }
        } else {
          if (widget.label == nameString) {
            context.read<RegisterBloc>().add(RegisterNameChange(name: text));
          } else {
            if (widget.label == emailString) {
              context.read<RegisterBloc>().add(RegisterEmailChange(email: text));
            } else {
              if (widget.label == usernameString) {
                context.read<RegisterBloc>().add(RegisterUserNameChange(username: text));
              } else {
                context.read<RegisterBloc>().add(RegisterPasswordChange(password: text));
              }
            }
          }
        }
        setState(() {

        });
      },
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