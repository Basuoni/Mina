import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mina_albaba/pages/home.dart';
import 'package:mina_albaba/pages/login_screen.dart';

Widget Body = const LoginScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user =  FirebaseAuth.instance.currentUser;
  if(user != null) Body = const HomeScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const MaterialColor kToDark = MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffC53F3F), //10%
      100: Color(0xffC53F3F), //20%
      200: Color(0xffC53F3F), //30%
      300: Color(0xffC53F3F), //40%
      400: Color(0xffC53F3F), //50%
      500: Color(0xffC53F3F), //60%
      600: Color(0xffC53F3F), //70%
      700: Color(0xffC53F3F), //80%
      800: Color(0xffC53F3F), //90%
      900: Color(0xffC53F3F), //100%
    },
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping  App',
      theme: ThemeData(
        primaryColor: const Color(0xffC53F3F),
        primarySwatch: kToDark,
      ),
      home: Body,
    );
  }
}
