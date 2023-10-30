import 'package:finaldb/database.dart';
import 'package:finaldb/homepage.dart';
import 'package:finaldb/main.dart';
import 'package:finaldb/signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  var icon = Icons.remove_red_eye_outlined;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [

              SizedBox(height: 120,),

              Center(child: Text("Log in", style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),)),

              SizedBox(height: 90,),

              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: conEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.deepPurple,),
                    labelText: "Enter Your Email",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        )
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        )
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      obscureText: show,
                      controller: conPass,
                      decoration: InputDecoration(
                        labelText: "Enter Your Password",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blue,
                            )
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            )
                        ),

                        prefixIcon: Icon(Icons.lock, color: Colors.deepPurple,),
                        suffixIcon: IconButton(
                          icon: Icon(icon, color: Colors.red,), onPressed: () {
                          setState(() {
                            if (show == false) {
                              show = true;
                              icon = Icons.remove_red_eye;
                            }
                            else {
                              show = false;
                              icon = Icons.remove_red_eye_outlined;
                            }
                          });
                        },),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: TextButton(onPressed: () {


                    },
                        child: Text("Forget Password ?",
                          style: TextStyle(fontWeight: FontWeight.normal),)),
                  ),
                ],
              ),

              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: InkWell(
                        onTap: () {
                          Db().loginUser(conEmail.text, conPass.text).then((
                              value) {
                            if (value.length == 1) {
                              Splash.pref.setInt('userid', value[0]['id']);
                              Splash.pref.setBool('login', true);
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) {
                                return HomePage();
                              },));
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("no user found")));
                            }
                          });
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.deepPurple,
                          child: Center(child: Text("Sign in", style: TextStyle(
                              fontSize: 17, color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 110,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't Have An Account ?",
                    style: TextStyle(color: Colors.deepPurple),),
                  TextButton(onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) {
                      return SignUp();
                    },));
                  }, child: Text("Sign up")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}