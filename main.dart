import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RecipeFinderApp());
}

class RecipeFinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Finder',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => RecipeSearchScreen(),
      },
    );
  }
}

//login screen
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('Failed to sign in. Error: $error');
      // Handle error and show appropriate UI
    }
  }

  void goToRegisterScreen() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: signIn,
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: goToRegisterScreen,
              child: const Text('Don\'t have an account? Register'),
            )
          ],
        ),
      ),
    );
  }
}

//register screen
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? registrationError;

  Future<void> register() async {
    try {
      setState(() {
        emailError = null;
        passwordError = null;
        registrationError = null;
      });

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty) {
        setState(() {
          emailError = 'Email is required';
        });
        return;
      }

      if (!isValidEmail(email)) {
        setState(() {
          emailError = 'Invalid email format';
        });
        return;
      }

      if (password.isEmpty) {
        setState(() {
          passwordError = 'Password is required';
        });
        return;
      }

      if (password.length < 6) {
        setState(() {
          passwordError = 'Password should be at least 6 characters';
        });
        return;
      }

      // Rest of the registration logic

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('Failed to register. Error: $error');
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          setState(() {
            registrationError =
                'The email address is already in use by another account.';
          });
        } else {
          setState(() {
            registrationError =
                'An error occurred while registering. Please try again.';
          });
        }
      } else {
        setState(() {
          registrationError =
              'An error occurred while registering. Please try again.';
        });
      }
    }
  }

  bool isValidEmail(String email) {
    // Add your email validation logic here
    // For simplicity, this example checks if the email contains an @ symbol
    return email.contains('@');
  }

  void goToLoginScreen() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            if (emailError != null)
              Text(
                emailError!,
                style: TextStyle(color: Colors.red),
              ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            if (passwordError != null)
              Text(
                passwordError!,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: register,
              child: const Text('Register'),
            ),
            if (registrationError != null)
              Text(
                registrationError!,
                style: TextStyle(color: Colors.red),
              ),
            TextButton(
              onPressed: goToLoginScreen,
              child: const Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

//class for recipe search screen
class RecipeSearchScreen extends StatefulWidget {
  @override
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  List<dynamic> recipes = [];
  TextEditingController searchController = TextEditingController();

  Future<void> fetchRecipes(String query) async {
    final url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final meals = data['meals'];
      if (meals != null) {
        setState(() {
          recipes = meals;
        });
      } else {
        setState(() {
          recipes = [];
        });
      }
    } else {
      setState(() {
        recipes = [];
      });
      print('Failed to fetch recipes. Error: ${response.statusCode}');
    }
  }

  void viewRecipeDetails(dynamic recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsScreen(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search Recipes',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              fetchRecipes(searchController.text);
            },
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  leading: Image.network(
                    recipe['strMealThumb'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(recipe['strMeal']),
                  onTap: () => viewRecipeDetails(recipe),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//for recipe details screen
class RecipeDetailsScreen extends StatelessWidget {
  final dynamic recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> ingredients = [];
    List<String> measures = [];

    // Extract ingredients and measures from the recipe data
    for (int i = 1; i <= 20; i++) {
      if (recipe['strIngredient$i'] != null &&
          recipe['strIngredient$i'] != '') {
        ingredients.add(recipe['strIngredient$i']);
        measures.add(recipe['strMeasure$i']);
      } else {
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['strMeal']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe['strMealThumb'],
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return Text(
                        '${measures[index]} ${ingredients[index]}',
                        style: TextStyle(fontSize: 16),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    recipe['strInstructions'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
