import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stock_app/component/new.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_bloc.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_event.dart';
import 'package:stock_app/screen/social/home/social_home_bloc/social_home_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../component/post.dart';
import '../../../../repositories/social_repository/models/post_hive.dart';
import '../../../../repositories/social_repository/post_hive_repository.dart';
import '../../../../repositories/symbol_repository/symbol_repository.dart';
import '../../../../util/globals.dart';
import 'package:timeago/timeago.dart' as timeago;


class BlogNewPage extends StatelessWidget {
  const BlogNewPage({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    Box<PostHive> postBox = Hive.box<PostHive>('post');
    SymbolRepository symbolRepository = SymbolRepository();
    PostHiveRepository postHiveRepository = PostHiveRepository(postBox: postBox);
    return BlocProvider(
      create: (_) => SocialHomeBloc(symbolRepository: symbolRepository, postHiveRepository: postHiveRepository),
      child: HomeNewView(symbol: symbol,),
    );
  }

}

class HomeNewView extends StatelessWidget {
  const HomeNewView({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,),
          BlocBuilder<SocialHomeBloc, SocialHomeState>(
            builder: (context, state) {
              switch (state.newStatus) {
                case SocialHomeStatus.initial:
                  context.read<SocialHomeBloc>().add(SocialHomeGetNewEvent(symbol));
                  return Center();
                case SocialHomeStatus.loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case SocialHomeStatus.success:
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print(1);
                          Uri u = Uri.parse(state.news.elementAt(index).link);
                          launchUrl(u);
                        },
                        child: NewItem(
                          name: state.news.elementAt(index).publisher,
                          time: state.news.elementAt(index).publishTime != null ? timeago.format(state.news.elementAt(index).publishTime!, locale: 'en_short') : null,
                          description: state.news.elementAt(index).title,
                          image: state.news.elementAt(index).imgUrl,
                          //image: state.posts.elementAt(index).image!,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: 0.012 * screenHeight, color: Colors.grey.shade300,);
                    },
                    itemCount: state.news.length,
                  );
                case SocialHomeStatus.failure:
                  return const Center(
                    child: Text("This symbol have no news", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,),),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}