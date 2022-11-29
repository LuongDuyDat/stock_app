import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_app/component/button.dart';
import 'package:stock_app/component/login_animated_picture.dart';
import 'package:stock_app/component/text_field.dart';
import 'package:stock_app/util/string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              InputField(label: emailString, hintText: userOrEmailString, icon: Icons.person),
              const SizedBox(height: 20,),
              InputField(label: passwordString, hintText: passwordString, icon: Icons.key),
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
              Button(
                height: 45,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                text: Text(loginString, style: const TextStyle(color: Colors.white, fontSize: 16.0),),
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
                    onPressed: () {}, 
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
}
