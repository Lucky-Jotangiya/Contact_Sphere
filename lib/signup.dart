import 'package:finaldb/database.dart';
import 'package:finaldb/login.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

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

          SizedBox(height: 20,),

          ElevatedButton(onPressed: () {

            String email = conEmail.text;
            String pass = conPass.text;

            Db().insertData(email,pass).then((value) {
              if(value){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("register successful")));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Login();
                },));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("already exists")));
              }
            });

          }, child: Text("sign up")),
        ],
      ),
    );
  }
}
