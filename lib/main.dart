import 'package:flutter/material.dart';
import 'package:magic/class.dart';
import 'package:magic/workout_list_screen.dart';
import 'package:magic/workout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/firebase_firestore.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (err) {
    print(err.toString());
  }
  runApp(MultiProvider(providers: [
    StreamProvider<List<Workout>>.value(
      value: DatabaseFirestoreService().getallworkouts(),
      // initialData: [Workout(id: "")],
      initialData: [],
      updateShouldNotify: ((List<Workout> previous, List<Workout> current) {
        return (current != previous);
      }),
      catchError: (context, error) => [Workout(id: "")],
    ),
    
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/workout_list_screen",
      routes: {
        "/workout_list_screen": (context) => const WorkoutListScreen(),
        "/workout_screen": (context) => const WorkoutScreen()
      },
    );
  }
}

