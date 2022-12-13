import 'package:hive/hive.dart';
import 'package:stock_app/repositories/social_repository/models/favorite_symbol.dart';
import 'package:stock_app/repositories/social_repository/models/user_hive.dart';

import '../../util/globals.dart';

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
        account = items.elementAt(i);
        return true;
      }
      if (items.elementAt(i).userName == userName && items.elementAt(i).passWord == password) {
        account = items.elementAt(i);
        return true;
      }
    }
    return false;
  }

  bool checkFavorite(String symbol) {
    UserHive? user = userBox.get(account.key);
    if (user != null) {
      var items = user.favoriteSymbols.toList();
      for (int i = 0; i < items.length; i++) {
        if (items.elementAt(i).name == symbol) {
          return true;
        }
      }
      return false;
    }
    return false;
  }

  Future<void> addToFavorite(String symbol, String shortName) async {
    Box<FavoriteSymbolHive> favoriteBox = Hive.box<FavoriteSymbolHive>('symbol');
    var items = favoriteBox.values.toList();
    int index = -1;
    for (int i = 0; i < items.length; i++) {
      if (items.elementAt(i).name == symbol) {
        index = i;
        break;
      }
    }
    FavoriteSymbolHive symbols;
    if (index == -1) {
      symbols = FavoriteSymbolHive(name: symbol, shortName: shortName);
      await favoriteBox.add(symbols);
    } else {
      symbols = items.elementAt(index);
    }
    account.favoriteSymbols.add(symbols);
    await account.save();
  }

  Future<void> deleteFromFavorite(String symbol) async {
    for (int i = 0; i < account.favoriteSymbols.length; i++) {
      if (account.favoriteSymbols.elementAt(i).name == symbol) {
        account.favoriteSymbols.removeAt(i);
        break;
      }
    }
    await account.save();
  }
}