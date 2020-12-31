class Contact {
  final String name;
  final String address;
  final String phone;
  final String about;
  final String avatar;

  Contact({this.name, this.address, this.phone, this.about, this.avatar});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      about: json['about'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["name"] = name;
    map["address"] = address;
    map["phone"] = phone;
    map["about"] = about;
    map["avatar"] = avatar;

    return map;
  }
}
