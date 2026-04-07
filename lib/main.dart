import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ─────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────
class Recipe {
  int? id;
  String name;
  String ingredients;
  String steps;
  String category;
  String time;
  String image;
  bool isFavorite;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.time,
    this.image = 'assets/images/logo.png',
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      'category': category,
      'time': time,
      'image': image,
    };
  }
}

// ─────────────────────────────────────────────
// SHARED DATA STORE
// ─────────────────────────────────────────────
class RecipeStore {
  static final List<Recipe> recipes = [
    Recipe(
      name: "Veg Biryani",
      category: "Indian",
      time: "40 mins",
      ingredients: "Rice, Veggies, Spices",
      steps: "1. Boil rice\n2. Sauté veggies\n3. Layer and steam.",
    ),
    Recipe(
      name: "Margherita Pizza",
      category: "Italian",
      time: "25 mins",
      ingredients: "Dough, Tomato Sauce, Mozzarella",
      steps: "1. Roll dough\n2. Add toppings\n3. Bake at 220°C.",
    ),
    Recipe(
      name: "Paneer Butter Masala",
      category: "Indian",
      time: "30 mins",
      ingredients: "Paneer, Butter, Tomato, Spices",
      steps: "1. Make tomato gravy\n2. Add paneer\n3. Simmer.",
    ),
    Recipe(
      name: "Veg Noodles",
      category: "Chinese",
      time: "25 mins",
      ingredients: "Noodles, Veggies, Soy Sauce",
      steps: "1. Boil noodles\n2. Stir fry veggies\n3. Mix together.",
    ),
    Recipe(
      name: "Chocolate Cake",
      category: "Desserts",
      time: "60 mins",
      ingredients: "Flour, Cocoa, Sugar, Eggs, Butter",
      steps: "1. Mix batter\n2. Bake at 180°C\n3. Cool and frost.",
    ),
  ];
}

// ─────────────────────────────────────────────
// MAIN APP
// ─────────────────────────────────────────────
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rsodu',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      // PRAC-5: Named Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/add': (context) => const AddRecipeScreen(),
        '/list': (context) => const AllRecipeScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-1: SPLASH SCREEN
// ─────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/chefs-hat.png',
              height: 120,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.restaurant_menu,
                size: 100,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Rsodu',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-2: HOME SCREEN (3 Buttons)
