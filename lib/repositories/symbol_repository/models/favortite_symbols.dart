import 'package:equatable/equatable.dart';

class FavoriteSymbol extends Equatable {
  const FavoriteSymbol({
    required this.symbol,
    required this.shortName,
  });

  final String symbol;
  final String shortName;

  @override
  List<Object?> get props => [
    symbol,
    shortName,
  ];
}