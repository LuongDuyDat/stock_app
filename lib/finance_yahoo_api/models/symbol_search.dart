import 'package:stock_app/finance_yahoo_api/models/symbol_search_component.dart';

class SymbolSearch {
  const SymbolSearch({
    required this.symbolList,
  });

  final List<SymbolComponent> symbolList;

  factory SymbolSearch.fromJson(Map<String, dynamic> json) {
    //final jsonDecode = jsonDecode(json['quotes']).c
    return SymbolSearch(
      symbolList: json["quotes"].map((json) => SymbolComponent.fromJson(json)),
    );
  }
}