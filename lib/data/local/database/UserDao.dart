

import 'package:mvvm_flutter_app/data/local/database/DBProvider.dart';
import 'package:mvvm_flutter_app/data/local/database/User.dart';

class UserDao{

  //singleton instance
  static final UserDao _instance = UserDao._internal();
  factory UserDao()=> _instance;
  UserDao._internal();

  final String tableName = 'User';

  final DBProvider dbProvider = DBProvider.db;

  //create
  Future<int> insertUser(User user) async{
    final db = await dbProvider.database;
    return await db.insert(tableName, user.toMap());
  }

  //get list
  Future<List<User>> getAllUser() async{
    final db = await dbProvider.database;
    List<Map<String, dynamic>> userMapList = await db.query(tableName);
    return List.generate(userMapList.length, (index) => User.fromJson(userMapList[index]));
  }

  //update
  Future<void> updateUser(User user) async{
    final db = await dbProvider.database;
    db.update(tableName, user.toMap(),where: 'id= ?', whereArgs: [user.id]);
  }

  //delete
  Future<void> deleteUser(String id) async{
    final db = await dbProvider.database;
    db.delete(tableName,where: 'id= ?', whereArgs: [id]);
  }

}