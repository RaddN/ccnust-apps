//packages import
// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state, use_build_context_synchronously, non_constant_identifier_names
import 'dart:async';
import 'dart:io';
import 'package:ccnust/courses.dart';
import 'package:ccnust/main.dart';
import 'package:ccnust/transport.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
//pages import
import 'FeesPage.dart';
import 'StudenProfile.dart';
import 'mgdbHelper/cookie_check.dart';
import 'mgdbHelper/mongodb.dart';
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
  var myEmail;
  var userCata;
  _HomePageState(this.tabbarpos);
  double bottomNavBarHeight = 60;
  late CircularBottomNavigationController _navigationController;
  var currentPage = "Dashboard";
  ///bus driver location update in every 3 second
  Timer? _timer;
  void updateLocation() {
    const oneSec = Duration(seconds: 3);
     _timer?.cancel();
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) async{
        if (kDebugMode) {
          print("Location function");
        }
        // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        LocationData? position =!Platform.isWindows? await getMyPosition():null;
        Position? position2 =Platform.isWindows? await getMyPosition2():null;
        if (kDebugMode) {
          print("Location function 2");
        }

        bool result = await InternetConnectionChecker().hasConnection;
        if(result) {
          MongoDatabase.updatelocation(Platform.isWindows?position2!.longitude.toString():position!.longitude.toString(),Platform.isWindows? position2!.latitude.toString():position!.latitude.toString(),myEmail);
        }
        else{
          _showSnackbar("No internet Connection");
        }
        if (kDebugMode) {
          print(position);
        }
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyEmail().then((value){
      setState(() {
        myEmail = value!.first;
        userCata = value.last;
      });
      if(value!.last=="driver") {
        updateLocation();
      }
    });
    if(myEmail!=null) {
      MongoDatabase.loggedInCheck(myEmail).then((value) {
      if(!value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
      }
    });
    }
    _navigationController = CircularBottomNavigationController(tabbarpos);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    List<TabItem> tabItems = List.of([
      TabItem(Icons.home, "Home", Colors.blue, labelStyle: const TextStyle(fontWeight: FontWeight.normal)),
      TabItem(Icons.bus_alert_rounded, "Bus", Colors.blue, labelStyle: const TextStyle(fontWeight: FontWeight.normal)),
      TabItem(Icons.calculate, "Fees", Colors.blue,),
    ]);
    Widget bodyContainer() {
      Widget page;
      switch (tabbarpos) {
        case 0:
          page = Home(screenWidth);
          break;
        case 1:
          page = TransportPage(userCata: userCata);
          break;
        case 2:
          page = const FeesPage();
          break;
        default:
          page = Home(screenWidth);
          break;
      }
      return Container(
          child: page
        );
    }
    return Scaffold(
      appBar: OurAppBar(context),
      drawer: OurDrawer(context,myEmail ?? "111121017"),
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        selectedPos: tabbarpos,
        controller: _navigationController,
        barHeight: bottomNavBarHeight,
        selectedIconColor: Colors.white,
        normalIconColor: Colors.grey,
        backgroundBoxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black45, blurRadius: 10.0),
        ],
        animationDuration: const Duration(milliseconds: 300),
        selectedCallback: (int? tabbarpos) {
          setState(() {
            this.tabbarpos = tabbarpos ?? 0;
            if (kDebugMode) {
              print(_navigationController.value);
            }
          });
        },

      ),
      body: bodyContainer()
    );
  }

  ListView Home(screenWidth) {
    return ListView(
          children: [
            screenWidth>800?
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ///Fee compare
                    Expanded(flex: 6, child: FeeCompare()),
                    Expanded(
                      flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const ListTile(

                          title: Text("Events",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),),
                          leading: Icon(Icons.event),
                          horizontalTitleGap: 0,
                        ),
                        Card(
                          margin: const EdgeInsets.all(15),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child:screenWidth>800? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: children(screenWidth),
                            ):Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: children(screenWidth),),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.all(15),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child:screenWidth>800? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: children(screenWidth),
                            ):Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: children(screenWidth),),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.all(15),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child:screenWidth>800? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: children(screenWidth),
                            ):Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: children(screenWidth),),
                          ),
                        ),
                      ],
                    ))
                  ],)
                :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              ///Fee compare
              FeeCompare(),
              ///Events
              const ListTile(
                title: Text("Events",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),),
                leading: Icon(Icons.event),
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.only(left: 15),
              ),
    Card(
      margin: const EdgeInsets.all(15),
    child: Padding(
    padding: const EdgeInsets.all(15.0),
    child:screenWidth>800? Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: children(screenWidth),
    ):Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children(screenWidth),),
    ),
    ),
                const SizedBox(height: 10,),
                Card(
                  margin: const EdgeInsets.all(15),
    child: Padding(
    padding: const EdgeInsets.all(15.0),
    child:screenWidth>800? Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: children(screenWidth),
    ):Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children(screenWidth),),
    ),
    ),
                const SizedBox(height: 10,),
    Card(
      margin: const EdgeInsets.all(15),
    child: Padding(
    padding: const EdgeInsets.all(15.0),
    child:screenWidth>800? Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: children(screenWidth),
    ):Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: children(screenWidth),),
    ),
    ),
            ],),

          ],
        );
  }

  List<Widget> children(screenWidth) {
    var image = Image.network("https://ccnust.ac.bd/wp-content/uploads/2020/05/296065723_1513844482369146_1907545956486137317_n.jpg");
    var title =const Text("Seminar on Constitution in Princely Era",style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18
    ),);
    var subtitle = const Text("Seminar on Constitution in Princely Era held at CCN-UST yesterday....");
    return [
      screenWidth>800?Expanded(flex: 3, child:image):image,
                  const SizedBox(width: 10,height: 10,),
      if(screenWidth>800)
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        title,
                        subtitle
                      ],
                    ),
                  ),
      if(screenWidth<800)
        title,
      if(screenWidth<800)
        subtitle,
                ];
  }

  Column FeeCompare() {
    return Column(
            children: [
              const SizedBox(height: 10,),
              const Center(child: Text("Fee Compare",style: TextStyle(
                  fontWeight: FontWeight.bold,
                fontSize: 25
              ),)),
              const SizedBox(height: 10,),
              Center(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 15,
                       color: Colors.blue,
                    ),
                    const SizedBox(width: 5,),
                    const Text("Paid"),
                    const SizedBox(width: 15,),
                     Container(
                      width: 40,
                      height: 15,
                       color: Colors.red,
                    ),
                    const SizedBox(width: 5,),
                    const Text("Due"),

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
                  animationDuration: const Duration(seconds: 1),
                  data: const [
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

  Drawer OurDrawer(BuildContext context,email) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child:UserAccountsDrawerHeader(accountName: const Text("Raihan Hossain",style: TextStyle(
        color: Colors.white,
                fontWeight: FontWeight.bold
        ),), accountEmail: Text(email,style: const TextStyle(
                  color: Colors.white
              ),),onDetailsPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfile(),));
              },currentAccountPictureSize: const Size(80, 80),currentAccountPicture: const CircleAvatar(backgroundImage: AssetImage("assets/mypic.jpg")),)
          ),
            SizedBox(
              height: MediaQuery.of(context).size.height-260,
              child: ListView(
                children: [
                  buildListTile(text: "Dashboard",icon: Icons.dashboard_customize,Ontap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 0),),)
                  ),
                  buildListTile(text: "Pay Fee",icon: Icons.attach_money,Ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context,myEmail), email: myEmail,),),),),
                  buildListTile(text: "Fees",icon: Icons.calculate,Ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 2),))),
                  buildListTile(text: "Library",icon: Icons.menu_book_rounded,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context,myEmail), email: myEmail,),),)),
                  buildListTile(text: "Attendance",icon: Icons.calendar_month_rounded,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context,myEmail), email: myEmail,),),),),
                  buildListTile(text: "Hostels",icon: Icons.bed_sharp,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context,myEmail), email: myEmail,),),),),
                  buildListTile(text: "Transport",icon: Icons.car_crash_outlined,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage(tabbarpos: 1))),),
                  buildListTile(text: "Course",icon: Icons.newspaper_sharp,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context,myEmail),),),),),
                  buildListTile(text: "Exam",icon: Icons.add_chart,Ontap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context,myEmail), email: myEmail,),),),),
                  buildListTile(text: "Logout",icon: Icons.logout,hoverColor: Colors.red,Ontap:() async{
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.remove('token');
                    if(userCata=="driver") {
                      _timer?.cancel();
                      setState(() {
                        _timer = null;
                      });
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'CCN University Of Science & Technology'),),);
                  },),
],
),
            ),
            const SizedBox(height: 15,),
            const Center(child: Text("CCN UNIVERSITY OF SCI. & TECH. ©\nArtificial Intelligent Technology",textAlign: TextAlign.center,style: TextStyle(
                color: Colors.lightBlue
            ),))
          ],
        ),
      ),
    );
  }

  AppBar OurAppBar(BuildContext context) {
    return AppBar(
      title: const Text("CCN UNIVERSITY OF SCI. & TECH.",style: TextStyle(
        color: Colors.white
      ),),
      actions: [
        const SizedBox(width: 15,),
        CircleAvatar(
          child: Stack(
            children: [
              IconButton(onPressed: () {
                currentPage == "Notification"?null:
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(OurAppBar: OurAppBar(context),OurDrawer: OurDrawer(context,myEmail)),));
                setState(() {
                  currentPage = "Notification";
                });
      }, icon: const Icon(Icons.notifications_outlined)),
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
                    child: const Text("1",style: TextStyle(
                      color: Colors.white
                    ),)),
              )

            ],
          ),
        ),
        const SizedBox(width: 15,),
        InkWell(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfile(),));
        }, child: const CircleAvatar(backgroundImage: AssetImage("assets/mypic.jpg"),)),
        const SizedBox(width: 15,),
      ],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  ListTile buildListTile({required text,icon,hoverColor,required Function() Ontap}) {
    return ListTile(
            onTap: () {
              Navigator.pop(context);
              if(currentPage == text) {
                null;
              } else{
              Ontap();
              setState(() {
                currentPage = text;
              });
            }},
            hoverColor:hoverColor ?? Colors.lightBlue,
      focusColor: hoverColor ?? Colors.lightBlue,
            title: Text(text),
            leading: Icon(icon),
          );
  }
  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
    if(userCata=="driver") {
      _timer?.cancel();
      setState(() {
        _timer = null;
      });
    }
  }
void _showSnackbar(String message) => ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(content: Text(message)));
}
