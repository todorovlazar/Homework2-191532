
import 'package:flutter/material.dart';
import 'package:homework2_191532/model/meal_model.dart';
import 'package:homework2_191532/model/recipe_model.dart';
import 'package:homework2_191532/screens/recipe_screen.dart';
import 'package:homework2_191532/services/services.dart';

class MealDetails {

  MealDetails();

  buildMealCard(BuildContext context, Meal meal, int index) {
    
    String mealType = _mealType(index);

    return GestureDetector(
          onTap: () async {
            Recipe recipe = await ApiService.instance.fetchRecipe(meal.id.toString());
            Navigator.push(context, MaterialPageRoute(builder:  (_) => RecipeScreen(
                  mealType: mealType,
                  recipe: recipe,
              ))
            );
          },
          child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //First widget is a container that loads decoration image
            Container(
              height: 220,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  // image: DecorationImage(
                  //   image: NetworkImage(meal.imgURL),
                  //   fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue, offset: Offset(0, 2), blurRadius: 6)
                  ]),
            ),
            //Second widget is a Container that has 2 text widgets 
            Container(
              margin: EdgeInsets.all(60),
              padding: EdgeInsets.all(10),
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  Text(
                    //mealtype
                    mealType,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.blue
                    ),
                  ),
                  Text(
                    //mealtitle
                    meal.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ]
      ),
    );
  } 

  _mealType(int index) {
      switch (index) {
        case 0:
          return 'Breakfast';
        case 1:
          return 'Lunch';
        case 2:
          return 'Dinner';
        default:
          return 'Breakfast';
      }
    }
}