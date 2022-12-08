import 'package:equatable/equatable.dart';

class SymbolTile extends Equatable {
  const SymbolTile({
    required this.close,
    required this.regularMarketPrice,
    required this.previousClose,
    required this.symbol,
    required this.shortName,
  });

  final List<double> close;
  final double regularMarketPrice;
  final double previousClose;
  final String symbol;
  final String shortName;

  @override
  List<Object?> get props => [
    close,
    regularMarketPrice,
    previousClose,
    symbol,
    shortName,
  ];
}