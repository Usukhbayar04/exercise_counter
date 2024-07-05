import 'package:flutter/material.dart';
import 'package:pose_tracking/model/exercise.dart';
import 'package:pose_tracking/screens/poseTracker.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercise exercise;
  const ExerciseScreen({super.key, required this.exercise});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(171, 132, 197, 235),
      appBar: AppBar(
        title: const Text(
          'Exercise Screen',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(176, 150, 197, 224),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.exercise.name),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PoseTrackerPage(title: 'PoseTracker'),
                  ),
                );
                print('clicked...');
              },
              child: const Text('Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
