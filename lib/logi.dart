import 'package:flutter/material.dart';

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
        child: Expanded(
          child: Padding(padding: EdgeInsets.all(10),
            child: OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logoGo.png",
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
