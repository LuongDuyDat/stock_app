import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/component/post.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/repositories/social_repository/post_hive_repository.dart';
import 'package:stock_app/repositories/symbol_repository/symbol_repository.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_bloc.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_event.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_state.dart';
import 'package:stock_app/util/globals.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../util/string.dart';

class HomeBlogPage extends StatelessWidget {
  const HomeBlogPage({super.key, required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    Box<PostHive> postBox = Hive.box<PostHive>('post');
    SymbolRepository symbolRepository = SymbolRepository();
    PostHiveRepository postHiveRepository = PostHiveRepository(postBox: postBox);
    return BlocProvider(
      create: (_) => SocialHomeBloc(symbolRepository: symbolRepository, postHiveRepository: postHiveRepository),
      child: HomeBlogView(symbol: symbol,),
    );
  }
}

class HomeBlogView extends StatefulWidget {
  const HomeBlogView({Key? key, required this.symbol}) : super(key: key);


  final String symbol;

  @override
  State<StatefulWidget> createState() => _HomeBlogViewState();

}

class _HomeBlogViewState extends State<HomeBlogView> {

  late ScrollController _scrollController;

  int type = 0;

  void _scrollListener() {
    setState(() {
      if (_scrollController.position.extentAfter < 0.2 * screenHeight && type == 0) {
        context.read<SocialHomeBloc>().add(SocialHomeGetMorePostEvent(widget.symbol, length: 5));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
          children: [
            Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 0.02 * screenWidth, height: screenHeight * 0.05, color: Colors.grey.shade300,),
                Container(
                  width: 0.96 * screenWidth,
                  height: screenHeight * 0.05,
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(108, 217, 134, 1.0),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5, top: 5),
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search, color: Colors.black, size: 20,),
                      hintText: searchString,
                      enabledBorder: OutlineInputBorder(
                        //borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //borderRadius: const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Color.fromRGBO(108, 217, 134, 1.0), width: 1),
                      ),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    autofocus: false,
                    cursorColor: Color.fromRGBO(108, 217, 134, 1.0),
                    onChanged: (text) {
                      context.read<SocialHomeBloc>().add(SocialHomeSearchWordChangeEvent(widget.symbol, content: text));
                      if (type == 0 && text != '') {
                        setState(() {
                          type = 1;
                        });
                      } else {
                        if (type == 1 && text == '') {
                          setState(() {
                            type = 0;
                          });
                        }
                      }
                    },
                  ),
                ),
                Container(width: 0.02 * screenWidth, height: screenHeight * 0.05, color: Colors.grey.shade300,),
              ],
            ),
            Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,),
            // test post
            BlocBuilder<SocialHomeBloc, SocialHomeState>(
              builder: (context, state) {
                if (state.searchWord == '') {
                  switch (state.postStatus) {
                    case SocialHomeStatus.initial:
                      context.read<SocialHomeBloc>().add(SocialHomeGetPostEvent(widget.symbol));
                      return Center();
                    case SocialHomeStatus.loading:
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                },
                                child: PostItem(
                                  name: state.posts.elementAt(index).id,
                                  time: timeago.format(state.posts.elementAt(index).createAt, locale: 'en_short'),
                                  description: state.posts.elementAt(index).content,
                                  image: state.posts.elementAt(index).image!,
                                  like: state.posts.elementAt(index).like,
                                  comment: state.posts.elementAt(index).comments.length,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,);
                            },
                            itemCount: state.posts.length,
                          ),
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    case SocialHomeStatus.success:
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: PostItem(
                              name: state.posts.elementAt(index).id,
                              time: timeago.format(state.posts.elementAt(index).createAt, locale: 'en_short'),
                              description: state.posts.elementAt(index).content,
                              image: state.posts.elementAt(index).image!,
                              like: state.posts.elementAt(index).like,
                              comment: state.posts.elementAt(index).comments.length,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,);
                        },
                        itemCount: state.posts.length,
                      );
                    case SocialHomeStatus.failure:
                      return const Center();
                  }
                } else {
                  switch (state.searchPostStatus) {
                    case SocialHomeStatus.initial:
                      return Center();
                    case SocialHomeStatus.loading:
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                },
                                child: PostItem(
                                  name: state.searchPosts.elementAt(index).id,
                                  time: timeago.format(state.searchPosts.elementAt(index).createAt, locale: 'en_short'),
                                  description: state.searchPosts.elementAt(index).content,
                                  image: state.searchPosts.elementAt(index).image!,
                                  like: state.searchPosts.elementAt(index).like,
                                  comment: state.searchPosts.elementAt(index).comments.length,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,);
                            },
                            itemCount: state.searchPosts.length,
                          ),
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    case SocialHomeStatus.success:
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: PostItem(
                              name: state.searchPosts.elementAt(index).id,
                              time: timeago.format(state.searchPosts.elementAt(index).createAt, locale: 'en_short'),
                              description: state.searchPosts.elementAt(index).content,
                              image: state.searchPosts.elementAt(index).image!,
                              like: state.searchPosts.elementAt(index).like,
                              comment: state.searchPosts.elementAt(index).comments.length,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,);
                        },
                        itemCount: state.searchPosts.length,
                      );
                    case SocialHomeStatus.failure:
                      return const Center();
                  }
                }
              }
            ),
            // GestureDetector(
            //   onTap: () {
            //   },
            //   child: PostItem(
            //     name: 'Fall Angel',
            //     time: "1d ago",
            //     description: "Mô tả sơ bộ về bài viết : đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM ",
            //     image: "https://i.pinimg.com/236x/72/56/64/72566455ccfe235e8279a89ad7fb8b01.jpg",
            //     like: 1000,
            //     comment: 3,
            //   ),
            // ),
            // Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) {
            //           return UploadPostPage(symbol: widget.symbol);
            //         })
            //     );
            //   },
            //   child: PostItem(
            //     name: 'Fall Angel',
            //     time: "1d ago",
            //     description: "Mô tả sơ bộ về bài viết : đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM đây là một bài viết dự đoán chứng khoán theo mô hình ML sử dụng mạng LSTM ",
            //     image: "https://i.pinimg.com/236x/72/56/64/72566455ccfe235e8279a89ad7fb8b01.jpg",
            //     like: 1000,
            //     comment: 3,
            //   ),
            // ),
            // Comment(
            //   name: 'Luong Dat',
            //   time: '5m',
            //   content: 'Chao cau! Toi La Dat',),
          ]
      ),
    );
  }
}
