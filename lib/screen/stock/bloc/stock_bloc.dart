import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_quotes.dart';
import 'package:stock_app/repositories/symbol_repository/models/quote.dart';
import 'package:stock_app/screen/stock/bloc/stock_event.dart';
import 'package:stock_app/screen/stock/bloc/stock_state.dart';

import '../../../repositories/symbol_repository/models/stock.dart';
import '../../../repositories/symbol_repository/symbol_repository.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc({
    required SymbolRepository symbolRepository,
  }) : _symbolRepository = symbolRepository,
        super(const StockState()) {
    on<StockGetQuote>(_onGetQuote);
    on<StockChangeIndex>(_onChangeIndex);
  }

  final SymbolRepository _symbolRepository;

  Future<void> _onGetQuote(
      StockGetQuote event,
      Emitter<StockState> emit,
      ) async {
    emit(state.copyWith(
      quoteStatus: () => StockStatus.loading,
    ));

    try {
      SymbolQuotes quotes = await _symbolRepository.getStockQuotes(event.symbol);
      emit(state.copyWith(
        quote: () => Quote(open: quotes.open, high: quotes.high, low: quotes.low),
      ));
    } on Exception {
      emit(state.copyWith(
        quoteStatus: () => StockStatus.failure,
      ));
    }


    if (state.quoteStatus != StockStatus.failure) {
      emit(
          state.copyWith(
              quoteStatus: () => StockStatus.success
          ));
    }
  }

  Future<void> _onChangeIndex(
      StockChangeIndex event,
      Emitter<StockState> emit,
      ) async {
    emit(state.copyWith(
      chartStatus: () => StockStatus.loading,
    ));

    try {
      Stock chart = await _symbolRepository.getStock(event.index, event.symbol);
      switch (event.index) {
        case 0:
          emit(state.copyWith(
             dayStock : () => chart,
          ));
          break;
        case 1:
          emit(state.copyWith(
            monthStock : () => chart,
          ));
          break;
        default:
          emit(state.copyWith(
            yearStock : () => chart,
          ));
      }
    } on Exception {
      emit(state.copyWith(
        chartStatus: () => StockStatus.failure,
      ));
    }


    if (state.chartStatus != StockStatus.failure) {
      emit(
          state.copyWith(
              chartStatus: () => StockStatus.success
          ));
    }
  }
}