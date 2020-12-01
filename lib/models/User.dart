

class User {
  String name;
  String email;
  String phone;
  String password;
  String provider;
  int balance;
  String suburb;
  String address;
  String pinCode;

  User(
    this.name,
    this.email,
    this.phone,
    this.password,
    this.provider,
    this.balance,
    this.pinCode,
    this.address,
    this.suburb,
  );

  User.empty();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> user = Map();
    user['name'] = name;
    user['email'] = email;
    user['phone'] = phone;
    user['password'] = password;
    user['balance'] = balance;
    user['provider'] = provider;
    user['suburb'] = suburb;
    user['pinCode'] = pinCode;
    user['address'] = address;

    return user;
  }

  bool isUserCompeleted() {
    return name != null &&
        email != null &&
        phone != null &&
        password != null &&
        balance != null &&
        provider != null &&
        address != null &&
        address != null &&
        pinCode != null;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.password = map['password'];
    this.balance = map['balance'];
    this.provider = map['provider'];
    this.pinCode = map['pinCode'];
    if (map['address'] != null) {
      this.address = map['address'];
    }
    if (map['suburb'] != null) {
      this.suburb = map['suburb'];
    }

  }
}
