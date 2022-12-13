import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'post_hive.g.dart';

@HiveType(typeId: 1)
class PostHive extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Uint8List? image;

  PostHive({
    required this.id,
    this.image,
  });
}