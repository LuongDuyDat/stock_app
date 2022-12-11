import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/util/globals.dart';

import '../util/string.dart';

class StockInfo extends StatelessWidget{
  const StockInfo({
    Key? key,
    required this.symbol,
    required this.shortName,
    required this.regularMarketValue,
    required this.different,
    required this.open,
    required this.high,
    required this.low,
  }) : super(key: key);

  final String symbol;
  final String shortName;
  final double regularMarketValue;
  final double different;
  final double open;
  final double high;
  final double low;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.19,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(213, 232, 223, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03 * screenWidth, vertical: 0.02 * screenHeight,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(symbol, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),
                    SizedBox(height: screenHeight * 0.004,),
                    Text(shortName, style: const TextStyle(fontSize: 16, color: Color(0xFF616967), fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("\$${regularMarketValue.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),
                    SizedBox(height: screenHeight * 0.004,),
                    Text(
                      different > 0 ? '+ ${different.toStringAsFixed(2)}' : different.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 16,
                        color: different > 0 ? const Color.fromRGBO(122, 232, 96, 1.0) : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(thickness: 1, height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(openString, style: const TextStyle(fontSize: 16, color: Color(0xFF616967), fontWeight: FontWeight.w500,),),
                    SizedBox(height: screenHeight * 0.004,),
                    Text("\$${open.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(highString, style: const TextStyle(fontSize: 16, color: Color(0xFF616967), fontWeight: FontWeight.w500,),),
                    SizedBox(height: screenHeight * 0.004,),
                    Text("\$${high.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lowString, style: const TextStyle(fontSize: 16, color: Color(0xFF616967), fontWeight: FontWeight.w500,),),
                    SizedBox(height: screenHeight * 0.004,),
                    Text("\$${low.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}