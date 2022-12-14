import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stock_app/repositories/social_repository/models/comment_hive.dart';
import 'package:stock_app/repositories/social_repository/models/favorite_symbol.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/repositories/social_repository/models/user_hive.dart';
import 'package:stock_app/screen/login/view/login.dart';
import 'package:stock_app/screen/social/home/social_home_view/blog.dart';

import 'bloc_observer.dart';

void main() async{
  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveAdapter());
  Hive.registerAdapter(PostHiveAdapter());
  Hive.registerAdapter(FavoriteSymbolHiveAdapter());
  Hive.registerAdapter(CommentHiveAdapter());
  //await init_database();
  await Hive.openBox<UserHive>('user');
  await Hive.openBox<PostHive>('post');
  await Hive.openBox<FavoriteSymbolHive>('symbol');
  await Hive.openBox<CommentHive>('comment');
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

Future<void> init_database() async {
  await Hive.deleteBoxFromDisk('user');
  await Hive.deleteBoxFromDisk('post');
  await Hive.deleteBoxFromDisk('symbol');
  await Hive.deleteBoxFromDisk('comment');
}
