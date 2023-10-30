import 'package:finaldb/database.dart';
import 'package:finaldb/login.dart';
import 'package:finaldb/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool show = false;
  var icon = Icons.remove_red_eye_outlined;

  TextEditingController conUser = TextEditingController();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            SizedBox(height: 120,),

            Center(child: Text("Sign up", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),)),

            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: conUser,
                decoration: InputDecoration(
                  labelText: "Enter UserName",
                  prefixIcon: Icon(
                    CupertinoIcons.profile_circled,
                    color: Colors.deepPurple,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: conEmail,
                decoration: InputDecoration(
                  labelText: "Enter Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.deepPurple,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: conPass,
                obscureText: show,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.deepPurple,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (show == false) {
                          show = true;
                          icon = Icons.remove_red_eye;
                        } else {
                          show = false;
                          icon = Icons.remove_red_eye_outlined;
                        }
                      });
                    },
                    icon: Icon(
                      icon,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: InkWell(
                      onTap: () {
                        String user = conUser.text;
                        String email = conEmail.text;
                        String pass = conPass.text;

                        if(conUser.text == ""){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Required Information")));
                        }
                        else if(conEmail.text == ""){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Required Information")));
                        }
                        else if(conPass.text == ""){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Required Information")));
                        }
                        else{
                          Db().insertData(user,email,pass).then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("register successful")));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Login();
                                    },
                                  ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("already exists")));
                            }
                          });
                        }
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Colors.deepPurple,
                        child: Center(
                            child: Text(
                          "Sign up",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
