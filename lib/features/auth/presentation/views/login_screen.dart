import 'package:devoida_task_manager/app/service_locator.dart';
import 'package:devoida_task_manager/app/singlton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/common/widget/button_widget.dart';
import '../../../../shared/common/widget/text_field_with_title_widget.dart';
import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/manager_values.dart';
import '../../../../shared/resources/routes_manager.dart';
import '../../../../shared/resources/size_config.dart';
import '../../../../shared/resources/styles_manager.dart';
import '../view_model/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  late AuthCubit _authCubit;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
    if (state is LoginUserLoadingState) {
            _isLoading = true;
          }
          if (state is LoginUserSuccessState) {
            _isLoading = false;
            Singleton().user = state.userEntity;
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
          if (state is LoginUserErrorState) {
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
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: getMediumStyle(
                          fontSize: FontSize.s32,
                        ),
                      ),
                      Text(
                        "Use your email and password to login, or create a new account if you don't have one.",
                        style: getHintStyle(
                          color: ColorManager.dimWhite,
                        ),
                      ),
                      const SizedBox(
                        height: AppPadding.p48,
                      ),
                      TextFieldWithTitle(
                        color: ColorManager.white,
                        fNameController: _emailController,
                        fieldName: "Email",
                        hintText: "Enter your email address..",
                        inputType: TextInputType.emailAddress,
                      ),
                      TextFieldWithTitle(color: ColorManager.white, fNameController: _passwordController, fieldName: "Password", inputType: TextInputType.visiblePassword, hintText: "Enter your password..", isSecure: true),
                      const SizedBox(
                        height: AppPadding.p48,
                      ),
                      CustomButton(
                          onPress: () {
                            if (_formKey.currentState?.validate() == true) {
                              _authCubit.loginUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text,);
                            }
                          },
                          labelText: "Login"),
                      TextButton(
                        onPressed: () => Navigator.popAndPushNamed(context, Routes.signUpRoute),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: getHintStyle(color: ColorManager.neutralGray700),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign up',
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
      );
  },
),
    );
  }
}
