import 'package:devoida_task_manager/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/service_locator.dart';
import '../../../../app/singlton.dart';
import '../../../../shared/common/widget/text_field_with_title_widget.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/manager_values.dart';
import '../../../../shared/resources/size_config.dart';

import '../../../../shared/common/widget/button_widget.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/routes_manager.dart';
import '../../../../shared/resources/styles_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  late AuthCubit _authCubit;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        _authCubit = AuthCubit();
        initAuthModule();
        return _authCubit;
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is CreateUserLoadingState) {
            _isLoading = true;
          }
          if (state is CreateUserSuccessState) {
            _isLoading = false;
            Singleton().user = state.userEntity;
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
          if (state is CreateUserErrorState) {
            _isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorManager.backgroundDark,
            body: Container(
              margin: getPadding(all: AppPadding.p24),
              child: _isLoading
                  ? const Center(
                      child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 2,
                          )),
                    )
                  : Center(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: AppPadding.p32,
                              ),
                              Text(
                                'Signup',
                                style: getMediumStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s32,
                                ),
                              ),
                              Text(
                                "Welcome to Divoida's Task Manager , Lets get you started!",
                                style: getHintStyle(
                                  color: ColorManager.dimWhite,
                                ),
                              ),
                              const SizedBox(
                                height: AppPadding.p48,
                              ),
                              TextFieldWithTitle(
                                fNameController: _nameController,
                                fieldName: "Full Name",
                                hintText: "Enter your name..",
                                inputType: TextInputType.name,
                              ),
                              TextFieldWithTitle(
                                fNameController: _emailController,
                                fieldName: "Email Address",
                                hintText: "Enter your email address..",
                                inputType: TextInputType.emailAddress,
                              ),
                              TextFieldWithTitle(fNameController: _passwordController, fieldName: "Password", inputType: TextInputType.visiblePassword, hintText: "Enter your password..", isSecure: true),
                              const SizedBox(
                                height: AppPadding.p48,
                              ),
                              CustomButton(
                                  onPress: () {
                                     Navigator.popAndPushNamed(context, Routes.homeRoute);
                                    // if (_formKey.currentState?.validate() == true) {
                                    //   _authCubit.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text, userName: _nameController.text);
                                    // }
                                  },
                                  labelText: "Signup"),
                              TextButton(
                                onPressed: () => Navigator.popAndPushNamed(context, Routes.loginRoute),
                                child: RichText(
                                  text: TextSpan(
                                    text: "You already have an account? ",
                                    style: getHintStyle(color: ColorManager.neutralGray700),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Login',
                                        style: getHintStyle(color: ColorManager.primary).copyWith(decoration: TextDecoration.underline, fontWeight: FontWeightManager.medium),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
