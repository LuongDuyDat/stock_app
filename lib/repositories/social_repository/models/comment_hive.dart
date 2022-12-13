import 'package:hive/hive.dart';

part 'comment_hive.g.dart';

@HiveType(typeId: 3)
class CommentHive extends HiveObject {
  @HiveField(0)
  final String content;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final DateTime createAt;

  CommentHive({
    required this.content,
    required this.userName,
    required this.createAt,
  });
}