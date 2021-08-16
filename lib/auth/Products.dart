import 'package:flutter/material.dart';
import 'package:rlcapp/auth/PickUpLocation.dart';
import 'package:rlcapp/auth/Purchase.dart';
import 'package:rlcapp/services/locationService.dart';
import 'package:rlcapp/services/productService.dart';

import '../constants.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  LocationService _location = LocationService();
  ProductService _prod = ProductService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // This is handled by the search bar itself.
            resizeToAvoidBottomInset: false,
            body: FutureBuilder(
              future: _prod.getProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot,) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {

                    print(snapshot.hasError);
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Scaffold(
                      appBar: AppBar(
                        //centerTitle: true,
                        backgroundColor: cDarkGreen,

                        title: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Text('Products',
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

                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              padding: const EdgeInsets.all(2.0),

                              itemBuilder: (context, position) {
                                return Card(
                                    borderOnForeground: true,
                                    margin: EdgeInsets.all(15.0),
                                    elevation: 10.0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                                          child: Text(
                                            snapshot.data[position].product_name,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.0
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                                          child: Text(
                                            '\$ ${snapshot.data[position].product_price}''.00'
                                            ,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 15.0),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: ElevatedButton(
                                              onPressed: () async {

                                                 dynamic result = await _location.determinePosition();
                                                 print(result);
                                                  if(!result){
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text('Error while getting location',
                                                          style: TextStyle(color: Colors.white),),
                                                        backgroundColor: Colors.red,

                                                      ),
                                                    );
                                                  }else{
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => PickUpLocation(),
                                                      ),
                                                    );
                                                  }

                                              },
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                                child:  const Text('Buy Now',
                                                  style: TextStyle(
                                                      fontSize: 18.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),


                                        /*SizedBox(height: 20.0,)*/
                                      ],

                                    )
                                );
                              })
                        ],
                      ),
                    )
                      ;
                    //Text(snapshot.data);
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },

              /*builder: (context, snapshot){
                  return snapshot.data != null ? listViewWidget(snapshot.data) : Container(child: Text('tj'),);
                },*/
            )

        )
    );
  }
}
