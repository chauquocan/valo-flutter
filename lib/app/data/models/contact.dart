class ContactModel {
  String? name;
  String? phone;
  String? email;
  String? address;
  int? id;
  String? icon;
  ContactModel(
      {this.name,
      this.phone,
      this.email,
      this.address,
      this.id,
      this.icon = "assets/icons/User Icon.svg"});
}
