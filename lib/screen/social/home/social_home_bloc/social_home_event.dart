import 'package:equatable/equatable.dart';

class SocialHomeEvent extends Equatable {
  const SocialHomeEvent({required this.symbol,});

  final String symbol;

  @override
  List<Object?> get props => [symbol];
}

class SocialHomeGetPostEvent extends SocialHomeEvent {
  const SocialHomeGetPostEvent(String symbol,) : super(symbol: symbol);

}

class SocialHomeGetMorePostEvent extends SocialHomeEvent {
  const SocialHomeGetMorePostEvent(String symbol,{ required this.length,}) : super(symbol: symbol);

  final int length;

  @override
  List<Object?> get props => [length, symbol];
}

class SocialHomeGetNewEvent extends SocialHomeEvent {
  const SocialHomeGetNewEvent(String symbol,) : super(symbol: symbol);
}

class SocialHomeSearchWordChangeEvent extends SocialHomeEvent {
  const SocialHomeSearchWordChangeEvent(String symbol,{ required this.content,}) : super(symbol: symbol);

  final String content;

  @override
  List<Object?> get props => [content, symbol];
}