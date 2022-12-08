import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeSubscriptionRequest extends HomeEvent {
  const HomeSubscriptionRequest({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [id];
}

class HomeSearchSymbol extends HomeEvent {
  const HomeSearchSymbol({
    required this.searchContent,
  });

  final String searchContent;

  @override
  List<Object?> get props => [searchContent];
}

class HomeLoadMoreFavoriteSymbol extends HomeEvent {
  const HomeLoadMoreFavoriteSymbol({
    required this.id,
    required this.start,
    required this.end,
  });

  final String id;
  final int start;
  final int end;
}