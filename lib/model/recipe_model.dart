
class Recipe {
  final String spoonacularSourceUrl;
  final String title;
  final String image;
  final int servings;
  final int readyInMinutes;
  final double pricePerServing;

  Recipe({ required this.spoonacularSourceUrl, required this.title, required this.image, required this.servings, required this.readyInMinutes, required this.pricePerServing });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      spoonacularSourceUrl: map['spoonacularSourceUrl'],
      title: map['title'],
      image: map['image'],
      servings: map['servings'],
      readyInMinutes: map['readyInMinutes'],
      pricePerServing: map['pricePerServing'],
    );
  }
}