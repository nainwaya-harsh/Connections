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
  final String ephoto;
  final List<String> eguests;

  EventModel({
    required this.id,
    required this.ephoto,
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
      ephoto:map['ephoto'],
      edate: map['edate'],
      etime: map['etime'],
      ecity: map['ecity'],
      eaddress: map['eaddress'],
      enumber: map['enumber'],
      eguests: map['eguests']!=null?List<String>.from((map['eguests'] as List).map((user)=>user['user_id'] ?? "")) :[]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ename': ename,
      'ephoto':ephoto,
      'edate': edate,
      'etime': etime,
      'ecity': ecity,
      'eaddress': eaddress,
      'enumber': enumber,
      'eguests': eguests
    };
  }

  String toJson() {
    return json.encode(toMap());
  }
}
