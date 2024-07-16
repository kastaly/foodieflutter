import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/src/core/models/recipe_model.dart';
import 'package:recipe_app/src/core/models/user_model.dart';
import 'package:recipe_app/src/services/api_service.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<UserModel> _userModelFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _userModelFuture = _apiService.fetchUserDetails(widget.recipe.userId);
  }

  @override
  Widget build(BuildContext context) {
    List<String> ingredients = widget.recipe.ingredients.split(';');
    List<String> steps = widget.recipe.steps.split('\n');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(widget.recipe.image),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 20),
            // FutureBuilder<UserModel>(
            //   future: _userModelFuture,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return buildRecipeDetails(snapshot.data!, ingredients, steps);
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Failed to load user details'));
            //     }
            //     return Center(child: CircularProgressIndicator());
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildRecipeDetails(UserModel user, List<String> ingredients, List<String> steps) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.recipe.title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '${widget.recipe.totalTime} mins',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '${widget.recipe.servings} servings',
                    style: TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user.profilePicture),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'User ${user.name}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.red,
                    child: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      color: Colors.white,
                      height: 16,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "6 Likes",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Ingredients',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ingredients.map((ingredient) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_dining,
                      color: Colors.green,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      ingredient,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Divider(color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Steps',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Step ${index + 1}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    step,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
