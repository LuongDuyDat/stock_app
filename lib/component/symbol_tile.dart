import 'package:flutter/material.dart';
import 'package:stock_app/component/stock_chart.dart';
import 'package:stock_app/screen/stock/view/stocks.dart';
import 'package:stock_app/util/globals.dart';
import 'package:stock_app/util/navigate.dart';

class SymbolRow extends StatelessWidget {
  const SymbolRow({
    Key? key,
    required this.close,
    required this.regularMarketPrice,
    required this.previousClose,
    required this.symbol,
    required this.shortName,
  }) : super(key: key);

  final String symbol;
  final String shortName;
  final List<double?> close;
  final double regularMarketPrice;
  final double previousClose;

  @override
  Widget build(BuildContext context) {
    double difference = regularMarketPrice - previousClose;
    return InkWell(
      onTap: () {
        Navigate.pushPage(context, StocksPage(symbol: symbol, shortName: shortName, regularMarket: regularMarketPrice, different: difference));
      },
      child: Container(
        height: screenHeight * 0.1,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(213, 232, 223, 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.03 * screenWidth),
          child: Row(
            children: [
              SizedBox(
                width: screenWidth * 0.38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(symbol, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),
                    SizedBox(height: screenHeight * 0.004,),
                    Text(shortName, style: const TextStyle(fontSize: 12, color: Color(0xFF9F9F9F), fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,),),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.29,
                height: screenHeight * 0.07,
                child: StockChartComponent(close: close, type: "home", difference: difference),
              ),
              SizedBox(width: screenWidth * 0.03,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: screenWidth * 0.14,
                    child: Text(regularMarketPrice.toStringAsFixed(2), style: const TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold,overflow: TextOverflow.clip,), maxLines: 1,),
                  ),
                  SizedBox(height: screenHeight * 0.004,),
                  Container(
                    width: screenWidth * 0.14,
                    color: difference > 0 ? const Color.fromRGBO(122, 232, 96, 1.0) : Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(difference.toStringAsFixed(2), style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,overflow: TextOverflow.clip,),maxLines: 1,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

}