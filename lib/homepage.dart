//packages import
import 'dart:async';
import 'dart:convert';
import 'package:ccnust/courses.dart';
import 'package:ccnust/main.dart';
import 'package:ccnust/transport.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
//pages import
import 'FeesPage.dart';
import 'StudenProfile.dart';
import 'paymentpage.dart';
import 'package:ccnust/notification.dart';
import 'package:ccnust/loginPage.dart';
class HomePage extends StatefulWidget {
  final tabbarpos;
  const HomePage({super.key, this.tabbarpos});

  @override
  State<HomePage> createState() => _HomePageState(tabbarpos);
}

class _HomePageState extends State<HomePage> {
  int tabbarpos;
  _HomePageState(this.tabbarpos);
  double bottomNavBarHeight = 60;
  late CircularBottomNavigationController _navigationController;
  var currentPage = "Dashboard";
  final url ="https://ccnust.onrender.com/api/users/";
  late Timer _timer;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) async{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            String datetime = DateTime.now().toString();
            Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            final response = await post(Uri.parse(url+"newlocation"), body: {
              "token":prefs.getString('token'),
              "latitude": position.latitude.toString(),
              "longitude": position.longitude.toString(),
              "lastupdatetime": datetime
            });
            print(response.body);
            print(position);
      },
    );
  }

  void loggedincheck() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    final response = await post(Uri.parse(url+"profile"),body: {
      "token":prefs.getString('token')
    });
    final jsonData = jsonDecode(response.body);

    // print(jsonData);
    if(jsonData['catagory']=="driver"){
      startTimer();
    }
    if(jsonData['_id']==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedincheck();
    _navigationController = CircularBottomNavigationController(tabbarpos);
  }

  @override
  Widget build(BuildContext context) {
    List<TabItem> tabItems = List.of([
      TabItem(Icons.home, "Home", Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
      TabItem(Icons.bus_alert_rounded, "Bus", Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
      TabItem(Icons.calculate, "Fees", Colors.blue,),
    ]);
    Widget bodyContainer() {
      var page;
      switch (tabbarpos) {
        case 0:
          page = Home();
          break;
        case 1:
          page =TransportPage();
          break;
        case 2:
          page = FeesPage();
          break;
        default:
          page = Home();
          break;
      }

      return GestureDetector(
        child: Container(
          child: page
        ),
        onTap: () {
          if (_navigationController.value == tabItems.length - 1) {
            _navigationController.value = 0;
          } else {
            _navigationController.value = _navigationController.value! + 1;
          }
        },
      );
    }
    return Scaffold(
      appBar: OurAppBar(context),
      drawer: OurDrawer(context),
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        selectedPos: tabbarpos,
        controller: _navigationController,
        barHeight: bottomNavBarHeight,
        selectedIconColor: Colors.white,
        normalIconColor: Colors.grey,
        backgroundBoxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black45, blurRadius: 10.0),
        ],
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (int? tabbarpos) {
          setState(() {
            this.tabbarpos = tabbarpos ?? 0;
            print(_navigationController.value);
          });
        },

      ),
      body: bodyContainer()
    );
  }

  Column Home() {
    return Column(
          children: [
            SizedBox(height: 10,),
            Center(child: Text("Fee Compare",style: TextStyle(
                fontWeight: FontWeight.bold,
              fontSize: 25
            ),)),
            SizedBox(height: 10,),
            Center(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 15,
                     color: Colors.blue,
                  ),
                  SizedBox(width: 5,),
                  Text("Paid"),
                  SizedBox(width: 15,),
                   Container(
                    width: 40,
                    height: 15,
                     color: Colors.red,
                  ),
                  SizedBox(width: 5,),
                  Text("Due"),

                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: DChartPie(
                labelFontSize: 16,
                showLabelLine: true,
                labelLineColor: Colors.black,
                strokeWidth: 2,
                labelLinelength: 10,
                labelLineThickness: 20,
                labelPadding: 10,
                labelPosition: PieLabelPosition.auto,
                animationDuration: Duration(seconds: 1),
                data: [
                  {'domain': 'paid', 'measure': 42000},
                  {'domain': 'Due', 'measure': 6500},

                ],
                fillColor: (pieData, index) {
                  switch (pieData['domain']) {
                    case 'paid':
                      return Colors.blue;
                    case 'Warm':
                      return Colors.orange;
                    default:
                      return Colors.red;
                  }
                },
                donutWidth: 60,
                labelColor: Colors.white,
                animate: true,
              ),
            ),
          ],
        );
  }

  Drawer OurDrawer(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child:UserAccountsDrawerHeader(accountName: Text("Raihan Hossain",style: TextStyle(
        color: Colors.white,
                fontWeight: FontWeight.bold
        ),), accountEmail: Text("111121017",style: TextStyle(
                  color: Colors.white
              ),),onDetailsPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfile(),));
              },currentAccountPictureSize: Size(80, 80),currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("assets/mypic.jpg")),)
          ),
            Container(
              height: MediaQuery.of(context).size.height-260,
              child: ListView(
                children: [
                  buildListTile(text: "Dashboard",icon: Icons.dashboard_customize,Ontap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(tabbarpos: 0),),)
                  ),
                  buildListTile(text: "Pay Fee",icon: Icons.attach_money,Ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context),),),),),
                  buildListTile(text: "Fees",icon: Icons.calculate,Ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(tabbarpos: 2),))),
                  buildListTile(text: "Library",icon: Icons.menu_book_rounded,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context),),),)),
                  buildListTile(text: "Attendance",icon: Icons.calendar_month_rounded,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context),),),),),
                  buildListTile(text: "Hostels",icon: Icons.bed_sharp,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context),),),),),
                  buildListTile(text: "Transport",icon: Icons.car_crash_outlined,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(tabbarpos: 1))),),
                  buildListTile(text: "Course",icon: Icons.newspaper_sharp,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context),),),),),
                  buildListTile(text: "Exam",icon: Icons.add_chart,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context),),),),),
                  buildListTile(text: "Logout",icon: Icons.logout,hoverColor: Colors.red,Ontap:() async{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.remove('token');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'),),);
                  },),
],
),
            ),
            SizedBox(height: 15,),
            Center(child: Text("CCN UNIVERSITY OF SCI. & TECH. ©\nArtificial Intelligent Technology",textAlign: TextAlign.center,style: TextStyle(
                color: Colors.lightBlue
            ),))
          ],
        ),
      ),
    );
  }

  AppBar OurAppBar(BuildContext context) {
    return AppBar(
      title: Text("CCN UNIVERSITY OF SCI. & TECH.",style: TextStyle(
        color: Colors.white
      ),),
      actions: [
        SizedBox(width: 15,),
        CircleAvatar(
          child: Stack(
            children: [
              IconButton(onPressed: () {
                currentPage == "Notification"?null:
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context)),));
                setState(() {
                  currentPage = "Notification";
                });
      }, icon: Icon(Icons.notifications_outlined)),
              Positioned(
                right: 0,
                child: Container(
                  width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.redAccent,
                    ),
                    child: Text("1",style: TextStyle(
                      color: Colors.white
                    ),)),
              )

            ],
          ),
        ),
        SizedBox(width: 15,),
        InkWell(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfile(),));
        }, child: CircleAvatar(backgroundImage: AssetImage("assets/mypic.jpg"),)),
        SizedBox(width: 15,),
      ],
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  ListTile buildListTile({required text,icon,hoverColor,required Ontap()}) {
    return ListTile(
            onTap: () {
              Navigator.pop(context);
              if(currentPage == text)
              null;
              else{
              Ontap();
              setState(() {
                currentPage = text;
              });
            }},
            hoverColor:hoverColor==null? Colors.lightBlue : hoverColor,

            title: Text(text),
            leading: Icon(icon),
          );
  }
  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
    _timer.cancel();
  }

}
