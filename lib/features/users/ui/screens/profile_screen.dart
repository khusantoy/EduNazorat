import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:millima/features/features.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  File? imageFile;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 300,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          "Profile Screen",
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: context.read<UserBloc>()..add(GetUserEvent()),
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserLoadedState) {
            nameEditingController.text = state.user.name;
            phoneEditingController.text = state.user.phone;
            emailEditingController.text = state.user.email ?? "";
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 218, 214, 214),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: state.user.photo == null
                                    ? imageFile == null
                                        ? Image.asset("assets/profile_logo.png",
                                            fit: BoxFit.cover)
                                        : Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                          )
                                    : imageFile != null
                                        ? Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            fit: BoxFit.cover,
                                            "${state.user.photo}",
                                          ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 5,
                                child: IconButton.filled(
                                  onPressed: openGallery,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: nameEditingController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Ismingizni kiriting";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: phoneEditingController,
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Telefon raqamingizni kiriting";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: emailEditingController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Emailingizni kiriting";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<UserBloc>().add(
                                  UpdateUserEvent(
                                    name: nameEditingController.text,
                                    phone: phoneEditingController.text,
                                    email: emailEditingController.text,
                                    phote: imageFile,
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Update"),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (state is UserErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text("User Topilmadi"),
            );
          }
        },
      ),
    );
  }
}
