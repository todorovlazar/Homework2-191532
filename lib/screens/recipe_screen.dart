
import 'package:flutter/material.dart';
import 'package:homework2_191532/model/recipe_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeScreen extends StatefulWidget {
  final String mealType;
  final Recipe recipe;

  RecipeScreen({required this.mealType, required this.recipe});
  
  @override
  _RecipeScreenState createState() => _RecipeScreenState();

}

class _RecipeScreenState extends State<RecipeScreen> {

  Recipe recipe = Recipe(spoonacularSourceUrl: '', title: '', image: '', servings: 0, readyInMinutes: 0, pricePerServing: 0.0);
  String mealType = '';

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
    mealType = widget.mealType;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Recipe Image
  //         Image.network(
  //           recipe.image,
  //           width: 200, // Adjust the width as needed
  //           height: 150, // Adjust the height as needed
  //           fit: BoxFit.cover,
  //         ),
  //         SizedBox(height: 16),

  //         // Recipe Title
  //         Text(
  //           recipe.title,
  //           style: TextStyle(
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 8),

  //         // Recipe Details
  //         Text(
  //           'Servings: ${recipe.servings}',
  //           style: TextStyle(
  //             fontSize: 16,
  //           ),
  //         ),
  //         Text(
  //           'Ready in Minutes: ${recipe.readyInMinutes}',
  //           style: TextStyle(
  //             fontSize: 16,
  //           ),
  //         ),
  //         Text(
  //           'Health Score: ${recipe.healthScore}',
  //           style: TextStyle(
  //             fontSize: 16,
  //           ),
  //         ),
  //         Text(
  //           'Price per Serving: \$${recipe.pricePerServing.toStringAsFixed(2)}',
  //           style: TextStyle(
  //             fontSize: 16,
  //           ),
  //         ),
  //         SizedBox(height: 16),

  //         // Ingredients
  //         Text(
  //           'Ingredients:',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: recipe.extendedIngredients.map((ingredient) {
  //             return Text(
  //               '${ingredient.original}',
  //               style: TextStyle(
  //                 fontSize: 16,
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealType),
      ),
      body: WebView(
        initialUrl: widget.recipe.spoonacularSourceUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}