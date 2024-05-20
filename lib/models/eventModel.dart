// import 'dart:convert';
// import 'package:connections/models/userModel.dart';

// class EventModel {
//   final String id;
//   final String ename;
//   final String edate;
//   final String etime;
//   final String ecity;
//   final String eaddress;
//   final String enumber;
//   final List<User> eguests;

//   EventModel({
//     required this.id,
//     required this.ename,
//     required this.edate,
//     required this.etime,
//     required this.ecity,
//     required this.eaddress,
//     required this.enumber,
//     required this.eguests,
//   });

//   // Convert Event object to a Map object
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'ename': ename,
//       'edate': edate,
//       'etime': etime,
//       'ecity': ecity,
//       'eaddress': eaddress,
//       'enumber': enumber,
//       'eguests': eguests.map((guest) => guest.toJson()).toList(),
//     };
//   }

//   // Create an Event object from a Map object
//   factory EventModel.fromJson(Map<String, dynamic> map) {
//     return EventModel(
//       id: map['_id'],
//       ename: map['ename'],
//       edate: map['edate'],
//       etime: map['etime'],
//       ecity: map['ecity'],
//       eaddress: map['eaddress'],
//       enumber: map['enumber'],
//        eguests: (map['eguests'] as List<dynamic>)
//           .map((guestData) => User.fromJson(guestData['eguest']))
//           .toList(),
//     );
//   }

//   String toJson(){
//     return json.encode(toMap());
//   }
// }




import 'dart:convert';
import 'package:connections/models/userModel.dart';

class EventModel {
  final String id;
  final String ename;
  final String edate;
  final String etime;
  final String ecity;
  final String eaddress;
  final String enumber;
  final List<User> eguests;

  EventModel({
    required this.id,
    required this.ename,
    required this.edate,
    required this.etime,
    required this.ecity,
    required this.eaddress,
    required this.enumber,
    required this.eguests,
  });

  factory EventModel.fromJson(Map<String, dynamic> map) {
    return EventModel(
      id: map['_id'],
      ename: map['ename'],
      edate: map['edate'],
      etime: map['etime'],
      ecity: map['ecity'],
      eaddress: map['eaddress'],
      enumber: map['enumber'],
      eguests: (map['eguests'] as List<dynamic>)
          .map((guestData) => User.fromJson(guestData['eguest']))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ename': ename,
      'edate': edate,
      'etime': etime,
      'ecity': ecity,
      'eaddress': eaddress,
      'enumber': enumber,
      'eguests': eguests.map((guest) => guest.toJson()).toList(),
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
