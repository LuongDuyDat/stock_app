import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/favorite_symbol.dart';

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
  @HiveField(4)
  final HiveList<FavoriteSymbolHive> favoriteSymbols;

  UserHive({
    required this.name,
    required this.userEmail,
    required this.userName,
    required this.passWord,
    required this.favoriteSymbols,
  });
}