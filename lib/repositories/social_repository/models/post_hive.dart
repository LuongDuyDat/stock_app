import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/comment_hive.dart';

part 'post_hive.g.dart';

@HiveType(typeId: 1)
class PostHive extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Uint8List? image;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final DateTime createAt;
  @HiveField(4)
  final int like;
  @HiveField(5)
  final String symbol;
  @HiveField(6)
  final HiveList<CommentHive> comments;

  PostHive({
    required this.id,
    this.image,
    required this.content,
    required this.createAt,
    required this.like,
    required this.symbol,
    required this.comments,
  });
}