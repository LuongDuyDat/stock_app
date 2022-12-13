import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/component/button.dart';
import 'package:stock_app/component/login_animated_picture.dart';
import 'package:stock_app/component/text_field.dart';
import 'package:stock_app/repositories/social_repository/models/user_hive.dart';
import 'package:stock_app/repositories/social_repository/user_hive_repository.dart';
import 'package:stock_app/screen/home/view/home.dart';
import 'package:stock_app/screen/login/bloc/login_bloc.dart';
import 'package:stock_app/screen/login/bloc/login_event.dart';
import 'package:stock_app/screen/login/bloc/login_state.dart';
import 'package:stock_app/screen/register/view/register.dart';
import 'package:stock_app/util/navigate.dart';
import 'package:stock_app/util/string.dart';

import '../../../util/globals.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    Box<UserHive> userBox = Hive.box<UserHive>('user');
    return BlocProvider(
      create: (_) => LoginBloc(userRepository: UserHiveRepository(userBox: userBox)),
      child: LoginView(),
    );
  }

}

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  int activeIndex = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 4) {
          activeIndex = 0;
        }
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 50,),
              SizedBox(
                height: 350,
                child: Stack(
                  children: [
                    LoginPicture(
                      activeIndex: activeIndex,
                      index: 0,
                      pictureUrl: 'https://ouch-cdn2.icons8.com/As6ct-Fovab32SIyMatjsqIaIjM9Jg1PblII8YAtBtQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNTg4/LzNmMDU5Mzc0LTky/OTQtNDk5MC1hZGY2/LTA2YTkyMDZhNWZl/NC5zdmc.png',
                    ),
                    LoginPicture(
                      activeIndex: activeIndex,
                      index: 1,
                      pictureUrl: 'https://ouch-cdn2.icons8.com/vSx9H3yP2D4DgVoaFPbE4HVf6M4Phd-8uRjBZBnl83g/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNC84/MzcwMTY5OS1kYmU1/LTQ1ZmEtYmQ1Ny04/NTFmNTNjMTlkNTcu/c3Zn.png',
                    ),
                    LoginPicture(
                      activeIndex: activeIndex,
                      index: 2,
                      pictureUrl: 'https://ouch-cdn2.icons8.com/fv7W4YUUpGVcNhmKcDGZp6pF1-IDEyCjSjtBB8-Kp_0/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMTUv/ZjUzYTU4NDAtNjBl/Yy00ZWRhLWE1YWIt/ZGM1MWJmYjBiYjI2/LnN2Zw.png',
                    ),
                    LoginPicture(
                      activeIndex: activeIndex,
                      index: 3,
                      pictureUrl: 'https://ouch-cdn2.icons8.com/AVdOMf5ui4B7JJrNzYULVwT1z8NlGmlRYZTtg1F6z9E/rs:fit:784:767/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvOTY5/L2NlMTY1MWM5LTRl/ZjUtNGRmZi05MjQ3/LWYzNGQ1MzhiOTQ0/Mi5zdmc.png',
                    ),
                  ]
                ),
              ),
              const SizedBox(height: 40,),
              InputField(label: emailString, hintText: userOrEmailString, icon: Icons.person, type: 0,),
              const SizedBox(height: 20,),
              InputField(label: passwordString, hintText: passwordString, icon: Icons.key, type: 0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {}, 
                    child: Text(
                      forgotPassString,
                      style: const TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  switch(state.loginStatus) {
                    case LoginStatus.initial:
                      return button(false);
                    case LoginStatus.loading:
                      return button(true);
                    case LoginStatus.success:
                      return FutureBuilder<Future>(
                        builder: (context, snapshot) {
                          return const Center();
                        },
                        future: Future.microtask(() {
                          Navigate.popPage(context);
                          return Navigate.pushPage(context, const HomePage());
                        }),
                      );
                    case LoginStatus.failure:
                      Future.delayed(const Duration(seconds: 1), () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email or Username are wrong',)));
                      });
                      context.read<LoginBloc>().add(LoginChangeStatus());
                      return Center();
                  }
                },
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doNotHaveAccountString,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0, fontWeight: FontWeight.w400,),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigate.pushPage(context, const RegisterPage());
                    },
                    child: Text(
                      registerString,
                      style: const TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget button(bool _isLoading) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Button(
          height: 45,
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: _isLoading == false ? Text(loginString, style: const TextStyle(color: Colors.white, fontSize: 16.0),)
              : Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
              strokeWidth: 2,
            ),
          ),
          onPressed: () {
            if (state.username.length < 6 || state.password.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please follow the instruction',)));
            } else {
              context.read<LoginBloc>().add(LoginSubmit());
            }
          },
        );
      },
    );
  }
}
