import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/finance_yahoo_api/finance_yahoo_api.dart';
import 'package:stock_app/finance_yahoo_api/models/stock_chart.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_news.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_search.dart';
import 'package:stock_app/pages/bottom_navy_bar.dart';
import 'package:stock_app/screen/home/view/home.dart';
import 'package:stock_app/screen/login.dart';
import 'package:stock_app/screen/stock/view/stocks.dart';

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
      home:  const StocksPage(
        shortName: 'Agilient Technologies',
        symbol: 'A',
        different: -3.33455,
        regularMarket: 152.952323,
      ),
    );
  }
}

