import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mina_albaba/repositories/store.dart';
import 'package:mina_albaba/widgets/app_button.dart';
import 'package:mina_albaba/widgets/app_text_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final nameCon = TextEditingController();
  final countCon = TextEditingController();
  final linkCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            AppTextField(
                hint: 'Product Name',
                prefixIcon: Icons.abc,
                txtController: nameCon),
            AppTextField(
                hint: 'Product count',
                prefixIcon: Icons.abc,
                txtController: countCon),
            AppTextField(
                hint: 'Product Link',
                prefixIcon: Icons.abc,
                txtController: linkCon),
            AppButton(
                color: const Color(0xffC53F3F),
                child: const Text(
                  'Add Product',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  bool res = await StoreRepo.addProduct(
                      nameCon.text, linkCon.text, int.parse(countCon.text));
                  if(res){
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Add Succeed")));
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  }else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Find error")));
                  }
                })
          ],
        ),
      ),
    );
  }
}
