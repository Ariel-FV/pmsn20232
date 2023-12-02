import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pmsn20232/models/ingredients_model.dart';
import 'package:pmsn20232/models/recipe_model.dart';

class ApiSpoonacular {
  //key1 = "d47776a698df48a39433875326a61e92";
  //key2 = "4ca65c42d70f4e7a8c3044e2caf942e7"

  final URL =
      "https://api.spoonacular.com/recipes/complexSearch?apiKey=2709f0681d2146e9b57327b2d35a107b&addRecipeInformation=true&number=100";

  Future<List<RecipeModel>?> getAllRecipes() async {
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var recipe = jsonDecode(response.body)['results'] as List;
      var listRecipe =
          recipe.map((recipes) => RecipeModel.fromMap(recipes)).toList();
      return listRecipe;
    }
    return null;
  }

  Future<List<ingredientsModel>> getIngredients(String id) async {
    final URL =
        'https://api.spoonacular.com/recipes/${id}/ingredientWidget.json?apiKey=2709f0681d2146e9b57327b2d35a107b';
    print(URL);
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var recipe = jsonDecode(response.body)['ingredients'] as List;
      var listRecipe = recipe
          .map((ingredients) => ingredientsModel.fromJson(ingredients))
          .toList();
      return listRecipe;
    } else {
      throw Exception('Hubo un error :()');
    }
  }
}
