import 'package:equatable/equatable.dart';
import 'package:stock_app/repositories/symbol_repository/models/symbol_tile.dart';

enum HomeStatus {initial, loading, success, failure}

class HomeState extends Equatable {
  const HomeState({
    this.symbolTileList = const [],
    this.symbolTileListStatus = HomeStatus.initial,
    this.hasMoreSymbolTile = true,
    this.symbolTileSearchList = const [],
    this.symbolTileSearchListStatus = HomeStatus.initial,
    this.searchContent = '',
  });

  final List<SymbolTile> symbolTileList;
  final HomeStatus symbolTileListStatus;
  final bool hasMoreSymbolTile;
  final List<SymbolTile> symbolTileSearchList;
  final HomeStatus symbolTileSearchListStatus;
  final String searchContent;

  HomeState copyWith({
    List<SymbolTile> Function()? symbolTileList,
    HomeStatus Function()? symbolTileListStatus,
    bool Function()? hasMoreSymbolTile,
    List<SymbolTile> Function()? symbolTileSearchList,
    HomeStatus Function()? symbolTileSearchListStatus,
    String Function()? searchContent,
  }) {
    return HomeState(
      symbolTileList: symbolTileList != null ? symbolTileList() : this.symbolTileList,
      symbolTileListStatus: symbolTileListStatus != null ? symbolTileListStatus() : this.symbolTileListStatus,
      hasMoreSymbolTile: hasMoreSymbolTile != null ? hasMoreSymbolTile() : this.hasMoreSymbolTile,
      symbolTileSearchList: symbolTileSearchList != null ? symbolTileSearchList() : this.symbolTileSearchList,
      symbolTileSearchListStatus: symbolTileSearchListStatus != null ? symbolTileSearchListStatus() : this.symbolTileSearchListStatus,
      searchContent: searchContent != null ? searchContent() : this.searchContent,
    );
  }

  @override
  List<Object?> get props => [
    symbolTileList,
    symbolTileListStatus,
    hasMoreSymbolTile,
    symbolTileSearchListStatus,
    symbolTileSearchList,
    searchContent,
  ];
}