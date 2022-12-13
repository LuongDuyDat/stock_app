import 'dart:convert';

import 'package:http/http.dart' as http;

class SymbolPredictRequestFailure implements Exception {}

class SymbolPredictNotFound implements Exception {}

class ModelAPI {
  ModelAPI({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  static const String _baseUrl = "127.0.0.1:5000";
  final http.Client _httpClient;

  Future<List<double>> getPredict(String symbol ,String value1, String value2, String value3, String value4, String value5, String value6, String value7) async{
    final symbolPredictRequest = Uri.http(
      _baseUrl,
      "/predict",
      {
        'symbol': symbol,
        'values1': value1,
        'values2': value2,
        'values3': value3,
        'values4': value4,
        'values5': value5,
        'values6': value6,
        'values7': value7,
      },
    );

    List<double> result = [];

    print(symbolPredictRequest);

    final symbolPredictResponse = await _httpClient.get(symbolPredictRequest);

    if (symbolPredictResponse.statusCode != 200) {
      throw SymbolPredictRequestFailure();
    }

    final symbolPredictJson = jsonDecode(symbolPredictResponse.body);

    if (symbolPredictJson["result"].isEmpty) {
      throw SymbolPredictNotFound();
    }

    List<String> temp = List<String>.from(symbolPredictJson["result"]);

    for (int i = 0; i < temp.length; i++) {
      result.add(double.parse(temp.elementAt(i)));
    }

    return result;
  }
}