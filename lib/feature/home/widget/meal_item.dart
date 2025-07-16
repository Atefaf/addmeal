import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mealapp/constant/color.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.image,
    required this.name,
    required this.time,
    required this.rate,
  });

  final String image;
  final String name;
  final String time;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Image (Responsive, covers any aspect ratio)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.file(
                File(image),
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),

          // ✅ Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Spacer(),

          // ✅ Time and Rating Row
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ⭐ Rating
                Row(
                  children: [
                    Icon(Icons.star, color: ColorConstant.primaryOrange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rate.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.primaryOrange,
                      ),
                    ),
                  ],
                ),
                // 🕒 Time
                Row(
                  children: [
                    Icon(Icons.access_time, color: ColorConstant.primaryOrange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.primaryOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
