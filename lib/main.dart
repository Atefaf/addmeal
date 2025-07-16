import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mealapp/data/meal_model.dart';
import 'package:mealapp/feature/onboarding/pages/onboardingScreen1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(MealModelAdapter());

  // Open the meals box
  await Hive.openBox<MealModel>('meals');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen1(),
    );
  }
}

