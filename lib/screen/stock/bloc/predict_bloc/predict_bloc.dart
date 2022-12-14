import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/repositories/symbol_repository/symbol_repository.dart';
import 'package:stock_app/screen/stock/bloc/predict_bloc/predict_event.dart';
import 'package:stock_app/screen/stock/bloc/predict_bloc/predict_state.dart';

import '../../../../repositories/symbol_repository/models/stock.dart';

class PredictBloc extends Bloc<PredictEvent, PredictState> {
  PredictBloc({
    required SymbolRepository symbolRepository,
  }) : _symbolRepository = symbolRepository,
        super(const PredictState()) {
    on<PredictSubscriptionRequest>(_onSubscriptionRequest);
  }

  final SymbolRepository _symbolRepository;

  Future<void> _onSubscriptionRequest (
      PredictSubscriptionRequest event,
      Emitter<PredictState> emit,
      ) async{
    emit(state.copyWith(
      predictStatus: () => PredictStatus.loading,
    ));

    Stock stock = await _symbolRepository.getStockChart('3mo', '1d', event.symbol);
    List<double> temp1 = [];
    for (int i = stock.close.length - 1; i >= 0; i--) {
      if (stock.close.elementAt(i) != null) {
        temp1.add(stock.close.elementAt(i)!);
      }
      if (temp1.length == 7) {
        break;
      }
    }
    if (temp1.length < 7) {
      emit(state.copyWith(
        predictStatus: () => PredictStatus.failure,
      ));
      return;
    }
    List<double> result = [];
    try {
      result = await _symbolRepository.getSymbolPredict(
          event.symbol,
          temp1[6],
          temp1[5],
          temp1[4],
          temp1[3],
          temp1[2],
          temp1[1],
          temp1[0]
      );
      print("Bloc");
      print(result);
    } on Exception {
      result = [];
    };

    if (result.length < 7) {
      emit(state.copyWith(
        predictStatus: () => PredictStatus.failure,
      ));
      return;
    }

    List<DateTime> temp2 = [];
    for (int i = 1; i <= 7; i++) {
      DateTime temp = DateTime.now().add(Duration(days: i));
      temp2.add(temp);
    }
    emit(state.copyWith(
      predictStatus: () => PredictStatus.success,
      close: () => result,
      timeStamp: () => temp2,
    ));
  }
}