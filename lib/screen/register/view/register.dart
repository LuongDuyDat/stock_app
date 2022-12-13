import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/component/button.dart';
import 'package:stock_app/component/text_field.dart';
import 'package:stock_app/screen/login/view/login.dart';
import 'package:stock_app/screen/register/bloc/register_bloc.dart';
import 'package:stock_app/screen/register/bloc/register_event.dart';
import 'package:stock_app/screen/register/bloc/register_state.dart';
import 'package:stock_app/util/globals.dart';
import 'package:stock_app/util/navigate.dart';
import 'package:stock_app/util/string.dart';

import '../../../repositories/social_repository/models/user_hive.dart';
import '../../../repositories/social_repository/user_hive_repository.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box<UserHive> userBox = Hive.box<UserHive>('user');
    return BlocProvider(
      create: (_) => RegisterBloc(userRepository: UserHiveRepository(userBox: userBox)),
      child: RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterView> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://ouch-cdn2.icons8.com/n9XQxiCMz0_zpnfg9oldMbtSsG7X6NwZi_kLccbLOKw/rs:fit:392:392/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNDMv/MGE2N2YwYzMtMjQw/NC00MTFjLWE2MTct/ZDk5MTNiY2IzNGY0/LnN2Zw.png', fit: BoxFit.cover, width: 280,),
              const SizedBox(height: 50,),
              FadeInDown(
                child: Text(
                  registerCapitalString,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.grey.shade900),
                ),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                  child: Text(
                    registerInstructionString,
                    textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                child: Column(
                  children: [
                    const SizedBox(height: 15,),
                    InputField(
                      label: nameString,
                      hintText: nameString,
                      icon: Icons.label,
                      type: 1,
                    ),
                    const SizedBox(height: 15,),
                    InputField(
                      label: emailString,
                      hintText: emailString,
                      icon: Icons.email,
                      type: 2,
                    ),
                    const SizedBox(height: 15,),
                    InputField(
                      label: usernameString,
                      hintText: usernameString,
                      icon: Icons.person,
                      type: 2,
                    ),
                    const SizedBox(height: 15,),
                    InputField(
                      label: passwordString,
                      hintText: passwordString,
                      icon: Icons.password,
                      type: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    switch(state.registerStatus) {
                      case RegisterStatus.initial:
                        return button(false);
                      case RegisterStatus.loading:
                        return button(true);
                      case RegisterStatus.success:
                        return FutureBuilder<Future>(
                          builder: (context, snapshot) {
                            return const Center();
                          },
                          future: Future.microtask(() {
                            Navigate.popPage(context);
                            return Navigate.pushPageReplacement(context, const LoginPage());
                          }),
                        );
                      case RegisterStatus.failure:
                        Future.delayed(const Duration(seconds: 1), () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email or Username are existed',)));
                        });
                        context.read<RegisterBloc>().add(RegisterChangeRegisterStatus());
                        return Center();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20,),
              FadeInDown(
                delay: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(alreadyHaveAccount, style: TextStyle(color: Colors.grey.shade700),),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: () {
                        Navigate.popPage(context);
                      },
                      child: Text(loginString, style: const TextStyle(color: Colors.black),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button(bool _isLoading) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Button(
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: _isLoading  ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.black,
                strokeWidth: 2,
              ),
            ) :
            Text(registerString, style: const TextStyle(color: Colors.white),),
            onPressed: () {
              if (state.username.length < 6 || state.password.length < 6 || state.name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please follow the instruction',)));
              } else {
                if (state.email.length <= 10 || state.email.substring(state.email.length - 10) != "@gmail.com") {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please follow the instruction',)));
                } else {
                  context.read<RegisterBloc>().add(RegisterSubmit());
                }
              }
            },
          );
        },
    );

  }
}
