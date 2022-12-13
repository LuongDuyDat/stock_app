import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/comment_hive.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';

class PostHiveRepository {
  final Box<PostHive> postBox;

  PostHiveRepository({
    required this.postBox,
  });

  void addPost(String id, Uint8List? image, String content, String symbol) {
    Box<CommentHive> commentBox = Hive.box<CommentHive>('comment');
    PostHive p = PostHive(
      id: id,
      image: image,
      content: content,
      symbol: symbol,
      createAt: DateTime.now(),
      comments: HiveList(commentBox),
      like: 0,
    );
    postBox.add(p);
  }
}