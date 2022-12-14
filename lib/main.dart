import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stock_app/repositories/social_repository/models/comment_hive.dart';
import 'package:stock_app/repositories/social_repository/models/favorite_symbol.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/repositories/social_repository/models/user_hive.dart';
import 'package:stock_app/screen/login/view/login.dart';
import 'package:stock_app/screen/social/blog.dart';

import 'bloc_observer.dart';

void main() async{
  // var client = FinanceYahooAPIClient();
  // StockChart result = await client.getStockChart("1d", "1m", "A");
  // for (int i = 0; i < result.close.length; i++) {
  //   print(result.close.elementAt(i));
  // }
  // ModelAPI modelAPI = ModelAPI();
  // double values1 = 148.30999755859375;
  // List<double> m = await modelAPI.getPredict('A', values1.toString(), 147.80999755859375.toString(),
  //     146.6300048828125.toString(),
  //     142.91000366210938.toString(),
  //     140.94000244140625.toString(),
  //     142.64999389648438.toString(),
  //     142.16000366210938.toString(),);
  //
  // for (int i = 0; i < m.length; i++) {
  //   print(m.elementAt(i));
  // }
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
      home: const BlogPage(symbol: 'AAPL'),
    );
  }
}

Future<void> init_database() async {
  await Hive.deleteBoxFromDisk('user');
  await Hive.deleteBoxFromDisk('post');
  await Hive.deleteBoxFromDisk('symbol');
  await Hive.deleteBoxFromDisk('comment');
}
