import 'package:equatable/equatable.dart';
import 'package:stock_app/repositories/symbol_repository/models/quote.dart';
import 'package:stock_app/repositories/symbol_repository/models/stock.dart';

enum StockStatus {initial, loading, success, failure}

class StockState extends Equatable{
  const StockState({
    this.selectIndex = 0,
    this.dayStock = const Stock(close: [], regularMarketPrice: 0, previousClose: 0,),
    this.monthStock = const Stock(close: [], regularMarketPrice: 0, previousClose: 0,),
    this.yearStock = const Stock(close: [], regularMarketPrice: 0, previousClose: 0,),
    this.quote = const Quote(open: 0, high: 0, low: 0,),
    this.chartStatus = StockStatus.initial,
    this.quoteStatus = StockStatus.initial,
  });

  final int selectIndex;
  final Stock dayStock;
  final Stock monthStock;
  final Stock yearStock;
  final Quote quote;
  final StockStatus chartStatus;
  final StockStatus quoteStatus;

  StockState copyWith({
    int Function()? selectIndex,
    Stock Function()? dayStock,
    Stock Function()? monthStock,
    Stock Function()? yearStock,
    StockStatus Function()? chartStatus,
    Quote Function()? quote,
    StockStatus Function()? quoteStatus,
  }) {
    return StockState(
      selectIndex: selectIndex != null ? selectIndex() : this.selectIndex,
      dayStock: dayStock != null ? dayStock() : this.dayStock,
      monthStock: monthStock != null ? monthStock() : this.monthStock,
      yearStock: yearStock != null ? yearStock() : this.yearStock,
      chartStatus: chartStatus != null ? chartStatus() : this.chartStatus,
      quote: quote != null ? quote() : this.quote,
      quoteStatus: quoteStatus != null ? quoteStatus() : this.quoteStatus,
    );
  }

  @override
  List<Object?> get props => [
    selectIndex,
    dayStock,
    monthStock,
    yearStock,
    quote,
    chartStatus,
    quoteStatus,
  ];
}