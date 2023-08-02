// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TransportPage extends StatefulWidget {
  const TransportPage({super.key});


  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  bool buslistshow = false;
  bool driveinfoshwo = false;
  final mapController = MapController();
  double? mylatitude;
  double? mylongitude;
  final url ="https://ccnust.onrender.com/api/users/";
void getmylocation()async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  setState(() {
    mylatitude = position.latitude;
    mylongitude = position.longitude;
  });
}
var busdetails;
  late Timer _timer;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final response = await post(Uri.parse("${url}buslocation"),body: {
          "token":prefs.getString('token')
        });
        final jsonData = jsonDecode(response.body);
        setState(() {
          busdetails = jsonData;
        });
        if (kDebugMode) {
          print(double.parse(busdetails[1]["latitude"]));
        }

      },
    );
  }
@override
  void initState(){
    // TODO: implement initState
    super.initState();
    getmylocation();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:mylatitude==null||mylongitude==null?const CupertinoActivityIndicator(): FlutterMap(
          mapController: mapController,
          options: MapOptions(
            interactiveFlags: InteractiveFlag.drag |
            InteractiveFlag.flingAnimation |
            InteractiveFlag.pinchMove |
            InteractiveFlag.pinchZoom |
            InteractiveFlag.doubleTapZoom,
            keepAlive: true,
            slideOnBoundaries: true,
            center: LatLng(mylatitude!, mylongitude!),
            zoom: 18.0,
            maxZoom: 18.0,
            enableScrollWheel: true,
            onTap: (tapPosition, point) {
              setState(() {
                driveinfoshwo = false;
              });
            },
            onMapReady: () {
              mapController.mapEventStream.listen((evt) {
              });
              // And any other `MapController` dependent non-movement methods
            },
          ),
          nonRotatedChildren: List.generate(busdetails==null?0:busdetails!.length, (index) => MarkerLayer(
            markers: [
              Marker(
                point: LatLng(double.parse(busdetails[index]["latitude"]), double.parse(busdetails[index]["longitude"])),
                width: 80,
                rotate: true,
                height: 80,
                builder: (context) => InkWell(
                  onTap: () {
                    setState(() {
                      driveinfoshwo = !driveinfoshwo;
                    });
                  },
                    child: Image.asset("assets/location.png")),
              ),
            ],
          )),
          children:[
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            Visibility(
              visible: buslistshow,
              child: Container(
              color: Colors.white,
              height: busdetails==null?0:busdetails.length*65.0,
              width: 200,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: List.generate(busdetails==null?0:busdetails!.length, (index){
                  final birthday = DateTime.parse(busdetails[index]["lastupdatetime"]);
                  final date2 = DateTime.now();
                   final difference = date2.difference(birthday).inMinutes;
                 return ListTile(
                    onTap: () {
                      mapController.move(LatLng(double.parse(busdetails[index]["latitude"]), double.parse(busdetails[index]["longitude"])), 18.0);
                    },
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    trailing: Icon(Icons.account_circle_rounded,color:difference<3? Colors.green:Colors.grey),
                    leading:Text("${index+1}"),
                    title: Text(busdetails[index]["name"]),
                  );
                }
                    ),
              ),
            ),),
            Visibility(
              visible: buslistshow,
              child: Positioned(
                top: -20,
                  left: 150,
                  child: IconButton(onPressed: () {
                    setState(() {
                      buslistshow = false;
                    });
              }, icon: const Icon(Icons.arrow_left,size: 40,color: Colors.green,))),
            ),
            Visibility(
              visible: !buslistshow,
              child: Positioned(
                  top: -20,
                  left: 0,
                  child: IconButton(onPressed: () {
                    setState(() {
                      buslistshow = true;
                    });
                  }, icon: const Icon(Icons.arrow_right,size: 40,color: Colors.green,))),
            ),
            Visibility(
              visible: driveinfoshwo,
              child: MarkerLayer(
                markers: List.generate(busdetails==null?0:busdetails!.length, (index) =>
                  Marker(
                    width: 100,
                    height: 200,
                    point: LatLng(double.parse(busdetails[index]["latitude"])-0.00065, double.parse(busdetails[index]["longitude"])), builder: (context) => Card(
                    child: Column(
                      children: [
                        CircleAvatar(foregroundColor: Colors.black,
                          radius: 40,
                          backgroundImage: NetworkImage(busdetails[index]["photo"]),),
                        Text(busdetails[index]["name"]),
                        const SizedBox(height: 5,),
                        Text(busdetails[index]["phone"]),
                      ],
                    ),
                  ),)
              )),
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(mylatitude!,mylongitude!),
                  width: 80,
                  rotate: true,
                  height: 80,
                  builder: (context) => Image.asset("assets/mylocation.png"),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
                right: 20,
                child: IconButton(onPressed: () {
                  mapController.move(LatLng(mylatitude!, mylongitude!), 18.0);
            }, icon: const Icon(Icons.location_searching,size: 40,)))
          ]),
      ),
    );
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
