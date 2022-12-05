class StockChart {
  const StockChart({
    required this.timeStamp,
    required this.close,
  });

  final List<DateTime> timeStamp;
  final List<double> close;

  factory StockChart.fromJson(Map<String, dynamic> json) {
    return StockChart(
      timeStamp: (List<int>.from(json['timestamp'])).map<DateTime>((e) => DateTime.fromMicrosecondsSinceEpoch(e * 1000)).toList(),
      close: List<double>.from(json['indicators']['quote'][0]['close']),
    );
  }
}