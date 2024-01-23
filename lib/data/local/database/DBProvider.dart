import 'dart:io';

import 'package:mvvm_flutter_app/constant/Constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DBProvider{

    static final DBProvider db = DBProvider._internal();
    factory DBProvider()=> db;
    DBProvider._internal();

    static Database? _database;

    Future<Database> get database async {
        if(_database != null){
            return _database!;
        }
        _database = await initDB();
        return _database!;
    }

    //init database
    initDB() async {
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path,Constant.DB_NAME);
        return await openDatabase(path, version: 1, onOpen: (db) {
        }, onCreate: _onCreateDB
        );
    }

    void _onCreateDB(Database db, int version) async{
        await db.execute("CREATE TABLE User ("
            "id INTEGER PRIMARY KEY,"
            "username TEXT,"
            "phone TEXT,"
            "address TEXT"
            ")");
    }
}
