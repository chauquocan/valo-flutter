class Contact {
  String name;
  String phone;
  String? email;
  String? address;
  int? id;
  String? icon;
  Contact({
    required this.name,
    required this.phone,
    this.email,
    this.address,
    this.id,
    this.icon = "assets/icons/User Icon.svg",
  });
}
