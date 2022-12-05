class StockChart {
  const StockChart({
    required this.timeStamp,
    required this.close,
  });

  final List<DateTime> timeStamp;
  final List<double> close;

  factory StockChart.fromJson(Map<String, dynamic> json) {
    return StockChart(
      timeStamp: (json['timestamp'] as List<int>).map<DateTime>((e) => DateTime.fromMicrosecondsSinceEpoch(e)).toList(),
      close: json['indicators']['quote'][0]['close'] as List<double>,
    );
  }
}