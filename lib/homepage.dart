import 'package:finaldb/database.dart';
import 'package:finaldb/login.dart';
import 'package:finaldb/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController conName = TextEditingController();
  TextEditingController conNumber = TextEditingController();
  TextEditingController conName2 = TextEditingController();
  TextEditingController conNumber2 = TextEditingController();

  int? userid;
  String email = "";
  String user = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userid = Splash.pref.getInt('userid')??0;
    });
    getData();
    userDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: () {
              showDialog(context: context, builder: (context) {
                return SimpleDialog(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: conName,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.drive_file_rename_outline,color: Colors.deepPurple,),
                            labelText: "Enter Name",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                        ),
                      ),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: conNumber,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.call,color: Colors.deepPurple,),
                            labelText: "Enter Number",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5,left: 200),
                      child: TextButton(onPressed: () {

                        if(conName.text.length>50){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Name Under 15 words")));
                        }

                        if(conNumber.text.length>10 || conNumber.text.length<10){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Valid Number")));
                        }
                        else{
                          setState(() {
                            Db().insertNewData(conName.text,conNumber.text,userid!,Splash.db!).then((value) {
                              getData();
                              conName.text = "";
                              conNumber.text = "";
                            });
                          });
                          Navigator.pop(context);
                        }

                      }, child: Text("ok")),
                    ),
                  ],
                );
              },);
            }, icon: Icon(Icons.add_call)),
          ),
        ],
      ),

      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [

              DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          backgroundImage: AssetImage("images/userbg.png"),
                        ),
                        SizedBox(width: 10,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user,style: TextStyle(color: Colors.white,fontSize: 15),),
                            SizedBox(height: 3,),
                            Text(email,style: TextStyle(color: Colors.white,fontSize: 10),),
                          ],
                        ),
                      ],
                    ),
                  )),

              ListTile(
                onTap: () {
                  Splash.pref.setBool('login', false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Login();
                  },));
                },
                leading: Icon(Icons.logout,color: Colors.deepPurple,),
                title: Text("Log Out",style: TextStyle(color: Colors.deepPurple),),
              ),
            ],
          ),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          itemCount: userdata.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipOval(child: Image.asset("images/userbg.png")),
              subtitle: Text("${userdata[index]['number']}"),
              title: Text("${userdata[index]['name']}"),
              trailing: PopupMenuButton(
                elevation: 5,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        onTap: () {
                          int id = userdata[index]['id'];
                          Db().delete(id,Splash.db!).then((value) {
                            getData();
                          });
                        },
                        height: 10,child: Padding(
                      padding: const EdgeInsets.only(bottom: 15,top: 5),
                      child: Row(children: [Icon(Icons.delete,size: 18,),SizedBox(width: 10,),Text("Delete",style: TextStyle(fontSize: 15),)],),
                    )),
                    PopupMenuItem(
                        onTap: () {
                          setState(() {
                            conName2.text = userdata[index]['name'];
                            conNumber2.text = userdata[index]['number'];
                          });
                          showDialog(context: context, builder: (context) {
                            return SimpleDialog(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                  child: TextField(
                                    controller: conName2,
                                    decoration: InputDecoration(
                                        labelText: "Enter Name",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue),
                                        ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 30,),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                  child: TextField(
                                    controller: conNumber2,
                                    decoration: InputDecoration(
                                        labelText: "Enter Number",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue),
                                        ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10,left: 190),
                                  child: TextButton(onPressed: () {

                                    int id = userdata[index]['id'];
                                    Db().update(conName2.text,conNumber2.text,Splash.db!,id!).then((value) {
                                      getData();
                                    });
                                    Navigator.pop(context);

                                  }, child: Text("Update")),
                                ),
                              ],
                            );
                          },);
                        },
                        height: 10,child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(children: [Icon(Icons.edit,size: 18,),SizedBox(width: 10,),Text("Edit Contact",style: TextStyle(fontSize: 15))],),
                    )),
                  ];
                },
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        ),
      ),
    );
  }

  void getData() {
    Db().viewcontact(Splash.db!, userid!).then((value) {
      setState(() {
        userdata = value;
      });
    });
  }
  List<Map> userdata = [];

  void userDetail() {
    Db().userDetail(Splash.db!,userid!).then((value) {
      setState(() {
        userData2 = value;
        email = userData2[0]['email'];
        user = userData2[0]['user'];
      });
    });
  }
  List<Map> userData2 = [];
}
