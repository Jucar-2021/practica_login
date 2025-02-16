import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica_login/logi.dart';
import 'PaginaBusqueda.dart';
import 'PaginaDetalles.dart';
import 'PaginaRegistro.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

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
        title: const Text(
          "Librería Firebase",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber.shade500,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              child: Text(
                'Menú',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.manage_search),
              title: const Text('Buscar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Paginabusqueda()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Agregar portada'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Paginaregistro()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FirebaseAnimatedList(
          query: query,
          itemBuilder: (context, snapshot, animation, index) {
            String? claveLibro = snapshot.key;
            if (claveLibro == null) return SizedBox.shrink();
            Map<String, String> libro = {
              "titulo": snapshot.child("titulo").value.toString(),
              "imagen": snapshot.child("imagen").value?.toString() ?? "",
              "autor": snapshot.child("autor").value.toString(),
              "editorial": snapshot.child("editorial").value.toString(),
              "paginas": snapshot.child("paginas").value.toString(),
              "genero": snapshot.child("genero").value.toString(),
            };
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Paginadetalles(libro: libro),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                      child: Image.memory(
                        base64Decode(snapshot.child("imagen").value.toString()),
                        width: 100,
                        height: 170,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 150,
                            color: Colors.grey[200],
                            child: const Icon(Icons.book, size: 40),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mayuslas(libro["titulo"]!),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              capitalizeNombres(libro["autor"]!),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.book_outlined,
                                    size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  '${libro["paginas"]} páginas',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                capitalize(libro["genero"]!),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.amber[900],
                                ),
                              ),

                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      print("<<<<<<<<<<<<<<<<<<<${claveLibro}>>>>>>>>>>>>>>>>>>>");
                                      if (claveLibro != null) {
                                        borrar(claveLibro);
                                      }
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red,size: 30,))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.group_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Paginalogin(),
            ),
          );
        },
      ),
    );
  }

  void borrar(String index) async {
    await FirebaseDatabase.instance.ref().child("libro").child(index).remove();
    setState(() {});
  }

  String capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String mayuslas(String? text) {
    if (text == null || text.isEmpty) return '';
    return text.toUpperCase();
  }

  String capitalizeNombres(String? text) {
    // Asegurar que acepte null
    if (text == null || text.isEmpty) return '';
    return text
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }
}
