import 'package:flutter/material.dart';
import 'exercise_plan_page.dart';

class DietPlanPage extends StatelessWidget {
  final String bmiCategory;
  final int userAge;

  const DietPlanPage({
    Key? key,
    required this.bmiCategory,
    required this.userAge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isChild = userAge < 18;

    Map<String, List<String>> childDietPlans = {
      "Underweight": [
        "🍼 Increase calorie intake with healthy foods",
        "🥛 Drink whole milk instead of low-fat",
        "🥜 Add nuts and seeds to meals and snacks",
        "🥑 Include healthy fats like avocado",
        "🍗 Serve protein with every meal",
        "⏰ Offer snacks between meals",
      ],
      "Healthy": [
        "🥦 Variety of colorful fruits and vegetables",
        "🥛 2-3 servings of dairy daily",
        "🍗 Lean proteins like chicken and fish",
        "🌾 Whole grains for energy",
        "💧 Plenty of water, limit juices",
        "🍎 Healthy snacks like fruits and nuts",
      ],
      "Overweight": [
        "⚖️ Focus on portion control",
        "🥦 More vegetables at every meal",
        "🍎 Whole fruits instead of juice",
        "💧 Water as main drink",
        "🚫 Limit sugary snacks",
        "🏃‍♂️ Combine with daily activity",
      ],
      "Obese": [
        "🔄 Make gradual healthy changes",
        "🥗 Fill half plate with vegetables",
        "🍗 Appropriate protein portions",
        "💧 Only water, no sugary drinks",
        "🚫 Remove processed snacks",
        "⚽ Increase activity gradually",
      ],
    };

    Map<String, List<String>> adultDietPlans = {
      "Underweight": [
        "📈 Increase calorie intake gradually",
        "🥑 Add healthy fats like nuts and oils",
        "🍗 Protein with every meal",
        "🥛 Full-fat dairy products",
        "⏰ Eat smaller meals more frequently",
        "🏋️‍♂️ Combine with strength training",
      ],
      "Normal": [
        "✅ Maintain balanced diet",
        "🥗 Half plate vegetables, quarter protein, quarter grains",
        "🥑 Healthy fats in moderation",
        "💧 Stay hydrated with water",
        "🚫 Limit processed foods",
        "⚖️ Monitor portions",
      ],
      "Overweight": [
        "⚖️ Reduce portion sizes",
        "🥦 Focus on fiber-rich vegetables",
        "🍗 Lean proteins to feel full",
        "💧 Drink water before meals",
        "🚫 Limit alcohol and sugary drinks",
        "🏃‍♀️ Combine with regular exercise",
      ],
      "Obese": [
        "🔄 Make sustainable changes",
        "🥗 Focus on non-starchy vegetables",
        "🍗 Adequate protein to preserve muscle",
        "💧 Water as primary beverage",
        "🚫 Eliminate sugary foods",
        "🚶‍♂️ Start with walking",
      ],
    };

    Map<String, String> dietImages = {
      "Underweight": "assets/underweight_diet.png",
      "Healthy": "assets/normal_diet.png",
      "Normal": "assets/normal_diet.png",
      "Overweight": "assets/overweight_diet.png",
      "Obese": "assets/obese_diet.png",
    };

    Map<String, Color> borderColors = {
      "Underweight": Colors.blueAccent,
      "Healthy": Colors.green,
      "Normal": Colors.green,
      "Overweight": Colors.orangeAccent,
      "Obese": Colors.redAccent,
    };

    List<String> dietPlan = isChild
        ? childDietPlans[bmiCategory] ?? []
        : adultDietPlans[bmiCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("${isChild ? '👶 Child' : '👨‍💼 Adult'} DIET PLAN"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/diet_background.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColors[bmiCategory] ?? Colors.white,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: (borderColors[bmiCategory] ?? Colors.white).withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        dietImages[bmiCategory] ?? "assets/diet_default.png",
                        width: 280,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "🍎 ${isChild ? 'Child' : 'Adult'} Diet Plan - $bmiCategory 🍎",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellowAccent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dietPlan
                          .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExercisePlanPage(
                            bmiCategory: bmiCategory,
                            userAge: userAge,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "🏋️ Continue to Exercise Plan",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}