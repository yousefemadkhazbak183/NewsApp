import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/app_sizes.dart';
import 'package:flutter_news_app/core/data/local_data/shared_preferences.dart';
import 'package:flutter_news_app/features/profile/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile'), centerTitle: true),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.pw24, horizontal: AppSizes.pw16),
            child: Consumer<ProfileController>(
              builder: (BuildContext context, ProfileController controller, Widget? child) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundImage: controller.selectedImage == null
                              ? const AssetImage("assets/images/logo.png")
                              : FileImage(File(controller.selectedImage!.path)),
                          radius: AppSizes.r60,
                          backgroundColor: Colors.transparent,
                        ),
                        GestureDetector(
                          onTap: () {
                            showImageSourceDialog(context);
                          },
                          child: Container(
                            height: AppSizes.h45,
                            width: AppSizes.w45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppSizes.r60),
                            ),
                            child: const Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h8),
                    Text(
                      PreferencesManager().getString("user_email") ?? "",
                      style: TextStyle(fontSize: AppSizes.sp16, color: Colors.black),
                    ),
                    SizedBox(height: AppSizes.h16),
                    const ListTile(title: Text("Person"), contentPadding: EdgeInsets.zero, leading: Icon(Icons.person)),
                    const ListTile(
                      title: Text("Language"),
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.language),
                    ),
                    const ListTile(
                      title: Text("Country"),
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.location_on),
                    ),
                    const ListTile(
                      title: Text("Terms & Conditions"),
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.info),
                    ),
                    const ListTile(title: Text("Logout"), contentPadding: EdgeInsets.zero, leading: Icon(Icons.logout)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void showImageSourceDialog(BuildContext context) {
    final controller = context.read<ProfileController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Select Image Source", style: TextStyle(fontSize: AppSizes.sp16)),

          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
              padding: EdgeInsets.all(AppSizes.pw16),
              child: Row(
                children: [
                  const Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.pw8),
                  const Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
              padding: EdgeInsets.all(AppSizes.pw16),
              child: Row(
                children: [
                  const Icon(Icons.photo_library),
                  SizedBox(width: AppSizes.pw8),
                  const Text("Galley"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
