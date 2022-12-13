import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/component/stock_chart.dart';
import 'package:stock_app/component/stock_info.dart';
import 'package:stock_app/repositories/social_repository/models/user_hive.dart';
import 'package:stock_app/repositories/social_repository/user_hive_repository.dart';
import 'package:stock_app/screen/home/view/home.dart';
import 'package:stock_app/screen/social/blog.dart';
import 'package:stock_app/screen/stock/bloc/stock_bloc/stock_bloc.dart';
import 'package:stock_app/screen/stock/bloc/stock_bloc/stock_event.dart';
import 'package:stock_app/screen/stock/bloc/stock_bloc/stock_state.dart';
import 'package:stock_app/screen/stock/view/predict_stock.dart';
import 'package:stock_app/util/navigate.dart';
import 'package:stock_app/util/string.dart';

import '../../../repositories/symbol_repository/symbol_repository.dart';
import '../../../util/globals.dart';

class StocksPage extends StatelessWidget {
  const StocksPage({ Key? key, required this.symbol, required this.shortName, required this.regularMarket, required this.different,}) : super(key: key);

  final String symbol;
  final String shortName;
  final double regularMarket;
  final double different;

  @override
  Widget build(BuildContext context) {
    SymbolRepository repository = SymbolRepository();
    Box<UserHive> userBox = Hive.box<UserHive>('user');
    UserHiveRepository userHiveRepository = UserHiveRepository(userBox: userBox);
    return BlocProvider(
      create: (_) => StockBloc(symbolRepository: repository, userHiveRepository: userHiveRepository,),
      child: StockPageView(symbol: symbol, shortName: shortName, different: different, regularMarket: regularMarket,),
    );
  }
}

class StockPageView extends StatelessWidget {
  const StockPageView({Key? key, required this.shortName, required this.symbol, required this.regularMarket, required this.different,}) : super(key: key);

