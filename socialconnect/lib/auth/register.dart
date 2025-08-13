import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:socialconnect/controllers/authcontroller.dart';
import 'package:socialconnect/widget/textfields.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  RegExp regex = RegExp(
    r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,16}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF6F0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: 'Delius',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 32),

                  Container(
                    padding: EdgeInsets.all(20),
                    height: 480,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Textfields(
                          label: "Enter your Name",
                          textEditingController: namecontroller,
                          validator:
                              ValidationBuilder()
                                  .minLength(3)
                                  .maxLength(20)
                                  .build(),
                        ),
                        SizedBox(height: 16),

                        Textfields(
                          label: "Enter your Email",
                          textEditingController: emailcontroller,
                          validator: ValidationBuilder().email().build()
                        ),

                        SizedBox(height: 16),

                        Textfields(
                          label: " Password",
                          textEditingController: passwordcontroller,
                          validator:
                              ValidationBuilder()
                                  .regExp(regex, "Use a strong password")
                                  .build(),
                        ),

                        SizedBox(height: 24),

                        Textfields(
                          label: " Confirm Password",
                          textEditingController: confirmpasswordcontroller,
                          validator: (value) {
                            if (value != passwordcontroller.text) {
                              return "Confirm password and password does not match!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                authController.register(
                                  namecontroller.text.trim(),
                                  emailcontroller.text.trim(),
                                  passwordcontroller.text.trim(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        Text.rich(
                          TextSpan(
                            text: "Have an account?",
                            children: [
                              TextSpan(
                                text: "Log In",
                                style: TextStyle(color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.offAllNamed("/login");
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
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
}
