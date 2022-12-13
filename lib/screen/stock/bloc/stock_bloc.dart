import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_quotes.dart';
import 'package:stock_app/repositories/social_repository/user_hive_repository.dart';
import 'package:stock_app/repositories/symbol_repository/models/quote.dart';
import 'package:stock_app/screen/stock/bloc/stock_event.dart';
import 'package:stock_app/screen/stock/bloc/stock_state.dart';
import 'package:stock_app/util/string.dart';

import '../../../repositories/symbol_repository/models/stock.dart';
import '../../../repositories/symbol_repository/symbol_repository.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc({
    required SymbolRepository symbolRepository,
    required UserHiveRepository userHiveRepository,
  }) : _symbolRepository = symbolRepository,
      _userHiveRepository = userHiveRepository,
        super(const StockState()) {
    on<StockGetQuote>(_onGetQuote);
    on<StockGetChart>(_onGetChart);
    on<StockChangeIndex>(_onChangeIndex);
    on<StockCheckFavorite>(_onCheckFavorite);
    on<StockChangeFavorite>(_onChangeFavorite);
  }

  final SymbolRepository _symbolRepository;
  final UserHiveRepository _userHiveRepository;

  void _onCheckFavorite(
      StockCheckFavorite event,
      Emitter<StockState> emit,
      ) {
    emit(state.copyWith(
      favoriteStatus: () => StockStatus.loading,
    ));
    bool isFavorite = _userHiveRepository.checkFavorite(event.symbol);

    if (isFavorite) {
      emit(state.copyWith(
        dropDownItem: () => [joinGroupString, deleteFromListString],
        favoriteStatus: () => StockStatus.success,
      ));
    } else {
      emit(state.copyWith(
        dropDownItem: () => [joinGroupString, addToListString],
        favoriteStatus: () => StockStatus.success,
      ));
    }
  }

  Future<void> _onChangeFavorite(
      StockChangeFavorite event,
      Emitter<StockState> emit,
      ) async{
    if (event.type == 0) {
      await _userHiveRepository.addToFavorite(event.symbol, event.shortName);
      emit(state.copyWith(
        dropDownItem: () => [joinGroupString, deleteFromListString],
      ));
    } else {
      await _userHiveRepository.deleteFromFavorite(event.symbol);
      emit(state.copyWith(
        dropDownItem: () => [joinGroupString, addToListString],
      ));
    }
  }

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