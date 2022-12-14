class SymbolNew {
  const SymbolNew({
    required this.title,
    this.publishTime,
    required this.publisher,
    required this.relatedSymbol,
    required this.imgUrl,
    required this.link,
  });

  final String title;
  final DateTime? publishTime;
  final String publisher;
  final String link;
  final String? imgUrl;
  final List<String> relatedSymbol;

  factory SymbolNew.fromJson(Map<String, dynamic> json) {
    return SymbolNew(
      title: json['title'] as String,
      publishTime:json['providerPublishTime'] != null ? DateTime.fromMillisecondsSinceEpoch((json['providerPublishTime'] as int) * 1000) : null,
      publisher: json['publisher'] as String,
      link: json['link'] as String,
      imgUrl: json['thumbnail'] != null ? json['thumbnail']['resolutions'][0]['url'] as String : null,
      relatedSymbol: List<String>.from(json['relatedTickers']),

    );
  }
}