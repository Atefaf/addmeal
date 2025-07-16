import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mealapp/constant/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealapp/data/meal_model.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key});
@override
State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  final _formKey = GlobalKey<FormState>();
  final _mealName = TextEditingController();
  final _mealTime = TextEditingController();
  final _mealRate = TextEditingController();
  final _mealDescription = TextEditingController();
  final box = Hive.box<MealModel>('meals');
  File? imagePicked;
  
 bool  isLoading = false;

  Future<void> pickImage() async {
    setState(() {
       isLoading = true;
    });
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imagePicked = File(pickedImage.path);
      });
    }
    setState(() {
      isLoading = false;
    });
   
  }

 void dipose() {
   _mealDescription.dispose();
   _mealDescription.dispose();
   _mealRate.dispose();
   _mealTime.dispose();
   _mealName.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Meal")),
      body:  SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField(
                  _mealName,
                  label: "Meal Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Meal name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  _mealRate,
                  label: "Rating (e.g. 4.5)",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Rating is required";
                    }
                    final rating = double.tryParse(value);
                    if (rating == null || rating < 0 || rating > 5) {
                      return "Enter a number between 0 and 5";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  _mealTime,
                  label: "Time (e.g. 20-30 min)",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Time is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextFormField(
                  _mealDescription,
                  label: "Description",
                  maxLines: 8,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description is required";
                    }
                    if (value.length < 10) {
                      return "Description must be at least 10 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  "Meal Picture",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.primaryOrange,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstant.primaryOrange.withOpacity(0.5),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
  child: isLoading
      ? const CircularProgressIndicator()
      : imagePicked != null
          ? Image.file(
              imagePicked!,
              fit: BoxFit.cover,
              width: double.infinity,
            )
          : const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
),

                  ),
                ),
                const SizedBox(height: 30),
                SizedBox
                (
                   width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        box.add(MealModel(name: _mealName.text, time: _mealTime.text, rate: double.tryParse(_mealRate.text)!,
                         description: _mealDescription.text,
                         imagePath: imagePicked?.path??''));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Meal Saved')),
                        );

                    Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryOrange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Save Meal",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller, {
    String? label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: maxLines > 1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.primaryOrange),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
