import 'package:stock_app/finance_yahoo_api/models/symbol_search_component.dart';

class SymbolSearch {
  const SymbolSearch({
    required this.symbolList,
  });

  final List<SymbolComponent> symbolList;

  factory SymbolSearch.fromJson(Map<String, dynamic> json) {
    return SymbolSearch(
      symbolList: json["quotes"].map<SymbolComponent>((json) => SymbolComponent.fromJson(json)).toList(),
    );
  }
}