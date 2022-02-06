import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_bar_gym/models/data_model.dart';
import 'package:the_bar_gym/models/exercise.dart';
import 'package:the_bar_gym/services/firestore_service.dart';

class ExerciseDetailProvider extends ChangeNotifier {
  late Stream<List> hello;

  ExerciseDetailProvider(){
    FirestoreService _firestoreService = FirestoreService();
  }

  final FirestoreService _firestoreService = FirestoreService();

  Future<void> addExcerciseData(Exercise exercise) async {
    double totalSets = _getTotalSets(exercise);

    exercise = exercise.copyWith(
      totalSets: totalSets,
    );

    await _firestoreService.add(exercise);
  }

  Future<void> updateExercise(Exercise exercise, List<Data> data) async {
    double totalSets = _getTotalSets(exercise);

    exercise = exercise.copyWith(
      totalSets: totalSets,
    );

    await _firestoreService.update(exercise);
  }

  double _getTotalSets(Exercise exercise) {
    double totalSets = 0;
    List<Data> data = exercise.data;

    for (var i = 0; i < data.length; i++) {
      double weight = data[i].weight!.kg!;
      int reps = data[i].reps!;
      totalSets += weight * reps;
    }

    return totalSets;
  }

  Future<void> deleteExercise() async {
    await _firestoreService.delete();
  }

  Stream<List<Exercise>> getAllData(DateTime date) {
    return _firestoreService.getAllbyDate(date).map((snapshot) => snapshot.docs.map((doc) => Exercise.fromMap(doc.data())).toList());
  }
}
