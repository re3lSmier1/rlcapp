//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:rlcapp/models/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';


class ProductService{


  /*var url =
  Uri.http('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
*/

  var userData = Hive.box('userData');

  Future<List<Product>> getProducts() async {
    List<Product> list;
    var userData = Hive.box('userData');

    //print(link);
    http.Response res = await http.get(
      Uri.parse(apiUrl + 'product/'),
      headers:  {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': 'Bearer ' +  userData.get('token')
      },
    );

    //print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      //print(data);
      var products = data as List;
      //print(products);

      list = products.map<Product>((json) => Product.fromJson(json)).toList();
      return list;
    }
    else{
      return [];
    }

  }




}