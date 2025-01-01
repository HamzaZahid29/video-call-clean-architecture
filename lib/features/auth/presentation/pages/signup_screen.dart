import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/static_app_routes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/drop_down_menu_items.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/validators/text_field_validators.dart';
import '../../../../core/widgets/common_elevated_button.dart';
import '../../../../core/widgets/password_field.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../widgets/auth_dropdown_menu.dart';
import '../widgets/auth_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
// disp

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackbar(context, state.messege);
          } else if (state is AuthSuccess) {
            showSnackbar(context, "User Created Successfully!");
            context.goNamed(Routes.homePage);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create Account',
                            style: AppTextStyles.headlineMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Create an account to access functions of this app. Fill all information.',
                            style: AppTextStyles.bodySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  AppAssets.createAccountIllustrationSvg),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Username',
                            style: AppTextStyles.titleSmall,
                          ),
                          AuthTextFormField(
                            textEditingController: userNameController,
                            label: 'Username',
                            formFieldValidator:
                            TextFieldValidators.userNameValidator,
                            suffixWidget: HugeIcon(
                              icon: HugeIcons.strokeRoundedUser,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Email Address',
                            style: AppTextStyles.titleSmall,
                          ),
                          AuthTextFormField(
                              textEditingController: emailController,
                              label: 'Email',
                              textInputType: TextInputType.emailAddress,
                              formFieldValidator:
                              TextFieldValidators.emailValidator,
                              suffixWidget: HugeIcon(
                                icon: HugeIcons.strokeRoundedMail01,
                                color: Colors.grey,
                                size: 18.0,
                              )),
                          const SizedBox(height: 10),
                          Text(
                            'Password',
                            style: AppTextStyles.titleSmall,
                          ),
                          PasswordField(
                            textEditingController: passwordController,
                            label: 'Password',
                            formFieldValidator:
                            TextFieldValidators.passwordValidator,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                  child: CommonElevatedButton(
                                      title: 'Register',
                                      onTap: state is AuthLoading
                                          ? null
                                          : () {
                                        if (_formKey.currentState!
                                            .validate()) {
                                            context.read<AuthBloc>().add(
                                                AuthSignUp(
                                                    email: emailController.text
                                                        .trim(),
                                                    password:
                                                    passwordController
                                                        .text
                                                        .trim(),
                                                    name:
                                                    userNameController
                                                        .text
                                                        .trim(),
                                                ));
                                        }
                                      })),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'Already have an account? ',
                                // Regular text
                                style: AppTextStyles.titleSmall
                                    .copyWith(color: Colors.grey.shade600),
                                children: [
                                  TextSpan(
                                    text: 'Login', // Styled text
                                    style: AppTextStyles.titleSmall
                                        .copyWith(color: Colors.red),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.goNamed(Routes.loginScreen);

                                        print('Login tapped');
                                      },
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center, // Optional alignment
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
