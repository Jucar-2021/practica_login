import 'google_signin.dart';
import 'libros_firebase.dart';
import 'package:flutter/material.dart';

class Paginalogin extends StatelessWidget {
  const Paginalogin({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Container(
          width: 300,
          child: OutlinedButton(
              onPressed: () {
                iniciarConGoogle().whenComplete(() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LibrosFirebase())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logoGo.png",
                    scale: 4,
                  ),
                  Text(
                    "Ingresa con Google",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              )),
        ),
      ),
    );
  }
}