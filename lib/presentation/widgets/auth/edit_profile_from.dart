import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class EditProfileFrom extends StatefulWidget {
  const EditProfileFrom({super.key});

  @override
  State<EditProfileFrom> createState() => _EditProfileFromState();
}

class _EditProfileFromState extends State<EditProfileFrom> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? isTermsChecked = false;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),

                // Profile Picture
                IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      backgroundImage: AssetImage('assets/test_user.jpeg'),
                      radius: 90,
                    )),
                const SizedBox(height: 35),

                // Profile Name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 5),
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: authBloc.state is Authenticated
                      ? (authBloc.state as Authenticated).user.fullName
                      : 'Full Name',
                  cursorColor: Colors.white,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required Field';
                    if (value.trim().isEmpty) return 'Required Field';
                    if (value.length < 3) return '3 characters minimum';

                    return null;
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red[100]),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimary),
                    hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Profile Email

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 5),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: authBloc.state is Authenticated
                      ? (authBloc.state as Authenticated).user.email
                      : 'Full Name',
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required Field';
                    if (value.trim().isEmpty) return 'Required Field';
                    final emailRegExp = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegExp.hasMatch(value))
                      return 'Should be an email';
                    return null;
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red[100]),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimary),
                    hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Profile Phone
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 5),
                    child: Text(
                      'Phone',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: authBloc.state is Authenticated
                      ? (authBloc.state as Authenticated).user.phoneNumber
                      : 'Phone',
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Required Field';
                    if (value.trim().isEmpty) return 'Required Field';

                    return null;
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red[100]),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimary),
                    hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: BrandButton(
                      onPressed: () {
                        // Save the form
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
