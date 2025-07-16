import 'package:hive/hive.dart';
// flutter packages pub run build_runner build

part 'meal_model.g.dart'; // Needed for Hive code generation

@HiveType(typeId: 0)
class MealModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String time;

  @HiveField(2)
  double rate;

  @HiveField(3)
  String imagePath;
  @HiveField(4)
  String description;
  MealModel({
     required this.description,
    required this.name,
    required this.time,
    required this.rate,
    required this.imagePath,
  });
}


// intialize hive :
/*
 WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(MealModelAdapter());

  // Open the meals box
  await Hive.openBox<MealModel>('meals');

  */