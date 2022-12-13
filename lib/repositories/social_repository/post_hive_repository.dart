import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/post_hive.dart';

class PostHiveRepository {
  final Box<PostHive> postBox;

  PostHiveRepository({
    required this.postBox,
  });

  void addPost(String id, Uint8List? image) {
    PostHive p = PostHive(id: id, image: image);
    postBox.add(p);
  }
}