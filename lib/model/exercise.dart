class Exercise {
  final int id;
  final String name;
  String? description;
  List<String>? musclesTargeted;
  String? difficulty;
  final String imageUrl;

  Exercise({
    required this.id,
    required this.name,
    this.description,
    this.musclesTargeted,
    this.difficulty,
    required this.imageUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      musclesTargeted: json['musclesTargeted'] != null
          ? List<String>.from(json['musclesTargeted'])
          : [],
      difficulty: json['difficulty'] ?? '',
      imageUrl: json['imageUrl'] ?? 'assets/images/pull_up.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'muscles_targeted': musclesTargeted,
      'difficulty': difficulty,
      'imageUrl': imageUrl,
    };
  }
}
