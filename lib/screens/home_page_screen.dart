import 'package:flutter/material.dart';
import 'package:homework2_191532/custom_ui/meal_details.dart';
import 'package:homework2_191532/custom_ui/total_nutrients.dart';
import 'package:homework2_191532/model/meal_model.dart';
import 'package:homework2_191532/model/meal_plan_model.dart';
import 'package:homework2_191532/screens/camera_screen.dart';
import 'package:homework2_191532/screens/restaurant_map_screen.dart';
import 'package:homework2_191532/services/services.dart';
import 'package:camera/camera.dart';

class HomePageScreen extends StatefulWidget {
  static String id = '/home';

  final double calculatedCaloriesMaintainWeight;
  final double calculatedCaloriesWeightLoss;
  final bool isNewUser;
  final MealPlan mealPlan;

  HomePageScreen({required this.calculatedCaloriesWeightLoss, required this.calculatedCaloriesMaintainWeight, required this.isNewUser, required this.mealPlan});

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePageScreen> {
  double calculatedCaloriesMaintainWeight = 0.0;
  double calculatedCaloriesWeightLoss = 0.0;
  bool isNewUser = false;
  bool sortAscending = true;
  // needed to initialize like these due to Late exceptions that i've been getting
  MealPlan mealPlan = new MealPlan(meals: [new Meal(id: 0, title: '', readyInMinutes: 0)], calories: 0.0, carbs: 0.0, fat: 0.0, protein: 0.0);


  @override
  void initState() {
    super.initState();
    
    calculatedCaloriesMaintainWeight = widget.calculatedCaloriesMaintainWeight;
    calculatedCaloriesWeightLoss = widget.calculatedCaloriesWeightLoss; 
    isNewUser = widget.isNewUser;
    mealPlan = widget.mealPlan;

  }

  void _openCamera() async {
    // Initialize the camera.
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(camera: firstCamera),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TotalNutrients totalNutrients = TotalNutrients(mealPlan);
    MealDetails mealDetails = MealDetails();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(children: [
               Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Container(
                    child: Transform.translate(
                      offset: const Offset(0, 0),
                      child: Image.asset('assets/images/MyHealthyBodyLogo.png'),
                    ),
                  ),
                ),
               ),
              ),
              Transform.translate(
                offset: const Offset(20, 0),
                child: IconButton(
                icon: Icon(Icons.restaurant, size: 40, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RestaurantMapScreen()),
                  );
                },
               )
              ),
              Transform.translate(
                offset: const Offset(30, 0),
                child: IconButton(
                icon: Icon(Icons.add_a_photo, size: 40, color: Colors.blue),
                onPressed: () {
                  _openCamera();
                },
               )
              ),
             ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Transform.translate(
                  offset: const Offset(0, -70),
                  child: const Text(
                    'Calculated calories',
                    style: TextStyle(color: Colors.black, fontSize: 38.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Transform.translate(
                  offset: const Offset(0, -70),
                  child: const Text(
                    'Maintain weight',
                    style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 40.0),
                Transform.translate(
                  offset: const Offset(0, -70),
                  child: const Text(
                    'Weight loss',
                    style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(
              children: [
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 140,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      color: Colors.blue,
                      child: Text(
                        '${calculatedCaloriesMaintainWeight.toInt()}cal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40.0),
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 140,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      color: Colors.blue,
                      child: Text(
                        '${calculatedCaloriesWeightLoss.toInt()}cal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Transform.translate(
                  offset: const Offset(0, -70),
                  child: const Text(
                    'Recipes',
                    style: TextStyle(color: Colors.black, fontSize: 38.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                margin: const EdgeInsets.only(top: 0.0),
                child: Transform.translate(
                  offset: const Offset(0, -80),
                  child: const Text(
                    'Get an idea what to eat today!',
                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(-100, -70),
              child: Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      // sort the meals based on their time needed for preparation
                      if (sortAscending) {
                        mealPlan.meals.sort((a, b) => a.readyInMinutes.compareTo(b.readyInMinutes));
                      } else {
                        mealPlan.meals.sort((a, b) => b.readyInMinutes.compareTo(a.readyInMinutes));
                      }
                      sortAscending = !sortAscending;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.sort,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Order by \ntime preparation',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -100),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1 + mealPlan.meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return totalNutrients.totalNutrientsOfMealCustomElement();
                    }

                    Meal meal = mealPlan.meals[index - 1];
                    return mealDetails.buildMealCard(context, meal, index - 1);
              },
             ),
            )
          ],
        ),
      ),
    );
}
}