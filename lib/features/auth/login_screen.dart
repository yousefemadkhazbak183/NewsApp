import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/data/local_data/shared_preferences.dart';
import 'package:flutter_news_app/core/data/user_repository.dart';
import 'package:flutter_news_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter_news_app/features/auth/register_screen.dart';
import 'package:flutter_news_app/features/navigation/navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;

  Future<void> login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    final String? error = UserRepository().login(
      emailController.text,
      passwordController.text,
    );

    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }

    await PreferencesManager().setBool("is_logged", true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const NavigationScreen();
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
          image: DecorationImage(
            image: AssetImage('assets/images/back_ground.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/logo.png", height: AppSizes.h45),
                ),
                SizedBox(height: AppSizes.h40),
                Text(
                  'Welcome to Newts',
                  style: TextStyle(fontSize: AppSizes.sp20, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: AppSizes.h24),

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

                SizedBox(height: AppSizes.h24),
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
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: AppColor.primaryColor),
                  ),
                SizedBox(height: AppSizes.h24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        login();
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Sign In'),
                  ),
                ),
                SizedBox(height: AppSizes.h24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: TextStyle(fontSize: AppSizes.sp14),
                    ),
                    SizedBox(width: AppSizes.w8),
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
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: AppSizes.sp14,
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
