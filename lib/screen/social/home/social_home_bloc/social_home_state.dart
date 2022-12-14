import 'package:equatable/equatable.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_news.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';

enum SocialHomeStatus {initial, loading, success, failure}

class SocialHomeState extends Equatable {
  const SocialHomeState({
    this.posts = const [],
    this.postStatus = SocialHomeStatus.initial,
    this.hasMorePost = true,
    this.news = const [],
    this.newStatus = SocialHomeStatus.initial,
    this.searchPosts = const [],
    this.searchPostStatus = SocialHomeStatus.initial,
    this.searchWord = '',
  });

  final List<PostHive> posts;
  final SocialHomeStatus postStatus;
  final bool hasMorePost;
  final List<SymbolNew> news;
  final SocialHomeStatus newStatus;
  final List<PostHive> searchPosts;
  final SocialHomeStatus searchPostStatus;
  final String searchWord;

  SocialHomeState copyWith({
    SocialHomeStatus Function()? postStatus,
    List<PostHive> Function()? posts,
    bool Function()? hasMorePost,
    SocialHomeStatus Function()? newStatus,
    List<SymbolNew> Function()? news,
    SocialHomeStatus Function()? searchPostStatus,
    List<PostHive> Function()? searchPosts,
    String Function()? searchWord,
  }) {
    return SocialHomeState(
      postStatus: postStatus != null ? postStatus() : this.postStatus,
      posts: posts != null ? posts() : this.posts,
      hasMorePost: hasMorePost != null ? hasMorePost() : this.hasMorePost,
      newStatus: newStatus != null ? newStatus() : this.newStatus,
      news: news != null ? news() : this.news,
      searchPostStatus: searchPostStatus != null ? searchPostStatus() : this.searchPostStatus,
      searchPosts: searchPosts != null ? searchPosts() : this.searchPosts,
      searchWord: searchWord != null ? searchWord() : this.searchWord,
    );
  }

  @override
  List<Object?> get props => [
    posts,
    postStatus,
    hasMorePost,
    news,
    newStatus,
    searchPosts,
    searchPostStatus,
    searchWord,
  ];
}