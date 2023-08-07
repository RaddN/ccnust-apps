// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:io';
import 'package:ccnust/mgdbHelper/cookie_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'mgdbHelper/mongodb.dart';
class TransportPage extends StatefulWidget {
  final userCata;
  const TransportPage({super.key, required this.userCata});
  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  bool buslistshow = false;
  bool driveinfoshwo = false;
  final mapController = MapController();
  var mylatitude;
  var mylongitude;
  Stream getBusDetails() async*{
    List busDetails;
    var driverCollection= MongoDatabase.collection_rtrn();
    while(true){
      bool result = await InternetConnectionChecker().hasConnection;
      if(!result){
        _showSnackbar("No internet Connection");
      }
      await Future<void>.delayed(const Duration(seconds: 3));
      yield busDetails =
          await driverCollection.find({"catagory": "driver"}).toList();
      if (kDebugMode) {
        // print("New location get success $busDetails");
      }
    }
  }
void getmylocation() async{
  LocationData? position =!Platform.isWindows? await getMyPosition():null;
  Position? position2 =Platform.isWindows? await getMyPosition2():null;
  setState(() {
    mylatitude =Platform.isWindows? position2!.latitude:position!.latitude;
    mylongitude =Platform.isWindows? position2!.longitude:position!.longitude;
  });
  if (kDebugMode) {
    print("my working");
  }
}
    @override
    void initState(){
      // TODO: implement initState
      super.initState();
      getmylocation();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child:StreamBuilder(
            stream: getBusDetails(),
            builder: (context, snapshot) {
              print("New location get success $snapshot");
              if(!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              var data = snapshot.data!.toList();
               // print(data);
              if(mylatitude==null){

                return CircularProgressIndicator();

              }
             return FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.doubleTapZoom,
                    keepAlive: true,
                    // adaptiveBoundaries: true, Don't use it. It's create an issue
                    slideOnBoundaries: true,
                    center: LatLng(mylatitude, mylongitude),
                    zoom: 18.0,
                    maxZoom: 18.0,
                    enableScrollWheel: true,
                    onTap: (tapPosition, point) {
                      setState(() {
                        driveinfoshwo = false;
                      });
                    },
                    onMapReady: () {
                      mapController.mapEventStream.listen((evt) {});
                      // And any other `MapController` dependent non-movement methods
                    },
                  ),
                  nonRotatedChildren: List.generate(
                      data.length, (index) =>
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(double.parse(data[index]["latitude"]),
                                double.parse(data[index]["longitude"])),
                            width: 80,
                            rotate: true,
                            height: 80,
                            builder: (context) =>
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        driveinfoshwo = !driveinfoshwo;
                                      });
                                    },
                                    child: Image.asset("assets/location.png")),
                          ),
                        ],
                      )),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    Visibility(
                      visible: buslistshow,
                      child: Container(
                        color: Colors.white,
                        height: data.length * 65.0,
                        width: 200,
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: List.generate(
                              data
                                  .length, (index) {
                            final birthday = DateTime.parse(
                                data[index]["lastupdatetime"]);
                            final date2 = DateTime.now();
                            final difference = date2
                                .difference(birthday)
                                .inMinutes;
                            return ListTile(
                              onTap: () {
                                mapController.move(LatLng(double.parse(
                                    data[index]["latitude"]),
                                    double.parse(
                                        data[index]["longitude"])),
                                    18.0);
                              },
                              horizontalTitleGap: 0,
                              contentPadding: EdgeInsets.zero,
                              trailing: Icon(Icons.account_circle_rounded,
                                  color: difference < 1 ? Colors.green : Colors
                                      .grey),
                              leading: Text("${index + 1}"),
                              title: Text(data[index]["name"]),
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
                          },
                              icon: const Icon(Icons.arrow_left, size: 40,
                                color: Colors.green,))),
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
                          },
                              icon: const Icon(Icons.arrow_right, size: 40,
                                color: Colors.green,))),
                    ),
                    Visibility(
                      visible: driveinfoshwo,
                      child: MarkerLayer(
                          markers: List.generate(data
                                  .length, (index) =>
                              Marker(
                                width: 100,
                                height: 200,
                                point: LatLng(double.parse(
                                    data[index]["latitude"]) -
                                    0.00065, double.parse(
                                    data[index]["longitude"])),
                                builder: (context) =>
                                    Card(
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            foregroundColor: Colors.black,
                                            radius: 40,
                                            backgroundImage: NetworkImage(data[index]["photo"]),),
                                          Text(
                                              data[index]["name"]),
                                          const SizedBox(height: 5,),
                                          Text(data[index]["phone"]),
                                        ],
                                      ),
                                    ),)
                          )),
                    ),
                    if(widget.userCata!="driver")
                    MarkerLayer(
                      markers: [
                        Marker(
                          point:LatLng(mylatitude!,mylongitude!),
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
                          mapController.move(LatLng(mylatitude, mylongitude), 18.0);
                        }, icon: const Icon(Icons.location_searching,size: 40,)))
                  ]);
              // return Container(child: Text(data.toString()),);
            }
          ),
        ),
      );
    }
    @override
    void dispose() {
      super.dispose();
      // if(_timer.isActive){
      //   _timer.cancel();
      //   if (kDebugMode) {
      //     print(_timer.tick);
      //   }
      //   if (kDebugMode) {
      //     print(_timer.isActive);
      //   }
      // }
    }
  void _showSnackbar(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
  }
