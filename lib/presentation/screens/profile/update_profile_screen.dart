import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/update_user/update_user_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/auth/update_user_form.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late UpdateUserBloc _updateUserBloc;
  late AuthBloc _authBloc;

  // late final updateUserBloc = GetIt.instance<UpdateUserBloc>();
  // late final authBloc = GetIt.instance<AuthBloc>();
  @override
  void initState() {
    super.initState();
    _updateUserBloc = GetIt.instance<UpdateUserBloc>();
    _authBloc = GetIt.instance<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: CustomAppBar(
            content: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    BrandBackButton(),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
      body: BlocProvider<UpdateUserBloc>.value(
        value: _updateUserBloc,
        child: BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              _authBloc.add(const VerifiedUser());
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  'Profile updated successfully',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(0xFF4F14A0),
                duration: Duration(seconds: 3),
              ));
            }
            if (state is UpdateUserFailed) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ));
            }
          },
          child: const UpdateUserForm(),
        ),
      ),
    );
  }
}
