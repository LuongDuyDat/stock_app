import 'package:stock_app/finance_yahoo_api/finance_yahoo_api.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_quotes.dart';
import 'package:stock_app/model_api/model_api.dart';
import 'package:stock_app/repositories/social_repository/models/favorite_symbol.dart';
import 'package:stock_app/repositories/symbol_repository/models/favortite_symbols.dart';
import 'package:stock_app/repositories/symbol_repository/models/symbol_tile.dart';
import 'package:stock_app/util/globals.dart';

import '../../finance_yahoo_api/models/stock_chart.dart';
import '../../finance_yahoo_api/models/symbol_news.dart';
import '../../finance_yahoo_api/models/symbol_search.dart';
import 'models/quote.dart';
import 'models/stock.dart';

class SymbolRepository {
  SymbolRepository({FinanceYahooAPIClient? financeYahooAPIClient, ModelAPI? modelAPI})
      : _financeYahooAPIClient = financeYahooAPIClient ?? FinanceYahooAPIClient(),
        _modelAPI = modelAPI ?? ModelAPI();

  final FinanceYahooAPIClient _financeYahooAPIClient;

  final ModelAPI _modelAPI;

  Future<List<double>> getSymbolPredict(String symbol, double value1, double value2, double value3, double value4, double value5, double value6, double value7) {
    return _modelAPI.getPredict(
      symbol,
      value1.toString(),
      value2.toString(),
      value3.toString(),
      value4.toString(),
      value5.toString(),
      value6.toString(),
      value7.toString(),
    );
  }

  Future<SymbolSearch> getSymbolSearch(String symbol) async{
    return await _financeYahooAPIClient.getSymbolSearch(symbol);
  }

  Future<List<SymbolNew>> getSymbolNew(String symbol) async{
    return await _financeYahooAPIClient.getSymbolNew(symbol);
  }

  Future<Stock> getStockChart(String range, String interval, String symbol) async{
    StockChart stockChart = await _financeYahooAPIClient.getStockChart(range, interval, symbol);

    return Stock(
      close: stockChart.close,
      regularMarketPrice: stockChart.regularMarketPrice,
      previousClose: stockChart.previousClose,
      timeStamp: stockChart.timeStamp,
    );
  }

  Future<SymbolQuotes> getStockQuotes(String symbol) async{
    return await _financeYahooAPIClient.getStockQuotes(symbol);
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
    List<FavoriteSymbolHive> symbols = account.favoriteSymbols;

    for (int i = 0; i < symbols.length; i++) {
      Stock temp = await getStockChart('1d', '1m', symbols.elementAt(i).name);
      yield SymbolTile(
        close: temp.close,
        regularMarketPrice: temp.regularMarketPrice,
        previousClose: temp.previousClose,
        symbol: symbols.elementAt(i).name,
        shortName: symbols.elementAt(i).shortName,
      );
    }

  }

  Stream<SymbolTile> getSearchSymbolTiles(String searchContent) async* {
    SymbolSearch symbolSearch = await getSymbolSearch(searchContent);

    for (int i = 0; i < symbolSearch.symbolList.length; i++) {
      Stock temp = await getStockChart('1d', '1m', symbolSearch.symbolList.elementAt(i).symbol);
      if (temp.previousClose != -1) {
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

  Future<Quote> getQuote(String symbol) async{
    SymbolQuotes quotes = await getStockQuotes(symbol);
    return Quote(
      open: quotes.open,
      high: quotes.high,
      low: quotes.low,
    );
  }

  Future<Stock> getStock(int selectIndex, String symbol) async{
    String time;
    String interval;
    switch (selectIndex) {
      case 0:
        time = '1d';
        interval = '1m';
        break;
      case 1:
        time = '1mo';
        interval = '30m';
        break;
      default:
        time = '1y';
        interval = '1d';
    }
    Stock temp = await getStockChart(time, interval, symbol);

    return temp;
  }
}