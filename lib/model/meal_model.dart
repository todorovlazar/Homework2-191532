
class Meal {
  final int id;
  final String title;
  final int readyInMinutes;
  
  Meal({required this.id, required this.title, required this.readyInMinutes});

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      title: map['title'],
      readyInMinutes: map['readyInMinutes']
      // imgURL: 'https://spoonacular.com/recipeImages/' + map['image'],
      );
  }
}