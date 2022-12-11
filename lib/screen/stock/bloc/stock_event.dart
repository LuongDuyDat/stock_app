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

class StockChangeIndex extends StockEvent {
  const StockChangeIndex({required this.symbol, required this.index,});

  final String symbol;
  final int index;

  @override
  List<Object?> get props => [symbol, index,];
}