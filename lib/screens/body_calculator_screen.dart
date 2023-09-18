
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework2_191532/calculator/calories_calculator.dart';
import 'package:homework2_191532/model/meal_model.dart';
import 'package:homework2_191532/screens/home_page_screen.dart';
import 'package:homework2_191532/services/services.dart';

import '../model/meal_plan_model.dart';

class BodyCalculatorScreen extends StatefulWidget {
  
  @override
  _BodyCalculatorState createState() => _BodyCalculatorState();
}

class _BodyCalculatorState extends State<BodyCalculatorScreen> {
  static const String _title = 'Body Calories Calculator';
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String selectedGender = 'Male';
  String selectedActivityLevel = 'Sedentary';
  double calculatedCalories = 0.0;
  MealPlan mealPlan = MealPlan(meals: [Meal(id: 0, title: '', readyInMinutes: 0)], calories: 0.0, carbs: 0.0, fat: 0.0, protein: 0.0);


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void calculateCalories() {
    int age = int.tryParse(ageController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    CalorieCalculator calculator = CalorieCalculator();
    double calories = calculator.calculateCalories(
      age: age,
      height: height,
      weight: weight,
      gender: selectedGender,
      activityLevel: selectedActivityLevel,
    );

    setState(() {
      calculatedCalories = calories;
    });
  }

  Future<void> _saveCaloriesToFirestore(double calculatedCaloriesWeightLoss, double calculatedCaloriesMaintainWeight) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      await _firestore.collection('users').doc(uid).set({
        'calculatedCaloriesWeightLoss': calculatedCaloriesWeightLoss,
        'calculatedCaloriesMaintainWeight': calculatedCaloriesMaintainWeight,
        'isNewUser': true,
      });
    }
  }

  Future<void> _generateMealPlan(calculatedCaloriesMaintainWeight) async {
    mealPlan = await ApiService.instance.generateMealPlan(
      targetCalories: calculatedCaloriesMaintainWeight.toInt(),
      diet: 'None',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(_title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(),
              child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 250,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Container(
                      child: Transform.translate(
                          offset: const Offset(-60, -50),
                          child: Image.asset('assets/images/MyHealthyBodyLogo.png')),
                    ),
                  )
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Transform.translate(
                      offset: const Offset(0, -80),
                      child: const Text(
                          'Body calories \n calculator',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 38.0, fontWeight: FontWeight.bold)
                      ),
                    )
                )
            ),
            Transform.translate(
              offset: const Offset(0, -80),
              child: Padding(
                // padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 0, bottom: 0
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                      hintText: 'Enter your age'),
                  controller: ageController,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -80),
              child:  Row(
                // padding: const EdgeInsets.only(
                //     left: 40.0, right: 40.0, top: 15, bottom: 0),
                // //padding: EdgeInsets.symmetric(horizontal: 15),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 20.0),
                    child: const Text(
                      'Gender',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Radio<String>(
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                  ),
                  const Text(
                    'Male',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Radio<String>(
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                  ),
                  const Text(
                    'Female',
                    style: TextStyle(fontSize: 20.0),
                  )
                ]
              )
            ),
            Transform.translate(
              offset: const Offset(0, -80),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 5, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Height(cm)',
                      hintText: 'Enter your height'),
                  controller: heightController,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -80),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 10, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Weight(kg)',
                      hintText: 'Enter your weight'),
                  controller: weightController,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -70),
              child: Container(
                width: 332,
                height: 50,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), 
                  borderRadius: BorderRadius.circular(3.0), 
                ),
                child: 
                  DropdownButton<String>(
                    value: selectedActivityLevel,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedActivityLevel = newValue!;
                      });
                    },
                    style: const TextStyle(color: Color.fromARGB(255, 80, 80, 80)),
                    items: <String>[
                      'Sedentary',
                      'Lightly Active',
                      'Moderately Active',
                      'Very Active',
                      'Super Active',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -60),
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () async {
                    // call the calculateCalories method
                    calculateCalories();

                    // set calculated calories for weight loss
                    double calculatedCaloriesWeightLoss = 0.0;
                    calculatedCaloriesWeightLoss = calculatedCalories - 500.0;

                    _saveCaloriesToFirestore(calculatedCaloriesWeightLoss, calculatedCalories);
                    
                    await _generateMealPlan(calculatedCalories);
                    
                    // after calculated calories 
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePageScreen(calculatedCaloriesWeightLoss: calculatedCaloriesWeightLoss, calculatedCaloriesMaintainWeight: calculatedCalories, isNewUser: true, mealPlan: mealPlan))
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}