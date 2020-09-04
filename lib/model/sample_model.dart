import 'dart:convert';
import 'package:flutter/material.dart';

SampleModel sampleModelFromJson(String str) => SampleModel.fromJson(json.decode(str));
String sampleModelToJson(SampleModel data) => json.encode(data.toJson());

final iconColorMap = {
  1: Colors.greenAccent,
  2: Colors.red,
  3: Colors.blue,
  4: Colors.yellow,
  5: Colors.orange,
  6: Colors.green,
  7: Colors.purple,
};

final iconMap = {
  1: Icons.ac_unit,
  2: Icons.add_call,
  3: Icons.airline_seat_recline_normal,
  4: Icons.domain,
  5: Icons.event,
  6: Icons.input,
  7: Icons.format_strikethrough,
};

class SampleModel {
  int id;
  String title;
  String text;
  DateTime date;
  IconData icon;
  Color iconColor;

  SampleModel(
      {this.id,
      this.title,
      this.text,
      this.date,
      /*JsonIgnore*/
      this.icon,
      this.iconColor
      /*JsonIgnore*/
      });

  factory SampleModel.fromJson(Map<String, dynamic> json) => SampleModel(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        date: DateTime.parse(json['date']),
        icon: iconMap[json['type']],
        iconColor: iconColorMap[json['type']],
      );

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'text': text, 'date': date.toIso8601String()};
}
