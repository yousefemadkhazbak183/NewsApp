import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/colors/app_color.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/data/local_data/shared_preferences.dart';
import 'package:flutter_news_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter_news_app/features/home/home_screen.dart';

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
      await PreferencesManager().setString("user_password", passwordController.text);
      await PreferencesManager().setBool("is_logged", true);
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const HomeScreen();
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
          image: DecorationImage(image: AssetImage('assets/images/back_ground.png'), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pw16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset("assets/images/logo.png", height: AppSizes.h45)),
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
                SizedBox(height: AppSizes.h24),
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
                    padding: EdgeInsetsGeometry.symmetric(vertical: AppSizes.h8),
                    child: Text(errorMessage!, style: const TextStyle(color: AppColor.primaryColor)),
                  ),

                SizedBox(height: AppSizes.h24),
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.h48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        register();
                      }
                    },
                    child: isLoading ? const CircularProgressIndicator() : const Text('Sign Up'),
                  ),
                ),
                SizedBox(height: AppSizes.h24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account?", style: TextStyle(fontSize: AppSizes.sp14)),
                    SizedBox(width: AppSizes.w8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: AppSizes.sp14),
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
