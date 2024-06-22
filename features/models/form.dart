import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormState createState() => _FormState();
}

class _FormState extends State<Forms> {
  final keys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: keys,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Usuário',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome de usuário';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
