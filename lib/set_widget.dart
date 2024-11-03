import 'package:flutter/material.dart';

import 'class.dart';
import 'services/firebase_firestore.dart';

class SetWidget extends StatefulWidget {
  final String? workoutid;
  const SetWidget({required this.workoutid, super.key});

  @override
  State<SetWidget> createState() => _SetWidgetState();
}

class _SetWidgetState extends State<SetWidget> {
  String dropdownValueExercice = listExercice.first;
  int dropdownValueWeight = 0;
  int dropdownValueRepetition = 0;
  final DatabaseFirestoreService _databaseFirestoreService =
      DatabaseFirestoreService();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        // height: 200,
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
           
            Expanded(
              child: DropdownButton<String>(
                  value: dropdownValueExercice,
                  items: listExercice
                      .map<DropdownMenuItem<String>>((String value) =>
                          DropdownMenuItem(value: value, child: Text(value)))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValueExercice = value!;
                    });
                  }),
            ),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Weight:"),
                  DropdownButton<int>(
                      value: dropdownValueWeight,
                      items: List<int>.generate(100, (int index) => index,
                              growable: true)
                          .map<DropdownMenuItem<int>>((int value) =>
                              DropdownMenuItem(
                                  value: value, child: Text("$value")))
                          .toList(),
                      onChanged: (int? value) {
                        setState(() {
                          dropdownValueWeight = value!;
                        });
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Repetitions:"),
                  DropdownButton<int>(
                      value: dropdownValueRepetition,
                      items: List<int>.generate(100, (int index) => index,
                              growable: true)
                          .map<DropdownMenuItem<int>>((int value) =>
                              DropdownMenuItem(
                                  value: value, child: Text("$value")))
                          .toList(),
                      onChanged: (int? value) {
                        setState(() {
                          dropdownValueRepetition = value!;
                        });
                      }),
                ],
              ),
            ),
            //const Icon(Icons.delete),
            GestureDetector(
                onTap: () {
                  if (widget.workoutid == null) {
                    _databaseFirestoreService
                        .createWorkout(
                            exercice: dropdownValueExercice,
                            weight: dropdownValueWeight,
                            repetition: dropdownValueRepetition)
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  }
                  if (widget.workoutid != null) {
                    _databaseFirestoreService.createSet(
                        workoutid: widget.workoutid!,
                        exercice: dropdownValueExercice,
                        weight: dropdownValueWeight,
                        repetition: dropdownValueRepetition);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      SizedBox(
                        width: 10,
                      ),
                      Text("SAVE")
                    ],
                  ),
                ))
          ],
        ));
  }
}