  final String symbol;
  final String shortName;
  final double regularMarket;
  final double different;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Row(
            children: [
              SizedBox(width: screenWidth * 0.018,),
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                  Navigate.pushPageReplacement(context, HomePage());
                },
              ),
            ],
          ),
          title: Text(
            symbol,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            BlocBuilder<StockBloc, StockState>(
              builder: (context, state) {
                switch(state.favoriteStatus) {
                  case StockStatus.initial:
                    context.read<StockBloc>().add(StockCheckFavorite(symbol: symbol,));
                    return const Center();
                  case StockStatus.loading:
                    return const Center();
                  default:
                    return DropdownButton(
                      value: null,
                      items: state.dropDownItem.map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (dynamic a) {
                        if (a == joinGroupString) {
                          Navigate.pushPage(context, BlogPage());
                        }
                        if (a == addToListString) {
                          context.read<StockBloc>().add(StockChangeFavorite(symbol: symbol, shortName: shortName, type: 0));
                        }
                        if (a == deleteFromListString) {
                          context.read<StockBloc>().add(StockChangeFavorite(symbol: symbol, shortName: shortName, type: 1));
                        }
                        if (a == predictString) {
                          Navigate.pushPage(context, PredictStockPage(
                            symbol: symbol,
                            shortName: shortName,
                            regularMarket: regularMarket,
                            different: different,
                            open: state.quote.open,
                            high: state.quote.high,
                            low: state.quote.low,
                          ));
                        }
                      },
                      icon: Icon(Icons.more_horiz),
                    );
                }
              },
            ),
            SizedBox(width: screenWidth * 0.06,),
          ],
        ),
        body: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.04 * screenHeight,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.064 * screenWidth),
                child: BlocBuilder<StockBloc, StockState>(
                  builder: (context, state) {
                    switch (state.quoteStatus){
                      case StockStatus.initial:
                        context.read<StockBloc>().add(StockGetQuote(symbol: symbol));
                        return const Center();
                      case StockStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case StockStatus.success:
                        return StockInfo(
                          symbol: symbol,
                          shortName: shortName,
                          regularMarketValue: regularMarket,
                          different: different,
                          open: state.quote.open,
                          high: state.quote.high,
                          low: state.quote.low,
                        );
                      case StockStatus.failure:
                        return const Center(
                          child: Text("Something went wrong", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,),),
                        );
                    }
                  },
                ),
              ),
              SizedBox(height:  screenHeight * 0.05,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.064 * screenWidth),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(201, 201, 201, 1),),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    SizedBox(height:  screenHeight * 0.03,),
                    BlocBuilder<StockBloc, StockState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<StockBloc>().add(const StockChangeIndex(index: 0,));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: state.selectIndex == 0 ? const Color(0xff161b22) : const Color.fromRGBO(240, 240, 240, 1),
                                ),
                                child: Text("D", style: TextStyle(color: state.selectIndex == 0 ? Colors.blueGrey.shade200 : Colors.blueGrey, fontSize: 20),),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<StockBloc>().add(const StockChangeIndex(index: 1,));
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: state.selectIndex == 1 ? const Color(0xff161b22) : const Color.fromRGBO(240, 240, 240, 1),
                                ),
                                child: Text("M", style: TextStyle(color: state.selectIndex == 1 ? Colors.blueGrey.shade200 : Colors.blueGrey, fontSize: 20),),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<StockBloc>().add(const StockChangeIndex(index: 2,));
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: state.selectIndex == 2 ? const Color(0xff161b22) : const Color.fromRGBO(240, 240, 240, 1),
                                ),
                                child: Text("Y", style: TextStyle(color: state.selectIndex == 2 ? Colors.blueGrey.shade200 : Colors.blueGrey, fontSize: 20),),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height:  screenHeight * 0.04,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03 * screenWidth),
                      child: BlocBuilder<StockBloc, StockState>(
                        builder: (context, state) {
                          switch (state.chartStatus){
                            case StockStatus.initial:
                              context.read<StockBloc>().add(StockGetChart(symbol: symbol,));
                              return const Center();
                            case StockStatus.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case StockStatus.success:
                              return SizedBox(
                                height: 0.3 * screenHeight,
                                width: double.infinity,
                                child: StockChartComponent(
                                  close: state.selectIndex == 0 ? state.dayStock.close : (state.selectIndex == 1 ? state.monthStock.close : state.yearStock.close),
                                  type: "stock",
                                  difference: different,
                                  timeStamp: state.selectIndex == 0 ? state.dayStock.timeStamp : (state.selectIndex == 1 ? state.monthStock.timeStamp : state.yearStock.timeStamp),
                                  index: state.selectIndex,
                                ),
                              );
                            case StockStatus.failure:
                              return const Center(
                                child: Text("Something went wrong", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,),),
                              );
                          }
                        },
                      ),
                    ),
                    SizedBox(height:  screenHeight * 0.03,),
                  ],
                ),
              ),
              // FadeInUp(
              //   duration: const Duration(milliseconds: 1000),
              //   from: 30,
              //   child: Text(
              //     '\$ 4,777.12',
              //     style: GoogleFonts.poppins(
              //       textStyle: TextStyle(
              //         color: Colors.blueGrey.shade100,
              //         fontSize: 36,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 10,),
              // FadeInUp(
              //   duration: const Duration(milliseconds: 1000),
              //   from: 30,
              //   child: const Text(
              //     '+1.5%',
              //     style: TextStyle(
              //       fontSize: 18,
              //       color: Colors.green,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 100),
              // FadeInUp(
              //   duration: const Duration(milliseconds: 1000),
              //   from: 60,
              //   child: SizedBox(
              //       height: MediaQuery.of(context).size.height * 0.3,
              //       child: LineChart(
              //         mainData(),
              //         swapAnimationCurve: Curves.easeInOutCubic,
              //         swapAnimationDuration: const Duration(milliseconds: 1000),
              //       )
              //   ),
              // ),
            ]
        )
    );
  }

  // // Charts Data
  // List<Color> gradientColors = [
  //   // const Color(0xffe68823),
  //   // const Color(0xffe68823),
  //   const Color(0xff23b6e6),
  //   const Color(0xff02d39a),
  // ];

  // LineChartData mainData() {
  //   return LineChartData(
  //     borderData: FlBorderData(
  //       show: false,
  //     ),
  //     gridData: FlGridData(
  //         show: false,
  //         horizontalInterval: 1.6,
  //         drawVerticalLine: false
  //     ),
  //     titlesData: FlTitlesData(
  //       show: true,
  //       rightTitles: AxisTitles(
  //         sideTitles: SideTitles(showTitles: true, reservedSize: 10),
  //       ),
  //       topTitles: AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 22,
  //           interval: 1,
  //           getTitlesWidget: bottomTitleWidgets,
  //         ),
  //       ),
  //       leftTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           interval: 1,
  //           getTitlesWidget: leftTitleWidgets,
  //           reservedSize: 35,
  //         ),
  //       ),
  //     ),
  //     minX: 0,
  //     maxX: _currentIndex == 0 ? _daylySpots.length-1.toDouble() : _currentIndex == 1 ? _monthlySpots.length-1.toDouble() : _currentIndex == 2 ? _daylySpots.length-20.toDouble() : _daylySpots.length.toDouble(),
  //     minY: 0,
  //     maxY: 200,
  //     lineTouchData: LineTouchData(
  //       getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
  //         return spotIndexes.map((index) {
  //           return TouchedSpotIndicatorData(
  //             FlLine(
  //               color: Colors.white.withOpacity(0.1),
  //               strokeWidth: 2,
  //               dashArray: [3, 3],
  //             ),
  //             FlDotData(
  //               show: false,
  //               getDotPainter: (spot, percent, barData, index) =>
  //                   FlDotCirclePainter(
  //                     radius: 8,
  //                     color: [
  //                       Colors.black,
  //                       Colors.black,
  //                     ][index],
  //                     strokeWidth: 2,
  //                     strokeColor: Colors.black,
  //                   ),
  //             ),
  //           );
  //         }).toList();
  //       },
  //       enabled: true,
  //       touchTooltipData: LineTouchTooltipData(
  //         tooltipPadding: const EdgeInsets.all(8),
  //         tooltipBgColor: const Color(0xff2e3747).withOpacity(0.8),
  //         getTooltipItems: (touchedSpots) {
  //           return touchedSpots.map((touchedSpot) {
  //             return LineTooltipItem(
  //               '\$${touchedSpot.y.round()}.00',
  //               const TextStyle(color: Colors.white, fontSize: 12.0),
  //
  //             );
  //           }).toList();
  //         },
  //       ),
  //       handleBuiltInTouches: true,
  //     ),
  //     lineBarsData: [
  //       LineChartBarData(
  //         spots: _currentIndex == 0 ? _daylySpots : _currentIndex == 1 ? _monthlySpots : _daylySpots,
  //         isCurved: true,
  //         gradient: LinearGradient(
  //           colors: [
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //             ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                 .lerp(0.2)!,
  //           ],
  //         ),
  //         barWidth: 2,
  //         dotData: FlDotData(
  //           show: false,
  //         ),
  //         belowBarData: BarAreaData(
  //           show: true,
  //           gradient: LinearGradient(
  //             colors: [
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //               ColorTween(begin: gradientColors[0], end: gradientColors[1])
  //                   .lerp(0.2)!
  //                   .withOpacity(0.1),
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget bottomTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //       color: Color(0xff68737d),
  //       fontWeight: FontWeight.bold,
  //       fontSize: 8
  //   );
  //   Widget text;
  //   if (_currentIndex == 0) {
  //     text = Text((value.toInt() + 1).toString(), style: style,);
  //   } else {
  //     if (_currentIndex == 1) {
  //       switch (value.toInt()) {
  //         case 0:
  //           text = const Text('JAN', style: style,);
  //           break;
  //         case 1:
  //           text = const Text('FEB', style: style,);
  //           break;
  //         case 2:
  //           text = const Text('MAR', style: style,);
  //           break;
  //         case 3:
  //           text = const Text('APR', style: style,);
  //           break;
  //         case 4:
  //           text = const Text('MAY', style: style,);
  //           break;
  //         case 5:
  //           text = const Text('JUN', style: style,);
  //           break;
  //         case 6:
  //           text = const Text('JUL', style: style,);
  //           break;
  //         case 7:
  //           text = const Text('AUG', style: style,);
  //           break;
  //         case 8:
  //           text = const Text('SEP', style: style,);
  //           break;
  //         case 9:
  //           text = const Text('OCT', style: style,);
  //           break;
  //         case 10:
  //           text = const Text('NOV', style: style,);
  //           break;
  //         case 11:
  //           text = const Text('DEC', style: style,);
  //           break;
  //         default:
  //           text = const Text('', style: style,);
  //       }
  //     } else {
  //       text = Text((1990 + value.toInt()).toString(), style: style,);
  //     }
  //   }
  //
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: text,
  //   );
  // }
  //
  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     color: Color(0xff67727d),
  //     fontWeight: FontWeight.bold,
  //     fontSize: 12,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 0:
  //       text = Text(0.toString(), style: style,);
  //       break;
  //     case 50:
  //       text = Text(50.toString(), style: style,);
  //       break;
  //     case 100:
  //       text = Text(100.toString(), style: style,);
  //       break;
  //     case 150:
  //       text = Text(150.toString(), style: style,);
  //       break;
  //     case 200:
  //       text = Text(200.toString(), style: style,);
  //       break;
  //     default:
  //       text = const Text('', style: style, textAlign: TextAlign.left);
  //   }
  //
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: text,
  //   );
  // }
}
