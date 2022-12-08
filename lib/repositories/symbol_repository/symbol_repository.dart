import 'package:stock_app/finance_yahoo_api/finance_yahoo_api.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_search_component.dart';
import 'package:stock_app/repositories/symbol_repository/models/favortite_symbols.dart';
import 'package:stock_app/repositories/symbol_repository/models/symbol_tile.dart';

import '../../finance_yahoo_api/models/stock_chart.dart';
import '../../finance_yahoo_api/models/symbol_news.dart';
import '../../finance_yahoo_api/models/symbol_search.dart';

class SymbolRepository {
  SymbolRepository({FinanceYahooAPIClient? financeYahooAPIClient})
      : _financeYahooAPIClient = financeYahooAPIClient ?? FinanceYahooAPIClient();

  final FinanceYahooAPIClient _financeYahooAPIClient;

  Future<SymbolSearch> getSymbolSearch(String symbol) async{
    return await _financeYahooAPIClient.getSymbolSearch(symbol);
  }

  Future<List<SymbolNew>> getSymbolNew(String symbol) async{
    return await _financeYahooAPIClient.getSymbolNew(symbol);
  }

  Future<StockChart> getStockChart(String range, String interval, String symbol) async{
    return await _financeYahooAPIClient.getStockChart(range, interval, symbol);
  }

  Future<List<FavoriteSymbol>> getFavoriteSymbol(String id, int start, int end) async{
    List<FavoriteSymbol> result = [];
    result.add(const FavoriteSymbol(symbol: 'A', shortName: 'Agilent Technologies, Inc.'));
    result.add(const FavoriteSymbol(symbol: 'AAPL', shortName: 'Apple Inc.'));
    result.add(const FavoriteSymbol(symbol: 'B', shortName: 'Barnes Group Inc.'));
    if (start > 0) {
      return [];
    }
    return result;
  }

  Stream<SymbolTile> getFavoriteSymbolTiles(String id, int start, int end) async* {
    List<FavoriteSymbol> symbols = await getFavoriteSymbol(id, start, end);

    for (int i = 0; i < symbols.length; i++) {
      StockChart temp = await getStockChart('1d', '1m', symbols.elementAt(i).symbol);
      yield SymbolTile(
        close: temp.close,
        regularMarketPrice: temp.regularMarketPrice,
        previousClose: temp.previousClose,
        symbol: symbols.elementAt(i).symbol,
        shortName: symbols.elementAt(i).shortName,
      );
    }

  }

  Stream<SymbolTile> getSearchSymbolTiles(String searchContent) async* {
    SymbolSearch symbolSearch = await getSymbolSearch(searchContent);

    for (int i = 0; i < symbolSearch.symbolList.length; i++) {
      StockChart temp = await getStockChart('1d', '1m', symbolSearch.symbolList.elementAt(i).symbol);
      yield SymbolTile(
        close: temp.close,
        regularMarketPrice: temp.regularMarketPrice,
        previousClose: temp.previousClose,
        symbol: symbolSearch.symbolList.elementAt(i).symbol,
        shortName: symbolSearch.symbolList.elementAt(i).shortName,
      );
    }
  }
}