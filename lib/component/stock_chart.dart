import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stock_app/util/globals.dart';

class StockChartComponent extends StatefulWidget {
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
  State<StatefulWidget> createState() => _StockChartComponent();

}

class _StockChartComponent extends State<StockChartComponent> {

  late DateTime t;
  late double difference = 0;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [];
    double minn = double.maxFinite;
    double maxy = -1;
    double maxX = widget.close.length.toDouble();
    for (int i = 0; i < widget.close.length; i++) {
      if (widget.close.elementAt(i) != null) {
        spots.add(FlSpot(i.toDouble(), widget.close.elementAt(i)!));
        minn = min(minn, widget.close.elementAt(i)!);
        maxy = max(maxy, widget.close.elementAt(i)!);
      }
    }
    if (spots.isNotEmpty) {
      difference = spots.elementAt(spots.length - 1).y - spots.elementAt(0).y;
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
          sideTitles: widget.type == 'stock'
              ? SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: rightTitleWidgets,
            reservedSize: 38,
          )
              : SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: widget.type == 'stock'
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
                color: Colors.black.withOpacity(1),
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
        enabled: widget.type == 'stock' ? true : false,
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(8),
          tooltipBgColor: const Color.fromRGBO(213, 232, 223, 1),
          maxContentWidth: screenWidth * 0.17,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                "\$ ${touchedSpot.y.toStringAsFixed(2)} \n",
                const TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: widget.timeStamp != null
                        ? (widget.index == 0
                        ? widget.timeStamp!.elementAt(touchedSpot.x.toInt()).toString().substring(10, 16)
                        : widget.timeStamp!.elementAt(touchedSpot.x.toInt()).toString().substring(0, 10))
                        : '',
                    style: const TextStyle(color: Color(0xFF616967), fontSize: 8.0, fontWeight: FontWeight.w500),
                  )
                ]
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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
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
    if (widget.index != null) {
      switch (widget.index) {
        case 0:
          int interval = widget.timeStamp!.length ~/ 6;
          for (int i = 1; i <= 5; i++) {
            if (value == meta.min + interval * i) {
              text = Text((widget.timeStamp!.elementAt(value.toInt()).hour).toString(), style: style,);
              break;
            } else {
              text = const Text('');
            }
          }
          break;
        case 1:
          int interval = widget.timeStamp!.length ~/ 6;
          for (int i = 1; i <= 5; i++) {
            if (value == meta.min + interval * i) {
              text = Text((widget.timeStamp!.elementAt(value.toInt()).day).toString(), style: style,);
              break;
            } else {
              text = const Text('');
            }
          }
          break;
        case 2:
          List<String> month = ['','JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP', 'OCT', 'NOV', 'DEC',];
          int interval = widget.timeStamp!.length ~/ 6;
          for (int i = 1; i <= 5; i++) {
            if (value == meta.min + interval * i) {
              text = Text(month[(widget.timeStamp!.elementAt(value.toInt()).month)], style: style,);
              break;
            } else {
              text = const Text('');
            }
          }
          break;
        default:
          if (value.toInt() < widget.timeStamp!.length) {
            text = Text((widget.timeStamp!.elementAt(value.toInt()).day).toString());
          } else {
            text = const Text('');
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

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text = const Text('');
    List<double> temp = [];
    for (int i = 0; i < widget.close.length; i++) {
      if (widget.close.elementAt(i) != null) {
        temp.add(widget.close.elementAt(i)!);
      }
    }
    temp.sort();
    int interval = temp.length ~/ 4;
    for (int i = 0; i <= 3; i++) {
      if (temp.isNotEmpty) {
        if (value == temp.elementAt(i * interval).toInt().toDouble()) {
          text = Text(temp.elementAt(i * interval).toStringAsFixed(1), style: style,);
          break;
        } else {
          text = const Text('');
        }
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

}