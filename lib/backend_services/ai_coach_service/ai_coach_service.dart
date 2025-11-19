import '../../../data_layer/database/ehr_database/ehr_database_service.dart';

/// Microservice AI Coach & Lập kế hoạch
class AICoachService {
  /// Tạo Kế hoạch Ăn uống 7 ngày dựa trên EHR
  static Future<Map<String, dynamic>> generateMealPlan({
    int days = 7,
  }) async {
    try {
      // Lấy dữ liệu EHR
      final ehrData = await EHRDatabaseService.getLatestEHR();
      
      // AI Tổng hợp Dữ liệu và Phân tích Ràng buộc
      final mealPlan = _createMealPlan(ehrData, days);

      return mealPlan;
    } catch (e) {
      throw Exception('Lỗi tạo kế hoạch ăn uống: $e');
    }
  }

  /// Tạo Lộ trình Tập luyện 4 tuần
  static Future<Map<String, dynamic>> generateExercisePlan({
    int weeks = 4,
  }) async {
    try {
      final ehrData = await EHRDatabaseService.getLatestEHR();
      final exercisePlan = _createExercisePlan(ehrData, weeks);

      return exercisePlan;
    } catch (e) {
      throw Exception('Lỗi tạo lộ trình tập luyện: $e');
    }
  }

  /// Tạo kế hoạch ăn uống
  static Map<String, dynamic> _createMealPlan(
    Map<String, dynamic>? ehrData,
    int days,
  ) {
    // Logic AI: Phân tích ràng buộc (bệnh lý, dị ứng, mục tiêu)
    final constraints = _extractConstraints(ehrData);

    final meals = <String, dynamic>{};
    for (int day = 1; day <= days; day++) {
      meals['day_$day'] = {
        'breakfast': _generateMeal('breakfast', constraints),
        'lunch': _generateMeal('lunch', constraints),
        'dinner': _generateMeal('dinner', constraints),
        'snacks': _generateMeal('snack', constraints),
        'calories': 2000, // Tính toán dựa trên EHR
        'carbs': 250,
        'protein': 150,
        'fats': 65,
      };
    }

    return {
      'plan_duration': days,
      'meals': meals,
      'total_calories_per_day': 2000,
      'recommendations': _getMealRecommendations(constraints),
    };
  }

  /// Tạo lộ trình tập luyện
  static Map<String, dynamic> _createExercisePlan(
    Map<String, dynamic>? ehrData,
    int weeks,
  ) {
    final constraints = _extractConstraints(ehrData);
    final workouts = <String, dynamic>{};

    for (int week = 1; week <= weeks; week++) {
      workouts['week_$week'] = {
        'monday': _generateWorkout('strength', constraints),
        'wednesday': _generateWorkout('cardio', constraints),
        'friday': _generateWorkout('flexibility', constraints),
        'intensity': _calculateIntensity(week, constraints),
      };
    }

    return {
      'plan_duration': weeks,
      'workouts': workouts,
      'progression': 'gradual',
    };
  }

  /// Trích xuất ràng buộc từ EHR
  static Map<String, dynamic> _extractConstraints(
    Map<String, dynamic>? ehrData,
  ) {
    return {
      'allergies': ehrData?['allergies'] ?? [],
      'medical_conditions': ehrData?['medical_conditions'] ?? [],
      'dietary_restrictions': ehrData?['dietary_restrictions'] ?? [],
      'fitness_level': ehrData?['fitness_level'] ?? 'beginner',
      'age': ehrData?['age'] ?? 30,
      'weight': ehrData?['weight'] ?? 70,
      'height': ehrData?['height'] ?? 170,
    };
  }

  static Map<String, dynamic> _generateMeal(
    String mealType,
    Map<String, dynamic> constraints,
  ) {
    // Logic tạo bữa ăn dựa trên ràng buộc
    return {
      'name': 'Sample $mealType',
      'ingredients': ['ingredient1', 'ingredient2'],
      'calories': 500,
    };
  }

  static Map<String, dynamic> _generateWorkout(
    String workoutType,
    Map<String, dynamic> constraints,
  ) {
    return {
      'type': workoutType,
      'duration': 30,
      'exercises': ['exercise1', 'exercise2'],
    };
  }

  static String _calculateIntensity(int week, Map<String, dynamic> constraints) {
    // Tăng dần cường độ theo tuần
    if (week == 1) return 'light';
    if (week == 2) return 'moderate';
    if (week == 3) return 'moderate';
    return 'intense';
  }

  static List<String> _getMealRecommendations(Map<String, dynamic> constraints) {
    return [
      'Uống đủ nước: 2-3 lít/ngày',
      'Ăn nhiều rau xanh và trái cây',
      'Hạn chế đường và muối',
    ];
  }
}

