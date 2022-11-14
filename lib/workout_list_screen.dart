import 'package:flutter/material.dart';
import 'package:magic/class.dart';
import 'package:provider/provider.dart';

import 'services/firebase_firestore.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseFirestoreService _databaseFirestoreService =
        DatabaseFirestoreService();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
              size: 40,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/workout_screen",
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: const Text("Workout List"),
        ),
        body: Column(
          children: [
            Consumer<List<Workout>>(builder: ((context, value, child) {
              
              return value.isEmpty
                  ? const Expanded(child: Center(child: Text("No Workout Recorded")))
                  : Expanded(
                      child: ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/workout_screen",
                                    arguments: Workout(
                                      id: value[index].id,
                                      // sets: _data[index].sets
                                    ));
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 80,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("Workout"),
                                      GestureDetector(
                                          onTap: () {
                                            _databaseFirestoreService
                                                .deleteWorkout(value[index].id);
                                          },
                                          child: const Icon(Icons.delete)),
                                    ],
                                  )),
                            );
                          }),
                    );
            }))
          ],
        ));
  }
}
