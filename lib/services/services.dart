import 'dart:convert';
import 'dart:io';
import 'package:homework2_191532/model/meal_plan_model.dart';
import 'package:homework2_191532/model/recipe_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();
  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY ="922777c0412f4f808a014d74dc166747";
  
  Future<MealPlan> generateMealPlan({required int targetCalories, String? diet}) async {

    if (diet == 'None') diet = '';
    Map<String, String?> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };
    
    Uri uri = Uri.https(
      _baseURL,
      '/mealplanner/generate',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri, headers: headers);
      //decode the body of the response into a map
      Map<String, dynamic> data = json.decode(response.body);
      //convert the map into a MealPlan Object using the factory constructor,
      //MealPlan.fromMap
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }
  
  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/$id/information',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try{
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;
    }catch (err) {
      throw err.toString();
    }}
  }