import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/data/local_data/shared_preferences.dart';
import 'package:flutter_news_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter_news_app/features/navigation/navigation_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    final savedEmail = PreferencesManager().getString("user_email");
    PreferencesManager().getString("user_password");

    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = "User Already Register";
        isLoading = false;
      });
    } else {
      await PreferencesManager().setString("user_email", emailController.text);
      await PreferencesManager().setString(
        "user_password",
        passwordController.text,
      );
      await PreferencesManager().setBool("is_logged", true);
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const NavigationScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back_ground.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/logo.png", height: 45),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Welcome to Newts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),

                CustomTextFormField(
                  hintText: 'usama@gmail.com',
                  controller: emailController,
                  title: 'Email',
                  validator: (value) {
                    final emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                ),

                const SizedBox(height: 24),
                CustomTextFormField(
                  hintText: '*********',
                  controller: passwordController,
                  title: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  hintText: '*********',
                  controller: confirmPasswordController,
                  title: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsetsGeometry.symmetric(vertical: 8),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: AppColor.primaryColor),
                    ),
                  ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        register();
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
