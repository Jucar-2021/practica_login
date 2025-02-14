import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';

import 'PaginaBusqueda.dart';
import 'PaginaDetalles.dart';
import 'PaginaRegistro.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class LibrosFirebase extends StatefulWidget {
  const LibrosFirebase({super.key});

  @override
  State<LibrosFirebase> createState() => _LibrosFirebaseState();
}

class _LibrosFirebaseState extends State<LibrosFirebase> {
  Query query =
      FirebaseDatabase.instance.ref().child("libro").orderByChild("nombre");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Libreria Firebase"),
          centerTitle: true,
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Paginabusqueda()));
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Paginaregistro()));
                },
                icon: Icon(Icons.new_label))
          ],
        ),
        body: Center(
          child: FirebaseAnimatedList(
            query: query,
            itemBuilder: (context, snapshot, animation, index) {
              Map<String, String> libro = {
                "titulo": snapshot.child("titulo").value.toString(),
                "imagen": snapshot.child("imagen").value?.toString() ?? "",
                "autor": snapshot.child("autor").value.toString(),
                "editorial": snapshot.child("editorial").value.toString(),
                "paginas": snapshot.child("paginas").value.toString(),
                "genero": snapshot.child("genero").value.toString(),
              };
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Paginadetalles(
                        libro: libro,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          width: 100,
                          child: Image.memory(
                            base64Decode(
                                snapshot.child("imagen").value.toString()),
                            scale: 3,
                          )),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                      Text(
                        snapshot.child("titulo").value.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
