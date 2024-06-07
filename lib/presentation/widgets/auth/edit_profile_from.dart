import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_text_input.dart';

class EditProfileFrom extends StatefulWidget {
  const EditProfileFrom({super.key});

  @override
  State<EditProfileFrom> createState() => _EditProfileFromState();
}

class _EditProfileFromState extends State<EditProfileFrom> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isTermsChecked = false;
  bool isObscured = true;
  File? _newUserImage;
  String? _newUserName;
  String? _newUserEmail;
  String? _newUserPhone;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // Profile Picture
                Stack(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          setState(() {
                            _newUserImage = File(pickedFile.path);
                          });
                        }
                      },
                      icon: _newUserImage == null
                          ? InteractiveViewer(
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/default_user_image.png')
                                        as ImageProvider<Object>?,
                                radius: 90,
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_newUserImage!),
                              radius: 90,
                            ),
                    ),
                    if (_newUserImage != null)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _newUserImage = null;
                            });
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 35),

                // Profile Name
                const _CustomAlign(title: 'Name'),
                CustomTextInput(
                  initialValue: authBloc.state is Authenticated
                      ? (authBloc.state as Authenticated).user.fullName
                      : 'Full Name',
                  hintText: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required Field';
                    if (value.trim().isEmpty) return 'Required Field';
                    if (value.length < 3) return '3 characters minimum';

                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newUserName = value;
                      _formKey.currentState!.validate();
                    });
                  },
                ),

                const SizedBox(height: 25),

                // Profile Email
                const _CustomAlign(title: 'Email'),
                CustomTextInput(
                  initialValue: authBloc.state is Authenticated
                      ? (authBloc.state as Authenticated).user.email
                      : 'Email',
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required Field';
                    if (value.trim().isEmpty) return 'Required Field';
                    final emailRegExp = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Should be an email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newUserEmail = value;
                      _formKey.currentState!.validate();
                    });
                  },
                ),

                const SizedBox(height: 25),

                // Profile Phone
                const _CustomAlign(title: 'Phone'),
                CustomTextInput(
                  initialValue: authBloc.state is Authenticated
                      ? (authBloc.state as Authenticated).user.phoneNumber
                      : 'Phone',
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required Field';
                    if (value.trim().isEmpty) return 'Required Field';
                    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return 'You must have a valid phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newUserPhone = value;
                      _formKey.currentState!.validate();
                    });
                  },
                ),

                const SizedBox(height: 25),

                // Save Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: BrandButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save the form
                          print(
                              'Image: $_newUserImage, Name: $_newUserName, Email: $_newUserEmail, Phone: $_newUserPhone');
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomAlign extends StatelessWidget {
  final String title;
  const _CustomAlign({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 0, 5),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}