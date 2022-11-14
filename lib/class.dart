
class Workout {
  String id;
  // List<dynamic> sets;
  Workout({
    required this.id,
  });
  Workout.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          // sets: json["sets"] ?? []
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      // "sets": sets,
    };
  }
}

class Setclass {
  String id;
  String exercice;
  int weight;
  int repetition;
  String workoutid;
  Setclass(
      {required this.id,
      required this.exercice,
      required this.weight,
      required this.repetition,
      required this.workoutid});
  Setclass.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          exercice: json["exercice"],
          weight: json["weight"],
          repetition: json["repetition"],
          workoutid: json["workoutid"],
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "exercice": exercice,
      "weight": weight,
      "repetition": repetition,
      "workoutid": workoutid,
    };
  }
}

final List<String> listExercice = [
  "Barbell row",
  "Bench press",
  "Shoulder press",
  "Deadlift",
  "Squat"
];
