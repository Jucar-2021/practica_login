import 'dart:convert';
import 'package:flutter/material.dart';

class Paginadetalles extends StatefulWidget {
  final Map libro;

  const Paginadetalles({super.key, required this.libro});

  @override
  State<Paginadetalles> createState() => _PaginadetallesState();
}

class _PaginadetallesState extends State<Paginadetalles> {
  @override
  Widget build(BuildContext context) {
    Map libro = widget.libro;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(libro["titulo"]),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Expanded(
            child: Column(
              children: [
                Container(
                  height: 400,
                  width: 300,
                  child: Image.memory(
                    base64Decode(libro["imagen"]!),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                Text(
                  libro["titulo"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  libro["autor"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  libro["paginas"] + " paginas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  libro["editorial"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  libro["genero"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
