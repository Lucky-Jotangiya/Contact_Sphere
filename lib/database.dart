import 'package:finaldb/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  Future<Database> getDataBase() async {

    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'MyDb.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String table1 =
            "create table table1 (id integer primary key autoincrement,user Text,email Text,password Text)";
        db.execute(table1);

        String table2 =
            "create table table2 (id integer primary key autoincrement,name text,number Text,userid integer)";
        db.execute(table2);
      },
    );
    return database;
  }

  Future<bool> insertData(String user, String email, String pass) async {

    Database database = Splash.db!;

    String check = "select * from table1 where email = '$email' or password = '$pass'";
    List<Map> list = await database.rawQuery(check);

    if(list.length == 0){
      String insertQry = "insert into table1 (user,email,password) values ('$user','$email','$pass')";
      int a = await database.rawInsert(insertQry);
      return true;
    }
    else{
      return false;
    }
  }

  Future<List<Map>> loginUser(String email, String pass) async {
    Database database = Splash.db!;

    String ss = "select * from table1 where email = '$email' and password = '$pass'";
    List<Map> list = await database.rawQuery(ss);
    return list;
  }

  Future<List<Map>> viewcontact(Database database, int userid) async {

    String select = "select * from table2 where userid = '$userid'";
    List<Map> ll = await database.rawQuery(select);
    return ll;
  }

  Future<bool> insertNewData(String name, String number, int userid, Database database) async {
    String check = "select * from table2 where number = '$number'";
    List<Map> list = await database.rawQuery(check);

    if(list.length == 0){
      String insert = "insert into table2 (name,number,userid) values ('$name','$number','$userid')";
      int a = await database.rawInsert(insert);
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> delete(int id, Database database) async {
    String delete = "delete from table2 where id = '$id'";
    int a = await database.rawDelete(delete);
  }

  Future<void> update(String name, String number, Database database, int id) async {

    String update = "update table2 set name = '$name' , number = '$number' where id = '$id'";
    await database.rawUpdate(update);
  }

  Future<List<Map>> userDetail(Database database, int id) async {
    String select = "select * from table1 where id = '$id'";
    List<Map> list = await database.rawQuery(select);
    print(list);
    return list;
  }
}
