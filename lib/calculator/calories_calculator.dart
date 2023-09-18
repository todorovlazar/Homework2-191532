class CalorieCalculator {
  double calculateCalories({required int age, required double height, required double weight, required String gender, required String activityLevel}) {
    // We use the Mifflin-St Jeor Equation for calculating calories needs
    double calories;

    // Calculate BMR based on gender
    calories = (gender == 'Male')
      ? (10 * weight) + (6.25 * height) - (5 * age) + 5
      : (10 * weight) + (6.25 * height) - (5 * age) - 161;
      
    // Apply activity level multiplier
    double activityMultiplier = getActivityMultiplier(activityLevel);
    calories *= activityMultiplier;

    // round to 2 decimal places
    calories = double.parse((calories).toStringAsFixed(2));

    return calories;
  }

  double getActivityMultiplier(String activityLevel) {
    // Defined activity level multipiers
    switch (activityLevel) {
      case 'Sedentary':
        return 1.2;
      case 'Lightly Active':
        return 1.375;
      case 'Moderately Active':
        return 1.55;
      case 'Very Active':
        return 1.725;
      case 'Super Active':
        return 1.9;
      default:
        return 1.0;
    }
  }
}
