import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  const Stock({
    required this.close,
    required this.regularMarketPrice,
    required this.previousClose,
  });

  final List<double?> close;
  final double regularMarketPrice;
  final double previousClose;

  @override
  List<Object?> get props => [
    close,
    regularMarketPrice,
    previousClose,
  ];
}