import 'package:flutter/material.dart';
import 'package:magic/class.dart';
import 'package:magic/set_widget.dart';
import 'package:magic/updateSet_widget.dart';
import 'package:provider/provider.dart';

import 'services/firebase_firestore.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Workout? _args = ModalRoute.of(context)?.settings.arguments as Workout?;
    DatabaseFirestoreService _databaseFirestoreService =
        DatabaseFirestoreService();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Workout"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Workout is not created at the beginning. workoutid is null ///
              _args == null
                  ? SizedBox(
                      height: 500,
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              height: 200,
                              // width: 200,
                              child: const Text("No Set Recorded")),
                          const Spacer(),
                          const Text("Add New Set Below"),
                          const SizedBox(
                            height: 200,
                            width: 200,
                            child: SetWidget(
                              workoutid: null,
                            ),
                          )
                        ],
                      ),
                    )
                  :

                  ///Workout is already created. workoutid is not null
                  StreamProvider<List<Setclass>>.value(
                      value:
                          _databaseFirestoreService.getsetsbyworkout(_args.id),
                      initialData: const [
                      ],
                      updateShouldNotify:
                          ((List<Setclass> previous, List<Setclass> current) {
                        return (current != previous);
                      }),
                      catchError: ((context, error) {
                        return [
                          Setclass(
                              id: "",
                              exercice: "Barbell row",
                              weight: 0,
                              repetition: 0,
                              workoutid: "")
                        ];
                      }),
                      child: Consumer<List<Setclass>>(
                          builder: (context, value, child) {
                        return SizedBox(
                          height: 500,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                height: 200,
                                // width: 200,
                                child:
                                    value.isEmpty
                                        ? const Text("No Set Recorded")
                                        : ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: value.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: UpdateSetWidget(
                                                    setid: value[index].id,
                                                    exercice:
                                                        value[index].exercice,
                                                    weight: value[index].weight,
                                                    repetition: value[index]
                                                        .repetition),
                                              );
                                              // Text( snapshot.data![index].exercice);
                                            }),
                              ),
                              const Spacer(),
                              const Text("Add New Set Below"),
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: SetWidget(
                                  workoutid: _args.id,
                                ),
                              )
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}
