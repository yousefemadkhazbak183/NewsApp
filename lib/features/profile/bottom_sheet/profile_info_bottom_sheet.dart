import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/data/user_repository.dart';

import 'package:flutter_news_app/core/model/user_model.dart';
import 'package:flutter_news_app/core/widgets/custom_text_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final UserModel user = UserRepository().getUser();
    emailController.text = user.email ?? "";
    userNameController.text = user.name ?? "";
  }

  void _saveUserData() async {
    if (_formKey.currentState?.validate() ?? false) {
      await UserRepository().updateUser(
        name: userNameController.text,
        email: emailController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.h12),
                Center(
                  child: Container(
                    height: AppSizes.h4,
                    width: AppSizes.w32,

                    decoration: BoxDecoration(
                      color: const Color(0xFF363636),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.h16),
                Text(
                  "Profile Info",
                  style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: AppSizes.h16),
                CustomTextFormField(
                  hintText: 'Youssef Emad',
                  controller: userNameController,
                  title: 'User Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your User Name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: AppSizes.h16),

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
                SizedBox(height: AppSizes.h40),
                ElevatedButton(
                  onPressed: () {
                    _saveUserData();
                  },
                  child: const Text("Save"),
                ),
                SizedBox(height: AppSizes.h16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
