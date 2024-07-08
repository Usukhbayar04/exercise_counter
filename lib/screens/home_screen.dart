import 'package:flutter/material.dart';
import 'package:pose_tracking/model/exercise.dart'; // Adjust import path as needed
import 'package:pose_tracking/widgets/cart.dart'; // Adjust import path as needed

class HomeScreen extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      id: 1,
      name: "Face Squat",
      description:
          "A face squat is a type of squat that focuses on maintaining a forward-facing posture.",
      musclesTargeted: ["Quads", "Glutes", "Hamstrings"],
      difficulty: "Beginner",
      imageUrl: "assets/images/push_up.jpg",
    ),
    Exercise(
      id: 2,
      name: "Side Squat",
      description:
          "A side squat involves stepping out to the side and squatting down, targeting different leg muscles.",
      musclesTargeted: ["Quads", "Glutes", "Hamstrings", "Adductors"],
      difficulty: "Intermediate",
      imageUrl: "assets/images/face_squat.jpg",
    ),
    Exercise(
      id: 3,
      name: "Face Lunge",
      description:
          "A face lunge involves stepping forward into a lunge position, focusing on the forward-facing posture.",
      musclesTargeted: ["Quads", "Glutes", "Hamstrings"],
      difficulty: "Beginner",
      imageUrl: "assets/images/face_lunge.jpeg",
    ),
    Exercise(
      id: 4,
      name: "Side Lunge",
      description:
          "A side lunge involves stepping out to the side and lunging down, targeting different leg muscles.",
      musclesTargeted: ["Quads", "Glutes", "Hamstrings", "Adductors"],
      difficulty: "Intermediate",
      imageUrl: "assets/images/side_lunge.jpg",
    ),
    Exercise(
      id: 5,
      name: "Face Plank",
      description:
          "A face plank is a plank exercise where the body is held in a push-up position with the face looking forward.",
      musclesTargeted: ["Core", "Shoulders", "Back"],
      difficulty: "Beginner",
      imageUrl: "assets/images/face_plank.jpg",
    ),
    Exercise(
      id: 6,
      name: "Side Plank",
      description:
          "A side plank is a plank exercise where the body is supported on one arm, facing sideways.",
      musclesTargeted: ["Core", "Obliques", "Shoulders"],
      difficulty: "Intermediate",
      imageUrl: "assets/images/side_plank.jpg",
    ),
    Exercise(
      id: 7,
      name: "Face Pushup",
      description:
          "A face push-up is a push-up exercise where the body is raised and lowered using the arms, maintaining a forward-facing posture.",
      musclesTargeted: ["Chest", "Triceps", "Shoulders"],
      difficulty: "Intermediate",
      imageUrl: "assets/images/push_up.jpg",
    ),
    Exercise(
      id: 8,
      name: "Side Pushup",
      description:
          "A side push-up involves positioning the body sideways and performing push-up movements, targeting different muscles.",
      musclesTargeted: ["Chest", "Triceps", "Shoulders", "Obliques"],
      difficulty: "Advanced",
      imageUrl: "assets/images/side_pushup.jpg",
    ),
    Exercise(
      id: 9,
      name: "Balance Leg Left",
      description:
          "A balance leg left exercise involves balancing on the left leg while performing various movements.",
      musclesTargeted: ["Legs", "Core", "Balance"],
      difficulty: "Intermediate",
      imageUrl: "assets/images/balance_leg_left.jpg",
    ),
    Exercise(
      id: 10,
      name: "Balance Leg Right",
      description:
          "A balance leg right exercise involves balancing on the right leg while performing various movements.",
      musclesTargeted: ["Legs", "Core", "Balance"],
      difficulty: "Intermediate",
      imageUrl: "assets/images/balance_leg_left.jpg",
    ),
    Exercise(
      id: 11,
      name: "Face Swing",
      description:
          "A face swing involves swinging the body or a weight forward and backward while maintaining a forward-facing posture.",
      musclesTargeted: ["Legs", "Core", "Shoulders"],
      difficulty: "Intermediate",
      imageUrl: "assets/images/face_pushup.jpg",
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning 🔥',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Usukhbayar Ganchuluun',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.circle_notifications,
                    size: 44,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextField(
                controller: null,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter search text',
                  labelStyle: const TextStyle(fontSize: 18),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Popular Workouts',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: exercises.map((exercise) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ExerciseCart(exercise: exercise),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
