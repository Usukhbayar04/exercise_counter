// // class Exerciselist extends StatefulWidget {
// //   const Exerciselist({super.key});

// //   @override
// //   State<Exerciselist> createState() => _ExerciselistState();
// // }

// // class _ExerciselistState extends State<Exerciselist> {
// //   List<Exercise> exercises = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadExercises();
// //   }

// //   Future<void> loadExercises() async {
// //     final String response =
// //         await rootBundle.loadString('assets/data/exercises.json');
// //     final data = await json.decode(response);
// //     setState(() {
// //       exercises = (data['exercises'] as List)
// //           .map((exerciseJson) => Exercise.fromJson(exerciseJson))
// //           .toList();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Exercises')),
// //       body: ListView.builder(
// //         itemCount: exercises.length,
// //         itemBuilder: (context, index) {
// //           final exercise = exercises[index];
// //           return ListTile(
// //             leading: Image.asset(exercise.imageUrl),
// //             title: Text(exercise.name),
// //             subtitle: Text(exercise.description),
// //             trailing: Text(exercise.difficulty),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// class Exercise {
//   final int id;
//   final String name;
//   String? description;
//   List<String>? musclesTargeted;
//   String? difficulty;
//   final String imageUrl;

//   Exercise({
//     required this.id,
//     required this.name,
//     description,
//     musclesTargeted,
//     difficulty,
//     required this.imageUrl,
//   });

//   factory Exercise.fromJson(Map<String, dynamic> json) {
//     return Exercise(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       musclesTargeted: List<String>.from(json['musclesTargeted']),
//       difficulty: json['difficulty'],
//       imageUrl: json['imageUrl'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'muscles_targeted': musclesTargeted,
//       'difficulty': difficulty,
//       'imageUrl': imageUrl,
//     };
//   }
// }
