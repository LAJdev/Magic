import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic/class.dart';
import 'package:uuid/uuid.dart';

class DatabaseFirestoreService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference workoutsCollection =
      FirebaseFirestore.instance.collection("workouts");

  final CollectionReference setsCollection =
      FirebaseFirestore.instance.collection("sets");

  Future createSet(
      {required String workoutid,
      required String exercice,
      required int weight,
      required int repetition}) async {
    var uuid = const Uuid();
    var setid = uuid.v4();
    return await setsCollection.doc(setid).set({
      "id": setid,
      "workoutid": workoutid,
      "exercice": exercice,
      "weight": weight,
      "repetition": repetition
    });
  }

  Future updateSet(
      {required String setid,
      required String exercice,
      required int weight,
      required int repetition}) async {
    return await setsCollection.doc(setid).update(
        {"exercice": exercice, "weight": weight, "repetition": repetition});
  }

  Future deleteSet(String setid) async {
    await setsCollection.doc(setid).delete();
  }

  Future deleteWorkout(String workoutid) async {
    var setcollectionlist =
        setsCollection.where("workoutid", isEqualTo: workoutid);
    await setcollectionlist.get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    }).then((value) {
      workoutsCollection.doc(workoutid).delete();
    });
  }

  /// Get sets by workoutid to use for the Workout Screen
  Stream<List<Setclass>> getsetsbyworkout(String workoutid) {
    final _setsCollection = setsCollection.withConverter<Setclass>(
        fromFirestore: ((snapshot, options) =>
            Setclass.fromJson(snapshot.data()!)),
        toFirestore: ((value, options) => value.toJson()));
    var data = _setsCollection
        .where("workoutid", isEqualTo: workoutid)
        .snapshots()
        .map((event) {
      var _list = <Setclass>[];
      event.docs.forEach((element) {
        _list.add(Setclass(
            id: element["id"],
            exercice: element["exercice"],
            weight: element["weight"],
            repetition: element["repetition"],
            workoutid: element["workoutid"]));
      });
      return _list;
    });
    return data;
  }

  Future createWorkout(
      {required String exercice,
      required int weight,
      required int repetition}) async {
    var uuid = const Uuid();
    var setid = uuid.v4();
    return await workoutsCollection.doc(setid).set({
      "id": setid,
    }).then((value) => createSet(
        workoutid: setid,
        exercice: exercice,
        weight: weight,
        repetition: repetition));
  }

  Stream<List<Workout>> getallworkouts() {
    final _workoutsCollection = workoutsCollection.withConverter<Workout>(
        fromFirestore: ((snapshot, options) =>
            Workout.fromJson(snapshot.data()!)),
        toFirestore: ((value, options) => value.toJson()));
    var data = _workoutsCollection.snapshots().map((event) {
      var _list = <Workout>[];
      event.docs.forEach((element) {
        _list.add(Workout(
          id: element["id"],
          // sets: element["sets"],
        ));
      });
      return _list;
    });
    return data;
  }
}
