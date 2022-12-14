import 'dart:math';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/comment_hive.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';

class PostHiveRepository {
  final Box<PostHive> postBox;

  PostHiveRepository({
    required this.postBox,
  });

  Future<PostHive> addPost(String name, Uint8List? image, String content, String symbol, DateTime time) async{
    Box<CommentHive> commentBox = Hive.box<CommentHive>('comment');
    PostHive p = PostHive(
      id: name,
      image: image,
      content: content,
      symbol: symbol,
      createAt: DateTime.now(),
      comments: HiveList(commentBox),
      like: 0,
    );
    await postBox.add(p);
    return p;
  }

  Stream<PostHive> getPostBySearch(String symbol, String content) async*{
    var items = postBox.values.where((element) {
      if (element.symbol == symbol && (element.id.toLowerCase().contains(content.toLowerCase()) || element.content.toLowerCase().contains(content))) {
        return true;
      }
      return false;
    }).toList();

    items.sort((b, a) => a.createAt.compareTo(b.createAt));
    for (int i = 0; i < items.length; i++) {
      yield items.elementAt(i);
    }
  }

  Stream<PostHive> getPost(String symbol, int start, int end) async*{
    var items = postBox.values.where((element) {
      if (element.symbol == symbol) {
        return true;
      }
      return false;
    }).toList();

    items.sort((b, a) => a.createAt.compareTo(b.createAt));
    for (int i = min(start, items.length - 1); i < min(end, items.length); i++) {
      yield items.elementAt(i);
    }
  }
}