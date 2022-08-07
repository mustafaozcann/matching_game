import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class GameCard {

  final int id;
  final String path;
  final Color? bgColor;
  bool isActive = false;
  int index = 0;

  GameCard({index = 0, isActive = false, required this.id, required this.path, required this.bgColor});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'img_id': id,
      'img_path': path,
    };
  }

  factory GameCard.fromMap(Map<String, dynamic> map) {
    return GameCard(
      id: map['img_id'] as int,
      path: map['img_path'] as String,
      bgColor: Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)),
      
    );
  }

  @override
  String toString() {
    return "ID: $id  ------ PATH: $path";
  }

  String toJson() => json.encode(toMap());

  factory GameCard.fromJson(String source) => GameCard.fromMap(json.decode(source) as Map<String, dynamic>);
}
