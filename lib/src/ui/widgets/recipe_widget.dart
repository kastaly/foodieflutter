import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/src/core/models/recipe_model.dart';
import 'package:recipe_app/src/core/models/user_model.dart';
import 'package:recipe_app/src/ui/screens/recipe/detail_recipe_screen.dart';
import 'package:recipe_app/src/ui/widgets/favorite_manager.dart';

class RecipeWidget extends StatefulWidget {
  final RecipeModel data;
  final UserModel user;

  const RecipeWidget({Key? key, required this.data, required this.user}) : super(key: key);

  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    // List<RecipeModel> favorites = await FavoriteManager.;
    setState(() {
      // _isFavorite = favorites.any((recipe) => recipe.id == widget.data.id);
    });
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        // FavoriteManager.removeFavorite(widget.data);
      } else {
        FavoriteManager.addFavorite(widget.data);
      }
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final likes = 2 + random.nextInt(7);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8,
      shadowColor: Colors.black54,
      child: InkWell(
        onTap: () {
          Get.to(() => RecipeDetailScreen(recipe: widget.data));
        },
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                    child: widget.data.imageUrl.isNotEmpty
                        ? Image.network(
                            widget.data.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Placeholder(fallbackHeight: 250.0);
                            },
                          )
                        : const Placeholder(fallbackHeight: 250.0),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.star : Icons.star_border,
                      color: _isFavorite ? Colors.yellow : Colors.white,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.profilePicture),
                    radius: 25,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      widget.data.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const Icon(Icons.favorite, size: 20.0, color: Colors.red),
                  const SizedBox(width: 6.0),
                  Text('$likes likes', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(width: 20.0),
                  const Icon(Icons.people, size: 20.0, color: Colors.grey),
                  const SizedBox(width: 6.0),
                  Text('${widget.data.servings} ', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => RecipeDetailScreen(recipe: widget.data));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  elevation: 5,
                ),
                child: const Text('Show Recipe', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
