import 'package:flutter/material.dart';
import 'package:stock_app/component/stock_chart.dart';
import 'package:stock_app/util/globals.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Divider(color: Colors.black,),
        SizedBox(
          height: screenHeight * 0.07,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(
                width: screenWidth * 0.4,
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
              Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.07,
                color: Colors.black,
                child: StockChartComponent(close: close, type: "home", difference: difference),
              ),
              SizedBox(width: screenWidth * 0.03,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(regularMarketPrice.toStringAsFixed(2), style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,),),
                  SizedBox(height: screenHeight * 0.004,),
                  Container(
                    width: screenWidth * 0.15,
                    color: difference > 0 ? const Color.fromRGBO(122, 232, 96, 1.0) : Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(difference.toStringAsFixed(2), style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(color: Colors.black,),
      ],
    );
  }

}