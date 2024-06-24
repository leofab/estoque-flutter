import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          "Estoque App",
          style: TextStyle(color: Colors.amber[100]),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: const Center(
              child: Text(
                "👤",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(30),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Usuário',
                icon: Icon(Icons.person),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Senha',
                icon: Icon(Icons.lock),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(left: 50, right: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Entrar",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
