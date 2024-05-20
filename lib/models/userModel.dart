// import 'dart:convert';

// class User {
//   final String id;
//   final String fname;
//   final String lname;
//   final String password;
//   final String mobilenumber;
//   final String email;
//   final String token;
//   // List<User>? following;
//   // List<User>? followers;

//   User(
//       {required this.id,
//       required this.fname,
//       required this.lname,
//       required this.password,
//       required this.mobilenumber,
//       required this.email,
//       required this.token});

//   factory User.fromJson(String jsonString) {
//     Map<String, dynamic> map = json.decode(jsonString);
//     return User(
//       id: map['_id'],
//       fname: map['fname'],
//       lname: map['lname'],
//       password: map['password'],
//       mobilenumber: map['mobilenumber'],
//       email: map['email'],
//       token: map['token']
//       // following: (map['following'] as List<dynamic>?)
//       //     ?.map((user) => User.fromJson(json.encode(user)))
//       //     .toList(),
//       // followers: (map['followers'] as List<dynamic>?)
//       //     ?.map((user) => User.fromJson(json.encode(user)))
//       //     .toList(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'fname': fname,
//       'lname': lname,
//       'password': password,
//       'mobilenumber': mobilenumber,
//       'email': email,
//       'token':token
//       // 'following': following?.map((user) => user.toMap()).toList(),
//       // 'followers': followers?.map((user) => user.toMap()).toList(),
//     };
//   }

//   String toJson() {
//     return json.encode(toMap());
//   }
// }








import 'dart:convert';

import 'package:connections/models/eventModel.dart';

class User {
  final String id;
  final String fname;
  final String lname;
  final String password;
  final String mobilenumber;
  final String email;
  final String token;
  final List<String> eventname;
  final List<String> followers;
  final List<String> following;

  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.password,
    required this.mobilenumber,
    required this.email,
    required this.eventname,
    required this.followers,
    required this.following,
    this.token = '',
  });

  factory User.fromJson(dynamic jsonInput) {
    Map<String, dynamic> map;

    if (jsonInput is String) {
      map = json.decode(jsonInput);
    } else if (jsonInput is Map<String, dynamic>) {
      map = jsonInput;
    } else {
      throw ArgumentError('Invalid JSON input');
    }

    return User(
      id: map['_id'],
      fname: map['fname'],
      lname: map['lname'],
      password: map['password'],
      mobilenumber: map['mobilenumber'],
      email: map['email'],
      token: map['token'] ?? '',
      eventname: List<String>.from(map['eventname']??[]),
      followers:List<String>.from(map['followers']??[]),
      following: List<String>.from(map['following']??[]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'password': password,
      'mobilenumber': mobilenumber,
      'email': email,
      'token': token,
      'eventname':eventname,
      'followers':followers,
      'following':following
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
