import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pose_tracking/model/exercise.dart';

class ExerciseService {
  Future<List<Exercise>> loadExercises() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/exercises.json');
      final data = await json.decode(response);

      List<Exercise> exercises = (data['exercises'] as List)
          .map((exercise) {
            try {
              return Exercise.fromJson(exercise);
            } catch (e) {
              print('Error parsing exercise: $exercise, Error: $e');
              return null; // or handle the error as needed
            }
          })
          .where((exercise) => exercise != null)
          .cast<Exercise>()
          .toList();

      print("Exercises parsed: $exercises");

      return exercises;
    } catch (e) {
      print('Aldaa : $e');
      return [];
    }
  }
}
