import 'package:flutter/material.dart';

class ExercisePlanPage extends StatelessWidget {
  final String bmiCategory;
  final int userAge;

  const ExercisePlanPage({
    Key? key,
    required this.bmiCategory,
    required this.userAge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isChild = userAge < 18;

    Map<String, List<String>> childExercisePlans = {
      "Underweight": [
        "💪 Strength building activities",
        "🤸 Bodyweight exercises",
        "🚴‍♂️ 30 mins moderate activity daily",
        "🏊 Swimming for full-body workout",
        "⚽ Team sports for fun",
        "🧘 Yoga for flexibility",
      ],
      "Healthy": [
        "✅ Maintain active lifestyle",
        "🏃‍♂️ 60 mins active play daily",
        "🚴 Cycling or scooter riding",
        "🤸‍♀️ Gymnastics or martial arts",
        "🏀 Basketball or soccer",
        "🧘‍♂️ Stretching regularly",
      ],
      "Overweight": [
        "⚖️ Focus on fun activities",
        "🚶‍♂️ Start with walking",
        "🏊 Low-impact swimming",
        "🚴 Cycling with family",
        "🤸 Active games like tag",
        "🧘 Yoga for stress relief",
      ],
      "Obese": [
        "🔄 Start slow and gradual",
        "🚶 Short walks, increase over time",
        "🏊 Water activities for joints",
        "🚴 Stationary biking",
        "🤸 Stretching exercises",
        "🎯 Set fun activity targets",
      ],
    };

    Map<String, List<String>> adultExercisePlans = {
      "Underweight": [
        "💪 Focus on muscle building",
        "🏋️ Weight training 3-4 times weekly",
        "🚴 Moderate cardio 2-3 times weekly",
        "🧘 Yoga for flexibility",
        "🏊 Swimming for low-impact option",
        "⏱️ Rest days for recovery",
      ],
      "Normal": [
        "✅ Maintain balanced routine",
        "🏃 150 mins moderate activity weekly",
        "🏋️ Strength training 2 times weekly",
        "🧘‍♀️ Yoga or Pilates",
        "🚴 Mix of cardio activities",
        "🤸 Core exercises for stability",
      ],
      "Overweight": [
        "⚖️ Focus on fat loss",
        "🚶‍♂️ Brisk walking 30 mins daily",
        "🏋️‍♂️ Strength training to preserve muscle",
        "🏊 Low-impact swimming",
        "🧘 Yoga for stress management",
        "⏱️ Gradually increase intensity",
      ],
      "Obese": [
        "🔄 Start with manageable activities",
        "🚶 Short walks, increase duration",
        "💺 Chair exercises if needed",
        "🏊 Water aerobics for joints",
        "🧘 Gentle stretching",
        "📈 Set small, achievable goals",
      ],
    };

    Map<String, String> exerciseImages = {
      "Underweight": "assets/underweight_exercise.png",
      "Healthy": "assets/normal_exercise.png",
      "Normal": "assets/normal_exercise.png",
      "Overweight": "assets/overweight_exercise.png",
      "Obese": "assets/obese_exercise.png",
    };

    Map<String, Color> borderColors = {
      "Underweight": Colors.blueAccent,
      "Healthy": Colors.green,
      "Normal": Colors.green,
      "Overweight": Colors.orangeAccent,
      "Obese": Colors.redAccent,
    };

    List<String> exercisePlan = isChild
        ? childExercisePlans[bmiCategory] ?? []
        : adultExercisePlans[bmiCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("${isChild ? '👶 Child' : '👨‍💼 Adult'} EXERCISE PLAN"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/exercise_background.png",
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
                  Text(
                    "🏋️ ${isChild ? 'Child' : 'Adult'} Exercise Plan - $bmiCategory 🏋️",
                    style: const TextStyle(
                      fontSize: 26,
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
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.cyanAccent, width: 3),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white30,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: exercisePlan
                          .map((exercise) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          exercise,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        exerciseImages[bmiCategory] ?? "assets/exercise_default.png",
                        width: 280,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 5,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "🏠 Back to Home",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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