import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

// --- 1. SplashScreen ---
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

  void _navigateToHome() async {
    // Wait for 3 seconds before switching screens
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
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

// --- 2. HomeScreen ---
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
              // Safe image loading with a fallback icon
              Image.asset(
                'assets/images/chefs-hat.png',
                height: 120,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.restaurant, size: 100, color: Colors.deepOrange),
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

              // All Recipes Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllRecipeScreen()),
                  );
                },
                icon: const Icon(Icons.menu_book),
                label: const Text("All Recipes", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange,
                  side: const BorderSide(color: Colors.deepOrange, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              const SizedBox(height: 15),

              // Add Recipe Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddRecipeScreen()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Recipe", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange,
                  side: const BorderSide(color: Colors.deepOrange, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              const SizedBox(height: 15),

              // Categories Button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                  );
                },
                icon: const Icon(Icons.category),
                label: const Text("Categories", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange,
                  side: const BorderSide(color: Colors.deepOrange, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 3. CategoriesScreen ---
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
        backgroundColor: Colors.deepOrange,
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
            return InkWell(
              onTap: () {
                // Future: Navigate to a specific category page
                print("Selected: ${categories[index]["name"]}");
              },
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
                      categories[index]["icon"],
                      size: 50,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      categories[index]["name"],
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

// --- 4. Add Recipe Screen ---
class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});
  @override
  State<AddRecipeScreen> createState() => AddRecipeScreenState();
}

class AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nametxt = TextEditingController();
  final TextEditingController ingredents = TextEditingController();
  final TextEditingController steps = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();

  String? selectedCategory;
  late final List<String> categories = [
    "Indian",
    "Italian",
    "Chinese",
    "Mexican",
    "Desserts"
  ];

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select category")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Recipe Added Successfully!", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepOrange,
        ),
      );

      Navigator.pop(context);
    }
  }

  // Helper method for styling text fields based on Rsodu theme
  InputDecoration _buildInputDecoration(String label) {
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
        title: const Text("Add Recipes", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nametxt,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Recipe Name"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter recipe name" : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: ingredents,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Recipe Ingredients"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter ingredients" : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: steps,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Steps"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter steps" : null,
              ),
              const SizedBox(height: 19),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Select Category"),
                items: categories
                    .map(
                      (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ),
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) =>
                value == null ? "Please select category" : null,
              ),
              const SizedBox(height: 19),
              TextFormField(
                controller: timecontroller,
                style: const TextStyle(color: Colors.black),
                decoration: _buildInputDecoration("Required Time (e.g., 30 mins)"),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter required time" : null,
              ),
              const SizedBox(height: 25),

              // Submit Button
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Save Recipe",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 5. All Recipe Screen (Pending) ---
class AllRecipeScreen extends StatelessWidget {
  const AllRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('All Recipes'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: const Center(
          child: Text(
              'All Recipes Screen (Pending)',
              style: TextStyle(color: Colors.deepOrange, fontSize: 16)
          )
      ),
    );
  }
}