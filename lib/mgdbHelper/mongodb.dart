// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:ccnust/mgdbHelper/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MongoDatabase{
  static var db,driverCollection;
  static connect() async{
     db = await Db.create(MONGO_URL);
    await db.open();
     driverCollection =  db.collection(collectionName);
  }
  static collection_rtrn(){
    return driverCollection =  db.collection(collectionName);
  }
  static connectionClose() async{
    await db.close();
  }
  static updatelocation(longitude,latitude,currentUserEmail) async{
    if(db.isConnected) {
      driverCollection.updateOne(where.eq('email', currentUserEmail),
          modify.set('longitude', longitude));
      driverCollection.updateOne(where.eq('email', currentUserEmail),
          modify.set('latitude', latitude));
      driverCollection.updateOne(where.eq('email', currentUserEmail),
          modify.set('lastupdatetime', DateTime.now().toString()));
      print("Location Update success");
      // var data =
      //     await driverCollection.findOne({"email": currentUserEmail});
      // print('Payload: ${currentUserEmail} updated data: ${data}');
    }else{
      await db.open();
    }
  }
  static Future<String> login(email,password) async{
    if(db.isConnected) {
      var getuser = await driverCollection.findOne({"email": email});
      if (getuser != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool checkPassword = BCrypt.checkpw(
            password, getuser["password"]);
        if (checkPassword) {
          final jwt = JWT(
            {"email": email
            }, issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
          );
          var token = jwt.sign(SecretKey(JSONWEBTOKEN_SECRET));
          if (kDebugMode) {
            print('Signed token: $token\n');
          }
          await prefs.setStringList('token', <String>[token, getuser["catagory"]]);
          return "Successfully logged in";
        }
        else {
          return "Wrong Password";
        }
      }
      return "Email address not found please sign up";
    }else{
      await db.open();
    }
    return "Email address not found please sign up";
  }
  static Future<bool> loggedInCheck(tokenEmail) async{
      var data = await driverCollection.findOne({"email": tokenEmail});
      if (data != null) {
        return true;
      }
      return false;
  }
static Future<List> getBusDetails() async{
    var busDetails = await driverCollection.find({"catagory":"driver"}).toList();
    print("New location get");
    return busDetails;
}
}