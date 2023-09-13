class Product {
  final int id;
  final int booth_id;
  final int vendor_id;
  final String product_name;
  final String product_description;
  final String product_image;
  final String product_assets;
  final int category;
  final int price;
  final int stocks;
  final int status;

  Product(
    this.id,
    this.booth_id,
    this.vendor_id,
    this.product_name,
    this.product_description,
    this.product_image,
    this.product_assets,
    this.category,
    this.price,
    this.stocks,
    this.status,
  );
}

class ProductImages {
  final int id;
  final String product_image;

  ProductImages(
    this.id,
    this.product_image,
  );
}

class QuantityModel {
  int id;
  int user_id;
  int product_id;
  int quantity;

  QuantityModel(
    this.id,
    this.user_id,
    this.product_id,
    this.quantity,
  );
}
class TotalPrice {
  int total_price;

  TotalPrice(
    this.total_price
  );
}
