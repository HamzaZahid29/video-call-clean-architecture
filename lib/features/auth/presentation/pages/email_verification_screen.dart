import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/static_app_routes.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../core/widgets/common_elevated_button.dart';
import '../blocs/forget_password_bloc/forget_password_bloc.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  EmailVerificationScreen({required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          'Email Verification',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            showSnackbar(context, 'Re-send email successful');
          } else if (state is ForgetPasswordFailure) {
            showSnackbar(context, "Error in re-sending email");
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
                              'Verify Email Address',
                              style: AppTextStyles.headlineMedium,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text:
                                  'We have sent you an email verification link to your email ',
                              style: AppTextStyles.bodySmall,
                              children: [
                                TextSpan(
                                  text: widget.email,
                                  style: AppTextStyles.titleSmall,
                                ),
                                TextSpan(
                                  text:
                                      '. Please check your email & click on that link to verify your email address.',
                                ),
                              ],
                            ),
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
                            'Its not Auto-direct verification, Please login after verification on link.',
                            style: AppTextStyles.bodySmall,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: CommonElevatedButton(
                                    title: 'Continue',
                                    onTap: () {
                                      context.goNamed(Routes.loginScreen);
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<ForgetPasswordBloc>()
                                    .add(SendForgerPasswordEvent(
                                      email: widget.email.trim(),
                                    ));
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Resend Email Link',
                                    style: AppTextStyles.titleSmall
                                        .copyWith(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
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
