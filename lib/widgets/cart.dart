import 'package:flutter/material.dart';
import 'package:pose_tracking/model/exercise.dart';
import 'package:pose_tracking/screens/exercise_screen.dart';

class ExerciseCart extends StatelessWidget {
  final Exercise exercise;
  const ExerciseCart({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.6;

    return InkWell(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 16,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                exercise.imageUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: width,
                height: height,
                color: Colors.black.withOpacity(0.25),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.play_circle_outline_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print(exercise.name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseScreen(exercise: exercise),
          ),
        );
      },
    );
  }
}
