import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  bool rem = false;
  final emailinput = TextEditingController();
  final passwordinput = TextEditingController();
  bool loginsuccess = false;
  var alert = "";
  final url ="https://ccnust.onrender.com/api/users/";
  void logincontroll({email,password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await post(Uri.parse(url+"login"), body: {
      "email": email,
      "password": password
    });
    final jsonData = jsonDecode(response.body);
    print(jsonData['alert']);
    if (jsonData['alert'] == "Successfully logged in") {
      await prefs.setString('token', jsonData['token']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(tabbarpos: 0),));
      print(prefs.getString('token'));
    }
    else {
      setState(() {
        alert = jsonData['alert'];
      });
    }
  }
  void loggedincheck() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    final response = await post(Uri.parse(url+"profile"),body: {
      "token":prefs.getString('token')
    });
    final jsonData = jsonDecode(response.body);
    print(jsonData['_id']);
    if(jsonData['_id']!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(tabbarpos: 0),));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedincheck();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailinput.dispose();
    passwordinput.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(child: Image.asset("assets/ccnustlogo.png")),
              SizedBox(height: 15,),
              Center(child: Text("Information Management System",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.green
              ),)),
              SizedBox(height: 15,),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 8.0,bottom: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.groups_rounded),
                          SizedBox(width: 15,),
                          Text("Please Enter Your Information",style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 16
                          ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: TextField(
                        controller: emailinput,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.manage_accounts)
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                      child: TextField(
                        controller: passwordinput,
                        obscureText: _passwordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(alert,style: TextStyle(color: Colors.redAccent)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: rem, onChanged: (value) {
                                setState(() {
                                  rem = value!;
                                });
                              },),
                              Text("Remember Me"),
                            ],
                          ),
                          ElevatedButton(onPressed: () {
                            logincontroll(email: emailinput.text,password: passwordinput.text);
                          },style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.only(left: 40,right: 40,top: 15,bottom: 15))
                          ), child: Row(
                            children: [
                              Icon(Icons.login,color: Colors.white,),
                              SizedBox(width: 10,),
                              Text("Login",style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                              ),),
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      color: Colors.lightBlueAccent,
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(onPressed: () {

                          }, icon: Icon(Icons.arrow_back), label: Text("Student Register")),
                          InkWell(
                            onTap: () {

                            },
                            child: Row(
                              children: [
                                Text("I forgot my password"),
                                Icon(Icons.arrow_forward_outlined)
                              ],
                            ),
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: Text("Artificial Intelligent Technology",style: TextStyle(
                  color: Colors.white
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
