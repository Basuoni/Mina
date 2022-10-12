import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mina_albaba/pages/add_screen.dart';
import 'package:mina_albaba/pages/login_screen.dart';
import 'package:mina_albaba/repositories/store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    StoreRepo.getProduct();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(itemBuilder: itemBuilder, itemCount: 100),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
        color: Colors.grey,
        height: 80.0,
      );
}
