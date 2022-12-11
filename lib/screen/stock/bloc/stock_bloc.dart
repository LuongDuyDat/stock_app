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
    on<StockGetChart>(_onGetChart);
    on<StockChangeIndex>(_onChangeIndex);
  }

  final SymbolRepository _symbolRepository;

  void _onChangeIndex(
      StockChangeIndex event,
      Emitter<StockState> emit,
      ) {
    emit(state.copyWith(
      selectIndex: () => event.index,
    ));
    Stock s = const Stock(close: [], regularMarketPrice: 0, previousClose: 0, timeStamp: []);
    switch(event.index) {
      case 0:
        emit(state.copyWith(
          chartStatus: () => StockStatus.initial,
        ));
        break;
      case 1:
        if (state.monthStock == s) {
          emit(state.copyWith(
            chartStatus: () => StockStatus.initial,
          ));
        }
        break;
      default:
        if (state.yearStock == s) {
          emit(state.copyWith(
            chartStatus: () => StockStatus.initial,
          ));
        }
    }
  }

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

  Future<void> _onGetChart(
      StockGetChart event,
      Emitter<StockState> emit,
      ) async {
    emit(state.copyWith(
      chartStatus: () => StockStatus.loading,
    ));

    try {
      Stock chart = await _symbolRepository.getStock(state.selectIndex, event.symbol);
      switch (state.selectIndex) {
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