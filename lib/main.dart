import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rlcapp/Loading.dart';

import 'auth/index.dart';
import 'nauth/Login.dart';

Future<bool>? _isAuthenticated;
Future<Directory?>? _appDirectory;


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Directory? appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  //Hive.init();
  await Hive.initFlutter(appDocPath);
  await Hive.openBox('userData');

  _isAuthenticated = checkIfAuthenticated();
  print('app loaded');
  runApp(MyApp());
}

Future<bool>checkIfAuthenticated() async {
  await Hive.openBox('userData');
  var userData =  Hive.box('userData');

  //await Future.delayed(Duration(seconds: 5));  // could be a long running task, like a fetch from keychain
  print(userData.get('token') != null ? true : false);
  return userData.get('token') != null ? true : false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ConVivo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) {
              return FutureBuilder(
                future: checkIfAuthenticated(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return new Loading();
                    default:
                      if (snapshot.data == true){
                        // print(snapshot.data + ' snapshot data' );
                        return AuthIndex();}
                      else
                        //print(snapshot.data);
                        return Login();
                  }
                },
              );
            });
          case '/login':
            return MaterialPageRoute(builder: (_) => Login());
          default:
            return MaterialPageRoute(builder: (_) => Login());
        }
      },
    );
  }
}
