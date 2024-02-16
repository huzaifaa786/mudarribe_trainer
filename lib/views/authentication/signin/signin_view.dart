import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/password_inputField.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/routes/app_routes.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/authentication/signin/signin_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      builder: (controller) => BusyIndicator(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            title: TopBar(
              text: "",
            ),
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Enter Your Registered Email & Password.'.tr,
                    style: TextStyle( color:  Get.isDarkMode? white: maincolor , fontSize: 15),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration:  BoxDecoration(
                           color:  Get.isDarkMode? bgContainer: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InputField(
                                lable: 'Email'.tr,
                                controller: controller.emailController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              PasswordInputField(
                                lable: 'Password'.tr,
                                obscure: controller.obscureTextPassword,
                                toggle: controller.toggle,
                                controller: controller.passwordController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  } else if (value.length < 6) {
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.forgetpassword);
                                      },
                                      child: GradientText2(
                                        text: 'Forget Password?'.tr,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  GradientButton(
                    title: 'Submit'.tr,
                    onPressed: controller.areFieldsFilled.value
                        ? () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.signInTrainer();
                            }
                          }
                        : () {
                            if (controller.formKey.currentState!.validate()) {}
                          },
                    selected: controller.areFieldsFilled.value,
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

bool _isValidEmail(String email) {
  final emailRegExp =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  return emailRegExp.hasMatch(email);
}
