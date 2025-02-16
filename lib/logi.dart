import 'package:flutter/material.dart';
import 'google_signin.dart';
import 'libros_firebase.dart';

class Paginalogin extends StatelessWidget {
  const Paginalogin({super.key});

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
          child: Padding(padding: EdgeInsets.all(10),
            child: OutlinedButton(
              onPressed: () {
                iniciarConGoogle().whenComplete(() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LibrosFirebase())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logoGo.gif",
                    width: 50,
                      height: 50,
                  ),
                  Text(
                    "        Ingress con Google",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
