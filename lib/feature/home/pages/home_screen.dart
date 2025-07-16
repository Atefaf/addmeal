import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mealapp/feature/home/pages/meal_detail_screen.dart';
import 'package:mealapp/feature/home/widget/add_meal.dart';
import 'package:mealapp/constant/Strings.dart';
import 'package:mealapp/constant/assets.dart';
import 'package:mealapp/constant/color.dart';
import 'package:mealapp/constant/text_style.dart';
import 'package:mealapp/data/meal_model.dart';

import 'package:lottie/lottie.dart';
import 'package:mealapp/feature/home/widget/meal_item.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override@override
Widget build(BuildContext context) {
  final mealsBox = Hive.box<MealModel>('meals');
    
  return Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: GestureDetector(
      onTap: ()  async {

        Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMeal()));
//  await mealsBox.clear();
      } ,

      
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: ColorConstant.primaryOrange, width: 2),
        ),
        child: const Icon(Icons.add, color: ColorConstant.primaryOrange, size: 30),
      ),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Stack(
            children: [
              Image.asset(Assets.headPicture),
              Positioned(
                top: 40,
                left: 50,
                child: Text(
                  Strings.welcomeAddANewRecipe,
                  style: TTextStyle.headlineStyle,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Your Food",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 20),

        // ✅ Meals List from Hive
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ValueListenableBuilder(
              valueListenable: mealsBox.listenable(),
              builder: (context, Box<MealModel> box, _) {
    if (box.isEmpty) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: Lottie.asset('assets/Food.json'),
        ),
        const SizedBox(height: 16),
        const Text(
          "No meals added yet.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

                return GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: box.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final meal = box.getAt(index);

                    return GestureDetector(
                       onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>  MealDetailScreen(
                           index: index,
                          imagePath: meal?.imagePath ?? '',
                        title: meal?.name ?? '',
                         time: meal?.time ?? '',
                        rating: meal?.rate ?? 0, description: meal?.description ?? '',)));
                         
                       },
                      child: MealItem(
                        image: meal?.imagePath ?? '',
                        name: meal?.name ?? '',
                         time: meal?.time ?? '',
                        rate: meal?.rate ?? 0,
                        
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
}




