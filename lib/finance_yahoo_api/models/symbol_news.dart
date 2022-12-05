class SymbolNew {
  const SymbolNew({
    required this.title,
    required this.publishTime,
    required this.publisher,
    required this.relatedSymbol,
  });

  final String title;
  final DateTime publishTime;
  final String publisher;
  final List<String> relatedSymbol;

  factory SymbolNew.fromJson(Map<String, dynamic> json) {
    return SymbolNew(
      title: json['title'] as String,
      publishTime: DateTime.fromMillisecondsSinceEpoch(json['providerPublishTime'] as int),
      publisher: json['publisher'] as String,
      relatedSymbol: json['relatedTickers'] as List<String>,

    );
  }
}