// ─────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Rsodu'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/chefs-hat.png',
                height: 130,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.restaurant,
                  size: 100,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Rsodu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 40),
              _HomeButton(
                icon: Icons.menu_book,
                label: "All Recipes",
                onPressed: () => Navigator.pushNamed(context, '/list'),
              ),
              const SizedBox(height: 15),
              _HomeButton(
                icon: Icons.add_circle_outline,
                label: "Add Recipe",
                onPressed: () => Navigator.pushNamed(context, '/add'),
              ),
              const SizedBox(height: 15),
              _HomeButton(
                icon: Icons.category,
                label: "Categories",
                onPressed: () => Navigator.pushNamed(context, '/categories'),
              ),
              const SizedBox(height: 15),
              _HomeButton(
                icon: Icons.favorite,
                label: "Favorites",
                onPressed: () => Navigator.pushNamed(context, '/favorites'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-3: CATEGORIES SCREEN (Grid Layout)
// ─────────────────────────────────────────────
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"name": "Indian", "icon": Icons.rice_bowl},
      {"name": "Italian", "icon": Icons.local_pizza},
      {"name": "Chinese", "icon": Icons.ramen_dining},
      {"name": "Mexican", "icon": Icons.local_dining},
      {"name": "Desserts", "icon": Icons.cake},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryRecipesScreen(
                      categoryName: categories[index]["name"],
                      categoryIcon: categories[index]["icon"],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categories[index]["icon"], size: 50, color: Colors.orange),
                    const SizedBox(height: 10),
                    Text(
                      categories[index]["name"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CATEGORY RECIPES SCREEN (Filtered List)
// ─────────────────────────────────────────────
class CategoryRecipesScreen extends StatelessWidget {
  final String categoryName;
  final IconData categoryIcon;

  const CategoryRecipesScreen({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = RecipeStore.recipes
        .where((r) => r.category.toLowerCase() == categoryName.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(categoryIcon, color: Colors.white),
            const SizedBox(width: 8),
            Text(categoryName),
          ],
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: filtered.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(categoryIcon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              "No recipes in $categoryName yet!",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Add a Recipe"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, '/add'),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final recipe = filtered[index];
          return RecipeCard(
            title: recipe.name,
            category: "${recipe.category} • ${recipe.time}",
            image: recipe.image,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailPage(
                    recipe: recipe,
                    recipeIndex: RecipeStore.recipes.indexOf(recipe),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-4: ADD RECIPE SCREEN (Form + Validation)
// ─────────────────────────────────────────────
class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _ingredientsCtrl = TextEditingController();
  final TextEditingController _stepsCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();

  String? selectedCategory;
  final List<String> categories = [
    "Indian", "Italian", "Chinese", "Mexican", "Desserts"
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      RecipeStore.recipes.add(Recipe(
        name: _nameCtrl.text,
        ingredients: _ingredientsCtrl.text,
        steps: _stepsCtrl.text,
        category: selectedCategory!,
        time: _timeCtrl.text,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Recipe Added Successfully!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Recipe Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Please enter recipe name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsCtrl,
                decoration: const InputDecoration(
                  labelText: "Ingredients",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                value!.isEmpty ? "Please enter ingredients" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stepsCtrl,
                decoration: const InputDecoration(
                  labelText: "Steps",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) =>
                value!.isEmpty ? "Please enter steps" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Select Category",
                  border: OutlineInputBorder(),
                ),
                items: categories
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() => selectedCategory = value),
                validator: (value) =>
                value == null ? "Please select a category" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeCtrl,
                decoration: const InputDecoration(
                  labelText: "Time Required (e.g. 30 mins)",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Please enter time required" : null,
              ),
              const SizedBox(height: 16),
              // Optional image upload placeholder
              OutlinedButton.icon(
                icon: const Icon(Icons.image, color: Colors.orange),
                label: const Text("Upload Image (Optional)",
                    style: TextStyle(color: Colors.orange)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            "Image picker requires image_picker package")),
                  );
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Save Recipe", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-6 + PRAC-12: ALL RECIPES WITH SEARCH
// ─────────────────────────────────────────────
class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({super.key});

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen> {
  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = RecipeStore.recipes;
  }

  void _filterSearch(String query) {
    final results = RecipeStore.recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredRecipes = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Recipes"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // PRAC-12: Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search Recipes",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _filterSearch,
            ),
          ),
          // PRAC-6: Recipe List
          Expanded(
            child: filteredRecipes.isEmpty
                ? const Center(child: Text("No Recipes Found"))
                : ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                // PRAC-8: RecipeCard widget reused
                return RecipeCard(
                  title: recipe.name,
                  category: "${recipe.category} • ${recipe.time}",
                  image: recipe.image,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(
                          recipe: recipe,
                          recipeIndex:
                          RecipeStore.recipes.indexOf(recipe),
                        ),
                      ),
                    );
                    setState(() {
                      filteredRecipes = RecipeStore.recipes;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-7: RECIPE DETAIL PAGE (Edit + Delete)
// ─────────────────────────────────────────────
class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  final int recipeIndex;

  const RecipeDetailPage(
      {super.key, required this.recipe, required this.recipeIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ingredients",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...recipe.ingredients.split(',').map((item) => ListTile(
                leading:
                const Icon(Icons.check_circle, color: Colors.orange),
                title: Text(item.trim()),
              )),
              const SizedBox(height: 20),
              const Text("Preparation Steps",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...recipe.steps.split('\n').asMap().entries.map((entry) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text("${entry.key + 1}",
                        style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(entry.value),
                );
              }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditRecipeScreen(
                              recipe: recipe, recipeIndex: recipeIndex),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      RecipeStore.recipes.removeAt(recipeIndex);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Recipe Deleted")),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-10: EDIT RECIPE SCREEN
// ─────────────────────────────────────────────
class EditRecipeScreen extends StatefulWidget {
  final Recipe recipe;
  final int recipeIndex;

  const EditRecipeScreen(
      {super.key, required this.recipe, required this.recipeIndex});

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController ingredientsCtrl;
  late TextEditingController stepsCtrl;
  late TextEditingController timeCtrl;

  String? selectedCategory;
  final List<String> categories = [
    "Indian", "Italian", "Chinese", "Mexican", "Desserts"
  ];

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.recipe.name);
    ingredientsCtrl = TextEditingController(text: widget.recipe.ingredients);
    stepsCtrl = TextEditingController(text: widget.recipe.steps);
    timeCtrl = TextEditingController(text: widget.recipe.time);
    selectedCategory = categories.contains(widget.recipe.category)
        ? widget.recipe.category
        : null;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    ingredientsCtrl.dispose();
    stepsCtrl.dispose();
    timeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Recipe"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                      labelText: "Recipe Name",
                      border: OutlineInputBorder()),
                  validator: (v) => v!.isEmpty ? "Enter recipe name" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: ingredientsCtrl,
                  decoration: const InputDecoration(
                      labelText: "Ingredients", border: OutlineInputBorder()),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: stepsCtrl,
                  decoration: const InputDecoration(
                      labelText: "Steps", border: OutlineInputBorder()),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                      labelText: "Category", border: OutlineInputBorder()),
                  items: categories
                      .map((c) =>
                      DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedCategory = v),
                  validator: (v) =>
                  v == null ? "Please select a category" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: timeCtrl,
                  decoration: const InputDecoration(
                      labelText: "Time Required",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updated = RecipeStore.recipes[widget.recipeIndex];
                      updated.name = nameCtrl.text;
                      updated.ingredients = ingredientsCtrl.text;
                      updated.steps = stepsCtrl.text;
                      updated.category = selectedCategory!;
                      updated.time = timeCtrl.text;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Recipe Updated!")),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update Recipe",
                      style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-13: FAVORITES SCREEN
// ─────────────────────────────────────────────
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favorites =
    RecipeStore.recipes.where((r) => r.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: favorites.isEmpty
          ? const Center(
          child: Text("No favorites yet! Tap ♥ on a recipe."))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final recipe = favorites[index];
          return RecipeCard(
            title: recipe.name,
            category: "${recipe.category} • ${recipe.time}",
            image: recipe.image,
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PRAC-8: RECIPE CARD WIDGET (Reusable)
// ─────────────────────────────────────────────
class RecipeCard extends StatefulWidget {
  final String title;
  final String category;
  final String image;
  final VoidCallback? onTap;

  const RecipeCard({
    required this.title,
    required this.category,
    required this.image,
    this.onTap,
    super.key,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  Recipe? _recipe;

  @override
  void initState() {
    super.initState();
    try {
      _recipe = RecipeStore.recipes.firstWhere((r) => r.name == widget.title);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            // LEFT THUMBNAIL IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                widget.image,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 90,
                  width: 90,
                  color: Colors.orange.shade100,
                  child: const Icon(Icons.fastfood, size: 40, color: Colors.orange),
                ),
              ),
            ),
            // RECIPE INFO
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.category,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            // FAVORITE ICON
            if (_recipe != null)
              IconButton(
                icon: Icon(
                  _recipe!.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _recipe!.isFavorite = !_recipe!.isFavorite;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HOME BUTTON WIDGET
// ─────────────────────────────────────────────
class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _HomeButton(
      {required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.orange),
      label: Text(label, style: const TextStyle(color: Colors.orange)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.orange, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
        elevation: 0,
      ),
    );
  }
}