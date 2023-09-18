
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework2_191532/model/meal_model.dart';
import 'package:homework2_191532/model/meal_plan_model.dart';
import 'package:homework2_191532/screens/body_calculator_screen.dart';
import 'package:homework2_191532/screens/signup_screen.dart';
import 'package:homework2_191532/services/services.dart';

import 'home_page_screen.dart';

class LoginScreen extends StatefulWidget{
  static String id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static const String _title = 'MyHealthyBody Login Page';
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  final _firestore= FirebaseFirestore.instance;
  bool isLoading = false;
  double calculatedCaloriesMaintainWeight = 0.0;
  double calculatedCaloriesWeightLoss = 0.0;
  bool isNewUser = false;
  MealPlan mealPlan = MealPlan(meals: [Meal(id: 0, title: '', readyInMinutes: 0)], calories: 0.0, carbs: 0.0, fat: 0.0, protein: 0.0);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getCaloriesFromFirestore() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;

        calculatedCaloriesMaintainWeight = data['calculatedCaloriesMaintainWeight'] as double;
        calculatedCaloriesWeightLoss = data['calculatedCaloriesWeightLoss'] as double;
        isNewUser = data['isNewUser'] as bool;
      }
    }
  }

  Future<void> _generateMealPlan(calculatedCaloriesMaintainWeight) async{
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
      body: 
      // (isLoading)
      //     ? const Center(
      //   child: SizedBox(
      //       width: 40,
      //       height: 40,
      //       child: CircularProgressIndicator(
      //         color: Color(0xff676FA3),
      //         strokeWidth: 3,
      //       )),
      // ) : 
      SingleChildScrollView(
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
                  offset: const Offset(0, -70),
                  child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black, fontSize: 50.0, fontWeight: FontWeight.bold)
                  ),
                )
              )
            ),
            Transform.translate(
              offset: const Offset(0, -80),
              child: Container(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (ctx) => SignUpScreen()));
                    },
                    child: const Text(
                      "Don't have account? Create new account.",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  )
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 0, bottom: 0
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email address',
                      hintText: 'Enter valid e-mail as lazar.todorov@test.com'),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Container(
                  child: TextButton(
                    onPressed: (){
                      //TODO FORGOT PASSWORD SCREEN GOES HERE
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  )
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        final user =
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          setState(() {
                            isLoading = false;
                          });

                          // getting calories for already pre-registered user
                          await _getCaloriesFromFirestore();

                          await _generateMealPlan(calculatedCaloriesMaintainWeight);
                          
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) => HomePageScreen(calculatedCaloriesMaintainWeight: calculatedCaloriesMaintainWeight, calculatedCaloriesWeightLoss: calculatedCaloriesWeightLoss, isNewUser: isNewUser, mealPlan: mealPlan), // Pass the value here
                            ),
                          );
                        }
                      } catch (e) {}
                      setState(() {
                        isLoading = false;
                      });
                    },
                  child: const Text(
                    'Login',
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