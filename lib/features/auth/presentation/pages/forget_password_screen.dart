import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/validators/text_field_validators.dart';
import '../../../../core/widgets/common_elevated_button.dart';
import '../blocs/forget_password_bloc/forget_password_bloc.dart';
import '../widgets/auth_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200)),
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft02,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Forget Password',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            context.push('/emailVerification/${emailController.text.trim()}');
          } else if (state is ForgetPasswordFailure) {
            showSnackbar(context, state.messege);
          }
        },
        builder: (context, state) {
          if (state is ForgetPasswordLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppThemes.primaryColor,
              ),
            );
          } else if (!(state is ForgetPasswordLoading)) {
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
                          Container(
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.headlineMedium,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Enter your email address, we will text you a verification code to verify.',
                            style: AppTextStyles.bodySmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  AppAssets.forgetPasswordIllustrationSvg),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Email Address',
                            style: AppTextStyles.titleSmall,
                          ),
                          AuthTextFormField(
                            textEditingController: emailController,
                            label: 'Email Address',
                            formFieldValidator:
                                TextFieldValidators.emailValidator,
                            textInputType: TextInputType.emailAddress,
                            suffixWidget: HugeIcon(
                              icon: HugeIcons.strokeRoundedMail01,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: CommonElevatedButton(
                                    title: 'Send Code',
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<ForgetPasswordBloc>()
                                            .add(SendForgerPasswordEvent(
                                              email:
                                                  emailController.text.trim(),
                                            ));
                                      }
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
