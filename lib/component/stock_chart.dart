import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockChartComponent extends StatelessWidget {
  const StockChartComponent({
    Key? key,
    required this.close,
    required this.type,
    required this.difference,
    this.timeStamp,
    this.index,
  }) : super(key: key);

  final List<double?> close;
  final String type;
  final double difference;
  final List<DateTime>? timeStamp;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [];
    double minn = double.maxFinite;
    double maxy = -1;
    double maxX = close.length.toDouble();
    for (int i = 0; i < close.length; i++) {
      if (close.elementAt(i) != null) {
        spots.add(FlSpot(i.toDouble(), close.elementAt(i)!));
        minn = min(minn, close.elementAt(i)!);
        maxy = max(maxy, close.elementAt(i)!);
      }
    }
    if (maxy == -1) {
      minn = 0;
      maxy = 200;
    } else {
      double d = maxy - minn;
      minn = minn - d/15;
      maxy = maxy + d/15;
    }
    return LineChart(
      mainData(spots, minn, maxy, maxX),
      swapAnimationCurve: Curves.easeInOutCubic,
      swapAnimationDuration: const Duration(milliseconds: 1000),
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
              ? SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 38,
          )
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
          sideTitles: SideTitles(showTitles: false),
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
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text = const Text('');
    if (index != null) {
      switch (index) {
        case 0:
          int interval = timeStamp!.length ~/ 6;
          for (int i = 1; i <= 5; i++) {
            if (value == meta.min + interval * i) {
              text = Text((timeStamp!.elementAt(value.toInt()).hour).toString(), style: style,);
              break;
            } else {
              text = const Text('');
            }
          }
          break;
        case 1:
          int interval = timeStamp!.length ~/ 6;
          for (int i = 1; i <= 5; i++) {
            if (value == meta.min + interval * i) {
              text = Text((timeStamp!.elementAt(value.toInt()).day).toString(), style: style,);
              break;
            } else {
              text = const Text('');
            }
          }
          break;
        default:
          List<String> month = ['','JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP', 'OCT', 'NOV', 'DEC',];
          int interval = timeStamp!.length ~/ 6;
          for (int i = 1; i <= 5; i++) {
            if (value == meta.min + interval * i) {
              text = Text(month[(timeStamp!.elementAt(value.toInt()).month)], style: style,);
              break;
            } else {
              text = const Text('');
            }
          }
      }
    } else {
      text = const Text('');
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
      fontSize: 10,
    );
    Widget text = const Text('');
    List<double> temp = [];
    for (int i = 0; i < close.length; i++) {
      if (close.elementAt(i) != null) {
        temp.add(close.elementAt(i)!);
      }
    }
    temp.sort();
    int interval = temp.length ~/ 4;
    for (int i = 0; i <= 3; i++) {
      if (value == temp.elementAt(i * interval).toInt().toDouble()) {
        text = Text(temp.elementAt(i * interval).toStringAsFixed(1), style: style,);
        break;
      } else {
        text = const Text('');
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}