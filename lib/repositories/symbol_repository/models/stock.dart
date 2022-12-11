import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  const Stock({
    required this.close,
    required this.regularMarketPrice,
    required this.previousClose,
    required this.timeStamp,
  });

  final List<double?> close;
  final double regularMarketPrice;
  final double previousClose;
  final List<DateTime> timeStamp;

  @override
  List<Object?> get props => [
    close,
    regularMarketPrice,
    previousClose,
    timeStamp,
  ];
}