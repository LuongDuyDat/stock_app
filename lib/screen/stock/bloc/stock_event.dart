import 'package:equatable/equatable.dart';

class StockEvent extends Equatable {
  const StockEvent();

  @override
  List<Object?> get props => [];
}

class StockGetQuote extends StockEvent {
  const StockGetQuote({required this.symbol});

  final String symbol;

  @override
  List<Object?> get props => [];
}

class StockGetChart extends StockEvent {
  const StockGetChart({required this.symbol,});

  final String symbol;

  @override
  List<Object?> get props => [symbol,];
}

class StockChangeIndex extends StockEvent {
  const StockChangeIndex({required this.index,});

  final int index;

  @override
  List<Object?> get props => [index,];
}