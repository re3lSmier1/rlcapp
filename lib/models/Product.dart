class Product {
  String product_name;
  int product_price;
  int product_id;

  Product(
      this.product_name,
      this.product_price,
      this.product_id
      );

  factory Product.fromJson(dynamic json) {
    //print(json);
    return Product(
        json['product_name'] as String,
        json['product_price'] as int,
        json['product_id'] as int
    );
  }

  @override
  String toString() {
    return '{ ${this.product_name}, ${this.product_price}, ${this.product_id} }';
  }
}