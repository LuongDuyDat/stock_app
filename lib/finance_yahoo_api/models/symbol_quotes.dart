class SymbolQuotes {
  const SymbolQuotes({
    required this.open,
    required this.high,
    required this.low,
    required this.vol,
    required this.trailingPE,
    required this.marketCap,
    required this.fiftyTwoWeekHigh,
    required this.fiftyTwoWeekLow,
    required this.averageVolume,
    required this.yield,
    required this.ePS,
  });

  final double open;
  final double high;
  final double low;
  final double vol;
  final double trailingPE;
  final int marketCap;
  final double fiftyTwoWeekHigh;
  final double fiftyTwoWeekLow;
  final double averageVolume;
  final double yield;
  final double ePS;

  factory SymbolQuotes.fromJson(Map<String, dynamic> json) {
    return SymbolQuotes(
      open: json['regularMarketOpen'] as double,
      high: json['regularMarketDayHigh'] as double,
      low: json['regularMarketDayLow'] as double,
      vol: json['regularMarketVolume'].toDouble() as double,
      trailingPE: json['trailingPE'] as double,
      marketCap: json['marketCap'] as int,
      fiftyTwoWeekHigh: json['fiftyTwoWeekHigh'] as double,
      fiftyTwoWeekLow: json['fiftyTwoWeekLow'] as double,
      averageVolume: json['averageDailyVolume3Month'].toDouble() as double,
      yield: json['trailingAnnualDividendYield'] as double,
      ePS: json['epsTrailingTwelveMonths'] as double,
    );
  }
}