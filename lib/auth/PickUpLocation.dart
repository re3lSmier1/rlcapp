import 'package:flutter/material.dart';

import '../constants.dart';

class PickUpLocation extends StatefulWidget {
  const PickUpLocation({Key? key}) : super(key: key);

  @override
  _PickUpLocationState createState() => _PickUpLocationState();
}

class _PickUpLocationState extends State<PickUpLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: cDarkGreen,

        title: Padding(
          padding: EdgeInsets.all(0.0),
          child: Text('Locations',
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
        ),
        actions: <Widget>[
          /*IconButton(
                            color: Colors.white,
                          icon: const Icon(Icons.shopping_cart_rounded),
                          tooltip: 'Cart for check',
                          onPressed: () {
                            //scaffoldKey.currentState.showSnackBar(snackBar);
                          },
                        ),*/

        ],
      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
