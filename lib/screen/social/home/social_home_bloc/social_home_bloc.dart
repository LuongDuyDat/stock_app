import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/finance_yahoo_api/models/symbol_news.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/repositories/social_repository/post_hive_repository.dart';
import 'package:stock_app/repositories/symbol_repository/symbol_repository.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_event.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_state.dart';

import '../../../../repositories/social_repository/models/post_hive.dart';

class SocialHomeBloc extends Bloc<SocialHomeEvent, SocialHomeState> {
  SocialHomeBloc({
    required SymbolRepository symbolRepository,
    required PostHiveRepository postHiveRepository,
  }) : _symbolRepository = symbolRepository,
        _postHiveRepository = postHiveRepository,
        super(const SocialHomeState()) {
    on<SocialHomeGetPostEvent>(_onGetPostEvent);
    on<SocialHomeGetMorePostEvent>(_onGetMorePostEvent);
    on<SocialHomeGetNewEvent>(_onGetNewEvent);
    on<SocialHomeSearchWordChangeEvent>(_onSearchWordChangeEvent);
  }

  final SymbolRepository _symbolRepository;
  final PostHiveRepository _postHiveRepository;

  Future<void> _onGetPostEvent (
      SocialHomeGetPostEvent event,
      Emitter<SocialHomeState> emit,
      ) async{
    emit(state.copyWith(
      postStatus: () => SocialHomeStatus.loading,
    ));

    await emit.forEach<PostHive>(
        _postHiveRepository.getPost(event.symbol, 0, 5),
        onData: (postHive) {
          List<PostHive> temp = List.from(state.posts);
          temp.add(postHive);
          return state.copyWith(posts: () => temp);
        },
        onError: (_, __) {
          return state.copyWith(
            postStatus: () => SocialHomeStatus.failure,
          );
        }
    );

    if (state.postStatus != SocialHomeStatus.failure) {
      emit(
          state.copyWith(
              postStatus: () => SocialHomeStatus.success
          ));
    }

    if (state.posts.length < 5) {
      emit(
          state.copyWith(
            hasMorePost: () => false,
          ));
    }

    if (state.posts.length == 0) {
      final byteData = await rootBundle.load('assets/stock1.jpeg');
      Uint8List u = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      PostHive p = await _postHiveRepository.addPost('Admin', u, "Welcome to " + event.symbol + " group. This is the place for everyone to discussion.", event.symbol, DateTime(2022, 12, 4));
      emit(
          state.copyWith(
              postStatus: () => SocialHomeStatus.success,
            posts: () => [p]
          ));
    }
  }

  Future<void> _onGetMorePostEvent (
      SocialHomeGetMorePostEvent event,
      Emitter<SocialHomeState> emit,
      ) async{
    if (state.hasMorePost == false) {
      return;
    }

    emit(state.copyWith(
      postStatus: () => SocialHomeStatus.loading,
    ));

    int cnt = state.posts.length;

    await emit.forEach<PostHive>(
        _postHiveRepository.getPost(event.symbol, cnt, cnt + 5),
        onData: (postHive) {
          List<PostHive> temp = List.from(state.posts);
          temp.add(postHive);
          return state.copyWith(posts: () => temp);
        },
        onError: (_, __) {
          return state.copyWith(
            postStatus: () => SocialHomeStatus.failure,
          );
        }
    );

    if (state.postStatus != SocialHomeStatus.failure) {
      emit(
          state.copyWith(
              postStatus: () => SocialHomeStatus.success
          ));
    }

    if (state.posts.length < cnt + 5) {
      emit(
          state.copyWith(
            hasMorePost: () => false,
          ));
    }
  }

  Future<void> _onGetNewEvent (
      SocialHomeGetNewEvent event,
      Emitter<SocialHomeState> emit,
      ) async{
    emit(state.copyWith(
      newStatus: () => SocialHomeStatus.loading,
    ));
    List<SymbolNew> news = [];
    try {
      news = await _symbolRepository.getSymbolNew(event.symbol);
    } on Exception {
      emit(
          state.copyWith(
              newStatus: () => SocialHomeStatus.failure,
          ));
    }

    if (state.postStatus != SocialHomeStatus.failure) {
      emit(
          state.copyWith(
            newStatus: () => SocialHomeStatus.success,
            news: () => news,
          ));
    }
  }

  Future<void> _onSearchWordChangeEvent (
      SocialHomeSearchWordChangeEvent event,
      Emitter<SocialHomeState> emit,
      ) async {
    emit(state.copyWith(
      searchPosts: () => [],
      searchWord: () => event.content,
      searchPostStatus: () => SocialHomeStatus.initial,
    ));

    if (event.content == '') {
      return;
    }

    emit(state.copyWith(
      searchPostStatus: () => SocialHomeStatus.loading,
    ));

    await emit.forEach<PostHive>(
        _postHiveRepository.getPostBySearch(event.symbol, event.content),
        onData: (postHive) {
          List<PostHive> temp = List.from(state.searchPosts);
          temp.add(postHive);
          return state.copyWith(searchPosts: () => temp);
        },
        onError: (_, __) {
          return state.copyWith(
            searchPostStatus: () => SocialHomeStatus.failure,
          );
        }
    );

    if (state.searchPostStatus != SocialHomeStatus.failure) {
      emit(
          state.copyWith(
              searchPostStatus: () => SocialHomeStatus.success
          ));
    }
  }
}