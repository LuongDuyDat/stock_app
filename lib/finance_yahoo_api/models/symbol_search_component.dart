class SymbolComponent {
  const SymbolComponent({
    required this.symbol,
    required this.shortName,
  });

  final String symbol;
  final String shortName;

  factory SymbolComponent.fromJson(Map<String, dynamic> json) {
    return SymbolComponent(
      symbol: json['symbol'] as String,
      shortName: json['shortname'] as String,
    );
  }
}