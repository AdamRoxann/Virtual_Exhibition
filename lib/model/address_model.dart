class AddressModel {
  final int id;
  final int user_id;
  final String address_name;
  final String address;
  final int status;
  final String created_at;

  AddressModel(
    this.id,
    this.user_id,
    this.address_name,
    this.address,
    this.status,
    this.created_at,
  );
}