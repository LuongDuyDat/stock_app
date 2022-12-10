import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/util/globals.dart';

class StockChartComponent extends StatelessWidget {
  const StockChartComponent({
    Key? key,
    required this.close,
    required this.type,
    required this.difference,
    this.timeStamp,
  }) : super(key: key);

  final List<double?> close;
  final String type;
  final double difference;
  final List<DateTime>? timeStamp;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [];
    double minn = double.maxFinite;
    double maxy = -1;
    double maxX = close.length.toDouble();
    for (int i = 0; i < close.length; i++) {
      if (close.elementAt(i) != null) {
        spots.add(FlSpot(i.toDouble(), close.elementAt(i)!));
        if (close.elementAt(i) == 201.0 && difference < -100) {
          print(i);
        }
        minn = min(minn, close.elementAt(i)!);
        maxy = max(maxy, close.elementAt(i)!);
      }
    }
    if (difference < -100) {
      print("hello");
      print(minn);
      print(maxy);
    }
    print(spots.length);
    if (maxy == -1) {
      minn = 0;
      maxy = 200;
    } else {
      double d = maxy - minn;
      minn = minn - d/15;
      maxy = maxy + d/15;
    }
    return SizedBox(
      width: screenWidth * 0.3,
      height: screenHeight * 0.02,
      child: LineChart(
        mainData(spots, minn, maxy, maxX),
        swapAnimationCurve: Curves.easeInOutCubic,
        swapAnimationDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  LineChartData mainData(List<FlSpot> spots, double minY, double maxY, double maxX) {
    return LineChartData(
      borderData: FlBorderData(
        show: false,
      ),
      gridData: FlGridData(
          show: false,
          horizontalInterval: 1.6,
          drawVerticalLine: false
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: type == 'stock'
              ? SideTitles(showTitles: true, reservedSize: 10)
              : SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: type == 'stock'
              ? SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          )
              : SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: type == 'stock'
              ? SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 35,
          )
              : SideTitles(showTitles: false),
        ),
      ),
      minX: 0,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.white.withOpacity(0.1),
                strokeWidth: 2,
                dashArray: [3, 3],
              ),
              FlDotData(
                show: false,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 8,
                      color: [
                        Colors.black,
                        Colors.black,
                      ][index],
                      strokeWidth: 2,
                      strokeColor: Colors.black,
                    ),
              ),
            );
          }).toList();
        },
        enabled: type == 'stock' ? true : false,
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBgColor: const Color(0xff2e3747).withOpacity(0.8),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                '\$${touchedSpot.y.round()}.00',
                const TextStyle(color: Colors.white, fontSize: 12.0),

              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          // gradient: LinearGradient(
          //   colors: [
          //     ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //         .lerp(0.2)!,
          //     ColorTween(begin: gradientColors[0], end: gradientColors[1])
          //         .lerp(0.2)!,
          //   ],
          // ),
          color: difference > 0 ? const Color.fromRGBO(122, 232, 96, 1.0) : Colors.red,
          barWidth: 2,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                difference > 0 ? const Color.fromRGBO(122, 232, 96, 0.5) : Colors.red.withOpacity(0.5),
                difference > 0 ? const Color.fromRGBO(122, 232, 96, 0.1) : Colors.red.withOpacity(0.1)
                // ColorTween(begin: gradientColors[0], end: gradientColors[1])
                //     .lerp(0.2)!
                //     .withOpacity(0.1),
                // ColorTween(begin: gradientColors[0], end: gradientColors[1])
                //     .lerp(0.2)!
                //     .withOpacity(0.1),

              ],
            ),
            color: difference > 0 ? const Color.fromRGBO(122, 232, 96, 1.0) : Colors.red,
          ),
        )
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color(0xff68737d),
        fontWeight: FontWeight.bold,
        fontSize: 8
    );
    Widget text;
    if (0 == 0) {
      text = Text((value.toInt() + 1).toString(), style: style,);
    } else {
      if (1 == 1) {
        switch (value.toInt()) {
          case 0:
            text = const Text('JAN', style: style,);
            break;
          case 1:
            text = const Text('FEB', style: style,);
            break;
          case 2:
            text = const Text('MAR', style: style,);
            break;
          case 3:
            text = const Text('APR', style: style,);
            break;
          case 4:
            text = const Text('MAY', style: style,);
            break;
          case 5:
            text = const Text('JUN', style: style,);
            break;
          case 6:
            text = const Text('JUL', style: style,);
            break;
          case 7:
            text = const Text('AUG', style: style,);
            break;
          case 8:
            text = const Text('SEP', style: style,);
            break;
          case 9:
            text = const Text('OCT', style: style,);
            break;
          case 10:
            text = const Text('NOV', style: style,);
            break;
          case 11:
            text = const Text('DEC', style: style,);
            break;
          default:
            text = const Text('', style: style,);
        }
      } else {
        text = Text((1990 + value.toInt()).toString(), style: style,);
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(0.toString(), style: style,);
        break;
      case 50:
        text = Text(50.toString(), style: style,);
        break;
      case 100:
        text = Text(100.toString(), style: style,);
        break;
      case 125:
        text = Text(125.toString(), style: style,);
        break;
      case 150:
        text = Text(150.toString(), style: style,);
        break;
      case 170:
        text = Text(175.toString(), style: style,);
        break;
      case 200:
        text = Text(200.toString(), style: style,);
        break;
      default:
        text = const Text('', style: style, textAlign: TextAlign.left);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}