import 'package:recipe_app/src/core/models/user_model.dart';

class RecipeModel {
  final int id;
  final int userId;
  final int categoryId;
  final String title;
  final String steps;
  final String ingredients;
  final int totalTime;
  final int servings;
  final String image;
  final String? video;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String imageUrl;
  final String? videoUrl;
  final UserModel user;
    bool isFavorite;


  RecipeModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.steps,
    required this.ingredients,
    required this.totalTime,
    required this.servings,
    required this.image,
    this.video,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.imageUrl,
    this.videoUrl,
    required this.user,
        this.isFavorite = false,

  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      title: json['title'],
      steps: json['steps'],
      ingredients: json['ingredients'],
      totalTime: json['total_time'],
      servings: json['servings'],
      image: json['image'],
      video: json['video'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
      user: UserModel.fromJson(json['user']),
            isFavorite: json['isFavorite'] ?? false,

    );
  }


    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'steps': steps,
      // Add more fields as needed
    };
  }


}
