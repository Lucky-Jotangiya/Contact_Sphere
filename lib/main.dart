import 'package:finaldb/database.dart';
import 'package:finaldb/homepage.dart';
import 'package:finaldb/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main(){
  runApp(MaterialApp(home: Splash(),));
}

class Splash extends StatefulWidget {

 static late SharedPreferences pref;
 static late Database db;

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabaseBefore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Center(child: CircularProgressIndicator())),
          
          Center(child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text("please waiting...."),
          )),
        ],
      ),
    );
  }

  Future<void> getDatabaseBefore() async {
    Splash.pref = await SharedPreferences.getInstance();

    await Db().getDataBase().then((value) {
      setState(() {
        Splash.db = value;
      });
    });

    setState(() {
      isLogin = Splash.pref.getBool('login')??false;
    });

    Future.delayed(Duration(seconds: 2)).then((value) {
      if(isLogin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        },));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Login();
        },));
      }
    });
  }
}
