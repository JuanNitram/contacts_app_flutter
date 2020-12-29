// class User {
//   String _email;
//   String _password;

//   User(this._email, this._password);

//   User.map(dynamic obj) {
//     print("Object " + obj);
//     this._email = obj["email"];
//     this._password = obj["password"];
//   }

//   String get email => _email;
//   String get password => _password;

//   Map<String, dynamic> toMap() {
//     var map = new Map<String, dynamic>();

//     map["email"] =_email;
//     map["password"] = _password;

//     return map;
//   }

//   factory
// }

class User {
  final String email;
  final String token;

  User({this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['user']['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["email"] = email;
    map["token"] = token;

    return map;
  }
}