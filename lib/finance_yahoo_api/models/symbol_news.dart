class SymbolNew {
  const SymbolNew({
    required this.title,
    required this.publishTime,
    required this.publisher,
    required this.relatedSymbol,
    required this.link,
  });

  final String title;
  final DateTime publishTime;
  final String publisher;
  final String link;
  final List<String> relatedSymbol;

  factory SymbolNew.fromJson(Map<String, dynamic> json) {
    return SymbolNew(
      title: json['title'] as String,
      publishTime: DateTime.fromMillisecondsSinceEpoch((json['providerPublishTime'] as int) * 1000),
      publisher: json['publisher'] as String,
      link: json['link'] as String,
      relatedSymbol: List<String>.from(json['relatedTickers']),

    );
  }
}