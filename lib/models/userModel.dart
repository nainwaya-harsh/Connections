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
  final String profile;
  final String description;
  final String linkedin;
  final String whatsapp;
  final String contact;
  final List<String> eventcreated;
  final List<String> eventattended;
  final List<String> followers;
  final List<String> following;
  final List<String> notification;

  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.password,
    required this.mobilenumber,
    required this.email,
    required this.eventcreated,
    required this.eventattended,
    required this.followers,
    required this.following,
    required this.profile,
    required this.notification,
    required this.description,
    required this.linkedin,
    required this.whatsapp,
    required this.contact,
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
      profile: map['profile'],
      description: map['description'],
      linkedin: map['linkedin'],
      whatsapp: map['whatsapp'],
      contact: map['contact'],
      token: map['token'] ?? '',
      eventcreated: map['eventcreated'] != null
          ? List<String>.from((map['eventcreated'] as List).map((event)=>event['event_id'] ?? ''))
          : [],
      eventattended: map['eventattended'] != null
          ? List<String>.from((map['eventattended'] as List).map((event)=>event['event_id'] ?? ''))
          : [],
      followers: map['followers'] != null
          ? List<String>.from((map['followers'] as List)
              .map((follower) => follower['user_id'] ?? ''))
          : [],
      following: map['following'] != null
          ? List<String>.from((map['following'] as List)
              .map((follow) => follow['guest_id'] ?? ''))
          : [],
      notification: map['notification'] != null
          ? List<String>.from((map['notification'] as List)
              .map((follow) => follow['notification'] ?? ''))
          : [],
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
      'profile':profile,
      'description':description,
      'linkedin':linkedin,
      'whatsapp':whatsapp,
      'contact':contact,
      'eventcreated':eventcreated,
      'eventattended':eventattended,
      'followers':followers,
      'following':following,
      'notification':notification
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
