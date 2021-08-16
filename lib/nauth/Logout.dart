import 'package:flutter/material.dart';
import 'package:rlcapp/services/authService.dart';

import '../Loading.dart';
import '../constants.dart';
import 'Login.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: [
          SizedBox(height: 100),
          Center(child: new Text('You are about to logout of the application. To continue click the button below')),
          Container(
            padding: EdgeInsets.only(top: 15.0),
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () async {
                dynamic result = await _auth.logout();

                if(!result){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error while logging you out',
                        style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.red,

                    ),
                  );
                }else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                }

              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                child:  const Text('Logout',
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }
}
