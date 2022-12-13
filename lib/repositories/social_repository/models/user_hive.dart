import 'package:hive/hive.dart';

part 'user_hive.g.dart';

@HiveType(typeId: 0)
class UserHive extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String userEmail;
  @HiveField(2)
  final String userName;
  @HiveField(3)
  final String passWord;

  UserHive({
    required this.name,
    required this.userEmail,
    required this.userName,
    required this.passWord,
  });
}