class StockChart {
  const StockChart({
    required this.timeStamp,
    required this.close,
    required this.regularMarketPrice,
    required this.previousClose,
  });

  final List<DateTime> timeStamp;
  final List<double?> close;
  final double regularMarketPrice;
  final double previousClose;

  factory StockChart.fromJson(Map<String, dynamic> json) {
    return StockChart(
      timeStamp: (List<int>.from(json['timestamp'])).map<DateTime>((e) => DateTime.fromMicrosecondsSinceEpoch(e * 1000)).toList(),
      close: (List<double?>.from(json['indicators']['quote'][0]['close'])),
      regularMarketPrice: json['meta']['regularMarketPrice'] as double,
      previousClose: json['meta']['previousClose'] as double,
    );
  }
}