// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:ccnust/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'backendhelper.dart';
import 'loginPage.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void loggedincheck() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await post(Uri.parse("${backendurl}profile"),body: {
      "token":prefs.getString('token')
    });
    final jsonData = jsonDecode(response.body);
    if (kDebugMode) {
      print(jsonData['_id']);
    }
    if(jsonData['_id']!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),));
    }
  }
  Future permissioncheck()async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    if (kDebugMode) {
      print(statuses[Permission.location]);
    }
    }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissioncheck();
    loggedincheck();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/ccnustlogo.png"),
              const SizedBox(height: 15,),
              RichText(text: const TextSpan(
                text: "CCN University",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),children: [
                  TextSpan(text: " of Science & Technology")
                  ]
              ),textAlign: TextAlign.center),
              const SizedBox(height: 15,),
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Text("Welcome to CCN University of Science & Technology, an UGC & Govt. approved Private University in Cumilla Bangladesh, which is a worldwide University in the soil of Cumilla established in 2014.",textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16
                  ),),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(onPressed: () async{
                Map<Permission, PermissionStatus> statuses = await [
                Permission.location,
                ].request();
                if (kDebugMode) {
                  print(statuses[Permission.location]);
                }
                permissioncheck();
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const LoginPage(),));
              },style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(15))
              ), child: const Text("GET STARTED",style: TextStyle(
                fontSize: 22,
                color: Colors.white
              ),)),
              const Padding(padding: EdgeInsets.all(8.0),
                child: Text("If any problem is observed, please contact our IT Section through Mr. Wazed Ali 01740894102, 01888042668",
                textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 13
                ),
                )
                ,
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
