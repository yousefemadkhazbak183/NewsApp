import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/data/local_data/shared_preferences.dart';
import 'package:flutter_news_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter_news_app/features/auth/register_screen.dart';
import 'package:flutter_news_app/features/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordEmail = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    final getEmail = PreferencesManager().getString("user_email");
    final getPassword = PreferencesManager().getString("user_password");

    if (getEmail == null || getPassword == null) {
      setState(() {
        errorMessage = "Not Found Account";
        isLoading = false;
      });
      return;
    }

    if (getEmail != emailController.text.trim() && getPassword != passwordEmail.text.trim()) {
      setState(() {
        errorMessage = "Not Found Account";
        isLoading = false;
      });
      return;
    }

    await PreferencesManager().setBool("is_logged", true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return HomeScreen();
        },
      ),
    );
    setState(() {
      errorMessage = null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/back_ground.png'), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/logo.png", height: 45)),
                const SizedBox(height: 40),
                const Text('Welcome to Newts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 24),

                CustomTextFormField(
                  hintText: 'usama@gmail.com',
                  controller: emailController,
                  title: 'Email',
                  validator: (value) {
                    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
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
                  controller: passwordEmail,
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
                if (errorMessage != null) Text(errorMessage!, style: const TextStyle(color: AppColor.primaryColor)),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        login();
                      }
                    },
                    child: isLoading ? const CircularProgressIndicator() : const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account?", style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Sign Up', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14)),
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
