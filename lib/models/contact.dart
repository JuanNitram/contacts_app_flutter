class Contact {
  final String name;
  final String address;

  Contact({this.name, this.address});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["name"] = name;
    map["address"] = address;

    return map;
  }
}
