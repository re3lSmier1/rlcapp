import 'package:flutter/material.dart';
import 'package:rlcapp/models/Product.dart';

class Purchase extends StatefulWidget {
  const Purchase({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: ListView(
          children: [
            Text(widget.product.product_name),
            Text('\$ ${widget.product.product_price}''.00'),

          ],
        ),
      ),
    );
  }
}
