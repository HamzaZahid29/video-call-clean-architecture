import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/static_app_routes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/validators/text_field_validators.dart';
import '../../../../core/widgets/common_elevated_button.dart';
import '../../../../core/widgets/password_field.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../widgets/auth_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                            'Login',
                            style: AppTextStyles.headlineMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Enter your information to login.',
                            style: AppTextStyles.bodySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  AppAssets.loginAccountIllustrationSvg),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Email',
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
                            ),
                          ),
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Forgot Password?', // Styled text
                                  style: AppTextStyles.titleSmall
                                      .copyWith(color: Colors.red),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.pushNamed(Routes.forgetPassword);
                                      print('Login tapped');
                                    },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: CommonElevatedButton(
                                    title: 'Login',
                                    onTap: state is AuthLoading
                                        ? null
                                        : () {
                                      if (_formKey.currentState!
                                          .validate()) {
                                        context.read<AuthBloc>().add(
                                            AuthLogin(
                                                email: emailController
                                                    .text
                                                    .trim(),
                                                password:
                                                passwordController
                                                    .text
                                                    .trim()));
                                      }
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: '''Don't have an account?''',
                                // Regular text
                                style: AppTextStyles.titleSmall
                                    .copyWith(color: Colors.grey.shade600),
                                children: [
                                  TextSpan(
                                    text: 'Register', // Styled text
                                    style: AppTextStyles.titleSmall
                                        .copyWith(color: Colors.red),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.goNamed(Routes.signupScreen);
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
