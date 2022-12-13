import 'package:equatable/equatable.dart';

enum PredictStatus {initial, loading, success, failure}

class PredictState extends Equatable {
  const PredictState({
    this.predictStatus = PredictStatus.initial,
    this.close = const [],
    this.timeStamp = const [],
  });

  final PredictStatus predictStatus;
  final List<double> close;
  final List<DateTime> timeStamp;

  PredictState copyWith({
    List<double> Function()? close,
    PredictStatus Function()? predictStatus,
    List<DateTime> Function()? timeStamp,
  }) {
    return PredictState(
      close: close != null ? close() : this.close,
      predictStatus: predictStatus != null ? predictStatus() : this.predictStatus,
      timeStamp: timeStamp != null ? timeStamp() : this.timeStamp,
    );
  }

  @override
  List<Object?> get props => [
    predictStatus,
    close,
    timeStamp,
  ];
}