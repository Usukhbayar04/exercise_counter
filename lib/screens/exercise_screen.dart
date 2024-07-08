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
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.85;

    List<String> words = widget.exercise.description!.split(' ');
    bool showSeeAllButton = words.length > 15;

    return Scaffold(
      backgroundColor: const Color.fromARGB(171, 132, 197, 235),
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              widget.exercise.imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: height * 0.05,
              left: width * 0.05,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 48, 46, 46)
                          .withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.exercise.name,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  '🏋️‍♂️ -',
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: width * 0.01),
                                Wrap(
                                  children: widget.exercise.musclesTargeted!
                                      .map((muscle) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        muscle,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white70,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                const Text(
                                  '📰 -',
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: width * 0.01),
                                Expanded(
                                  child: Text(
                                    _showFullText
                                        ? widget.exercise.description!
                                        : words.take(12).join(' ') +
                                            (showSeeAllButton ? '...' : ''),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (String level in [
                                  'Beginner',
                                  'Intermediate',
                                  'Advanced'
                                ])
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          widget.exercise.difficulty! == level
                                              ? Colors.white38
                                              : Colors.black38,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      level,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        SizedBox(
                          width: width * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PoseTrackerPage(
                                      title: widget.exercise.name),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Start Workout',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (showSeeAllButton && !_showFullText)
              Positioned(
                bottom: height * 0.169,
                right: width * 0.04,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _showFullText = true;
                    });
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Hero(
//                   tag: widget.exercise.id,
//                   child: Image.asset(
//                     widget.exercise.imageUrl,
//                     width: width,
//                     height: height,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),