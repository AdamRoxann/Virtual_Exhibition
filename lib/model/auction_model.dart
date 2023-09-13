class AuctionProduct {
  final int id;
  final int booth_id;
  final int vendor_id;
  final int product_id;
  final String product_name;
  final String product_description;
  final String product_image;
  final int last_bidder_id;
  final String name;
  final int start_amount;
  final int bin_amount;
  final int current_amount;
  final int minimum_quantity;
  final int maximum_quantity;
  final String start_time;
  final String finish_time;
  final String offer_available_time;

  AuctionProduct(
    this.id,
    this.booth_id,
    this.vendor_id,
    this.product_id,
    this.product_name,
    this.product_description,
    this.product_image,
    this.last_bidder_id,
    this.name,
    this.start_amount,
    this.bin_amount,
    this.current_amount,
    this.minimum_quantity,
    this.maximum_quantity,
    this.start_time,
    this.finish_time,
    this.offer_available_time,
  );
}