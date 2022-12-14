import 'dart:math';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_app/repositories/social_repository/models/comment_hive.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';
import 'package:stock_app/repositories/social_repository/models/user_hive.dart';

class PostHiveRepository {
  final Box<PostHive> postBox;

  PostHiveRepository({
    required this.postBox,
  });

  Future<bool> addFavorite(dynamic userKey, dynamic postKey) async {
    PostHive? p = postBox.get(postKey);

    Box<UserHive> userBox = Hive.box<UserHive>('user');
    UserHive? u = userBox.get(userKey);

    if (p == null || u == null) {
      return false;
    }

    p.like.add(u);
    await p.save();

    return true;
  }

  Future<void> createPost(String name, String content, XFile? image, String symbol) async{
    Box<UserHive> userBox = Hive.box<UserHive>('user');
    Box<CommentHive> commentBox = Hive.box<CommentHive>('comment');
    Uint8List? i;
    if (image != null) {
      i = await image.readAsBytes();
    }
    PostHive temp = PostHive(
      id: name,
      content: content,
      image: i,
      symbol: symbol,
      createAt: DateTime.now(),
      like: HiveList(userBox),
      comments: HiveList(commentBox),
    );
    await postBox.add(temp);
  }

  Future<bool> deleteFavorite(dynamic userKey, dynamic postKey) async {
    PostHive? p = postBox.get(postKey);

    Box<UserHive> userBox = Hive.box<UserHive>('user');
    UserHive? u = userBox.get(userKey);

    if (p == null || u == null) {
      return false;
    }


    int index = p.like.indexOf(u);

    if (index == -1) {
      return false;
    }

    await p.like.removeAt(index);
    await p.save();

    return true;
  }

  Future<CommentHive?> addComment(String userName, dynamic postKey, String content) async {
    PostHive? p = postBox.get(postKey);

    if (p == null) {
      return null;
    }

    CommentHive comment = CommentHive(content: content, userName: userName, createAt: DateTime.now());

    Box<CommentHive> commentBox = Hive.box<CommentHive>('comment');

    await commentBox.add(comment);

    p.comments.add(comment);

    await p.save();

    return comment;
  }

  Future<PostHive> addPost(String name, Uint8List? image, String content, String symbol, DateTime time) async{
    Box<CommentHive> commentBox = Hive.box<CommentHive>('comment');
    Box<UserHive> userBox = Hive.box<UserHive>('user');
    PostHive p = PostHive(
      id: name,
      image: image,
      content: content,
      symbol: symbol,
      createAt: time,
      comments: HiveList(commentBox),
      like: HiveList(userBox),
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