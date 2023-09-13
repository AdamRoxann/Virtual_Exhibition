class OrderProductModel {
  final int id;
  final int user_id;
  final int product_id;
  final String product_name;
  final String product_description;
  final String product_image;
  final int price;
  final int category;
  final int order_list_id;
  final int quantity;
  final int status;
  final String invoice_id;
  final String address_name;
  final String created_at;
  final String updated_at;

  // final String follow_status_user;

  OrderProductModel(
    this.id,
    this.user_id,
    this.product_id,
    this.product_name,
    this.product_description,
    this.product_image,
    this.price,
    this.category,
    this.order_list_id,
    this.quantity,
    this.status,
    this.invoice_id,
    this.address_name,
    this.created_at,
    this.updated_at,
  );
}

class OrderModelDetail {
  final int id;
  final int user_id;
  final int product_id;
  final String product_name;
  final String product_image;
  final String product_description;
  final int price;
  final int quantity;
  final int status;
  final int total_price;
  final String invoice_id;
  final String created_at;
  final String updated_at;

  // final String follow_status_user;

  OrderModelDetail(
    this.id,
    this.user_id,
    this.product_id,
    this.product_name,
    this.product_image,
    this.product_description,
    this.price,
    this.quantity,
    this.status,
    this.total_price,
    this.invoice_id,
    this.created_at,
    this.updated_at,
  );
}

class OrderList {
  final int id;
  final int user_id;
  final String name;
  final int product_id;
  final String product_name;
  final String product_image;
  final String product_description;
  final int price;
  final int quantity;
  final int status;
  final String address;
  final int total_price;
  final String invoice_id;
  final String created_at;
  final String updated_at;

  // final String follow_status_user;

  OrderList(
    this.id,
    this.user_id,
    this.name,
    this.product_id,
    this.product_name,
    this.product_image,
    this.product_description,
    this.price,
    this.quantity,
    this.status,
    this.address,
    this.total_price,
    this.invoice_id,
    this.created_at,
    this.updated_at,
  );
}

