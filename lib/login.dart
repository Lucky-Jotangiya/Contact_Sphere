import 'package:finaldb/database.dart';
import 'package:finaldb/homepage.dart';
import 'package:finaldb/main.dart';
import 'package:finaldb/signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: conEmail,
            decoration: InputDecoration(
              labelText: "enter email",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),

          SizedBox(height: 20,),

          TextField(
            controller: conPass,
            decoration: InputDecoration(
              labelText: "enter password",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),

          ElevatedButton(onPressed: () {

            Db().loginUser(conEmail.text,conPass.text).then((value) {
              if(value.length == 1){
                Splash.pref.setInt('userid', value[0]['id']);
                Splash.pref.setBool('login', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                },));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("no user found")));
              }
            });

          }, child: Text("login")),

          ElevatedButton(onPressed: () {

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Signup();
            },));

          }, child: Text("register")),
        ],
      ),
    );
  }
}
