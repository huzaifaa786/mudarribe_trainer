// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mudarribe_trainer/components/bio_input.dart';
import 'package:mudarribe_trainer/components/card.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/genderSelectar.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/loading_indicator.dart';
import 'package:mudarribe_trainer/components/multi_select_dropdown.dart';
import 'package:mudarribe_trainer/components/password_inputField.dart';
import 'package:mudarribe_trainer/components/topbar.dart';
import 'package:mudarribe_trainer/values/category_list.dart';
import 'package:mudarribe_trainer/values/controller.dart';
import 'package:mudarribe_trainer/values/languages.dart';
import 'package:mudarribe_trainer/values/ui_utils.dart';
import 'package:mudarribe_trainer/views/authentication/signup/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
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
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Fill Your Information'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: controller.profileImage != null
                                ? Image.file(controller.profileImage!).image
                                : AssetImage("assets/images/user.png"),
                          ),
                          Positioned(
                              bottom: 23,
                              right: 17,
                              child: RawMaterialButton(
                                onPressed: () {
                                  controller.selectProfileImage();
                                },
                                elevation: 2.0,
                                // fillColor: Color(0xFFF5F6F9),
                                // ignore: sort_child_properties_last
                                child: controller.profileImage != null
                                    ? Text('')
                                    : Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.blue,
                                        size: 39,
                                      ),
                                padding: EdgeInsets.all(15.0),
                                shape: CircleBorder(),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: GradientText2(
                        text: 'Choose photo',
                      ),
                    ),
                    InputField(
                      lable: 'Name',
                      controller: controller.nameController,
                    ),
                    InputField(
                      lable: 'Email',
                      controller: controller.emailController,
                    ),
                    PasswordInputField(
                      lable: 'Password',
                      obscure: controller.obscureTextPassword,
                      toggle: controller.togglePassword,
                      controller: controller.passwordController,
                    ),
                    PasswordInputField(
                      lable: 'Confirm Password',
                      obscure: controller.obscureTextCPassword,
                      toggle: controller.toggleCPassword,
                      controller: controller.confirmPasswordController,
                    ),
                    BioInputField(
                      lable: 'Bio',
                      controller: controller.bioController,
                    ),
                    Gap(16),
                    MultiSelectDropDown(
                      label: 'Area of profession',
                      item: CategoryList(),
                      onchange: controller.onchange,
                      selected: controller.selectedCategories,
                    ),
                    Gap(16),
                    MultiSelectDropDown(
                      label: 'Spoken Languages',
                      item: Languages(),
                      onchange: controller.onlangchange,
                      selected: controller.selectedLanguages,
                    ),
                    Gap(8),
                    Card1(
                      text: 'Upload Your Certificate',
                      ontap: () {
                        controller.selectCertificate();
                      },
                      file: controller.certificate,
                    ),
                    Card1(
                      text: 'Upload Your ID or Passport',
                      ontap: () {
                        controller.selectPassportId();
                      },
                      file: controller.passportId,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText2(
                            text: 'Gender ?',
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GenderCard(
                          text: 'Male',
                          image: "assets/images/male.svg",
                          selected:
                              signupController.gender == 'male' ? true : false,
                          ontap: signupController.onmaletap,
                        ),
                        GenderCard(
                          text: 'Female',
                          image: "assets/images/female.svg",
                          ontap: signupController.onfemaletap,
                          selected: signupController.gender == 'female'
                              ? true
                              : false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                      title: 'Submit',
                      onPressed: controller.areFieldsFilled.value
                          ? () {
                              controller.signUpTrainer();
                            }
                          : () {
                              UiUtilites.errorSnackbar('Fill out all fields',
                                  'Please fill all above fields');
                            },
                      selected: controller.areFieldsFilled.value,
                    ),
                    Gap(20)
                  ])),
            ),
          ),
        ),
      ),
    );
  }
}
