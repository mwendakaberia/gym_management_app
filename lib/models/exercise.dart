import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:the_bar_gym/models/data_model.dart';

// class Exercises extends Table {
//   IntColumn? get id => integer().autoIncrement()();
//   TextColumn? get name => text()();
//   IntColumn? get sets => integer()();
//   TextColumn? get data => text()();
//   TextColumn? get note => text()();
//   DateTimeColumn? get date => dateTime()();
// }

class Exercise {
  String name;
  int sets;
  List<Data> data;
  String? note;
  DateTime date;
  double? totalSets;
  Exercise({
    required this.name,
    required this.sets,
    required this.data,
    this.note,
    required this.date,
    this.totalSets,
  });

  Exercise copyWith({
    String? name,
    int? sets,
    List<Data>? data,
    String? note,
    DateTime? date,
    double? totalSets,
  }) {
    return Exercise(
      name: name ?? this.name,
      sets: sets ?? this.sets,
      data: data ?? this.data,
      note: note ?? this.note,
      date: date ?? this.date,
      totalSets: totalSets ?? this.totalSets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sets': sets,
      'data': data.map((x) => x.toMap()).toList(),
      'note': note,
      'date': date.millisecondsSinceEpoch,
      'totalSets': totalSets,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] ?? '',
      sets: map['sets']?.toInt() ?? 0,
      data: List<Data>.from(map['data']?.map((x) => Data.fromMap(x))),
      note: map['note'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      totalSets: map['totalSets']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) => Exercise.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(name: $name, sets: $sets, data: $data, note: $note, date: $date, totalSets: $totalSets)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise &&
        other.name == name &&
        other.sets == sets &&
        listEquals(other.data, data) &&
        other.note == note &&
        other.date == date &&
        other.totalSets == totalSets;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    sets.hashCode ^
    data.hashCode ^
    note.hashCode ^
    date.hashCode ^
    totalSets.hashCode;
  }
}