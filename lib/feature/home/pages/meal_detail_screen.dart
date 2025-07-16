import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mealapp/constant/color.dart';
import 'package:mealapp/data/meal_model.dart';

class MealDetailScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final double rating;
  final String description;
  final int index;

  const MealDetailScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.rating,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🍔 Meal Image with Back Button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.file(
                  File(imagePath),
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 🍔 Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "$title ",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 12),

          // 🕒 Time & ⭐ Rating
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConstant.primaryOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, color: Colors.orange, size: 18),
                  const SizedBox(width: 6),
                  Text(time, style: const TextStyle(fontSize: 14)),

                  const SizedBox(width: 24),

                  const Icon(Icons.star, color: Colors.orange, size: 18),
                  const SizedBox(width: 6),
                  Text(rating.toString(), style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 📝 Description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              style: const TextStyle(color: Colors.grey, height: 1.5),
            ),
          ),

          const SizedBox(height: 20),

          // Delete Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                final mealsBox = Hive.box<MealModel>('meals');
                await mealsBox.deleteAt(index);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Delete Meal",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

