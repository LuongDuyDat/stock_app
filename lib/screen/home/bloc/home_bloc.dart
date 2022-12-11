import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/repositories/symbol_repository/models/symbol_tile.dart';
import 'package:stock_app/repositories/symbol_repository/symbol_repository.dart';
import 'package:stock_app/screen/home/bloc/home_event.dart';
import 'package:stock_app/screen/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required SymbolRepository symbolRepository,
  }) : _symbolRepository = symbolRepository,
      super(const HomeState()) {
    on<HomeSubscriptionRequest>(_onSubscriptionRequest);
    on<HomeSearchSymbol>(_onSearchSymbol);
    on<HomeLoadMoreFavoriteSymbol>(_onLoadMoreFavoriteSymbol);
  }

  final SymbolRepository _symbolRepository;

  Future<void> _onSubscriptionRequest(
      HomeSubscriptionRequest event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(
      symbolTileListStatus: () => HomeStatus.loading,
    ));

    try {
      await emit.forEach<SymbolTile>(
          _symbolRepository.getFavoriteSymbolTiles(event.id, 0, 7),
          onData: (symbolTile) {
            List<SymbolTile> temp = List.from(state.symbolTileList);
            temp.add(symbolTile);
            return state.copyWith(symbolTileList: () => temp);
          },
          onError: (_, __) {
            return state.copyWith(
              symbolTileListStatus: () => HomeStatus.failure,
            );
          }
      );
    } on Exception {
      emit(state.copyWith(
        symbolTileListStatus: () => HomeStatus.failure,
      ));
    }

    if (state.symbolTileList.isEmpty) {
      emit(
          state.copyWith(
              hasMoreSymbolTile: () => false,
          ));
    }

    if (state.symbolTileListStatus != HomeStatus.failure) {
      emit(
          state.copyWith(
              symbolTileListStatus: () => HomeStatus.success
          ));
    }
  }

  Future<void> _onSearchSymbol(
      HomeSearchSymbol event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(
      symbolTileSearchListStatus: () => HomeStatus.loading,
      symbolTileSearchList: () => [],
      searchContent: () => event.searchContent,
    ));
    try {
      await emit.forEach<SymbolTile>(
          _symbolRepository.getSearchSymbolTiles(event.searchContent),
          onData: (symbolTile) {
            List<SymbolTile> temp = List.from(state.symbolTileSearchList);
            temp.add(symbolTile);
            return state.copyWith(symbolTileSearchList: () => temp);
          },
          onError: (_, __) {
            return state.copyWith(
              symbolTileSearchListStatus: () => HomeStatus.failure,
            );
          }
      );
    } on Exception {
      emit(state.copyWith(
        symbolTileSearchListStatus: () => HomeStatus.failure,
      ));
    }

    if (state.symbolTileSearchListStatus != HomeStatus.failure) {
      emit(
          state.copyWith(
              symbolTileSearchListStatus: () => HomeStatus.success
          ));
    }
  }

  Future<void> _onLoadMoreFavoriteSymbol(
      HomeLoadMoreFavoriteSymbol event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(
      symbolTileListStatus: () => HomeStatus.loading,
    ));
    int start = state.symbolTileList.length;
    try {
      await emit.forEach<SymbolTile>(
          _symbolRepository.getFavoriteSymbolTiles(event.id, start, start + 5),
          onData: (symbolTile) {
            List<SymbolTile> temp = List.from(state.symbolTileList);
            temp.add(symbolTile);
            return state.copyWith(symbolTileList: () => temp);
          },
          onError: (_, __) {
            return state.copyWith(
              symbolTileListStatus: () => HomeStatus.failure,
            );
          }
      );
    } on Exception {
      emit(state.copyWith(
        symbolTileListStatus: () => HomeStatus.failure,
      ));
    }

    if (state.symbolTileList.length < start + 5) {
      emit(state.copyWith(
        hasMoreSymbolTile: () => false,
      ));
    }

    if (state.symbolTileListStatus != HomeStatus.failure) {
      emit(
          state.copyWith(
              symbolTileListStatus: () => HomeStatus.success
          ));
    }
  }
}