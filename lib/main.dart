// ignore_for_file: use_build_context_synchronously

import 'package:ccnust/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'loginPage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'mgdbHelper/cookie_check.dart';
import 'mgdbHelper/mongodb.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool result = await InternetConnectionChecker().hasConnection;
  if(result) {
    await MongoDatabase.connect();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCNUST',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(title: 'CCNUST'),
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
  Future permissioncheck()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(!result){
      _showSnackbar("No internet Connection");
    }
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
    getMyEmail().then((tokenData){
      if(tokenData!=null) {
        MongoDatabase.loggedInCheck(tokenData.first).then((value) {
      if(value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),));
      }
    });
      }
    });
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
  void _showSnackbar(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
