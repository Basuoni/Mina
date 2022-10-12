import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mina_albaba/pages/sign_up.dart';
import 'package:mina_albaba/widgets/app_button.dart';
import 'package:mina_albaba/widgets/app_text_field.dart';

import '../repositories/authenticate.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
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
                    height: 200, child: SvgPicture.asset('assets/login.svg')),
                const SizedBox(height: 30),
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
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      log("Done");
                      String mes = await AuthenticateRepo.login(
                          emailController.text, passwordController.text);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(mes)));
                      if (mes == 'Login Succeed') {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SignUpScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        " Sign up",
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
