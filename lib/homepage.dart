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
  int? userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userid = Splash.pref.getInt('userid')??0;
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: () {

          showDialog(context: context, builder: (context) {
            return SimpleDialog(
              children: [
                TextField(
                  controller: conName,
                  decoration: InputDecoration(
                    labelText: "enter name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )
                  ),
                ),

                TextField(
                  controller: conNumber,
                  decoration: InputDecoration(
                      labelText: "enter number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      )
                  ),
                ),

                TextButton(onPressed: () {

                  setState(() {
                    Db().insertNewData(conName.text,conNumber.text,userid!,Splash.db!).then((value) {
                      getData();
                      conName.text = "";
                      conNumber.text = "";
                    });
                  });
                  Navigator.pop(context);

                }, child: Text("ok")),
              ],
            );
          },);

      },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {

            Splash.pref.setBool('login', false);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return Login();
            },));

          }, icon: Icon(Icons.logout)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: ListView.builder(
          itemCount: userdata.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: IconButton(onPressed: () {

                showDialog(context: context, builder: (context) {
                  return SimpleDialog(
                    children: [
                      TextField(
                        controller: conName,
                        decoration: InputDecoration(
                            labelText: "enter name",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                        ),
                      ),

                      TextField(
                        controller: conNumber,
                        decoration: InputDecoration(
                            labelText: "enter number",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                        ),
                      ),

                      TextButton(onPressed: () {
                        int id = userdata[0]['id'];
                        Db().update(conName.text,conNumber.text,Splash.db!,id!).then((value) {
                          getData();
                        });
                        Navigator.pop(context);

                      }, child: Text("update")),
                    ],
                  );
                },);

              }, icon: Icon(Icons.edit)),

              trailing: IconButton(onPressed: () {

                int id = userdata[0]['id'];
                Db().delete(id,Splash.db!).then((value) {
                  getData();
                });

              }, icon: Icon(Icons.delete)),
              subtitle: Text("${userdata[index]['number']}"),
              title: Text("${userdata[index]['name']}"),
            );
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
}
