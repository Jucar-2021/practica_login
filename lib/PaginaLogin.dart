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
          child: ElevatedButton(
            onPressed: () {
              iniciarConGoogle().whenComplete(() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LibrosFirebase()),
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logoGo.gif",
                  scale: 4,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, color: Colors.red); // Si hay error, muestra un ícono
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  "Ingresa con Google",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
