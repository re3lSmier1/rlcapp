//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';


class AuthService{


  /*var url =
  Uri.http('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
*/
  Future signIn(String customerEmail, String customerPassword) async {
    print(customerEmail);
    print(customerPassword);
    try{
      http.Response response = await http.post(
          Uri.parse(apiUrl + 'customer/login'),
          headers:  {
            "accept": "application/json"
          },
          body: {'customer_email': customerEmail, 'customer_password': customerPassword}
      );

      var userData = Hive.box('userData');
      var user = jsonDecode(response.body);
      print(response.statusCode);
      //print(user['token']);
      // obtain shared preferences

      // set value
      if(response.statusCode == 200){
        userData.put('token', user['token']);
        userData.put('customer_id', user['id']);
        //prefs.setString('userKey', user['token']);
        //print(prefs.getString('userKey') ?? 0);
        return true;
      }else{
        return false;
      }

    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future checkEmailExists(String email) async {
    try{
      print(email);
      print(Uri.parse(apiUrl + 'user/checkCustomerEmail'));
      var response = await http.post(
          Uri.parse(apiUrl + 'user/checkCustomerEmail'),
          headers:  {
            "accept": "application/json"
          },
          body: {
            //'userFullName': fullName,
            'userEmail': email,
            //'password': password,
            //'sId': sId,

          }
      );
      //var partialData = await Hive.openBox('partialData');

      print("Answered");
      print(response.body);
      print(response.statusCode);
      Map<String, dynamic> user = await jsonDecode(response.body);

      if(response.statusCode == 200){
        print(user);
        return true;
      }else{
        return false;
      }

    }catch(e){
      print(e.toString());
      //return null;
    }
  }

  Future verifyEmail(String fullName, String email, String code) async {
    try{
      //print(sId);
      http.Response response = await http.post(
          Uri.parse(apiUrl + 'unverified/verifyEmail'),
          headers:  {
            "accept": "application/json"
          },
          body: {
            'userFullName': fullName,
            'userEmail': email,
            'userVerificationCode': code
          }
      );



      Map<String, dynamic> user = await jsonDecode(response.body);

      if(user["status"] == "success"){
        print(user);
        return user;
      }else{
        return user;
      }

    }catch(e){
      print(e.toString());
      //return null;
    }
  }

  Future createUser(String customerName, String customerEmail, String customerPassword) async {

    try{

      http.Response response = await http.post(
          Uri.parse(apiUrl + 'user/register'),
          headers:  {
            "accept": "application/json"
          },
          body: {
            'customer_email': customerEmail,
            'customer_name': customerName,
            'customer_password': customerPassword

          }
      );
      var userData =  Hive.box('userData');


      Map<String, dynamic> user = jsonDecode(response.body);

      print(user['token']);
      // set value

      //notifyListeners();
      if(response.statusCode == 201){
        userData.put('token', user['token']);
        userData.put('customer_id', user['id']);
        //print(prefs.getString('userKey') ?? 0);
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  /*Future getUser() async{
    try{
      var userData = Hive.box('userData');
      http.Response response = await http.post(
        Uri.parse(apiUrl + 'users/getuser'),
        headers:  {
          "accept": "application/json",
          "authorization": 'Bearer ' + userData.get('userKey') ?? 0
        },
        //body: {'email': email, 'password': password}
      );

      //print(response.body);
      Map<String, dynamic> user = jsonDecode(response.body);
      userData.put('userFullName', user['userFullName']);
      userData.put('userId', user['_id']);
      userData.put('userSId', user['userId']);
      userData.put('userEmail', user['userEmail']);
      userData.put('userDepartment', user['userDepartment']);
      userData.put('userTelephone', user['userTelephone']);
      //print(user);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future checkStatus() async{
    //print('checking status');
    try{
      var userData = Hive.box('userData');
      //print(prefs.getString('userKey'));
      http.Response response = await http.post(

        Uri.parse(apiUrl + 'users/statusCheck'),
        headers:  {
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': 'Bearer ' +  userData.get('userKey') ?? 0
        },
      );
      //print('status fount');
      //print(response.body);
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }*/

  Future logout() async{
    try{
      var userData = Hive.box('userData');
      userData.delete('token');
      userData.delete('id');
      //prefs.remove('userKey');
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }



}