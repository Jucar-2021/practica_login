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
      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(50),
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
              SizedBox(height: 15),
              Text(
                libro["titulo"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                libro["autor"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                "${libro["paginas"]} páginas",
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

    );
  }
}
