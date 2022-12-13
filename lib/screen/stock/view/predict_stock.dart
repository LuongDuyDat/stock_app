import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/screen/stock/bloc/predict_bloc/predict_bloc.dart';
import 'package:stock_app/screen/stock/bloc/predict_bloc/predict_event.dart';
import 'package:stock_app/screen/stock/bloc/predict_bloc/predict_state.dart';
import 'package:stock_app/util/string.dart';

import '../../../component/stock_chart.dart';
import '../../../component/stock_info.dart';
import '../../../repositories/symbol_repository/symbol_repository.dart';
import '../../../util/globals.dart';

class PredictStockPage extends StatelessWidget {
  const PredictStockPage({
    Key? key,
    required this.symbol,
    required this.shortName,
    required this.regularMarket,
    required this.different,
    required this.open,
    required this.high,
    required this.low,
  }) : super(key: key);

  final String symbol;
  final String shortName;
  final double regularMarket;
  final double different;
  final double open;
  final double high;
  final double low;

  @override
  Widget build(BuildContext context) {
    SymbolRepository repository = SymbolRepository();
    return BlocProvider(
      create: (_) => PredictBloc(symbolRepository: repository,),
      child: PredictPageView(
        symbol: symbol,
        shortName: shortName,
        different: different,
        regularMarket: regularMarket,
        open: open,
        high: high,
        low: low,
      ),
    );
  }
}

class PredictPageView extends StatelessWidget {
  const PredictPageView({
    Key? key,
    required this.symbol,
    required this.shortName,
    required this.regularMarket,
    required this.different,
    required this.open,
    required this.high,
    required this.low,
  }) : super(key: key);

  final String symbol;
  final String shortName;
  final double regularMarket;
  final double different;
  final double open;
  final double high;
  final double low;

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
                },
              ),
            ],
          ),
          title: Text(
            predictString + ' ' + symbol,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.04 * screenHeight,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.064 * screenWidth),
                child: StockInfo(
                  symbol: symbol,
                  shortName: shortName,
                  regularMarketValue: regularMarket,
                  different: different,
                  open: open,
                  high: high,
                  low: low,
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03 * screenWidth),
                      child: BlocBuilder<PredictBloc, PredictState>(
                        builder: (context, state) {
                          switch (state.predictStatus){
                            case PredictStatus.initial:
                              context.read<PredictBloc>().add(PredictSubscriptionRequest(symbol: symbol,));
                              return const Center();
                            case PredictStatus.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case PredictStatus.success:
                              return SizedBox(
                                height: 0.3 * screenHeight,
                                width: double.infinity,
                                child: StockChartComponent(
                                  close: state.close,
                                  type: "stock",
                                  difference: different,
                                  timeStamp: state.timeStamp,
                                  index: 3,
                                ),
                              );
                            case PredictStatus.failure:
                              return const Center(
                                child: Text("Our model can not predict this Stock", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,),),
                              );
                          }
                        },
                      ),
                    ),
                    SizedBox(height:  screenHeight * 0.03,),
                  ],
                ),
              ),
              SizedBox(height: 0.05 * screenHeight,),
              BlocBuilder<PredictBloc,PredictState>(
                builder: (context, state) {
                  switch(state.predictStatus) {
                    case PredictStatus.success:
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'The predicted price' + ' next day: \n',
                          style: TextStyle(color: Colors.black, fontSize: 25, height: 1.3,),
                          children: [
                            TextSpan(
                              text: state.close.elementAt(0).toStringAsFixed(3) + '\$',
                              style: TextStyle(color: Colors.black, fontSize: 25, height: 1.3, fontWeight: FontWeight.bold,),
                            )
                          ],
                        ),
                      );
                    default:
                      return Center();
                  }
                },
              ),
            ]
        )
    );
  }
}