import 'dart:convert';

class GeoLocation {
  final String lat;
  final String long;

  GeoLocation({required this.lat, required this.long});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'] as String,
      long: json['long'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'long': long,
      };
}

class Address {
  final GeoLocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      geolocation: GeoLocation.fromJson(json['geolocation']),
      city: json['city'] as String,
      street: json['street'] as String,
      number: json['number'] as int,
      zipcode: json['zipcode'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'geolocation': geolocation.toJson(),
        'city': city,
        'street': street,
        'number': number,
        'zipcode': zipcode,
      };
}

class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
      };
}

class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;
  final int v;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      name: Name.fromJson(json['name']),
      address: Address.fromJson(json['address']),
      phone: json['phone'] as String,
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'username': username,
        'password': password,
        'name': name.toJson(),
        'address': address.toJson(),
        'phone': phone,
        '__v': v,
      };
}


String toJson(List<User> users) {
  final List<Map<String, dynamic>> userMaps =
      users.map((user) => user.toJson()).toList();
  return jsonEncode(userMaps);
}

