import 'package:flutter/material.dart';
import 'google_signin.dart';
import 'libros_firebase.dart';

class Paginalogin extends StatefulWidget {
  const Paginalogin({super.key});

  @override
  _PaginaloginState createState() => _PaginaloginState();
}

class _PaginaloginState extends State<Paginalogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Valida tu cuanta"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [

        ],
      ),
      body: Center(
        child: Container(
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              setState(() {});
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
                    return Icon(Icons.error, color: Colors.red);
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  "Ingresa con Google",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
