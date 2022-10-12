import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mina_albaba/pages/home.dart';
import 'package:mina_albaba/widgets/app_button.dart';
import 'package:mina_albaba/widgets/app_text_field.dart';

import '../repositories/authenticate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                SizedBox(
                    height: 150, child: SvgPicture.asset('assets/login.svg')),
                const SizedBox(height: 30),
                AppTextField(
                    hint: "Name",
                    prefixIcon: Icons.person_outline,
                    txtController: nameController),
                AppTextField(
                    hint: "E-mail",
                    prefixIcon: Icons.email_outlined,
                    txtController: emailController),
                AppTextField(
                  hint: "Password",
                  prefixIcon: Icons.lock_outline,
                  txtController: passwordController,
                  suffixIcon:
                      isPassword ? Icons.visibility : Icons.visibility_off,
                  isPassword: isPassword,
                  onPressedIcon: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                ),
                AppButton(
                  color: const Color(0xffC53F3F),
                  child: const Text(
                    'Sign Up ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      log("Done");
                      String mes = await AuthenticateRepo.signup(
                          emailController.text,
                          nameController.text,
                          passwordController.text);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(mes)));
                      if (mes == 'Add Succeed') {
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()),
                              (route) => false);
                        });
                      }
                    } else {
                      log("Error");
                    }
                  },
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Do have an account? ",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        " Login",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xffC53F3F)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
