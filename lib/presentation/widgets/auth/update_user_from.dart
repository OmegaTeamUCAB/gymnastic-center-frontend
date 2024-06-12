import 'dart:convert';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/update_user/update_user_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_text_input.dart';

class UpdateUserForm extends StatefulWidget {
  const UpdateUserForm({super.key});

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isTermsChecked = false;
  bool isObscured = true;
  File? _newUserImage;
  String? _newUserName;
  String? _newUserEmail;
  String? _newUserPhone;
  String? _base64Image;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    final updateUserBloc = GetIt.instance<UpdateUserBloc>();
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
                            _base64Image = transforImage(_newUserImage) as String?;
                          });
                        }else {
                          _base64Image = '';
                        }
                      },
                      icon: authBloc.state is Authenticated &&
                              (authBloc.state as Authenticated).user.image !=
                                  null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(
                                (authBloc.state as Authenticated).user.image!,
                              ),
                              radius: 60,
                            )
                          : CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceTint,
                              radius: 60,
                              child: Text(
                                  (authBloc.state as Authenticated)
                                      .user
                                      .fullName
                                      .split(' ')
                                      .map((l) => l[0])
                                      .take(2)
                                      .join(),
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold)),
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
                              _base64Image = '';
                            });
                          },
                        ),
                      ),
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                // if (_newUserImage != null)
                TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remove profile photo',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      _newUserImage = null;
                    });
                  },
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
                    _newUserName = value;
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
                     _newUserEmail = value;
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
                    print('Valor $value');
                    _newUserPhone = value;
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
                        print(_newUserEmail);
                        print(_newUserName);
                        print(_newUserPhone);
                        print(_base64Image);
                        updateUserBloc.add(UpdateUser(fullName:_newUserName!, phoneNumber:_newUserPhone!, email: _newUserEmail!, image: _base64Image!));
                      
                      if (_formKey.currentState!.validate()) {
                        // Save the form
                        }
                    },
                    text: 'Save',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> transforImage(File? image)async{
     Uint8List bytes = await _newUserImage!.readAsBytes();
     _base64Image = base64Encode(bytes);
     return _base64Image;
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
