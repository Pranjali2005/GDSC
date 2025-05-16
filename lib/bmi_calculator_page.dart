import 'package:flutter/material.dart';
import 'diet_plan_page.dart';

class BMICalculatorPage extends StatefulWidget {
  final String userName;
  final int userAge;
  final String userGender;

  const BMICalculatorPage({
    Key? key,
    required this.userName,
    required this.userAge,
    required this.userGender,
  }) : super(key: key);

  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  double? bmi;
  String category = "";
  String note = "";

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      double heightInMeters = height / 100;
      double calculatedBMI = weight / (heightInMeters * heightInMeters);

      setState(() {
        bmi = calculatedBMI;

        if (widget.userAge >= 6 && widget.userAge <= 18) {
          // Child calculation (6–18 years)
          bool isMale = widget.userGender.toLowerCase() == 'male';
          var childResult = _calculateChildBMI(calculatedBMI, widget.userAge, isMale);
          category = childResult['category']!;
          note = childResult['note']!;
        } else if (widget.userAge > 18) {
          // Adult calculation (>18)
          var adultResult = _calculateAdultBMI(calculatedBMI);
          category = adultResult['category']!;
          note = adultResult['note']!;
        } else {
          // Under 6
          category = "Not supported";
          note = "BMI calculation is not supported for children under 6 years.";
        }
      });
    }
  }

  Map<String, String> _calculateAdultBMI(double bmi) {
    String category;
    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi < 25) {
      category = "Normal";
    } else if (bmi < 30) {
      category = "Overweight";
    } else {
      category = "Obese";
    }

    return {
      'category': category,
      'note': "For adults (age > 18 years)",
    };
  }

  Map<String, String> _calculateChildBMI(double bmi, int age, bool isMale) {
    String category;
    String percentile;
    String advice;

    if (isMale) {
      if (bmi < 14.5) {
        percentile = "<5th";
        category = "Underweight";
        advice = "Consult a pediatrician for nutritional guidance";
      } else if (bmi < 17.5) {
        percentile = "5th–<85th";
        category = "Healthy";
        advice = "Maintain balanced diet and regular activity";
      } else if (bmi < 19.5) {
        percentile = "85th–<95th";
        category = "Overweight";
        advice = "Focus on healthy eating and increased physical activity";
      } else {
        percentile = "≥95th";
        category = "Obese";
        advice = "Consult a pediatrician for weight management plan";
      }
    } else {
      if (bmi < 14) {
        percentile = "<5th";
        category = "Underweight";
        advice = "Consult a pediatrician for nutritional guidance";
      } else if (bmi < 17.5) {
        percentile = "5th–<85th";
        category = "Healthy";
        advice = "Maintain balanced diet and regular activity";
      } else if (bmi < 19) {
        percentile = "85th–<95th";
        category = "Overweight";
        advice = "Focus on healthy eating and increased physical activity";
      } else {
        percentile = "≥95th";
        category = "Obese";
        advice = "Consult a pediatrician for weight management plan";
      }
    }

    return {
      'category': category,
      'note': "For $age-year-old ${isMale ? 'boy' : 'girl'} ($percentile percentile)\n$advice",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI CALCULATOR"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/bmibackground.png",
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome, ${widget.userName}!",
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  Text(
                    "Age: ${widget.userAge} | Gender: ${widget.userGender}",
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/bmi_chart.png",
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.yellowAccent, width: 3),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      children: [
                        buildInputField(weightController, "Enter your Weight (kg)"),
                        const SizedBox(height: 15),
                        buildInputField(heightController, "Enter your Height (cm)"),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: calculateBMI,
                          child: const Text(
                            "Calculate BMI",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (bmi != null)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.cyanAccent, width: 3),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Your BMI: ${bmi!.toStringAsFixed(1)}",
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                "Category: $category",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
                              ),
                              if (note.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    note,
                                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Image.asset(
                                "assets/bmi_info.png",
                                width: 250,
                              ),
                              const SizedBox(height: 20),
                              if (category != "Not supported")
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.greenAccent,
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DietPlanPage(
                                          bmiCategory: category,
                                          userAge: widget.userAge,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Continue to Diet Plan",
                                    style: TextStyle(fontSize: 18, color: Colors.black),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
