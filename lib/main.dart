import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/screen/home/view/home.dart';
import 'package:stock_app/screen/login/view/login.dart';
import 'package:stock_app/screen/social/blog.dart';
import 'package:stock_app/screen/social/home.dart';
import 'package:stock_app/screen/social/search.dart';

import 'bloc_observer.dart';

void main() async{
  // var client = FinanceYahooAPIClient();
  // StockChart result = await client.getStockChart("1d", "1m", "A");
  // for (int i = 0; i < result.close.length; i++) {
  //   print(result.close.elementAt(i));
  // }
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
