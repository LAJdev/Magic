import 'package:flutter/material.dart';

import 'class.dart';
import 'services/firebase_firestore.dart';

class UpdateSetWidget extends StatefulWidget {
  final String setid;
  final String exercice;
  final int weight;
  final int repetition;
  const UpdateSetWidget(
      {required this.setid,
      required this.exercice,
      required this.weight,
      required this.repetition,
      super.key});

  @override
  State<UpdateSetWidget> createState() => _UpdateSetWidgetState();
}

class _UpdateSetWidgetState extends State<UpdateSetWidget> {
  late String dropdownValueExercice;
  late int dropdownValueWeight;
  late int dropdownValueRepetition;
  final DatabaseFirestoreService _databaseFirestoreService =
      DatabaseFirestoreService();
  
  @override
  Widget build(BuildContext context) {
    dropdownValueExercice = widget.exercice;
    dropdownValueWeight = widget.weight;
    dropdownValueRepetition = widget.repetition;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        // height: 300,
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            DropdownButton<String>(
              underline: Container(),
                value: dropdownValueExercice,
                // items: _list,
                items: listExercice
                    .map<DropdownMenuItem<String>>((String value) =>
                        DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (String? value) {
                  _databaseFirestoreService.updateSet(
                      setid: widget.setid,
                      exercice: value!,
                      weight: dropdownValueWeight,
                      repetition: dropdownValueRepetition);
                 
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Weight in Kg:"),
                DropdownButton<int>(
                    underline: Container(),
                    value: dropdownValueWeight,
                    items: List<int>.generate(100, (int index) => index,
                            growable: true)
                        .map<DropdownMenuItem<int>>((int value) =>
                            DropdownMenuItem(
                                value: value, child: Text("$value")))
                        .toList(),
                    onChanged: (int? value) {
                      _databaseFirestoreService.updateSet(
                          setid: widget.setid,
                          exercice: widget.exercice,
                          weight: value!,
                          repetition: dropdownValueRepetition);
                    
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Repetitions:"),
                DropdownButton<int>(
                  underline: Container(),
                    value: dropdownValueRepetition,
                    items: List<int>.generate(100, (int index) => index,
                            growable: true)
                        .map<DropdownMenuItem<int>>((int value) =>
                            DropdownMenuItem(
                                value: value, child: Text("$value")))
                        .toList(),
                    onChanged: (int? value) {
                     
                      _databaseFirestoreService.updateSet(
                          setid: widget.setid,
                          exercice: widget.exercice,
                          weight: widget.weight,
                          repetition: value!);
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      _databaseFirestoreService
                          .deleteSet(widget.setid)
                          ;
                    },
                    child: const Icon(Icons.delete)),
                
              ],
            ),
          ],
        ));
  }
}
