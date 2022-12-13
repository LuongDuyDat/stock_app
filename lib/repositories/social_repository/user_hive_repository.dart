import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/favorite_symbol.dart';
import 'package:stock_app/repositories/social_repository/models/user_hive.dart';

class UserHiveRepository {
  final Box<UserHive> userBox;

  UserHiveRepository({
    required this.userBox,
  });

  bool register(String name, String userName, String email, String passWord) {
    var items = userBox.values.toList();
    for (int i = 0; i < items.length; i++) {
      if (items.elementAt(i).userEmail == email || items.elementAt(i).userName == userName) {
        return false;
      }
    }
    Box<FavoriteSymbolHive> symbolBox = Hive.box<FavoriteSymbolHive>('symbol');
    UserHive u = UserHive(
      name: name,
      userEmail: email,
      userName: userName,
      passWord: passWord,
      favoriteSymbols: HiveList(symbolBox),
    );
    userBox.add(u);
    return true;
  }

  bool login(String userName, String userEmail, String password) {
    var items = userBox.values.toList();

    for (int i = 0; i < items.length; i++) {
      if (items.elementAt(i).userEmail == userEmail && items.elementAt(i).passWord == password) {
        return true;
      }
      if (items.elementAt(i).userName == userName && items.elementAt(i).passWord == password) {
        return true;
      }
    }
    return false;
  }
}