import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  const Quote({
    required this.open,
    required this.high,
    required this.low,
  });

  final double open;
  final double high;
  final double low;

  @override
  List<Object?> get props => [
    open,
    high,
    low,
  ];
}