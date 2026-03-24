import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ─────────────────────────────────────────────
// Data Model
// ─────────────────────────────────────────────
class Recipe {
  String name;
  String ingredients;
  String steps;
  String category;
  String time;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.time,
  });
}

// ─────────────────────────────────────────────
// In-memory data store (shared across screens)
// ─────────────────────────────────────────────
class RecipeStore {
  static final List<Recipe> recipes = [
    Recipe(
      name: "Veg Biryani",
      ingredients:
      "2 cups Basmati Rice\n1 cup Mixed Vegetables\n2 Onions\n2 Tomatoes\nBiryani Masala\nSalt\nOil",
      steps:
      "Wash and soak the rice for 20 minutes.\nHeat oil in a pan and fry sliced onions.\nAdd tomatoes and cook until soft.\nAdd vegetables and spices.\nAdd soaked rice and water.\nCook for 20 minutes until rice is done.",
      category: "Indian",
      time: "40 mins",
    ),
  ];
}

// ─────────────────────────────────────────────
// App
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const SplashScreen(),
    );
  }
}

// ─────────────────────────────────────────────
// 1. SplashScreen
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 2. HomeScreen
// ─────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/chefs-hat.png',
                height: 120,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.restaurant,
                  size: 100,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Rsodu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(height: 30),
              _HomeButton(
                icon: Icons.menu_book,
                label: "All Recipes",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AllRecipeScreen()),
                ),
              ),
              const SizedBox(height: 15),
              _HomeButton(
                icon: Icons.add,
                label: "Add Recipe",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddRecipeScreen()),
                ),
              ),
              const SizedBox(height: 15),
              _HomeButton(
                icon: Icons.category,
                label: "Categories",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable home button widget
class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _HomeButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepOrange,
        side: const BorderSide(color: Colors.deepOrange, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. CategoriesScreen
// ─────────────────────────────────────────────
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {"name": "Indian", "icon": Icons.rice_bowl},
    {"name": "Italian", "icon": Icons.local_pizza},
    {"name": "Chinese", "icon": Icons.ramen_dining},
    {"name": "Mexican", "icon": Icons.local_dining},
    {"name": "Desserts", "icon": Icons.cake},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: _categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final category = _categories[index];
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              // FIX: actually navigate to filtered recipe list
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllRecipeScreen(
                    filterCategory: category["name"] as String,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.deepOrange, width: 2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category["icon"] as IconData,
                      size: 50,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      category["name"] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
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
// 4. AddRecipeScreen
// ─────────────────────────────────────────────
class AddRecipeScreen extends StatefulWidget {
  // FIX: support editing an existing recipe
  final Recipe? existingRecipe;
  final int? recipeIndex;

  const AddRecipeScreen({super.key, this.existingRecipe, this.recipeIndex});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _ingredientsController;
  late final TextEditingController _stepsController;
  late final TextEditingController _timeController;

  String? _selectedCategory;

  static const List<String> _categories = [
    "Indian",
    "Italian",
    "Chinese",
    "Mexican",
    "Desserts",
  ];

  bool get _isEditing => widget.existingRecipe != null;

  @override
  void initState() {
    super.initState();
    // FIX: pre-fill fields when editing
    final r = widget.existingRecipe;
    _nameController = TextEditingController(text: r?.name ?? '');
    _ingredientsController = TextEditingController(text: r?.ingredients ?? '');
    _stepsController = TextEditingController(text: r?.steps ?? '');
    _timeController = TextEditingController(text: r?.time ?? '');
    _selectedCategory = r?.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final recipe = Recipe(
      name: _nameController.text.trim(),
      ingredients: _ingredientsController.text.trim(),
      steps: _stepsController.text.trim(),
      category: _selectedCategory!,
      time: _timeController.text.trim(),
    );

    if (_isEditing && widget.recipeIndex != null) {
      // FIX: update existing recipe in store
      RecipeStore.recipes[widget.recipeIndex!] = recipe;
    } else {
      // FIX: actually save new recipe to store
      RecipeStore.recipes.add(recipe);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing ? "Recipe Updated!" : "Recipe Added Successfully!",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
    );

    Navigator.pop(context, true); // return true to signal a change
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.deepOrange),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.deepOrange, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _isEditing ? "Edit Recipe" : "Add Recipe",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
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
                controller: _nameController,
                decoration: _inputDecoration("Recipe Name"),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Please enter recipe name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                decoration: _inputDecoration("Ingredients (one per line)"),
                maxLines: 4,
                validator: (v) =>
                (v == null || v.isEmpty) ? "Please enter ingredients" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stepsController,
                decoration: _inputDecoration("Steps (one per line)"),
                maxLines: 4,
                validator: (v) =>
                (v == null || v.isEmpty) ? "Please enter steps" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                dropdownColor: Colors.white,
                decoration: _inputDecoration("Select Category"),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCategory = v),
                validator: (v) =>
                v == null ? "Please select a category" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: _inputDecoration("Required Time (e.g., 30 mins)"),
                validator: (v) =>
                (v == null || v.isEmpty) ? "Please enter required time" : null,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  _isEditing ? "Update Recipe" : "Save Recipe",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 5. AllRecipeScreen  (FIX: fully implemented)
// ─────────────────────────────────────────────
class AllRecipeScreen extends StatefulWidget {
  final String? filterCategory;

  const AllRecipeScreen({super.key, this.filterCategory});

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen> {
  List<Recipe> get _recipes {
    if (widget.filterCategory == null) return RecipeStore.recipes;
    return RecipeStore.recipes
        .where((r) => r.category == widget.filterCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final title =
    widget.filterCategory != null ? widget.filterCategory! : "All Recipes";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      // FIX: FAB to add a recipe directly from this screen
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        onPressed: () async {
          final changed = await Navigator.push<bool>(
            context,
            MaterialPageRoute(builder: (_) => const AddRecipeScreen()),
          );
          if (changed == true) setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: _recipes.isEmpty
          ? const Center(
        child: Text(
          "No recipes yet. Tap + to add one!",
          style: TextStyle(color: Colors.deepOrange, fontSize: 16),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _recipes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final recipe = _recipes[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.deepOrange, width: 1),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.restaurant, color: Colors.white),
              ),
              title: Text(
                recipe.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                  "${recipe.category}  •  ${recipe.time}"),
              trailing: const Icon(Icons.chevron_right,
                  color: Colors.deepOrange),
              onTap: () async {
                // FIX: find the actual index in the master list
                final masterIndex =
                RecipeStore.recipes.indexOf(recipe);
                final changed = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailPage(
                      recipe: recipe,
                      recipeIndex: masterIndex,
                    ),
                  ),
                );
                if (changed == true) setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 6. RecipeDetailPage  (FIX: dynamic data, working edit/delete)
// ─────────────────────────────────────────────
class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  final int recipeIndex;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
    required this.recipeIndex,
  });

  @override
  Widget build(BuildContext context) {
    final ingredients =
    recipe.ingredients.split('\n').where((s) => s.isNotEmpty).toList();
    final steps =
    recipe.steps.split('\n').where((s) => s.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info chips
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.category,
                        size: 16, color: Colors.white),
                    label: Text(recipe.category,
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.deepOrange,
                  ),
                  Chip(
                    avatar: const Icon(Icons.timer,
                        size: 16, color: Colors.white),
                    label: Text(recipe.time,
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: Colors.deepOrange,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Ingredients
              const Text(
                "Ingredients",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...ingredients.map(
                    (item) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.check_circle,
                      color: Colors.deepOrange),
                  title: Text(item),
                ),
              ),

              const SizedBox(height: 16),

              // Steps
              const Text(
                "Preparation Steps",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...steps.asMap().entries.map(
                    (entry) => ListTile(
                  dense: true,
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    child: Text("${entry.key + 1}"),
                  ),
                  title: Text(entry.value),
                ),
              ),

              const SizedBox(height: 30),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // FIX: Edit navigates to AddRecipeScreen pre-filled
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final changed = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddRecipeScreen(
                            existingRecipe: recipe,
                            recipeIndex: recipeIndex,
                          ),
                        ),
                      );
                      if (changed == true && context.mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
                  ),

                  // FIX: Delete actually removes from store
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Delete Recipe"),
                          content: Text(
                              "Are you sure you want to delete '${recipe.name}'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                RecipeStore.recipes.removeAt(recipeIndex);
                                Navigator.pop(context); // close dialog
                                Navigator.pop(context, true); // back to list
                              },
                              child: const Text("Delete",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
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