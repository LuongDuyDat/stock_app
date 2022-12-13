import 'package:equatable/equatable.dart';

class PredictEvent extends Equatable {
  const PredictEvent();

  @override
  List<Object?> get props => [];
}

class PredictSubscriptionRequest extends PredictEvent {
  const PredictSubscriptionRequest({required this.symbol});

  final String symbol;

  @override
  List<Object?> get props => [symbol];
}