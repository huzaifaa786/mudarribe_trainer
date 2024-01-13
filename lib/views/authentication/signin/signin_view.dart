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
          title: TopBar(text: "",),),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
             
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'Enter Your Registered Email & Password.',
                  style: TextStyle(color: white, fontSize: 15),
                ).translate(),
                Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 21, 21, 21),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputField(
                              lable: 'Email',
                              controller: controller.emailController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PasswordInputField(
                              lable: 'Password',
                              obscure: controller.obscureTextPassword,
                              toggle: controller.toggle,
                              controller: controller.passwordController,
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
                                    child: const GradientText2(
                                      text: 'Forget Password?',
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
                  title: 'Submit',
                  onPressed: controller.areFieldsFilled.value
                      ? () {
                          controller.signInTrainer();
                        }
                      : () {
                          UiUtilites.errorSnackbar('Fill out all fields',
                              'Please fill all above fields');
                        },
                  selected: controller.areFieldsFilled.value,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
