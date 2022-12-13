import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/component/button.dart';
import 'package:stock_app/component/text_field.dart';
import 'package:stock_app/screen/verification.dart';
import 'package:stock_app/util/navigate.dart';
import 'package:stock_app/util/string.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController controller = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://ouch-cdn2.icons8.com/n9XQxiCMz0_zpnfg9oldMbtSsG7X6NwZi_kLccbLOKw/rs:fit:392:392/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNDMv/MGE2N2YwYzMtMjQw/NC00MTFjLWE2MTct/ZDk5MTNiY2IzNGY0/LnN2Zw.png', fit: BoxFit.cover, width: 280, ),
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
                    const SizedBox(height: 10,),
                    InputField(
                      label: nameString,
                      hintText: nameString,
                      icon: Icons.label,
                      type: 1,
                    ),
                    const SizedBox(height: 10,),
                    InputField(
                      label: emailString,
                      hintText: emailString,
                      icon: Icons.email,
                      type: 0,
                    ),
                    const SizedBox(height: 20,),
                    InputField(
                      label: usernameString,
                      hintText: usernameString,
                      icon: Icons.person,
                      type: 0,
                    ),
                    const SizedBox(height: 20,),
                    InputField(
                      label: passwordString,
                      hintText: passwordString,
                      icon: Icons.password,
                      type: 0,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60,),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                child: Button(
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
                  Text(requestOtp, style: const TextStyle(color: Colors.white),),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });

                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        _isLoading = false;
                      });
                      Navigate.pushPage(context, const Verification());
                    });
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
      )
    );
  }
}
