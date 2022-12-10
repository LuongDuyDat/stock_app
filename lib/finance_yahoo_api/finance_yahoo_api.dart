import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_app/finance_yahoo_api/models/stock_chart.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_search.dart';

import 'models/symbol_news.dart';
import 'models/symbol_quotes.dart';

class SymbolSearchRequestFailure implements Exception {}

class SymbolSearchNotFound implements Exception {}

class SymbolNewRequestFailure implements Exception {}

class SymbolNewNotFound implements Exception {}

class SymbolChartRequestFailure implements Exception {}

class SymbolChartNotFound implements Exception {}


class FinanceYahooAPIClient {
  FinanceYahooAPIClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  static const String _baseUrl = "query1.finance.yahoo.com";
  final http.Client _httpClient;

  Future<SymbolSearch> getSymbolSearch(String symbol) async{
    final symbolSearchRequest = Uri.https(
      _baseUrl,
      "/v1/finance/search",
      {'q': symbol},
    );

    final symbolSearchResponse = await _httpClient.get(symbolSearchRequest);

    if (symbolSearchResponse.statusCode != 200) {
      throw SymbolSearchRequestFailure();
    }

    final symbolSearchJson = jsonDecode(symbolSearchResponse.body);

    final searchResult = symbolSearchJson;

    if (searchResult["quotes"].isEmpty) {
      throw SymbolSearchNotFound();
    }

    return SymbolSearch.fromJson(searchResult as Map<String, dynamic>);
  }

  Future<List<SymbolNew>> getSymbolNew(String symbol) async{
    final symbolNewRequest = Uri.https(
      _baseUrl,
      "/v1/finance/search",
      {'q': symbol},
    );

    final symbolNewResponse = await _httpClient.get(symbolNewRequest);

    if (symbolNewResponse.statusCode != 200) {
      throw SymbolSearchRequestFailure();
    }

    final symbolNewJson = jsonDecode(symbolNewResponse.body);
    if (symbolNewJson["count"] == 0) {
      throw SymbolNewNotFound();
    }

    final newResult = symbolNewJson['news'];
    List<SymbolNew> result = newResult.map<SymbolNew>((json) {
      return SymbolNew.fromJson(json);
    }).toList();

    for (int i = 0; i < result.length; i++) {
      if (!result.elementAt(i).relatedSymbol.contains(symbol)) {
        result.removeAt(i);
      }
    }

    return result;
  }

  Future<SymbolQuotes> getStockQuotes(String symbol) async {
    final symbolGetQuotes = Uri.https(
      _baseUrl,
      "/v8/finance/quote",
      {
        'symbol': symbol,
      },
    );

    final symbolQuoteResponse = await _httpClient.get(symbolGetQuotes);

    if (symbolQuoteResponse.statusCode != 200) {
      throw SymbolChartRequestFailure();
    }

    final symbolNewJson = jsonDecode(symbolQuoteResponse.body);
    final quoteResult = symbolNewJson['quoteResponse'];

    if (quoteResult["result"] == null) {
      throw SymbolChartNotFound();
    }
    return SymbolQuotes.fromJson(quoteResult["result"].first as Map<String, dynamic>) ;
  }

  Future<StockChart> getStockChart(String range, String interval, String symbol) async{
    final symbolGetChart = Uri.https(
      _baseUrl,
      "/v8/finance/chart/$symbol",
      {
        'range': range,
        'interval': interval,
        'indicators': 'quote',
        'includeTimestamps': 'true',
      },
    );

    final symbolChartResponse = await _httpClient.get(symbolGetChart);

    if (symbolChartResponse.statusCode != 200) {
      throw SymbolChartRequestFailure();
    }

    final symbolNewJson = jsonDecode(symbolChartResponse.body);
    final chartResult = symbolNewJson['chart'];

    if (chartResult["result"] == null) {
      throw SymbolChartNotFound();
    }
    return StockChart.fromJson(chartResult["result"].first as Map<String, dynamic>) ;
  }
}