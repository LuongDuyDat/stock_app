import 'package:hive/hive.dart';

part 'favorite_symbol.g.dart';

@HiveType(typeId: 2)
class FavoriteSymbolHive extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String shortName;

  FavoriteSymbolHive({
    required this.name,
    required this.shortName,
  });
}