import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudarribe_trainer/components/color_button.dart';
import 'package:mudarribe_trainer/components/gradientext.dart';
import 'package:mudarribe_trainer/components/inputfield.dart';
import 'package:mudarribe_trainer/components/password_inputField.dart';
import 'package:mudarribe_trainer/values/color.dart';
import 'package:mudarribe_trainer/values/controller.dart';
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
      builder: (controller) =>  Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                'Enter Your Registered Email & Password.',
                style: TextStyle(color: white, fontSize: 15),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 21, 21, 21),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputField(
                            lable: 'Email',
                          ),
                          SizedBox(height: 20,),
                           PasswordInputField(
                        lable: 'password',
                        obscure: signinController.obscureTextPassword,
                        toggle: signinController.toggle,
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GradientText2(text: 'Forget Password ?',),
                        ],
                      )
                        ],
                      ),
                    ),
                  )),
                    SizedBox(height: 50,),
                   GradientButton(title: 'Sign In', onPressed: () {})
            ],
          ),
        )),
      ),
    );
  }
}
